.. _installation:

============
Installation
============

*On this page*

* :ref:`Overview <overview>`
* :ref:`Technical requirements <tech-requirements>`
* :ref:`New installations <new-install>`
* :ref:`Upgrading from 1.6 <upgrade>`
* :ref:`Advanced <advanced>`

.. _overview:

Overview
========

Archivematica is not a single application - dozens of different components and
tools are required for a fully working installation. As a result, there are many
possible deployment configurations.

These instructions are designed to get you up and running as quickly as
possible, even if you are not familiar the various tools and applications that
are bundled into Archivematica.

Experience with the Linux command line is helpful, and to support a running
production system it should be considered a requirement.

Don't be afraid to ask for help if you get stuck, or if you don't understand
some part of the instructions. The `Archivematica google group`_ is a good place
to look for assistance.

.. note:: For testing purposes, you may find it easier to install on a virtual
   machine using Vagrant. See the :ref:`Quick Start Guide <quick-start-install>`

.. _tech-requirements:

Technical Requirements
======================

Operating System
----------------

Archivematica |release| installation instructions are provided here for the
following operating systems:

* Ubuntu 14.04.5 64-bit Server Edition
* Ubuntu 16.04.2 64-bit Server Edition (beta)
* CentOS 7.3.1611 64-bit

Archivematica |version| is the first release to be tested on Ubuntu 16.04. Support
for this OS is still considered beta; installation has been tested but production
deployments are limited.

Other Linux distributions should work, but will require customization of these
installation instructions.

Support for Mac OS X is possibly in theory, but is not being tested, and would
require more significant deviation from these instructions.

Archivematica is unlikely to ever run directly in a Windows environment.
Consider the use of a virtualization platform to run Linux VMs.

Dependencies
------------

Archivematica has a long list of software it depends on. All of these
dependencies are installed when following the instructions below.

In these instructions everything is installed into one machine. It is possible
to install some of the components on separate machines, to improve performance,
such as:

* MySQL
* gearman
* Elasticsearch (optional as of Archivematica 1.7, see below)

Archivematica has a long list of software it depends on. All of these
dependencies are installed when following the instructions below.

In these instructions everything is installed into one machine. It is possible
to install some of the components, such as MySQL, Elasticsearch, and Gearman,
on separate machines, to improve performance. Using additional machines will
require additional configuration. For more information, see :ref:`Advanced <advanced>`.

.. note::
   Archivematica |version| has been tested with MySQL 5.5, including
   the Percona and MariaDB alternatives. Archivematica uses MySQL 5.7 on
   Ubuntu 16.04.

   Some of the tools run by Archivematica require Java to be
   installed (primarily Elasticsearch and fits). On Ubuntu 14.04, Open JDK 7
   is used. On Ubuntu 16.04 Open JDK 8 is the default. It is possible to use
   Oracle Java 7 or 8 instead.

   The remaining dependencies should be kept at the versions installed
   by Archivematica.

Elasticsearch
^^^^^^^^^^^^^

Installing Elasticsearch to provide a search index is now optional as of
Archivematica version 1.7. Installing Archivematica without Elasticsearch means
reduced consumption of compute resources and lower operational complexity.
However, some functionality, such as the Backlog, Appraisal and Archival Storage
tabs, is not available.

When Elasticsearch is used, Archivematica |release| requires version 1.x (tested
with 1.7.6). Support for a more recent version of Elasticsearch is being
developed and is planned for a future release.


Hardware
--------

Archivematica is capable of running on almost any hardware supported by Linux;
however, processing large collections will require better hardware.

Minimum hardware requirements
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For small-scale functionality testing using small collections (transfers with 100
files or less, files 1 GB or smaller), we recommend the following minimum hardware
requirements:

* Processor: 2 CPU cores
* Memory: 2GB+
* Disk space (processing): 7GB plus two to three times the disk space required for the
  collection being processed (e.g., 3GB to process a 1GB transfer)

