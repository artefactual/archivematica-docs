.. _install-pkg-centos:

==========================================
Installing Archivematica on CentOS/Red Hat
==========================================

Archivematica versions 1.5.1 and higher support installation on CentOS/Red Hat.

*On this page*

* :ref:`Installation instructions <centos-instructions>`
* :ref:`Post-installation configuration <centos-post-install-config>`

.. _centos-instructions:

Installation instructions
-------------------------

1. Prerequisites

   Update your system

   .. code:: bash

      sudo yum update

   If your environment uses SELinux, at a minimum you will need to run the
   following commands. Additional configuration may be required for your local
   setup.

   .. code:: bash

      # Allow Nginx to use ports 81 and 8001
      sudo semanage port -m -t http_port_t -p tcp 81
      sudo semanage port -a -t http_port_t -p tcp 8001
      # Allow Nginx to connect the MySQL server and Gunicorn backends
      sudo setsebool -P httpd_can_network_connect_db=1
      sudo setsebool -P httpd_can_network_connect=1
      # Allow Nginx to change system limits
      sudo setsebool -P httpd_setrlimit 1

2. Some extra repositories need to be installed in order to fulfill the
   installation procedure.

   * Extra packages for enterprise Linux:

   .. code:: bash

      sudo yum install -y epel-release

   * Elasticsearch (optional):

   .. note::
      Skip this step if you are planning to run Archivematica in
      indexless mode (without Elasticsearch).

   .. code:: bash

      sudo -u root rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
      sudo -u root bash -c 'cat << EOF > /etc/yum.repos.d/elasticsearch.repo
      [elasticsearch-1.7]
      name=Elasticsearch repository for 1.7 packages
      baseurl=https://packages.elastic.co/elasticsearch/1.7/centos
      gpgcheck=1
      gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
      enabled=1
      EOF'

   * Archivematica:

   While Archivematica 1.7 is in development, please use these commands to
   install the development repositories:

   .. code:: bash

      sudo -u root bash -c 'cat << EOF > /etc/yum.repos.d/archivematica.repo
      [archivematica]
      name=archivematica
      baseurl=http://jenkins-ci.archivematica.org/repos/rpm/release-1.7/
      gpgcheck=0
      enabled=1
      [archivematica-storage-service]
      name=archivematica-storage-service
      baseurl=http://jenkins-ci.archivematica.org/repos/rpm/release-0.11/
      gpgcheck=0
      enabled=1
      EOF'

      sudo -u root bash -c 'cat << EOF > /etc/yum.repos.d/archivematica-extras.repo
      [archivematica-extras]
      name=archivematica-extras
      baseurl=https://packages.archivematica.org/1.7.x/centos-extras
      gpgcheck=1
      gpgkey=https://packages.archivematica.org/1.7.x/key.asc
      enabled=1
      EOF'

   If the release has been completed, you should use these commands to install
   the final repositories:

   .. code:: bash

      sudo -u root bash -c 'cat << EOF > /etc/yum.repos.d/archivematica.repo
      [archivematica]
      name=archivematica
      baseurl=https://packages.archivematica.org/1.7.x/centos
      gpgcheck=1
      gpgkey=https://packages.archivematica.org/1.7.x/key.asc
      enabled=1
      EOF'

      sudo -u root bash -c 'cat << EOF > /etc/yum.repos.d/archivematica-extras.repo
      [archivematica-extras]
      name=archivematica-extras
      baseurl=https://packages.archivematica.org/1.7.x/centos-extras
      gpgcheck=1
      gpgkey=https://packages.archivematica.org/1.7.x/key.asc
      enabled=1
      EOF'

3. Common services like Elasticsearch, MariaDB and Gearmand should be installed
   and enabled before the Archivematica install.

   .. note:: Do not enable Elasticsearch if you are running Archivematica in
      indexless mode.

   .. code:: bash

      sudo -u root yum install -y java-1.8.0-openjdk-headless elasticsearch mariadb-server gearmand
      sudo -u root systemctl enable elasticsearch
      sudo -u root systemctl start elasticsearch
      sudo -u root systemctl enable mariadb
      sudo -u root systemctl start mariadb
      sudo -u root systemctl enable gearmand
      sudo -u root systemctl start gearmand

