.. _upgrade:

============================================================
Upgrade from Archivematica |previous_version|.x to |release|
============================================================

*On this page:*

* :ref:`Clean up completed transfers watched directory <completed-transfers>`
* :ref:`Create a backup <create-backup>`
* :ref:`Upgrade Ubuntu package install <upgrade-ubuntu>`
* :ref:`Upgrade Rocky Linux/Red Hat package install <upgrade-rocky>`
* :ref:`Upgrade in indexless mode <upgrade-indexless>`
* :ref:`Upgrade with output capturing disabled <upgrade-no-output-capture>`
* :ref:`Update search indices <update-search-indices>`
* :ref:`Review the processing configuration <review-processing-configuration>`
* :ref:`Migrate from MySQL 5.x to 8.x <migrate-mysql>`
* :ref:`Uninstall FITS <uninstall-fits>`
* :ref:`Upgrade Elasticsearch from 6.x to 8.x <upgrade-elasticsearch>`

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

For more info, refer to the `ElasticSearch docs`_.


.. _upgrade-ubuntu:

Upgrade on Ubuntu packages
--------------------------

#. Update the operating system.

   .. code:: bash

      sudo apt-get update && sudo apt-get upgrade

#. Update package sources.

   .. code:: bash

      curl -fsSL https://packages.archivematica.org/1.18.x/key.asc | sudo gpg --dearmor -o /etc/apt/keyrings/archivematica-1.18.x.gpg

      echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/archivematica-1.18.x.gpg] http://packages.archivematica.org/1.18.x/ubuntu jammy main' >> /etc/apt/sources.list
      echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/archivematica-1.18.x.gpg] http://packages.archivematica.org/1.18.x/ubuntu-externals jammy main' >> /etc/apt/sources.list

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

      sudo apt-get install archivematica archivematica-common
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

.. _upgrade-rocky:

Upgrade on Rocky Linux/Red Hat packages
---------------------------------------

#. Upgrade the repositories for |version|:

   .. code:: bash

    sudo sed -i 's/1.17.x/1.18.x/g' /etc/yum.repos.d/archivematica*

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
          /usr/share/archivematica/virtualenvs/archivematica/bin/python -m archivematica.dashboard.manage \
              migrate --noinput
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
          /usr/share/archivematica/virtualenvs/archivematica-storage-service/bin/python -m archivematica.storage_service.manage \
              migrate
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

      sudo pip install ansible==2.9.10 jmespath jinja2==3.0.3

#. Checkout the deployment repo:

   .. code:: bash

      git clone https://github.com/artefactual/deploy-pub.git

#. Go into the appropiate playbook folder, and install the needed roles

   .. _ubuntu-24.04:

   Ubuntu 24.04 (Noble):

   .. code:: bash

      cd deploy-pub/playbooks/archivematica-noble
      ansible-galaxy install -f -p roles/ -r requirements.yml

   .. rocky-9:

   Rocky Linux 9:

   .. code:: bash

      cd deploy-pub/playbooks/archivematica-rocky9
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

   If you are using Rocky Linux, run the following commands.

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

   If you are using Rocky Linux, run the following commands.

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
       /usr/share/archivematica/virtualenvs/archivematica/bin/python -m archivematica.dashboard.manage \
           rebuild_transfer_backlog --from-storage-service --no-prompt
   ";

   sudo -u archivematica bash -c " \
       set -a -e -x
       source /etc/default/archivematica-dashboard || \
           source /etc/sysconfig/archivematica-dashboard \
               || (echo 'Environment file not found'; exit 1)
       /usr/share/archivematica/virtualenvs/archivematica/bin/python -m archivematica.dashboard.manage \
           rebuild_aip_index_from_storage_service --delete-all
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

.. _migrate-mysql:

Migrate from MySQL 5.x to 8.x
-----------------------------

It is recommended the MySQL databases for Archivematica and Storage Service use
the MySQL 8 ``utf8mb4`` character set and its default collation
``utf8mb4_0900_ai_ci`` (or ``utf8mb4_general_ci`` in MariaDB).

If you migrate your databases from MySQL 5.x you can check the character set
and encoding of their tables with:

.. code:: sql

   SELECT
      t.table_schema, t.table_name, c.character_set_name, t.table_collation
   FROM
      information_schema.tables t,
      information_schema.collation_character_set_applicability c
   WHERE
      c.collation_name = t.table_collation
      AND t.table_type = 'BASE TABLE'
      AND (t.table_schema = 'MCP' OR t.table_schema = 'SS');

If they use the ``utf8mb3`` character set and collation you should update them
to avoid potential migration conflicts like this:

.. code:: bash

   Running migrations:
     Applying admin.0003_logentry_add_action_flag_choices... OK
     Applying auth.0009_alter_user_last_name_max_length... OK
     Applying auth.0010_alter_group_name_max_length... OK
     Applying auth.0011_update_proxy_permissions... OK
     Applying auth.0012_alter_user_first_name_max_length... OK
     Applying locations.0031_rclone_space...Traceback (most recent call last):
     File "/pyenv/data/versions/3.9.18/lib/python3.9/site-packages/django/db/backends/utils.py", line 84, in _execute
       return self.cursor.execute(sql, params)
     File "/pyenv/data/versions/3.9.18/lib/python3.9/site-packages/django/db/backends/mysql/base.py", line 73, in execute
       return self.cursor.execute(query, args)
     File "/pyenv/data/versions/3.9.18/lib/python3.9/site-packages/MySQLdb/cursors.py", line 179, in execute
       res = self._query(mogrified_query)
     File "/pyenv/data/versions/3.9.18/lib/python3.9/site-packages/MySQLdb/cursors.py", line 330, in _query
       db.query(q)
     File "/pyenv/data/versions/3.9.18/lib/python3.9/site-packages/MySQLdb/connections.py", line 255, in query
       _mysql.connection.query(self, query)
   MySQLdb.OperationalError: (3780, "Referencing column 'space_id' and referenced column 'uuid' in foreign key constraint 'locations_rclone_space_id_adb7fd1d_fk_locations_space_uuid' are incompatible.")

   django.db.utils.OperationalError: (3780, "Referencing column 'space_id' and referenced column 'uuid' in foreign key constraint 'locations_rclone_space_id_adb7fd1d_fk_locations_space_uuid' are incompatible.")

The following script can be used as a reference to update the character set of
the databases and their tables.

.. literalinclude:: scripts/mysql-change-encoding-collation.sh
   :language: bash
   :lines: 1-104

.. _uninstall-fits:

Uninstall FITS
--------------

`FITS`_ has been removed in Archivematica 1.17.0 to mitigate potential
vulnerabilities identified by various security scanners.

You can uninstall `FITS` using the following commands:

Ubuntu
^^^^^^

#. Upgrade your existing Archivematica pipeline to 1.17.0 or higher following
   the instructions above.

#. Stop and disable the `fits-nailgun` service

   .. code:: bash

      sudo systemctl stop fits-nailgun
      sudo systemctl disable fits-nailgun

#. Remove the `fits` and `nailgun` packages.

   .. code:: bash

      sudo apt-get purge fits nailgun

Rocky Linux/Red Hat
^^^^^^^^^^^^^^^^^^^

#. Upgrade your existing Archivematica pipeline to 1.17.0 or higher following
   the instructions above.

#. Stop and disable the `fits-nailgun` service.

   .. code:: bash

      sudo systemctl stop fits-nailgun
      sudo systemctl disable fits-nailgun

#. Remove the `fits` and `nailgun` packages.

   .. code:: bash

      sudo yum remove fits nailgun

Ansible
^^^^^^^

The `stable/1.17.x` branch of the `ansible-archivematica-src`_ repository
disables and uninstalls the `fits` and `nailgun` packages automatically.

.. _upgrade-elasticsearch:

Upgrade Elasticsearch from 6.x to 8.x
--------------------------------------

.. note::

   This section only applies when upgrading to Archivematica 1.18.0 or higher,
   which requires Elasticsearch 8.x. If you are upgrading from a version that
   uses Elasticsearch 6.x, you must follow this procedure.

Archivematica 1.18.0 requires Elasticsearch 8.x, which is not directly
compatible with the 6.x version used in previous releases. As a result, data
from Elasticsearch 6.x cannot be automatically upgraded to 8.x and will require
manual migration.