Recommended minimum production requirements
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For production processing, the hardware requirements depend almost entirely on
the size and number of files being processed. These recommendations should be
considered the minimum for a viable production system:

* Processor: 2 CPU cores
* Memory: 4GB
* Disk space (processing): 200GB

More commonly, we deploy the following:

* Processor: 8 CPU cores
* Memory: 16GB

For processing disk space, we recommend allocating 20GB plus four times
the disk space required for the largest transfer that you expect to process. If
your largest transfer is 50GB, allocation at least 220GBs of disk space.

The amount of transfer source disk space needed is subjective, and depends on
individual workflows.

The amount of storage disk space needed will depend on how much material you
intend to store, as well as how it is stored (compressed or uncompressed).

These requirements may not be suitable for certain types of material - for example,
audio-visual material requires more processing power than images or documents.

.. _new-install:

New installations
=================

When installing Archivematica for the first time, there are a few choices to
make before starting:

* Installation method: manual or Ansible?
* Installation source: OS packages or GitHub?
* Operating system: Ubuntu or CentOS/Red Hat?

Instructions are provided for the following choices:

* :ref:`Manual Install of OS Packages on Ubuntu <install-pkg-ubuntu>`
* :ref:`Manual Install of OS Packages on CentOS/Red Hat <install-pkg-centos>`
* :ref:`Automated Install from Github on Ubuntu <ansible-git-ubuntu>`

Other combinations work, but are not covered in this documentation. Please
see the `ansible-archivematica-src`_ repo, the `deploy-pub`_ repo and ask on the
`archivematica-tech`_ mailing list for more details.


.. _install-pkg-ubuntu:

Installing Ubuntu Packages
--------------------------

Archivematica packages are hosted at packages.archivematica.org as a central
place to store packages for multiple operating systems. Packages for both Ubuntu
14.04 and 16.04 are available.

.. note:: Ubuntu 14.04 is currently in maintenance updates only mode and will
   cease to be officially supported in April 2019. We recommend upgrading to
   Ubuntu 16.04.

1. Add packages.archivematica.org to your list of trusted repositories.

   Using 14.04 (Trusty):

   Run these three commands right now (**and delete this section when the final
   release packages are made.**):

   .. code:: bash

      sudo wget -O - https://packages.archivematica.org/1.7.x/key.asc | sudo apt-key add -
      sudo wget -O - http://jenkins-ci.archivematica.org/repos/devel.key | sudo apt-key add -
      sudo sh -c 'echo "deb http://jenkins-ci.archivematica.org/repos/apt/release-0.11-trusty/ ./" >> /etc/apt/sources.list'
      sudo sh -c 'echo "deb http://jenkins-ci.archivematica.org/repos/apt/release-1.7-trusty/ ./" >> /etc/apt/sources.list'
      sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu-externals trusty main" >> /etc/apt/sources.list'

   Run these three commands when the final release packages are made:

   .. code:: bash

      sudo wget -O - https://packages.archivematica.org/1.7.x/key.asc  | sudo apt-key add -
      sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu trusty main" >> /etc/apt/sources.list'
      sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu-externals trusty main" >> /etc/apt/sources.list'

   Using 16.04 (Xenial):

   Run these three commands right now (**and delete this section when the final
   release packages are made**):

   .. code:: bash

      sudo wget -O - https://packages.archivematica.org/1.7.x/key.asc | sudo apt-key add -
      sudo wget -O - http://jenkins-ci.archivematica.org/repos/devel.key | sudo apt-key add -
      sudo sh -c 'echo "deb http://jenkins-ci.archivematica.org/repos/apt/release-0.11-xenial/ ./" >> /etc/apt/sources.list'
      sudo sh -c 'echo "deb http://jenkins-ci.archivematica.org/repos/apt/release-1.7-xenial/ ./" >> /etc/apt/sources.list'
      sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu-externals xenial main" >> /etc/apt/sources.list'

   Run these three commands when the final release packages are made:

   .. code:: bash

      sudo wget -O - https://packages.archivematica.org/1.7.x/key.asc  | sudo apt-key add -
      sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu xenial main" >> /etc/apt/sources.list'
      sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu-externals xenial main" >> /etc/apt/sources.list'

