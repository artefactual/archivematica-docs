.. _upgrade:

============================================================
Upgrade from Archivematica |previous_version|.x to |release|
============================================================

*On this page:*

* :ref:`Create a backup <create-backup>`
* :ref:`Upgrade Ubuntu package install <upgrade-ubuntu>`
* :ref:`Upgrade CentOS/Red Hat package install <upgrade-centos>`
* :ref:`Upgrade in indexless mode <upgrade-indexless>`

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

1. Update the operating system.

   .. code:: bash

      sudo apt-get update && sudo apt-get upgrade

2. Update Python Setuptools. This is used to install Python dependencies for
   both the Storage Service and the dashboard. There is a `known issue with pip`_
   on Ubuntu 14.04 which makes this step necessary.

   .. code:: bash

      sudo pip install -U setuptools

3. Update package sources.

   .. code:: bash

      sudo add-apt-repository --remove ppa:archivematica/externals
      echo 'deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu trusty main' >> /etc/apt/sources.list
      echo 'deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu-externals trusty main' >> /etc/apt/sources.list

   Optionally you can remove the lines referencing
   packages.archivematica.org/|previous_version|.x from /etc/apt/sources.list.

4. Update the Storage Service.

   .. code:: bash

      sudo apt-get update
      sudo apt-get install archivematica-storage-service

5. Update the Application Container. As of Storage Service version 0.10.0, the
   Storage Service uses Gunicorn as WSGI server. This means that the old uwsgi
   server needs to be stopped and disabled after performing the upgrade.

   .. code:: bash

      sudo service uwsgi stop
      sudo update-rc.d uwsgi disable

6. Update Archivematica. During the update process you may be asked about
   updating configuration files. Choose to accept the maintainers versions. You
   will also be asked about updating the database - say 'ok' to each of those
   steps. If you have set a password for the root MySQL database user, enter it
   when prompted. It is better to update the dashboard before updating the mcp
   components.

   .. code:: bash

      sudo apt-get upgrade

7. Disable unused services. Archivematica |release| uses Nginx as HTTP server,
   and Gunicorn as WSGI server. This means that some services used in
   Archivematica |previous_release| should be stopped and disabled before
   performing the upgrade.

   .. code:: bash

       sudo service apache2 stop
       sudo update-rc.d apache2 disable

8. Restart services.

   .. code:: bash

      sudo service nginx restart
      sudo restart archivematica-storage-service
      sudo ln -s /etc/nginx/sites-available/dashboard.conf /etc/nginx/sites-enabled/dashboard.conf
      sudo service gearman-job-server restart
      sudo restart archivematica-mcp-server
      sudo restart archivematica-mcp-client
      sudo start archivematica-dashboard
      sudo restart fits
      sudo freshclam
      sudo service clamav-daemon restart
      sudo service nginx restart

   .. note:: Depending on how your Ubuntu system is set up, you may have trouble
      restarting gearman with the command in the block above. If that is the
      case, try this command instead:

   .. code:: bash

      sudo restart gearman-job-server

9. Remove unused services.

   .. code:: bash

       sudo apt-get remove --purge python-pip apache2 uwsgi

.. _update-transfer-index:

Update Transfer Index
^^^^^^^^^^^^^^^^^^^^^

This new feature allows you to update a backlog created in an earlier version
of Archivematica so that it can be used with the Appraisal Tab and the Backlog
tab.

.. IMPORTANT::

   These are experimental instructions. Do not use them on a production system
   unless you have a back-up you can restore from.

.. note::

   Archivematica devtools is a set of utilities that was built by developers while
   working on Archivematica. Devtools includes helper scripts that make it easier
   to perform certain maintenance tasks. One of those tools is used to rebuild
   the Transfer index in Elasticsearch, which is used by the different backlog
   tools such as the new Appraisal Tab. Currently this must be installed using
   git. These instructions will be updated if a packaged version becomes available.
   See the `devtools repo`_ for more details.


1. Install devtools.

   .. code:: bash

       sudo apt-get install git ruby-ronn
       git clone https://github.com/artefactual/archivematica-devtools
       cd archivematica-devtools
       make install

2. Confirm location of transfer backlog

   You need to know the path to the Transfer Backlog Location. The default
   path is '/var/archivematica/sharedDirectory/www/AIPsStore/transferBacklog'.
   You can confirm the path for your installation by:

   - logging into the Storage Service and clicking on the Locations tab.
   - type 'backlog' in the search searchbox
   - copy the value in the column labelled 'path' (there should be only one row)


