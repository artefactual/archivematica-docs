.. _upgrade:

============================================================
Upgrade from Archivematica |previous_version|.x to |release|
============================================================

*On this page:*

* :ref:`Create a backup <create-backup>`
* :ref:`Upgrade Ubuntu package install <upgrade-ubuntu>`
* :ref:`Upgrade CentOS/Red Hat package install <upgrade-centos>`
* :ref:`Upgrade search indices <upgrade-search-indices>`
* :ref:`Upgrade in indexless mode <upgrade-indexless>`
* :ref:`Upgrade with output capturing disabled <upgrade-no-output-capture>`

.. note::

   While it is possible to upgrade a GitHub-based source install using ansible,
   these instructions do not cover that scenario.

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

.. _upgrade-ubuntu:

Upgrade on Ubuntu
-----------------

Before you start: Archivematica 1.7 stopped using ``/usr/share/python`` as the
home for our Python virtual environments. We did this because it was causing
Ubuntu Xenial to break when attempting to upgrade a system package called
``python-minimal``. If you're running Ubuntu Xenial the following commands are
going to be necessary to continue the upgrade:

.. code:: bash

   sudo rm -rf /usr/share/python/archivematica-dashboard
   sudo rm -rf /usr/share/python/archivematica-mcp-server
   sudo rm -rf /usr/share/python/archivematica-mcp-client

1. Update the operating system.

   .. code:: bash

      sudo apt-get update && sudo apt-get upgrade

2. Update package sources.

   In Ubuntu 16.04:

   .. code:: bash

      sudo add-apt-repository --remove ppa:archivematica/externals
      echo 'deb [arch=amd64] http://packages.archivematica.org/1.8.x/ubuntu xenial main' >> /etc/apt/sources.list
      echo 'deb [arch=amd64] http://packages.archivematica.org/1.8.x/ubuntu-externals xenial main' >> /etc/apt/sources.list

   Optionally you can remove the lines referencing
   packages.archivematica.org/|previous_version|.x from /etc/apt/sources.list.

   In Ubuntu 18.04:

   .. code:: bash

      sudo add-apt-repository --remove ppa:archivematica/externals
      echo 'deb [arch=amd64] http://packages.archivematica.org/1.8.x/ubuntu bionic main' >> /etc/apt/sources.list
      echo 'deb [arch=amd64] http://packages.archivematica.org/1.8.x/ubuntu-externals bionic main' >> /etc/apt/sources.list

   Optionally you can remove the lines referencing
   packages.archivematica.org/|previous_version|.x from /etc/apt/sources.list.

3. Update the Storage Service.

   .. code:: bash

      sudo apt-get update
      sudo apt-get install archivematica-storage-service

4. Update the Application Container. As of Storage Service version 0.10.0, the
   Storage Service uses Gunicorn as WSGI server. This means that the old uwsgi
   server needs to be stopped and disabled after performing the upgrade.

   .. code:: bash

      sudo service uwsgi stop
      sudo update-rc.d uwsgi disable

5. Update Archivematica. During the update process you may be asked about
   updating configuration files. Choose to accept the maintainers versions. You
   will also be asked about updating the database - say 'ok' to each of those
   steps. If you have set a password for the root MySQL database user, enter it
   when prompted. It is better to update the dashboard before updating the mcp
   components.

   .. code:: bash

      sudo apt-get upgrade

6. Disable unused services. Archivematica |release| uses Nginx as HTTP server,
   and Gunicorn as WSGI server. This means that some services used in
   Archivematica |previous_release| should be stopped and disabled before
   performing the upgrade.

   .. code:: bash

       sudo service apache2 stop
       sudo update-rc.d apache2 disable

7. Restart services.

   .. code:: bash

      sudo service nginx restart
      sudo restart archivematica-storage-service
      sudo ln -s /etc/nginx/sites-available/dashboard.conf /etc/nginx/sites-enabled/dashboard.conf
      sudo service gearman-job-server restart
      sudo restart archivematica-mcp-server
      sudo restart archivematica-mcp-client
      sudo start archivematica-dashboard
      sudo restart fits-nailgun
      sudo freshclam
      sudo service clamav-daemon restart
      sudo service nginx restart

   .. note:: Depending on which service manager (init system) you are using
      (e.g., `systemd <https://freedesktop.org/wiki/Software/systemd/>`_,
      `Upstart <http://upstart.ubuntu.com/>`_, or init), the above ``start``
      and ``restart`` commands may not work. Please refer to the documentation
      for your operating system's service manager for more details.

   .. note:: Depending on how your Ubuntu system is set up, you may have trouble
      restarting gearman with the command in the block above. If that is the
      case, try this command instead:

   .. code:: bash

      sudo restart gearman-job-server