2. Add Elasticsearch package source (optional). Elasticsearch comes from its own
   package repository.

   .. note:: Skip this step if you are planning to run Archivematica in indexless
      mode (without Elasticsearch).

   .. code:: bash

      sudo wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
      sudo sh -c 'echo "deb http://packages.elasticsearch.org/elasticsearch/1.7/debian stable main" >> /etc/apt/sources.list'

At this point you will need to restart dashboard and mcp-server services

   .. code:: bash

      sudo service archivematica-dashboard restart
      sudo service archivematica-mcp-server restart


3. Update to the most recent OS release (14.04.5 or 16.04.2). This step will
   also fetch a list of the software from the package repositories you just
   added to your system.

   .. code:: bash

      sudo apt-get update
      sudo apt-get upgrade

4. Install Elasticsearch (optional)

   .. note:: Skip this step if you are planning to run Archivematica in indexless
      mode (without Elasticsearch).

   .. code:: bash

      sudo apt-get install elasticsearch

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

7. Update pip. This is used to install Python dependencies for both the Storage
   Service and the dashboard. There is a `known issue with pip`_ on Ubuntu 14.04
   that makes this step necessary. This step is optional on Ubuntu 16.04, but is
   still a good idea to get the most recent version of pip.

   .. code:: bash

      sudo wget https://bootstrap.pypa.io/get-pip.py
      sudo python get-pip.py

8. Install the Archivematica packages. The order of installation is important -
   the mcp-server package must be installed before the dashboard package. While
   it is possible to install the mcp-client package on a separate machine, that
   configuration is not documented in these instructions.

   The mcp-server package will install MySQL and configure the database used by
   Archivematica. Depending on the version of MySQL that gets installed the
   prompts you will see may differ. In all cases, you will be prompted to create
   a password for the 'root' user. Keep note of the password you create.
   On Ubuntu 14.04, MySQL 5.5 is installed, and
   the default 'archivematica' database user is automatically created with a
   default password of 'demo'. On Ubuntu 16.04, MySQL 5.7 is installed, and
   you are prompted to add a password for the 'archivematica' user. You must
   use 'demo' as the password during the install process. The password can be
   changed after the installation is complete.

   The fits package needs to be installed as a prerequisite, due to a
   circular dependencies problem that arises only on Ubuntu 14.04.

   .. code:: bash

      sudo apt-get install -y archivematica-mcp-server
      sudo apt-get install -y archivematica-dashboard
      sudo apt-get install -y fits
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
       sudo service archivematica-mcp-client start
       sudo service archivematica-storage-service start
       sudo service archivematica-dashboard start
       sudo service nginx restart
       sudo systemctl enable fits
       sudo service fits start

    If you have trouble with the gearman command try restarting it:

    .. code:: bash

       sudo service gearman-job-server restart

13. Complete :ref:`Post Install Configuration <post-install-config>`.


.. _install-pkg-centos:

Install CentOS/Red Hat Packages
-------------------------------

Archivematica version 1.5.1 and higher support installation on CentOS/Red Hat.

1. Prerequisites

   Update your system

   .. code:: bash

      sudo yum update

   If your environment uses SELinux, at a minmum you will need to run the
   following commands. Additional configuration may be required for your local
   setup.

   .. code:: bash

      # Allow nginx to use ports 8000 and 8001
      sudo semanage port -m -t http_port_t -p tcp 8000
      sudo semanage port -a -t http_port_t -p tcp 8001
      # Allow nginx to connect the mysql server and gunicorn backends:
      sudo setsebool -P httpd_can_network_connect_db=1
      sudo setsebool -P httpd_can_network_connect=1
      # Allow nginx to change system limits
      sudo setsebool -P httpd_setrlimit 1