.. warning::

   Before starting this process, ensure you have backed up your Elasticsearch
   data as described in the :ref:`Create a backup <create-backup>` section.
   Keep your backups until you have verified that the upgrade was successful
   and Archivematica is functioning properly with Elasticsearch 8.x.

Stage 1: Backup and prepare for upgrade
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Stop all Archivematica services.

   If you are using Ubuntu, run the following commands:

   .. code:: bash

      sudo service archivematica-dashboard stop
      sudo service archivematica-mcp-server stop
      sudo service archivematica-mcp-client stop
      sudo service archivematica-storage-service stop

   If you are using Rocky Linux, run the following commands:

   .. code:: bash

      sudo systemctl stop archivematica-dashboard
      sudo systemctl stop archivematica-mcp-server
      sudo systemctl stop archivematica-mcp-client
      sudo systemctl stop archivematica-storage-service

#. Create a backup of your Elasticsearch data.

   .. code:: bash

      sudo service elasticsearch stop
      sudo tar --create --gzip --file var_lib_elasticsearch_$(date +%y%m%d).tgz /var/lib/elasticsearch
      sudo service elasticsearch start

#. Check that Elasticsearch is running and note the current indices.

   .. code:: bash

      curl --request GET "localhost:9200/_cat/indices?v"

   The output should show your current indices, similar to:

   .. code:: bash

      health status index         uuid                   pri rep docs.count docs.deleted store.size pri.store.size
      yellow open   transferfiles SjoFbZLSTO6ay6GYLveO1Q   5   1         32            2     93.6kb         93.6kb
      yellow open   transfers     kNMGveNRS6K3YYdlI7hPQw   5   1          1            0      6.8kb          6.8kb
      yellow open   aips          pE9ucbEjRXeiCBhw5AvndQ   5   1         79            1    343.9kb        343.9kb
      yellow open   aipfiles      7iM3mnk5Q02yLqi1wdO0Fg   5   1       1680            2       10mb           10mb

#. Check for existing snapshots and remove them if present.

   .. code:: bash

      curl --request GET "localhost:9200/_snapshot/_all?pretty"

   If snapshots exist, remove them:

   .. code:: bash

      curl --request DELETE "localhost:9200/_snapshot/backup-repo?pretty"

Stage 2: Create temporary Elasticsearch 6.x instance
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Stop the system Elasticsearch service.

   .. code:: bash

      sudo service elasticsearch stop

#. Check your current Elasticsearch version.

   If you are using Ubuntu:

   .. code:: bash

      dpkg -l elasticsearch

   If you are using Rocky Linux:

   .. code:: bash

      rpm -q elasticsearch

#. Install Java 11 for the temporary Elasticsearch instances.

   Elasticsearch 6.x requires Java 11. We'll install it separately and use
   it only for the temporary instances to avoid affecting your system's default
   Java version.

   If you are using Ubuntu:

   .. code:: bash

      sudo apt-get update
      sudo apt-get install openjdk-11-jdk

   If you are using Rocky Linux:

   .. code:: bash

      sudo yum install java-11-openjdk java-11-openjdk-devel

   Note the Java 11 installation path for later use:

   .. code:: bash

      export JAVA11_HOME=$(dirname $(dirname $(readlink -f $(which java))))
      echo "Java 11 installed at: $JAVA11_HOME"

#. Download and set up a temporary Elasticsearch 6.x instance with the same
   version you are using. Here we use version 6.8.23.

   .. code:: bash

      wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.8.23.tar.gz
      tar --extract --gzip --verbose --file elasticsearch-6.8.23.tar.gz
      cd elasticsearch-6.8.23

#. Copy your Elasticsearch data directory to the temporary instance.

   .. code:: bash

      sudo cp /var/lib/elasticsearch data --recursive --force
      sudo chown $USER:$USER data --recursive

#. Start the temporary Elasticsearch instance on a different port.

   .. code:: bash

      JAVA_HOME=$JAVA11_HOME ES_JAVA_OPTS="-Xms2g -Xmx2g" ./bin/elasticsearch --daemonize --pidfile elastic-6x-tmp.pid \
      -Ehttp.port=9500 -Ediscovery.type=single-node