4. Install Archivematica Storage Service

   * First, install the packages:

     .. code:: bash

        sudo -u root yum install -y python-pip archivematica-storage-service

     .. warning:: If you are planning to use the `Sword API`_ of the
        Archivematica Storage Service, then (due to a `known issue`_), you must
        instruct Gunicorn to use the ``sync`` worker class:

     .. code:: bash

        sudo sh -c 'echo "SS_GUNICORN_WORKER_CLASS=sync" >> /etc/sysconfig/archivematica-storage-service'

   * After the package is installed, populate the SQLite database, and collect
     some static files used by django.  These tasks must be run as
     “archivematica” user.

     .. code:: bash

        sudo -u archivematica bash -c " \
        set -a -e -x
        source /etc/sysconfig/archivematica-storage-service
        cd /usr/lib/archivematica/storage-service
        /usr/share/archivematica/virtualenvs/archivematica-storage-service/bin/python manage.py migrate
        ";

   * Now enable and start the archivematica-storage-service, rngd (needed for
     encrypted spaces) and the Nginx frontend:

     .. code:: bash

        sudo -u root systemctl enable archivematica-storage-service
        sudo -u root systemctl start archivematica-storage-service
        sudo -u root systemctl enable nginx
        sudo -u root systemctl start nginx
        sudo -u root systemctl enable rngd
        sudo -u root systemctl start rngd

     .. note:: The Storage Service will be available at ``http://<ip>:8001``.

5. Installing Archivematica Dashboard and MCP Server

   There are a number of environment variables that Archivematica recognizes
   which can be used to alter how it is configured. For the full list, see the
   `Dashboard install README`_, the `MCPClient install README`_, and the
   `MCPServer install README`_.

   * First, install the packages:

     .. code:: bash

        sudo -u root yum install -y archivematica-common archivematica-mcp-server archivematica-dashboard

   * Create user and mysql database with:

     .. code:: bash

        sudo -H -u root mysql -hlocalhost -uroot -e "DROP DATABASE IF EXISTS MCP; CREATE DATABASE MCP CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
        sudo -H -u root mysql -hlocalhost -uroot -e "CREATE USER 'archivematica'@'localhost' IDENTIFIED BY 'demo';"
        sudo -H -u root mysql -hlocalhost -uroot -e "GRANT ALL ON MCP.* TO 'archivematica'@'localhost';"

   * And as archivematica user, run migrations:

     .. code:: bash

        sudo -u archivematica bash -c " \
        set -a -e -x
        source /etc/sysconfig/archivematica-dashboard
        cd /usr/share/archivematica/dashboard
        /usr/share/archivematica/virtualenvs/archivematica-dashboard/bin/python manage.py migrate
        ";

   * Start and enable services:

     .. code:: bash

        sudo -u root systemctl enable archivematica-mcp-server
        sudo -u root systemctl start archivematica-mcp-server
        sudo -u root systemctl enable archivematica-dashboard
        sudo -u root systemctl start archivematica-dashboard

   * Restart Nginx in order to load the dashboard config file:

     .. code:: bash

        sudo -u root systemctl restart nginx

     .. note:: The dashboard will be available at ``http://<ip>:81``

6. Installing Archivematica MCP client

   * First, add extra repos with the MCP Client dependencies:

     * Nux multimedia repo

       .. code:: bash

          sudo rpm -Uvh https://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm

     * Forensic tools repo

       .. code:: bash

          sudo rpm -Uvh https://forensics.cert.org/cert-forensics-tools-release-el7.rpm

   * Then install the package:

     .. code:: bash

        sudo -u root yum install -y archivematica-mcp-client

   * The MCP Client expects some programs in certain paths, so we put them in place:

     .. code:: bash

        sudo ln -s /usr/bin/7za /usr/bin/7z

   * Tweak ClamAV configuration:

     .. code:: bash

        sudo -u root sed -i 's/^#TCPSocket/TCPSocket/g' /etc/clamd.d/scan.conf
        sudo -u root sed -i 's/^Example//g' /etc/clamd.d/scan.conf

   * Indexless mode:

     If you are planning on running Archivematica in indexless mode (i.e.,
     without Elasticsearch), then modify the relevant systemd EnvironmentFile
     files by adding lines that set the relevant environment variables to
     ``false``:

     .. code:: bash

         sudo sh -c 'echo "ARCHIVEMATICA_DASHBOARD_DASHBOARD_SEARCH_ENABLED=false" >> /etc/sysconfig/archivematica-dashboard'
         sudo sh -c 'echo "ARCHIVEMATICA_MCPSERVER_MCPSERVER_SEARCH_ENABLED=false" >> /etc/sysconfig/archivematica-mcp-server'
         sudo sh -c 'echo "ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_SEARCH_ENABLED=false" >> /etc/sysconfig/archivematica-mcp-client'

   * After that, we can enable and start/restart services

     .. code:: bash

        sudo -u root systemctl enable archivematica-mcp-client
        sudo -u root systemctl start archivematica-mcp-client
        sudo -u root systemctl enable fits-nailgun
        sudo -u root systemctl start fits-nailgun
        sudo -u root systemctl enable clamd@scan
        sudo -u root systemctl start clamd@scan
        sudo -u root systemctl restart archivematica-dashboard
        sudo -u root systemctl restart archivematica-mcp-server