2. Extra repos:

   Some repositories need to be installed in order to fulfill the installation
   procedure:

   * Extra packages for enterprise Linux

     .. code:: bash

        sudo yum install -y epel-release

   * Elasticsearch (optional)

     .. note:: Skip this step if you are planning to run Archivematica in
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

   * Archivematica

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

3. Service dependencies

   Common services like Elasticsearch, MariaDB and Gearmand should be installed
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
        /usr/share/python/archivematica-storage-service/bin/python manage.py migrate
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
        /usr/share/python/archivematica-dashboard/bin/python manage.py migrate
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

   CentOS will install firewalld which will be running default rules likely
   blocking ports 81 and 8001. If you are not able to access the dashboard and
   Storage Service, then use the following command to check if firewalld is
   running:

   .. code:: bash

      sudo systemctl status firewalld

   If firewalld is running, you will likely need to modify the firewall rules
   to allow access to ports 81 and 8001 from your location:

   .. code:: bash

      sudo firewall-cmd --add-port=81/tcp --permanent
      sudo firewall-cmd --add-port=8001/tcp --permanent
      sudo firewall-cmd --reload

8. Complete :ref:`Post Install Configuration <post-install-config>`.


.. _ansible-git-ubuntu:

Automated Ubuntu GitHub Install
-------------------------------

Installing from source has been tested using ansible scripts. Ansible
installations have been tested for new installations but are not fully tested
for upgrades.

These instructions are designed to create a test environment on your local
machine. A virtual machine running Ubuntu 14.04 will be created.

It is assumed here that your host operating system is Ubuntu. This can be
modified for a different Unix based operating system, such as Mac OS X or
another Linux distribution such as CentOS. These instructions will not
work if you are using Windows as the host OS. For Windows installations
you can create a virtual machine and follow the manual install instructions.

The ansible roles referenced here can be used in production deployments
by creating your own ansible playbook to run them. See the `deploy-pub`_ repo
for more details.

1. Install VirtualBox, Vagrant, and Ansible.

   .. code:: bash

      sudo apt-get install virtualbox vagrant
      sudo pip install -U ansible

   Vagrant must be at least version 1.5. Check your version with:

   .. code:: bash

      vagrant --version

   If it is not up to date, you can download the newest version from the
   `Vagrant website <https://www.vagrantup.com/downloads.html>`_ .

2. Checkout the deployment repo:

   .. code:: bash

      git clone https://github.com/artefactual/deploy-pub.git

3. Download the Ansible roles:

   .. code:: bash

      cd deploy-pub/playbooks/archivematica
      ansible-galaxy install -f -p roles/ -r requirements.yml

4. Create the virtual machine and provision it:

   .. code:: bash

      vagrant up

   .. warning::

     This will take a while. It depends on your computer, but it could take up
     to an hour. Your computer may be very slow while Archivematica is being
     provisioned - be sure to save any work and be prepared to step away from
     your computer while Archivematica is building.

   If there are any errors, reprovisioning the VM often fixes the issue.

   .. code:: bash

      vagrant provision

5. Once it's done provisioning, you can log in to your virtual machine:

   .. code:: bash

      vagrant ssh

   You can also access your Archivematica instance through the web browser:

   * Archivematica: `<http://192.168.168.192>`_. Username & password configured
     on installation.
   * Storage Service: `<http://192.168.168.192:8000>`_. Username: test,
     password: test.


.. _post-install-config:

Post Install Configuration
--------------------------

After successfully completing a new installation using one of the methods
above, follow these steps to complete the configuration of your new server.

1. The Storage Service runs as a separate web application from the Archivematica
   dashboard. Go to the following link in a web browser and log in as user
   *test* with the password *test*: http://localhost:8000, or use the IP address
   of the machine you have been installing on. Note that RPM packages use port
   8001.

   If you are running the storage service and the dashboard on the same host you
   should use:

   .. code:: bash

      localhost

   or

   .. code:: bash

      127.0.0.1

   If you are using a public IP address you'll need to configure your firewall
   rules and allow access only to port 80 and 8000 for Archivematica usage
   (port 81 and 8001 for RPM packages).