8. Remove unused services.

   .. code:: bash

       sudo apt-get remove --purge python-pip apache2 uwsgi

.. _upgrade-centos:

Upgrade on CentOS/Red Hat
-------------------------

1. Upgrade the repositories for |version|:

   .. code:: bash

      sudo sed -i 's/1.7.x/1.8.x/g' /etc/yum.repos.d/archivematica*

2. Upgrade the packages:

   .. code:: bash

      sudo yum update

3. Once the new packages are installed, upgrade the databases for both
   Archivematica and the Storage Service. This can be done with:

   .. code:: bash

      sudo -u archivematica bash -c " \
          set -a -e -x
          source /etc/default/archivematica-dashboard || \
              source /etc/sysconfig/archivematica-dashboard \
                  || (echo 'Environment file not found'; exit 1)
          cd /usr/share/archivematica/dashboard
          /usr/share/archivematica/virtualenvs/archivematica-dashboard/bin/python manage.py migrate
      ";

      sudo -u archivematica bash -c " \
          set -a -e -x
          source /etc/default/archivematica-storage-service || \
              source /etc/sysconfig/archivematica-storage-service \
                  || (echo 'Environment file not found'; exit 1)
          cd /usr/lib/archivematica/storage-service
          /usr/share/archivematica/virtualenvs/archivematica-storage-service/bin/python manage.py migrate
      ";

4. Restart the Archivematica related services, and continue using the system:

   .. code:: bash

      sudo systemctl restart archivematica-storage-service
      sudo systemctl restart archivematica-dashboard
      sudo systemctl restart archivematica-mcp-client
      sudo systemctl restart archivematica-mcp-server

5. Depending on your browser settings, you may need to clear your browser cache
   to make the dashboard pages load properly. For example in Firefox or Chrome
   you should be able to clear the cache with control-shift-R or
   command-shift-F5.

.. _upgrade-search-indices:

Upgrade search indices
----------------------

.. note::

   Ignore this section if you are planning to run Archivematica without a
   search index. Instead, follow the instructions on :ref:`how
   to upgrade Archivematica in indexless mode <upgrade-indexless>`.

To complete these instructions you need to know the paths of your transfer
backlog and AIP storage locations. Respectively, these usually are:

* :file:`/var/archivematica/sharedDirectory/www/AIPsStore/transferBacklog`
* :file:`/var/archivematica/sharedDirectory/www/AIPsStore`

You can confirm the paths of your installation in the Location tab of the
Storage Service.

This process has two steps:

1. **Rebuild transfer index:**

   Run the following command passing the path of the transfer backlog location
   you confirmed above:

   .. code:: bash

      sudo -u archivematica bash -c " \
          set -a -e -x
          source /etc/default/archivematica-dashboard || \
              source /etc/sysconfig/archivematica-dashboard \
                  || (echo 'Environment file not found'; exit 1)
          cd /usr/share/archivematica/dashboard
          /usr/share/archivematica/virtualenvs/archivematica-dashboard/bin/python manage.py \
              rebuild_transfer_backlog \
                  --transfer-backlog-dir=/var/archivematica/sharedDirectory/www/AIPsStore/transferBacklog
      ";

   This may take a while if you have a large backlog. Once it completes, you
   should be able to see your Transfer Backlog in the Appraisal tab and in the
   Backlog tab.

   Depending on your browser settings, you may need to clear your browser cache
   to make the dashboard pages load properly. For example in Firefox or Chrome
   yo should be able to clear the cache with ``control-shift-R`` or
   ``command-shift-F5``.

2. **Rebuild the AIP index:**

   Run the following command passing the path of the AIP storage location you
   confirmed above:

   .. code:: bash

      sudo -u archivematica bash -c " \
          set -a -e -x
          source /etc/default/archivematica-dashboard || \
              source /etc/sysconfig/archivematica-dashboard \
                  || (echo 'Environment file not found'; exit 1)
          cd /usr/share/archivematica/dashboard
          /usr/share/archivematica/virtualenvs/archivematica-dashboard/bin/python manage.py \
              rebuild_elasticsearch_aip_index_from_files \
                  /var/archivematica/sharedDirectory/www/AIPsStore
      ";

   This may take a while if you have many AIPs stored.

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

.. _`known issue with pip`: https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1658844
