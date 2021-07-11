.. _upgrade:

============================================================
Upgrade from Archivematica |previous_version|.x to |release|
============================================================

*On this page:*

* :ref:`Clean up completed transfers watched directory <completed-transfers>`
* :ref:`Create a backup <create-backup>`
* :ref:`Upgrade Ubuntu package install <upgrade-ubuntu>`
* :ref:`Upgrade CentOS/Red Hat package install <upgrade-centos>`
* :ref:`Upgrade in indexless mode <upgrade-indexless>`
* :ref:`Upgrade with output capturing disabled <upgrade-no-output-capture>`
* :ref:`Update search indices <update-search-indices>`
* :ref:`Review the processing configuration <review-processing-configuration>`

.. note::

   While it is possible to upgrade a GitHub-based source install using ansible,
   these instructions do not cover that scenario.


.. _completed-transfers:

Clean up completed transfers watched directory
----------------------------------------------

.. note::

   Ignore this section if you upgrading from Archivematica 1.11 or newer.

Upgrading from Archivematica 1.10.x or older to Archivematica |release| can
result in a number of completed transfers appearing as failed in the
Archivematica dashboard, as well as corresponding failure notification emails
being sent. These are not actual failures, but are unintentional side effects
of changes made in Archivematica 1.11 to the workflow and to how metadata files
are stored and copied into the SIP.

To prevent these failures from occuring during an upgrade from Archivematica
1.10 or earlier:

1. Confirm that all transfers and ingests are complete.

   Check that there are no transfers or SIPs that are still being processed or
   awaiting decisions in the Transfer and Ingest tabs. If there are, finish
   processing the transfers/ingests before proceeding.