2. Create a new administrative user in the Storage Service. The Storage Service
   has its own set of users. Navigate to Administrators > Users and add at
   least one administrative user. We also recommend modifying the test user and
   changing the default password. After you have created an administrative user,
   copy the user's API key to your clipboard.

3. Log in to the Archivematica dashboard to finish the installation in a
   web browser: http://localhost. Again, you can use the IP address of the
   machine you have been installing on. Note that RPM packages use port 81.

4. On the Welcome page, create an administrative user for the Archivematica 
   pipeline by entering the organization name, the organization identifier, 
   username, email, and password.

5. On the next screen, connect your pipeline to the Storage Service by entering
   the Storage Service URL and User and pasting the API key that you copied in
   Step 2.


.. _upgrade:

Upgrade from Archivematica |previous_version|.x to |release|
============================================================

* :ref:`Upgrade Ubuntu Package Install <upgrade-ubuntu>`
* :ref:`Upgrade CentOS/Red Hat Package Install <upgrade-centos>`
* :ref:`Upgrade in indexless mode <upgrade-indexless>`

While it is possible to upgrade a GitHub-based source install using ansible,
these instructions do not cover that scenario.

Create a backup
---------------

Before starting any upgrade procedure on a production system, it is prudent to
back up your system. If you are using a virtual machine, take a snapshot of it
before making any changes. Alternatively, back up the file systems being used
by your system. Exact procedures for updating will depend on your local
installation. At a minimum you should make backups of:

* The Storage Service SQLite (or MySQL) database
* The dashboard MySQL database

A simple example of backing up these two databases:

.. code:: bash

   sudo cp /var/archivematica/storage-service/storage.db ~/storage_db_backup.db
   mysqldump -u root -p MCP > ~/am_backup.sql

If you do not have a password set for the root user in mysql, you can take out
the '-p' portion of that command. If there is a problem during the upgrade
process, you can restore your mysql database from this backup and try the
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
   steps. If you have set a password for the root mysql database user, enter it
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
   git. These instructions will be updated when a packaged version is available.
   See the `devtools repo`_ for more details.


1. Install devtools.

   .. code:: bash

       sudo apt-get install git ruby-ronn
       git clone https://github.com/artefactual/archivematica-devtools
       cd archivematica-devtools
       make install

2. Confirm Location of Transfer Backlog

   You need to know the path to the Transfer Backlog Location. The default
   path is '/var/archivematica/sharedDirectory/www/AIPsStore/transferBacklog'.
   You can confirm the path for your installation by:

   - logging into the Storage Service and clicking on the Locations tab.
   - type 'backlog' in the search searchbox
   - copy the value in the column labelled 'path' (there should be only one row)


3. Rebuild Transfer Index

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


.. _advanced:

Advanced
========

.. _development:

Install for development
-----------------------

The recommended way to install Archivematica for development is with Ansible and
Vagrant. For instructions on how to install Archivematica from a virtual machine,
see the `Ansible & Vagrant Installation instructions
<https://wiki.archivematica.org/Getting_started#Installation>`_ on the Archivematica
wiki. See also instructions for installation on a virtual machine using Vagrant in
the :ref:`Quick Start Guide <quick-start-install>`

.. note:: Archivematica can also be installed for development using Docker and
   Docker Compose. If you would like to take this approach, then follow the
   `Archivematica Docker Compose installation instructions`_.


.. _multiple-machines:

Installing across multiple machines
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It is possible to spread Archivematica's processing load across several machines
by installing the following services on separate machines:

* Elasticsearch
* gearman
* MySQL

For help, send an email to the `archivematica-tech`_ mailing list.

.. _SSL-support:

