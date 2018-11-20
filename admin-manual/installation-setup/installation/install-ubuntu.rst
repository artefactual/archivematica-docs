.. _install-pkg-ubuntu:

===========================================
Manually Installing Archivematica on Ubuntu
===========================================

Archivematica packages are hosted at packages.archivematica.org as a central
place to store packages for multiple operating systems. Packages for both Ubuntu
16.04 and 18.04 are available.

.. note:: Manual installation using packages on Ubuntu is not officially
   supported. Please see :ref:`Instructions for new installation <instructions>`.

*On this page*

* :ref:`Installation instructions for Ubuntu 16.04 (Xenial) and Ubuntu 18.04 (Bionic) <ubuntu-instructions>`
* :ref:`Post-installation configuration <ubuntu-post-install-config>`

.. _ubuntu-instructions:

Ubuntu 16.04 (Xenial) and Ubuntu 18.04 (Bionic) installation instructions
=========================================================================

1. Use these commands to install the repositories:

   Ubuntu 16.04 (Xenial):

   .. code:: bash

      sudo wget -O - https://packages.archivematica.org/1.8.x/key.asc  | sudo apt-key add -
      sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.8.x/ubuntu xenial main" >> /etc/apt/sources.list'
      sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.8.x/ubuntu-externals xenial main" >> /etc/apt/sources.list'

   Ubuntu 18.04 (Bionic):

   .. code:: bash

      sudo wget -O - https://packages.archivematica.org/1.8.x/key.asc  | sudo apt-key add -
      sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.8.x/ubuntu bionic main" >> /etc/apt/sources.list'
      sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.8.x/ubuntu-externals bionic main" >> /etc/apt/sources.list'

2. Add Elasticsearch package source (optional). Elasticsearch comes from its own
   package repository.

   .. note::
      Skip this step if you are planning to run :ref:`Archivematica without
      Elasticsearch <install-elasticsearch>`.

   Ubuntu 16.04 (Xenial):  

   .. code:: bash

      sudo wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
      sudo sh -c 'echo "deb http://packages.elasticsearch.org/elasticsearch/1.7/debian stable main" >> /etc/apt/sources.list'

   Ubuntu 18.04 (Bionic): 

   Skip this step, the package will be downloaded directly in step 4.

3. Update to the most recent OS release. This step will also fetch a list of
   the software from the package repositories you just added to your system.

   .. code:: bash

      sudo apt-get update
      sudo apt-get upgrade

4. Install Elasticsearch (optional)

   .. note:: Skip this step if you are planning to run Archivematica in indexless
      mode (without Elasticsearch).

   Ubuntu 16.04 (Xenial):

   .. code:: bash

      sudo apt-get install elasticsearch

   Ubuntu 18.04 (Bionic):

   .. code:: bash

      sudo apt-get install -y htop ntp unzip openjdk-8-jre-headless
      sudo curl -s https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.7.6.deb -o /var/cache/apt/archives/elasticsearch-1.7.6.deb
      sudo dpkg -i /var/cache/apt/archives/elasticsearch-1.7.6.deb

5. Install the Storage Service package.

   .. code:: bash

      sudo apt-get install -y archivematica-storage-service

6. Configure the Storage Service.

   .. code:: bash

      sudo rm -f /etc/nginx/sites-enabled/default
      sudo ln -s /etc/nginx/sites-available/storage /etc/nginx/sites-enabled/storage

   .. warning:: If you are planning to use the `Sword API`_ of the Archivematica
      Storage Service, then (due to a `known issue`_), you must instruct
      Gunicorn to use the ``sync`` worker class:

   .. code:: bash

      sudo sh -c 'echo "SS_GUNICORN_WORKER_CLASS=sync" >> /etc/default/archivematica-storage-service'

7. Update ``pip``. This is used to install Python dependencies for both the
   Storage Service and the Dashboard. This step is optional on Ubuntu 16.04, but
   is still a good idea to get the most recent version of ``pip``.

   .. code:: bash

      curl -Ls https://bootstrap.pypa.io/get-pip.py | sudo python -

8. Install the Archivematica packages. The order of installation is important -
   the archivematica-mcp-server package must be installed before the dashboard
   package. While it is possible to install the archivematica-mcp-client package
   on a separate machine, that configuration is not documented in these
   instructions.

   The archivematica-mcp-server package will install MySQL and configure the
   database used by Archivematica. Depending on the version of MySQL that is
   installed, the interfaces that you see may differ slightly.

   When you are prompted to create a password for the archivematica-mcp-server,
   you must use ``demo`` as the password during the install process. The
   password can be changed after the installation is complete.

   .. code:: bash

      sudo apt-get install -y archivematica-mcp-server
      sudo apt-get install -y archivematica-dashboard
      sudo apt-get install -y archivematica-mcp-client

9. Configure the Archivematica components (optional). There are a number of
   environment variables that Archivematica recognizes which can be used to
   alter how it is configured. For the full list, see the
   `Dashboard install README`_, the `MCPClient install README`_, and the
   `MCPServer install README`_.

   .. note:: If you are planning on running Archivematica in indexless mode (i.e.
      without Elasticsearch), then modify the relevant systemd EnvironmentFile
      files by adding lines that set the relevant environment variables to ``false``:

   .. code:: bash

      sudo sh -c 'echo "ARCHIVEMATICA_DASHBOARD_DASHBOARD_SEARCH_ENABLED=false" >> /etc/default/archivematica-dashboard'
      sudo sh -c 'echo "ARCHIVEMATICA_MCPSERVER_MCPSERVER_SEARCH_ENABLED=false" >> /etc/default/archivematica-mcp-server'
      sudo sh -c 'echo "ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_SEARCH_ENABLED=false" >> /etc/default/archivematica-mcp-client'