#. Verify that the temporary instance is functioning correctly and that the
   document counts closely match those of your production environment.

   .. code:: bash

      curl --request GET "localhost:9500/_cat/indices?v"

Stage 3: Remove your Elasticsearch 6.x installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Uninstall Elasticsearch.

   If you are using Ubuntu:

   .. code:: bash

      sudo apt-get remove --purge elasticsearch

   If you are using Rocky Linux:

   .. code:: bash

      sudo yum remove elasticsearch

#. Rename Elasticsearch directories.

   .. code:: bash

      sudo mv /etc/elasticsearch /etc/elasticsearch-6
      sudo mv /var/lib/elasticsearch /var/lib/elasticsearch-6
      sudo mv /var/log/elasticsearch /var/log/elasticsearch-6

Stage 4: Upgrade Archivematica
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Upgrade Archivematica using your preferred installation method, ensuring that
Elasticsearch is upgraded to version 8.x and that the Elasticsearch server
address in your settings files includes the connection scheme (e.g.,
``http://127.0.0.1:9200`` instead of ``127.0.0.1:9200``). Omitting the scheme
will prevent Archivematica from connecting to Elasticsearch.

After restarting Archivematica, Elasticsearch will be configured with mappings
appropriate for the new version. However, the indexes will initially be empty
and will require data migration.

Stage 5: Reindex from temporary Elasticsearch 6.x instance
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Configure Elasticsearch to support reindexing from the temporary 6.x
   instance:

   .. code:: bash

      echo 'reindex.remote.whitelist: localhost:9500' | sudo tee -a /etc/elasticsearch/elasticsearch.yml
      sudo service elasticsearch restart

#. Migrate your Archivematica indexes using curl:

   .. code:: bash

      sleep 30
      curl --request POST "localhost:9200/_reindex?pretty" --header 'Content-Type: application/json' --data '
      {
        "source": {
          "remote": {
            "host": "http://localhost:9500"
          },
          "index": "aips"
        },
        "dest": {
          "index": "aips"
        }
      }'
      curl --request POST "localhost:9200/_reindex?pretty" --header 'Content-Type: application/json' --data '
      {
        "source": {
          "remote": {
            "host": "http://localhost:9500"
          },
          "index": "aipfiles"
        },
        "dest": {
          "index": "aipfiles"
        }
      }'
      curl --request POST "localhost:9200/_reindex?pretty" --header 'Content-Type: application/json' --data '
      {
        "source": {
          "remote": {
            "host": "http://localhost:9500"
          },
          "index": "transfers"
        },
        "dest": {
          "index": "transfers"
        }
      }'
      curl --request POST "localhost:9200/_reindex?pretty" --header 'Content-Type: application/json' --data '
      {
        "source": {
          "remote": {
            "host": "http://localhost:9500"
          },
          "index": "transferfiles"
        },
        "dest": {
          "index": "transferfiles"
        }
      }'

#. Verify reindexing was successful.

   .. code:: bash

      curl -X POST "http://localhost:9200/_flush"
      curl --request GET "localhost:9200/_cat/indices?v"

   You should see all your indices with the correct document counts. You should
   also verify that Archivematica is working correctly with Elasticsearch 8.x
   by checking the Dashboard and performing test searches.

Stage 6: Remove the Elasticsearch 6.x instance
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Stop the temporary Elasticsearch 6.x instance.

   .. code:: bash

      kill $(cat ~/elasticsearch-6.8.23/elastic-6x-tmp.pid)

#. Remove the Elasticsearch 6.x directory.

   .. code:: bash

      rm -rf ~/elasticsearch-6.8.23

.. _`Elasticsearch docs`: https://www.elastic.co/guide/en/elasticsearch/reference/8.19/snapshot-restore.html
.. _`release notes`: https://wiki.archivematica.org/Release_Notes
.. _`Reindex API`: https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-reindex.html
.. _`es-reindex.sh`: https://github.com/artefactual-labs/ops-helpers/blob/master/es-helpers/README.md#es-reindexsh-update-search-indices
.. _FITS: https://harvard-lts.github.io/fits/about
.. _`ansible-archivematica-src`: https://github.com/artefactual-labs/ansible-archivematica-src
