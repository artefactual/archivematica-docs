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

   .. literalinclude:: scripts/am-centos-rpm.sh
      :language: bash
      :lines: 3

   If your environment uses SELinux, at a minimum you will need to run the
   following commands. Additional configuration may be required for your local
   setup.

   .. literalinclude:: scripts/am-centos-rpm.sh
      :language: bash
      :lines: 5-12

2. Some extra repositories need to be installed in order to fulfill the
   installation procedure.

   * Extra packages for enterprise Linux:

   .. literalinclude:: scripts/am-centos-rpm.sh
      :language: bash
      :lines: 14

   * Elasticsearch (optional):

   .. note::
      Skip this step if you are planning to run :ref:`Archivematica without
      Elasticsearch <install-elasticsearch>`.

   .. literalinclude:: scripts/am-centos-rpm.sh
      :language: bash
      :lines: 16-26

   * Archivematica:

      Use these commands to install the repositories:

   .. literalinclude:: scripts/am-centos-rpm.sh
      :language: bash
      :lines: 28-44


3. Common services like Elasticsearch, MariaDB and Gearmand should be installed
   and enabled before the Archivematica install.

   .. note:: Do not enable Elasticsearch if you are running Archivematica in
      indexless mode.

   .. literalinclude:: scripts/am-centos-rpm.sh
      :language: bash
      :lines: 51-57


4. Install Archivematica Storage Service

   * First, install the packages:

     .. literalinclude:: scripts/am-centos-rpm.sh
        :language: bash
        :lines: 59

     .. warning:: If you are planning to use the `Sword API`_ of the
        Archivematica Storage Service, then (due to a `known issue`_), you must
        instruct Gunicorn to use the ``sync`` worker class:

     .. code:: bash

        sudo sh -c 'echo "SS_GUNICORN_WORKER_CLASS=sync" >> /etc/sysconfig/archivematica-storage-service'

   * After the package is installed, populate the SQLite database, and collect
     some static files used by django.  These tasks must be run as
     “archivematica” user.

     .. literalinclude:: scripts/am-centos-rpm.sh
        :language: bash
        :lines: 61-65

   * Now enable and start the archivematica-storage-service, rngd (needed for
     encrypted spaces) and the Nginx frontend:


     .. literalinclude:: scripts/am-centos-rpm.sh
        :language: bash
        :lines: 81-86

     .. note:: The Storage Service will be available at ``http://<ip>:8001``.

5. Installing Archivematica Dashboard and MCP Server

   There are a number of environment variables that Archivematica recognizes
   which can be used to alter how it is configured. For the full list, see the
   `Dashboard install README`_, the `MCPClient install README`_, and the
   `MCPServer install README`_.

   * First, install the packages:

     .. literalinclude:: scripts/am-centos-rpm.sh
        :language: bash
        :lines: 88

   * Create user and mysql database with:

     .. literalinclude:: scripts/am-centos-rpm.sh
        :language: bash
        :lines: 90-92

   * And as archivematica user, run migrations:

     .. literalinclude:: scripts/am-centos-rpm.sh
        :language: bash
        :lines: 94-99

   * Start and enable services:

     .. literalinclude:: scripts/am-centos-rpm.sh
        :language: bash
        :lines: 101-104

   * Restart Nginx in order to load the dashboard config file:

     .. literalinclude:: scripts/am-centos-rpm.sh
        :language: bash
        :lines: 106

     .. note:: The dashboard will be available at ``http://<ip>:81``

6. Installing Archivematica MCP client

   * First, add extra repos with the MCP Client dependencies:

     * Nux multimedia repo

       .. literalinclude:: scripts/am-centos-rpm.sh
          :language: bash
          :lines: 108

     * Forensic tools repo

       .. literalinclude:: scripts/am-centos-rpm.sh
          :language: bash
          :lines: 109

   * Then install the package:

     .. literalinclude:: scripts/am-centos-rpm.sh
        :language: bash
        :lines: 111

   * The MCP Client expects some programs in certain paths, so we put them in place:

     .. literalinclude:: scripts/am-centos-rpm.sh
        :language: bash
        :lines: 113

   * Tweak ClamAV configuration:

     .. literalinclude:: scripts/am-centos-rpm.sh
        :language: bash
        :lines: 114-115

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

     .. literalinclude:: scripts/am-centos-rpm.sh
        :language: bash
        :lines: 117-124

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

   .. literalinclude:: scripts/am-centos-rpm.sh
      :language: bash
      :lines: 126-128

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
   ``http://127.0.0.1:8001`` if this is a local development setup).

   If you are using an IP address or fully-qualified domain name instead of
   localhost, you will need to configure your firewall rules and allow access
   only to ports 81 and 8001 for Archivematica usage.

2. The Storage Service has its own set of users. Create a new user with full
   admin privileges::

      sudo -u archivematica bash -c " \
          set -a -e -x
          source /etc/default/archivematica-storage-service || \
              source /etc/sysconfig/archivematica-storage-service \
                  || (echo 'Environment file not found'; exit 1)
          cd /usr/lib/archivematica/storage-service
          /usr/share/archivematica/virtualenvs/archivematica-storage-service/bin/python manage.py createsuperuser
        ";

  After you have created this user, the API key will be generated automatically, and that key will connect the Archivematica pipeline to the Storage Service API. The API key can be found via the web interface (go to **Administration > Users**).

3. To finish the installation, use your web browser to navigate to the
   Archivematica dashboard using the IP address of the machine on which you have
   been installing, e.g., ``http://<MY-IP-ADDR>:81`` (or ``http://localhost:81``
   or ``http://127.0.0.1:81`` if this is a local development setup).

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