10. Configure the dashboard.

    .. code:: bash

       sudo ln -s /etc/nginx/sites-available/dashboard.conf /etc/nginx/sites-enabled/dashboard.conf

11. Start Elasticsearch (optional).

    .. note:: Skip this step if you are planning to run Archivematica in indexless
       mode (without Elasticsearch).

    .. code:: bash

       sudo service elasticsearch restart
       sudo update-rc.d elasticsearch defaults 95 10

12. Start the remaining services

    .. code:: bash

       sudo service clamav-freshclam restart
       sudo service clamav-daemon start
       sudo service gearman-job-server restart
       sudo service archivematica-mcp-server start
       sudo service archivematica-mcp-client restart
       sudo service archivematica-storage-service start
       sudo service archivematica-dashboard restart
       sudo service nginx restart
       sudo systemctl enable fits-nailgun
       sudo service fits-nailgun start

    If you have trouble with the gearman command try restarting it:

    .. code:: bash

       sudo service gearman-job-server restart

13. Configure your firewall (if applicable)

    On Ubuntu, the default firewall configuration tool is ufw (Uncomplicated
    Firewall). To see the firewall status, enter:

    .. code:: bash

       sudo ufw status

    If ufw is active, you must ensure that it is not blocking the ports used by
    the dashboard and the Storage Service, i.e., 80 and 8000.

    .. code:: bash

       sudo ufw allow 80
       sudo ufw allow 8000
       sudo ufw reload

14. Complete :ref:`Post Install Configuration <ubuntu-post-install-config>`.

.. _ubuntu-post-install-config:

Post-install configuration
--------------------------

After successfully completing a new installation, follow these steps to complete
the configuration of your new server.

1. The Storage Service runs as a separate web application from the Archivematica
   dashboard. The Storage Service is exposed on port 8000 by default for Ubuntu
   package installs. Use your web browser to navigate to the Storage Service at
   the IP address of the machine you have been installing on, e.g.,
   ``http://<MY-IP-ADDR>:8000`` (or ``http://localhost:8000`` or
   ``http://127.0.0.1:8000`` if this is a local development setup).

   If you are using an IP address or fully-qualified domain name instead of
   localhost, you will need to configure your firewall rules and allow access
   only to ports 80 and 8000 for Archivematica usage.

2. The Storage Service has its own set of users. Add at least one
   administrative user:: 

    sudo -u archivematica bash -c " \
        set -a -e -x
        source /etc/default/archivematica-storage-service || \
            source /etc/sysconfig/archivematica-storage-service \
                || (echo 'Environment file not found'; exit 1)
        cd /usr/lib/archivematica/storage-service
        /usr/share/archivematica/virtualenvs/archivematica-storage-service/bin/python manage.py createsuperuser
        ";

   After you have created this user an API key will be generated that will connect
   the Archivematica pipeline to the Storage Service API. Click edit to see the
   new user's details. The API key will be found at the bottom of the page.
   Copy this to your clipboard as it will be used later on in the
   post-installation configuration.

   .. note::
      It is recommended that you also modify the test user and change the
      default password. This will also result in a new API key for the test
      user but that does not need to be copied to the clipboard in this
      instance.

3. To finish the installation, use your web browser to navigate to the
   Archivematica dashboard using the IP address of the machine on which you have
   been installing, e.g., ``http://<MY-IP-ADDR>:80`` (or ``http://localhost:80``
   or ``http://127.0.0.1:80`` if this is a local development setup).

4. At the Welcome page, create an administrative user for the Archivematica
   pipeline by entering the organization name, the organization identifier,
   username, email, and password.

5. On the next screen, connect your pipeline to the Storage Service by entering
   the Storage Service URL and username, and by pasting in the API key that you
   copied in Step (2).

   - If the Storage Service and the Archivematica dashboard are installed on
     the same machine, then you should supply ``http://127.0.0.1:8000`` as the
     Storage Service URL at this screen.
   - If the Storage Service and the Archivematica dashboard are installed on
     different nodes (servers), then you should use the IP address or
     fully-qualified domain name of your Storage Service instance,
     e.g., ``http://<MY-IP-ADDR>:8000`` *and* you must ensure that any firewall
     rules (i.e., iptables, ufw, AWS security groups, etc.) are configured to
     allow requests from your dashboard IP to your Storage Service IP on the
     appropriate port.

:ref:`Back to the top <install-pkg-ubuntu>`

.. _`issue #1065`: https://github.com/artefactual/archivematica/issues/1065
.. _`known issue`: https://github.com/artefactual/archivematica-storage-service/issues/312
.. _`Sword API`: https://wiki.archivematica.org/Sword_API
.. _`known issue with pip`: https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1658844
.. _`Dashboard install README`: https://github.com/artefactual/archivematica/blob/stable/1.8.x/src/dashboard/install/README.md
.. _`MCPClient install README`: https://github.com/artefactual/archivematica/blob/stable/1.8.x/src/MCPClient/install/README.md
.. _`MCPServer install README`: https://github.com/artefactual/archivematica/blob/stable/1.8.x/src/MCPServer/install/README.md