2. Delete all contents of the completedTransfers watched directory.

   .. code:: bash

      sudo rm -rf /var/archivematica/sharedDirectory/watchedDirectories/SIPCreation/completedTransfers/*

3. Perform the upgrade as described below.


.. _create-backup:

Create a backup
---------------

Before starting any upgrade procedure on a production system, we strongly
recommend backing up your system. If you are using a virtual machine, take a
snapshot of it before making any changes. Alternatively, back up the file
systems being used by your system. Exact procedures for updating will depend on
your local installation. At a minimum you should make backups of:

* The Storage Service SQLite (or MySQL) database
* The dashboard MySQL database

This is a simple example of backing up these two databases:

.. code:: bash

   sudo cp /var/archivematica/storage-service/storage.db ~/storage_db_backup.db
   mysqldump -u root -p MCP > ~/am_backup.sql

If you do not have a password set for the root user in MySQL, you can take out
the '-p' portion of that command. If there is a problem during the upgrade
process, you can restore your MySQL database from this backup and try the
upgrade again.

If you're upgrading from Archivematica 1.8 or lower to the 1.9 version or
higher, the Elasticsearch version support changed from 1.x to 6.x and it's
also recommended to create a backup of your Elasticsearch data, especially if
you don't have access to the AIP storage locations in the local filesystem.

You can follow these steps in order to create a backup of Elasticsearch:

.. code:: bash

   # Remove and recreate the folder that stores the backup
   sudo rm -rf /var/lib/elasticsearch/backup-repo/
   sudo mkdir -p /var/lib/elasticsearch/backup-repo/
   sudo chown elasticsearch:elasticsearch /var/lib/elasticsearch/backup-repo/
   # Allow elasticsearch to write files to the backup
   echo 'path.repo: ["/var/lib/elasticsearch/backup-repo"]' |sudo tee -a /etc/elasticsearch/elasticsearch.yml
   # Restart ElasticSearch and wait for it to start
   sudo service elasticsearch restart
   sleep 60s
   # Configure the ES backup
   curl -XPUT "localhost:9200/_snapshot/backup-repo" -H 'Content-Type: application/json' -d \
   '{
        "type": "fs",
        "settings": {
        "location": "./",
        "compress": true
        }
    }'
   # Take the actual backup, and copy it to a safe place
   curl -X PUT "localhost:9200/_snapshot/backup-repo/am_indexes_backup?wait_for_completion=true"
   cp /var/lib/elasticsearch/backup-repo elasticsearch-backup -rf

For more info, refer to the `ElasticSearch 6.8 docs`_.


.. _upgrade-ubuntu:

Upgrade on Ubuntu packages
--------------------------

#. Update the operating system.

   .. code:: bash

      sudo apt-get update && sudo apt-get upgrade

#. Update package sources.

   .. code:: bash

      echo 'deb [arch=amd64] http://packages.archivematica.org/1.13.x/ubuntu bionic main' >> /etc/apt/sources.list
      echo 'deb [arch=amd64] http://packages.archivematica.org/1.13.x/ubuntu-externals bionic main' >> /etc/apt/sources.list

   Optionally you can remove the lines referencing
   packages.archivematica.org/|previous_version|.x from /etc/apt/sources.list.

#. Update the Storage Service.

   .. code:: bash

      sudo apt-get update
      sudo apt-get install archivematica-storage-service

#. Update Archivematica. During the update process you may be asked about
   updating configuration files. Choose to accept the maintainers versions. You
   will also be asked about updating the database - say 'ok' to each of those
   steps. If you have set a password for the root MySQL database user, enter it
   when prompted.

   .. code:: bash

      sudo apt-get install archivematica-common
      sudo apt-get install archivematica-dashboard
      sudo apt-get install archivematica-mcp-server
      sudo apt-get install archivematica-mcp-client

#. Restart services.

   .. code:: bash

      sudo service archivematica-storage-service restart
      sudo service gearman-job-server restart
      sudo service archivematica-mcp-server restart
      sudo service archivematica-mcp-client restart
      sudo service archivematica-dashboard restart
      sudo service nginx restart

#. Depending on your browser settings, you may need to clear your browser cache
   to make the dashboard pages load properly. For example in Firefox or Chrome
   you should be able to clear the cache with control-shift-R or
   command-shift-F5.

.. _upgrade-centos:

Upgrade on CentOS/Red Hat packages
----------------------------------

#. Upgrade the repositories for |version|:

   .. code:: bash

    sudo sed -i 's/1.12.x/1.13.x/g' /etc/yum.repos.d/archivematica*

#. Remove the current installed version of ghostscript:

   .. code:: bash

      sudo rpm -e --nodeps ghostscript ghostscript-x11 \
                           ghostscript-core ghostscript-fonts

#. Upgrade Archivematica packages:

   .. code:: bash

      sudo yum update

#. Apply the Archivematica database migrations:

   .. code:: bash

      sudo -u archivematica bash -c " \
          set -a -e -x
          source /etc/default/archivematica-dashboard || \
              source /etc/sysconfig/archivematica-dashboard \
                  || (echo 'Environment file not found'; exit 1)
          cd /usr/share/archivematica/dashboard
          /usr/share/archivematica/virtualenvs/archivematica/bin/python manage.py migrate --noinput
      ";

#. Apply the Storage Service database migrations:

   .. warning::

      In Archivematica 1.13 or newer, the new default database backend is MySQL.
      Please follow our :ref:`migration guide <storageservice:migration-sqlite-mysql>`
      to move your data to a MySQL database before these migrations are applied.

      If you want to continue using SQLite, please edit the environment
      configuration found in ``/etc/sysconfig/archivematica-storage-service``.
      Comment out ``SS_DB_URL`` and indicate the path of the SQLite database
      with ``SS_DB_NAME``, e.g.:
      ``SS_DB_NAME=/var/archivematica/storage-service/storage.db``.

   .. code:: bash

      sudo -u archivematica bash -c " \
          set -a -e -x
          source /etc/default/archivematica-storage-service || \
              source /etc/sysconfig/archivematica-storage-service \
                  || (echo 'Environment file not found'; exit 1)
          cd /usr/lib/archivematica/storage-service
          /usr/share/archivematica/virtualenvs/archivematica-storage-service/bin/python manage.py migrate
      ";

#. Restart the Archivematica related services, and continue using the system:

   .. code:: bash

      sudo systemctl restart archivematica-storage-service
      sudo systemctl restart archivematica-dashboard
      sudo systemctl restart archivematica-mcp-client
      sudo systemctl restart archivematica-mcp-server

#. Depending on your browser settings, you may need to clear your browser cache
   to make the dashboard pages load properly. For example in Firefox or Chrome
   you should be able to clear the cache with control-shift-R or
   command-shift-F5.

.. _upgrade-ansible:

Upgrade on Vagrant / Ansible
----------------------------

This upgrade method will work with Vagrant machines, but also
with cloud based virtual machines, or physical servers.

#. Connect to your Vagrant machine or server

    .. code:: bash

      vagrant ssh # Or ssh <your user>@<host>

#. Install Ansible

    .. code:: bash

      sudo pip install ansible==2.9.10 jmespath

#. Checkout the deployment repo:

   .. code:: bash

      git clone https://github.com/artefactual/deploy-pub.git

#. Go into the appropiate playbook folder, and install the needed roles

   .. _ubuntu-18.04:

   Ubuntu 18.04 (Bionic):

   .. code:: bash

      cd deploy-pub/playbooks/archivematica-bionic
      ansible-galaxy install -f -p roles/ -r requirements.yml

   .. _centos-7:

   Centos 7:

   .. code:: bash

      cd deploy-pub/playbooks/archivematica-centos7
      ansible-galaxy install -f -p roles/ -r requirements.yml

   All the following steps should be run from the respective playbook folder
   for your operating system.

#. Verify that the vars-singlenode.yml has the appropiate contents for
   Elasticsearch and Archivematica, or update it with your own

#. Create a hosts file.

   .. code:: bash

    echo 'am-local   ansible_connection=local' > hosts

#. Upgrade Archivematica running

   .. code:: bash

    ansible-playbook -i hosts singlenode.yml --tags=elasticsearch,archivematica-src

.. _upgrade-indexless:

Upgrade in indexless mode
-------------------------

As of Archivematica 1.7, Archivematica can be run in indexless mode; that is,
without Elasticsearch. Installing Archivematica without Elasticsearch, or with
limited Elasticsearch functionality, means reduced consumption of compute
resources and lower operational complexity. By setting the
``archivematica_src_search_enabled`` configuration attribute, administrators can
define how many things Elasticsearch is indexing, if any. This can impact
searching across several different dashboard pages.

1. Upgrade your existing Archivematica pipeline following the instructions
   above.

2. Modify the relevant systemd EnvironmentFile files by adding lines that set
   the relevant environment variables to ``false``.

   If you are using Ubuntu, run the following commands.

   .. code:: bash

      sudo sh -c 'echo "ARCHIVEMATICA_DASHBOARD_DASHBOARD_SEARCH_ENABLED=false" >> /etc/default/archivematica-dashboard'
      sudo sh -c 'echo "ARCHIVEMATICA_MCPSERVER_MCPSERVER_SEARCH_ENABLED=false" >> /etc/default/archivematica-mcp-server'
      sudo sh -c 'echo "ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_SEARCH_ENABLED=false" >> /etc/default/archivematica-mcp-client'

   If you are using CentOS, run the following commands.

   .. code:: bash

      sudo sh -c 'echo "ARCHIVEMATICA_DASHBOARD_DASHBOARD_SEARCH_ENABLED=false" >> /etc/sysconfig/archivematica-dashboard'
      sudo sh -c 'echo "ARCHIVEMATICA_MCPSERVER_MCPSERVER_SEARCH_ENABLED=false" >> /etc/sysconfig/archivematica-mcp-server'
      sudo sh -c 'echo "ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_SEARCH_ENABLED=false" >> /etc/sysconfig/archivematica-mcp-client'

3. Restart services.

   If you are using Ubuntu, run the following commands.

   .. code:: bash

      sudo service archivematica-dashboard restart
      sudo service archivematica-mcp-client restart
      sudo service archivematica-mcp-server restart

   If you are using CentOS, run the following commands.

   .. code:: bash

      sudo -u root systemctl restart archivematica-dashboard
      sudo -u root systemctl restart archivematica-mcp-client
      sudo -u root systemctl restart archivematica-mcp-server

4. If you had previously installed and started the Elasticsearch service, you
   can turn it off now.

   .. code:: bash

      sudo -u root systemctl stop elasticsearch
      sudo -u root systemctl disable elasticsearch

.. _upgrade-no-output-capture:

Upgrade with output capturing disabled
--------------------------------------

As of Archivematica 1.7.1, output capturing can be disabled at upgrade or at
any other time. This means the stdout and stderr from preservation tasks are
not captured, which can result in a performane improvement. See the
`Task output capturing configuration <task-output-capturing-admin>` page for
more details. In order to disable output capturing, set the
``ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_CAPTURE_CLIENT_SCRIPT_OUTPUT`` environment
variable to ``false`` and restart the MCP Client process(es). Consult the
installation instructions for your deployment method for more details on how to
set environment variables and restart Archivematica processes.

:ref:`Back to the top <upgrade>`


.. _update-search-indices:

Update search indices
---------------------

.. note::

   Ignore this section if you are planning to run Archivematica without search
   indices.

Archivematica releases may introduce changes that require updating the search
indices to function properly, e.g. Archivematica v1.12.0 introduced new fields
to the search indices and made some changes to text field types. Please keep an
eye on our `release notes`_ before you start the upgrade.

The update can be accomplished one of two ways. Preferably, you can
:ref:`reindex the documents <reindex-documents>` which is usually faster because
the same documents that you already have indexed will be re-ingested. We would
love to know if this is not working for you, but when that's the case, it is
possible to :ref:`recreate the indices <recreate-indices>` which will take much
longer to complete because it accesses the original data, e.g. your AIPs.

.. _reindex-documents:

Reindex the documents
^^^^^^^^^^^^^^^^^^^^^

In Elasticsearch, it is possible to add new fields to search indices but it is
not possible to update existing ones. The recommended strategy is to create new
indices with our desired mapping and reindex our documents. This is based on the
`Reindex API`_.

It is a multi-step process that we have automated with a script:
`es-reindex.sh`_. Please follow the link and read the instructions carefully.

.. warning::

   Before you continue, we recommend backing up your Elasticsearch data. Please
   read the official docs for instructions.

.. note::

   We may implement this script as a Django command in the future for better
   usability. For the time being, please download the script and tweak as
   needed.

.. _recreate-indices:

Recreate the indices
^^^^^^^^^^^^^^^^^^^^

This method will allow you to delete and rebuild the existing Elasticsearch
indices so that all the Backlog and Archival Storage column fields are fully
populated, including for transfers and AIPs ingested prior to the upgrade to
Archivematica |release|. Run the commands described in
:ref:`Rebuild the indexes <elasticsearch-indexes>` to fully delete and rebuild
the indices.

Execution example:

.. code:: bash

   sudo -u archivematica bash -c " \
       set -a -e -x
       source /etc/default/archivematica-dashboard || \
           source /etc/sysconfig/archivematica-dashboard \
               || (echo 'Environment file not found'; exit 1)
       cd /usr/share/archivematica/dashboard
       /usr/share/archivematica/virtualenvs/archivematica/bin/python \
           manage.py rebuild_transfer_backlog --from-storage-service --no-prompt
   ";

   sudo -u archivematica bash -c " \
       set -a -e -x
       source /etc/default/archivematica-dashboard || \
           source /etc/sysconfig/archivematica-dashboard \
               || (echo 'Environment file not found'; exit 1)
       cd /usr/share/archivematica/dashboard
       /usr/share/archivematica/virtualenvs/archivematica/bin/python \
           manage.py rebuild_aip_index_from_storage_service --delete-all
   ";

.. note::

   Please note, the use of encrypted or remote Transfer Backlog and AIP Store
   locations may require use of the option to rebuild indices from the Storage
   Service API rather than from the filesystem. At this time, it is not
   possible to rebuild the indices for all types of remote locations.

.. note::

   Please note, the execution of this command may take a long time for big
   AIP and Transfer Backlog storage locations, especially if the packages are
   stored compressed or encrypted, or you are using a third party service. If
   that is the case, you may want to :ref:`reindex the Elasticsearch
   documents <reindex-documents>` instead.

.. _review-processing-configuration:

Review the processing configuration
-----------------------------------

After any Archivematica upgrade, it is recommended to perform a sanity check on
your :ref:`processing configurations <process-config>`. Look for new decision
points where you want to establish a default, like the new "Scan for viruses"
introduced in Archivematica 1.13.

The ``default`` and ``automated`` bundled configurations can be reset to the
Archivematica defaults.


.. _`Elasticsearch 6.8 docs`: https://www.elastic.co/guide/en/elasticsearch/reference/6.8/modules-snapshots.html
.. _`release notes`: https://wiki.archivematica.org/Release_Notes
.. _`Reindex API`: https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-reindex.html
.. _`es-reindex.sh`: https://github.com/artefactual-labs/ops-helpers/tree/master/es-helpers#es-reindexsh-update-search-indices