3. Rebuild transfer index

   Using the path you confirmed above, replace the text '/path/to/transfers'
   with the correct path for your system.

   .. code:: bash

       am rebuild-transfer-backlog /path/to/transfers

   This may take a while if you have a large backlog. Once it completes, you
   should be able to see your Transfer Backlog in the Appraisal tab and in the
   Backlog tab.

   Depending on your browser settings, you may need to clear your browser cache
   to make the dashboard pages load properly. For example in Firefox or Chrome
   you should be able to clear the cache with control-shift-R or
   command-shift-F5.

.. _upgrade-centos:

Upgrade from Archivematica |previous_version| for CentOS/Red Hat
--------------------------------------------------------------------------------

1. Upgrade the repositories for |version|:

   .. code:: bash

      sudo sed -i 's/1.6.x/1.7.x/g' /etc/yum.repos.d/archivematica*

2. Upgrade the packages:

   .. code:: bash

      sudo yum update

3. Once the new packages are installed, upgrade the databases for both
   Archivematica and the Storage Service. This can be done with:

   .. code:: bash

      sudo -u archivematica bash -c " \
      set -a -e -x
      source /etc/sysconfig/archivematica-storage-service
      cd /usr/lib/archivematica/storage-service
      /usr/share/python/archivematica-storage-service/bin/python manage.py migrate
      ";

      sudo -u archivematica bash -c " \
      set -a -e -x
      source /etc/sysconfig/archivematica-dashboard
      cd /usr/share/archivematica/dashboard
      /usr/share/python/archivematica-dashboard/bin/python manage.py migrate
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

Update Transfer Index
^^^^^^^^^^^^^^^^^^^^^

This new feature allows you to update a backlog created in an earlier version
of Archivematica so that it can be used with the Appraisal Tab and the Backlog
tab. To test this feature, follow the instructions

.. IMPORTANT::

   These are experimental instructions. Do not use them on a production system
   unless you have a back-up you can restore from.

1. Install devtools

   .. code:: bash

       sudo yum install -y archivematica-devtools

   .. note::

      Archivematica devtools is a set of utilities that was built by developers
      while working on Archivematica. Devtools includes helper scripts that
      make it easier to perform certain maintenance tasks. One of those tools
      is used to rebuild the Transfer index in Elasticsearch, which is used by
      the different backlog tools such as the new Appraisal Tab. Currently this
      must be installed using git. These instructions will be updated when a
      packaged version is available.  See the `devtools repo`_ for more details.

2. Find the path to the Transfer Backlog location. The default path is
   '/var/archivematica/sharedDirectory/www/AIPsStore/transferBacklog'. You can
   confirm the path for your installation by searching for it in the Storage Service:

   * Log into the Storage Service and click on the Locations tab.
   * Type 'backlog' in the searchbox.
   * Copy the value in the column labelled 'path' (there should be only one row)

3. Using the path you confirmed above, replace the text '/path/to/transfers'
   with the correct path for your system.

   .. code:: bash

       am rebuild-transfer-backlog /path/to/transfers

   This may take a while if you have a large backlog. Once it completes, you
   should be able to see your Transfer Backlog in the Appraisal tab and in the
   Backlog tab.

.. _upgrade-indexless:

Upgrade in indexless mode
-------------------------

As of Archivematica 1.7, Archivematica can be run in indexless mode; that is,
without Elasticsearch. Installing Archivematica without Elasticsearch means
reduced consumption of compute resources and lower operational complexity.
Disabling Elasticsearch means that the Backlog, Appraisal, and Archival Storage
tabs do not appear and their functionality is not available.

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

   If you are using Ubuntu 14.04, run the following commands.

   .. code:: bash

      sudo service elasticsearch stop
      sudo update-rc.d elasticsearch disable

   If you are using Ubuntu 16.04 or CentOS/Red Hat, run the following commands.

   .. code:: bash

      sudo -u root systemctl stop elasticsearch
      sudo -u root systemctl disable elasticsearch

:ref:`Back to the top <upgrade>`

.. _`known issue with pip`: https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1658844
.. _`devtools repo`: https:github.com/artefactual/archivematica-devtools