Configure Archivematica with SSL
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Archivematica can be configured for HTTPS following the sample configurations for
`dashboard <https://github.com/artefactual-labs/ansible-archivematica-src/blob/qa/1.7.x/templates/etc/nginx/sites-available/dashboard-ssl.conf.j2>`_
and
`storage-service <https://github.com/artefactual-labs/ansible-archivematica-src/blob/qa/1.7.x/templates/etc/nginx/sites-available/storage-ssl.conf.j2>`_.

In order to obtain valid SSL certificates trusted by any browser, you can use `Let's Encrypt <https://letsencrypt.org>`_.


.. _firewall:

Firewall requirements
^^^^^^^^^^^^^^^^^^^^^

When installing Archivematica on multiple machines, all the machines must be
able to reach each other on the following ports:

* http, mysqld, gearman, nfs, ssh


.. _install-atom:

Using AtoM 2.x with Archivematica
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Archivematica |version| has been tested with and is recommended for use with AtoM
versions 2.2. AtoM version 2.2 or higher is required for use with the
hierarchical DIP functionality; see :ref:`Arrange a SIP from backlog <arrange-sip>`.

Installation instructions for Atom 2 are available on the
:ref:`accesstomemory.org documentation <atom:home>`. When following those
instructions, it is best to download Atom from the git repository (rather than
use one of the supplied tarballs). When checking out Atom, use the head of
either the stable/2.1.x, stable/2.2.x or qa/2.3.x branch (integration with qa branch is experimental).

Once you have a working AtoM installation, you can configure dip upload
between Archivematica and Atom. The basic steps are:

* Update atom dip upload configuration in the Archivematica dashboard

* Confirm atom-worker is configured on the Atom server (copy the atom-
  worker.conf file from atom source to /etc/init/)

* Enable the Sword Plugin in the AtoM plugins page

* Enable job scheduling in the AtoM settings page (AtoM version 2.1 or lower only)

* Confirm gearman is installed on the AtoM server

* Configure ssh keys to allow rsync to work for the archivematica user, from
  the Archivematica server to the Atom server

* Start gearman on the Atom server

* Start the atom worker on the AtoM server

.. _install-duracloud:

Duracloud
^^^^^^^^^

See :ref:`Archivematica DuraCloud quick start guide <duracloud-setup>`

.. _install-swift:

Swift
^^^^^

See: :ref:`Swift Storage Service docs <storageservice:swift>`

.. _install-islandora:

Islandora
^^^^^^^^^

See: :ref:`Fedora Storage Service docs <storageservice:fedora>`

.. _install-arkivum:

Arkivum
^^^^^^^

See: :ref:`Arkivum Storage Service docs <storageservice:arkivum>`

:ref:`Back to the top <installation>`


.. _`archivematica-tech`: https://groups.google.com/forum/#!forum/archivematica-tech
.. _`deploy-pub`: https://github.com/artefactual/deploy-pub
.. _`ansible-archivematica-src`: https://github.com/artefactual-labs/ansible-archivematica-src
.. _`Dashboard install README`: https://github.com/artefactual/archivematica/blob/stable/1.7.x/src/dashboard/install/README.md
.. _`MCPClient install README`: https://github.com/artefactual/archivematica/blob/stable/1.7.x/src/MCPClient/install/README.md
.. _`MCPServer install README`: https://github.com/artefactual/archivematica/blob/stable/1.7.x/src/MCPServer/install/README.md
.. _`Archivematica google group`: https://groups.google.com/a/artefactual.com/forum/#!forum/archivematica
.. _`known issue`: https://github.com/artefactual/archivematica-storage-service/issues/312
.. _`Sword API`: https://wiki.archivematica.org/Sword_API
.. _`known issue with pip`: https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1658844
.. _`devtools repo`: https:github.com/artefactual/archivematica-devtools
.. _`Archivematica Docker Compose installation instructions`: https://github.com/artefactual-labs/am/tree/master/compose