7. Finalizing installation

   **Configuration**

   Each service has a configuration file in
   /etc/sysconfig/archivematica-packagename

   **Troubleshooting**

   If IPv6 is disabled, Nginx may refuse to start. If that is the case make sure
   that the listen directives used under /etc/nginx are not using IPv6 addresses
   like [::]:80.

   CentOS will install firewalld which will be running default rules that will
   likely be blocking ports 81 and 8001. If you are not able to access the
   dashboard and Storage Service, then use the following command to check if
   firewalld is running:

   .. code:: bash

      sudo systemctl status firewalld

   If firewalld is running, you will likely need to modify the firewall rules
   to allow access to ports 81 and 8001 from your location:

   .. code:: bash

      sudo firewall-cmd --add-port=81/tcp --permanent
      sudo firewall-cmd --add-port=8001/tcp --permanent
      sudo firewall-cmd --reload


8. Complete :ref:`Post Install Configuration <centos-post-install-config>`.

.. _centos-post-install-config:

Post-install configuration
--------------------------

After successfully completing a new installation, follow these steps to complete
the configuration of your new server.

1. The Storage Service runs as a separate web application from the Archivematica
   dashboard. The Storage Service is exposed on port 8001 by default when
   deploying using RPM packages. Use your web browser to navigate to the
   Storage Service at the IP address of the machine you have been installing
   on, e.g., ``http://<MY-IP-ADDR>:8001`` (or ``http://localhost:8001`` or
   ``http://127.0.0.1:8001`` if this is a local development setup). The default
   username and password are ``test``/ ``test``.

   If you are using an IP address or fully-qualified domain name instead of
   localhost, you will need to configure your firewall rules and allow access
   only to ports 81 and 8001 for Archivematica usage.

2. The Storage Service has its own set of users. Navigate to
   **Administration > Users** and add at least one administrative user. After
   you have created this user an API key will be generated that will connect
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
   Archivematica dashboard using the IP address of the machine you have been
   installing on. (Note that the dashboard will be exposed on port 81.)

4. At the Welcome page, create an administrative user for the Archivematica
   pipeline by entering the organization name, the organization identifier,
   username, email, and password.

5. On the next screen, connect your pipeline to the Storage Service by entering
   the Storage Service URL and username, and by pasting in the API key that you
   copied in Step (2).

   - If the Storage Service and the Archivematica dashboard are installed on
     the same machine, then you should supply ``http://127.0.0.1:8001`` as the
     Storage Service URL at this screen.
   - If the Storage Service and the Archivematica dashboard are installed on
     different nodes (servers), then you should use the IP address or
     fully-qualified domain name of your Storage Service instance,
     e.g., ``http://<MY-IP-ADDR>:8001`` *and* you must ensure that any firewall
     rules (i.e., iptables, ufw, AWS security groups, etc.) are configured to
     allow requests from your dashboard IP to your Storage Service IP on the
     appropriate port.

:ref:`Back to the top <install-pkg-centos>`

.. _`Dashboard install README`: https://github.com/artefactual/archivematica/blob/stable/1.7.x/src/dashboard/install/README.md
.. _`MCPClient install README`: https://github.com/artefactual/archivematica/blob/stable/1.7.x/src/MCPClient/install/README.md
.. _`MCPServer install README`: https://github.com/artefactual/archivematica/blob/stable/1.7.x/src/MCPServer/install/README.md
.. _`known issue`: https://github.com/artefactual/archivematica-storage-service/issues/312
.. _`Sword API`: https://wiki.archivematica.org/Sword_API
