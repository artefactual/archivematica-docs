.. _installation:

============
Installation
============

*On this page*

* :ref:`Overview <overview>`
* :ref:`Technical requirements <tech-requirements>`
* :ref:`New installation <new-install>`
* :ref:`Upgrade from 1.6 <upgrade>`
* :ref:`Advanced <advanced>`

.. _overview:

Overview
========

Archivematica is not a single application, there are a dozens of different
components and tools required for a full working installation.  As a result
there are many possible deployment configurations.

These instructions are designed to get you up and running as quickly as
possible, even if you are not familiar with the linux operating system or the
various tools and applications that are bundled into an Archivematica
installation.

Experience with the linux command line is helpful, and to support a running
production system, it should be considered a requirement.

Don't be afraid to ask for help if you get stuck, or if you don't understand
some part of the instructions.  The `Archivematica google group`_ is a good place
to look for assistance.

.. note:: For testing purposes, you may find it easier to install on a virtual machine using Vagrant. See the :ref:`Quick Start Guide <quick-start-install>`

.. _tech-requirements:

Technical Requirements
======================

**Operating System**

Archivematica |release| installation instructions are provided here for the
following operating systems:

* Ubuntu 14.04.5 64 bit Server Edition
* Ubuntu 16.04.2 64 bit Server Edition (beta)
* CentOS 7.3.1611 64 bit

Archivematica |version| is the first release to be tested on Ubuntu 16.04.  Support
for this OS is still considered beta; installation has been tested but production
deployments are limited.

Other linux distributions should work, but will require customization of these
installation instructions.

Support for Mac OS X is possibly in theory, but is not being tested, and would
require more significant deviation from these instructions.

Archivematica is unlikely to ever run directly in a Windows environment.
Consider the use of a virtualization platform to run linux VMs.

**Hardware**

Archivematica is capable of running on almost any hardware supported by linux;
however, processing large collections will require better hardware. See

* :ref:`Minimum Hardware Requirements <requirements-small>`
* :ref:`Recommended Minimum Production Requirements <requirements-production>`

**Dependencies**

Archivematica has a long list of software it depends on.  All of these
dependencies are installed when following the instructions below.

In these instructions everything is installed into one machine.  It is possible
to install some of the components on separate machines, to improve performance,
such as:

* MySQL
* gearman
* Elasticsearch (optional as of |release|, see below)

Using additional machines requires some additional configuration.

See :ref:`Advanced <advanced>`.

.. note:: *Indexing*. Installing Elasticsearch to provide a search index is now
   optional as of version |release|.  Installing Archivematica without
   Elasticsearch means reduced consumption of compute resources and lower
   operational complexity.  However, some functionality, such as the Backlog,
   Appraisal and Archival Storage tabs, is not available.

   When Elasticsearch is used, Archivematica |release| requires version 1.x (tested
   with 1.7.6). Support for a more recent version of Elasticsearch is being
   developed and is planned for a future release.

.. note:: *MySQL*. Archivematica |version| has been tested with MySQL 5.5, including
   the Percona and MariaDB alternatives.  Archivematica uses MySQL 5.7 on
   Ubuntu 16.04.

.. note:: *Java*. Some of the tools run by Archivematica require Java to be
   installed (primarily Elasticsearch and fits).  On Ubuntu 14.04, Open JDK 7
   is used.  On Ubuntu 16.04 Open JDK 8 is the default.  It is possible to use
   Oracle Java 7 or 8 instead.

.. note:: The remaining dependencies should be kept at the versions installed
   by Archivematica.


.. _requirements-small:

Minimum Hardware Requirements
-----------------------------

For small-scale functionality testing using small collections (transfers with 100 files or
less, 1 GB or smaller)

* Processor: 2 CPU cores
* Memory: 2GB+
* Disk space: 7GB plus two to three times the disk space required for the
  collection being processed (e.g., 3GB to process a 1GB transfer)

.. _requirements-production:

Recommended Minimum Production Requirements
-------------------------------------------

For production processing the hardware requirements depend almost entirely on
the size and number of files being processed.  These recommendations should be
considered the minimum for a viable production system:

* Processor: 2 CPU cores
* Memory: 4GB+
* Disk space: 20GB plus three to four times the disk space required for the
  collection being processed (e.g., 200GB to process a 50GB transfer)

These requirements may not be suitable for certain types of material, e.g. audio-visual.


.. _new-install:

New installation
================

When installing Archivematica for the first time, there are a few choices to
make before starting.

* choice of installation method (manual or ansible).
* choice of installation source (os packages or GitHub).
* choice of operating system (ubuntu or centos/rhel).

Instructions are provided for the following choices:

* :ref:`Manual Install of OS Packages on Ubuntu <install-pkg-ubuntu>`
* :ref:`Manual Install of OS Packages on CentOS/Redhat <install-pkg-centos>`
* :ref:`Automated Install from Github on Ubuntu <ansible-git-ubuntu>`

Other combinations work, but are not covered in this documentation. Please
see the `ansible-archivematica-src`_ repo, the `deploy-pub`_ repo and ask on the
`archivematica-tech`_ mailing list for more details.


.. _install-pkg-ubuntu:

Installing Ubuntu Packages
--------------------------

Archivematica packages are hosted at packages.archivematica.org. This has been
introduced to allow one central place to store packages for multiple OS's.
Packages for both Ubuntu 14.04 and 16.04 are available.

.. note:: Use of 14.04 is not recommended since 14.04 is currently in
   maintenance updates only mode and will cease to be officially supported in
   April 2019.

1. Add Archivematica package sources

Add packages.archivematica.org to your list of trusted repositories.

Using 14.04 (Trusty):

Run these three commands right now (**Delete this section when the final release
packages are made**):

.. code:: bash

   sudo wget -O - https://packages.archivematica.org/1.7.x/key.asc | sudo apt-key add -
   sudo wget -O - http://jenkins-ci.archivematica.org/repos/devel.key | sudo apt-key add -
   sudo sh -c 'echo "deb http://jenkins-ci.archivematica.org/repos/apt/release-0.11-trusty/ ./" >> /etc/apt/sources.list'
   sudo sh -c 'echo "deb http://jenkins-ci.archivematica.org/repos/apt/release-1.7-trusty/ ./" >> /etc/apt/sources.list'
   sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu-externals trusty main" >> /etc/apt/sources.list'

Run these three commands when the final release packages are made:

.. code:: bash

   sudo wget -O - https://packages.archivematica.org/1.7.x/key.asc | sudo apt-key add -
   sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu trusty main" >> /etc/apt/sources.list'
   sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu-externals trusty main" >> /etc/apt/sources.list'

Using 16.04 (Xenial):

Run these three commands right now (**Delete this section when the final release
packages are made**):

.. code:: bash

   sudo wget -O - https://packages.archivematica.org/1.7.x/key.asc | sudo apt-key add -
   sudo wget -O - http://jenkins-ci.archivematica.org/repos/devel.key | sudo apt-key add -
   sudo sh -c 'echo "deb http://jenkins-ci.archivematica.org/repos/apt/release-0.11-xenial/ ./" >> /etc/apt/sources.list'
   sudo sh -c 'echo "deb http://jenkins-ci.archivematica.org/repos/apt/release-1.7-xenial/ ./" >> /etc/apt/sources.list'
   sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu-externals xenial main" >> /etc/apt/sources.list'

Run these three commands when the final release packages are made:

.. code:: bash

   sudo wget -O - https://packages.archivematica.org/1.7.x/key.asc | sudo apt-key add -
   sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu xenial main" >> /etc/apt/sources.list'
   sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu-externals xenial main" >> /etc/apt/sources.list'

2. Add Elasticsearch package source (optional)

.. note:: Skip this step if you are planning to run Archivematica in indexless
   mode (without Elasticsearch).

Elasticsearch comes from its own package repository.

.. code:: bash

   sudo wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
   sudo sh -c 'echo "deb http://packages.elasticsearch.org/elasticsearch/1.7/debian stable main" >> /etc/apt/sources.list'

3. Update your system

Update to the most recent release (14.04.5, or 16.04.2. This step will also fetch a list of
the software from the package repositories you just added to your system.

.. code:: bash

   sudo apt-get update
   sudo apt-get upgrade

4. Install Elasticsearch (optional)

.. note:: Skip this step if you are planning to run Archivematica in indexless
   mode (without Elasticsearch).

.. code:: bash

   sudo apt-get install elasticsearch

5. Install the storage service package

.. code:: bash

   sudo apt-get install -y archivematica-storage-service

6. Configure the storage service

.. code:: bash

   sudo rm -f /etc/nginx/sites-enabled/default
   sudo ln -s /etc/nginx/sites-available/storage /etc/nginx/sites-enabled/storage

7. Update pip

This is used to install python dependencies for both the storage service and
the dashboard.  There is a known issue: https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1658844
with the version of pip installed on Ubuntu 14.04, which makes this step
necessary.  This step is optional on Ubuntu 16.04, but is still a good idea, to
get the most recent version of pip.

.. code:: bash

   sudo wget https://bootstrap.pypa.io/get-pip.py
   sudo python get-pip.py

8. Install the Archivematica packages

The order of installation is important - the mcp-server package must be
installed before the dashboard package.  While it is possible to install the
mcp-client package on a separate machine, that configuration is not
documented in these instructions.

The mcp-server package will install MySQL and configure the database used by
Archivematica.  Depending on the version of MySQL that gets installed the
prompts you will see may differ.  In all cases, you will be prompted to create
a password for the 'root' user.  Keep note of the password you create.
On Ubuntu 14.04, MySQL 5.5 is installed, and
the default 'archivematica' database user is automatically created with a
default password of 'demo'.  On Ubuntu 16.04, MySQL 5.7 is installed, and
you are prompted to add a password for the 'archivematica' user.  You must
use 'demo' as the password during the install process.  The password can be
changed after the installation is complete.

.. code:: bash

   sudo apt-get install -y archivematica-mcp-server
   sudo apt-get install -y archivematica-dashboard
   sudo apt-get install -y archivematica-mcp-client

9. Configure the Archivematica components (optional)

There are a number of environment variables that Archivematica recognizes which
can be used to alter how it is configured. For the full list, see the
`Dashboard install README`_, the `MCPClient install README`_, and the
`MCPServer install README`_.

If you are planning on running Archivematica in indexless mode (i.e., without
Elasticsearch), then modify the relevant systemd EnvironmentFile files by
adding lines that set the relevant environment variables to ``false``:

.. code:: bash

    sudo sh -c 'echo "ARCHIVEMATICA_DASHBOARD_DASHBOARD_SEARCH_ENABLED=false" >> /etc/default/archivematica-dashboard'
    sudo sh -c 'echo "ARCHIVEMATICA_MCPSERVER_MCPSERVER_SEARCH_ENABLED=false" >> /etc/default/archivematica-mcp-server'
    sudo sh -c 'echo "ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_SEARCH_ENABLED=false" >> /etc/default/archivematica-mcp-client'

10. Configure the dashboard

.. code:: bash

   sudo ln -s /etc/nginx/sites-available/dashboard.conf /etc/nginx/sites-enabled/dashboard.conf

11. Start Elasticsearch (optional)

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

13. Post Install Configuration

See :ref:`Post Install Configuration <post-install-config>`


.. _install-pkg-centos:

Install CentOS/Redhat Packages
------------------------------

Archivematica version 1.5.1 and higher support installation on CentOS/Redhat.

1. Prerequisites

Update your system

.. code:: bash

   sudo yum update
   
If your environment uses SELinux, at a minmum you will need to run the following commands. Additional configuration may be required for your local setup.

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

Some repositories need to be installed in order to fulfill the installation procedure:

* Extra packages for enterprise linux

.. code:: bash

   sudo yum install -y epel-release

* Elasticsearch (optional)

.. note:: Skip this step if you are planning to run Archivematica in indexless
   mode (without Elasticsearch).

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
   gpgcheck=0
   enabled=1
   EOF'

3. Service dependencies

Common services like Elasticsearch, mariadb and gearmand should be installed
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

* After the package is installed, populate the sqlite database, and
  collect some static files used by django.
  These tasks must be run as “archivematica” user.

.. code:: bash

   sudo -u archivematica bash -c " \
   set -a -e -x
   source /etc/sysconfig/archivematica-storage-service
   cd /usr/lib/archivematica/storage-service
   /usr/share/python/archivematica-storage-service/bin/python manage.py migrate
   ";

* Now enable and start the archivematica-storage-service, rngd (needed for encrypted spaces) and the nginx frontend:

.. code:: bash

   sudo -u root systemctl enable archivematica-storage-service
   sudo -u root systemctl start archivematica-storage-service
   sudo -u root systemctl enable nginx
   sudo -u root systemctl start nginx
   sudo -u root systemctl enable rngd
   sudo -u root systemctl start rngd

.. note:: The storage service will be available at http://<ip>:8001

5. Installing Archivematica Dashboard and MCP Server

There are a number of environment variables that Archivematica recognizes which
can be used to alter how it is configured. For the full list, see the
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

* Restart nginx in order to load the dashboard config file:

.. code:: bash

   sudo -u root systemctl restart nginx

.. note:: The dashboard will be available at http://ip:81

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

If you are planning to run Archivematica in indexless mode (i.e., without
Elasticsearch), then set the relevant environment variables to ``false``

If you are planning on running Archivematica in indexless mode (i.e., without
Elasticsearch), then modify the relevant systemd EnvironmentFile files by
adding lines that set the relevant environment variables to ``false``:

.. code:: bash

    sudo sh -c 'echo "ARCHIVEMATICA_DASHBOARD_DASHBOARD_SEARCH_ENABLED=false" >> /etc/sysconfig/archivematica-dashboard'
    sudo sh -c 'echo "ARCHIVEMATICA_MCPSERVER_MCPSERVER_SEARCH_ENABLED=false" >> /etc/sysconfig/archivematica-mcp-server'
    sudo sh -c 'echo "ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_SEARCH_ENABLED=false" >> /etc/sysconfig/archivematica-mcp-client'

After that, we can enable and start services

.. code:: bash

   sudo -u root systemctl enable archivematica-mcp-client
   sudo -u root systemctl start archivematica-mcp-client
   sudo -u root systemctl enable fits-nailgun
   sudo -u root systemctl start fits-nailgun
   sudo -u root systemctl enable clamd@scan
   sudo -u root systemctl start clamd@scan
 
7. Finalizing installation

**Configuration**

Each service has a configuration file in /etc/sysconfig/archivematica-packagename

**Troubleshooting**

If IPv6 is disabled, Nginx may refuse to start. If that is the case make sure 
that the listen directives used under /etc/nginx are not using IPv6 addresses 
like [::]:80.

CentOS will install firewalld which will be running default rules likely 
blocking ports 81 and 8001. If you are not able to access the dashboard and 
storage service, check if firewalld is running. If it is, you will likely need 
to modify the firewall rules to allow access to ports 81 and 8001 from your 
location:

.. code:: bash

   sudo firewall-cmd --zone=public --add-port=81/tcp  --permanent
   sudo firewall-cmd --zone=public --add-port=8001/tcp  --permanent
   sudo service firewalld restart


8. Post Install Configuration

See :ref:`Post Install Configuration <post-install-config>`


.. _ansible-git-ubuntu:

Automated Ubuntu GitHub Install
-------------------------------

Installing from source has been tested using ansible scripts. Ansible
installations have been tested for new installations but are not fully tested
for upgrades.

These instructions are designed to create a test environment on your local
machine.  A virtual machine running Ubuntu 14.04 will be created.

It is assumed here that your host operating system is Ubuntu.  This can be
modified for a different Unix based operating system, such as Mac OS X or
another linux distribution such as Centos.  These instructions will not
work if you are using Windows as the host OS.  For Windows installations
you can create a virtual machine and follow the manual install instructions.

The ansible roles referenced here can be used in production deployments
by creating your own ansible playbook to run them. See
https://github.com/artefactual/deploy-pub/playbooks/archivematica for more
details.

1. Install Dependencies

These instructions require VirtualBox, Vagrant, and Ansible

.. code:: bash

   sudo apt-get install virtualbox vagrant
   sudo pip install -U ansible

Vagrant must be at least version 1.5. Check your version with:

.. code:: bash

   vagrant --version

If it is not up to date, you can download the newest version from the
`Vagrant website <https://www.vagrantup.com/downloads.html>`_ .

2. Download Installer

Checkout the deployment repo:

.. code:: bash

   git clone https://github.com/artefactual/deploy-pub.git

3. Dependencies

Download the Ansible roles:

.. code:: bash

   cd deploy-pub/playbooks/archivematica
   ansible-galaxy install -f -p roles/ -r requirements.yml

4. Install

Create the virtual machine and provision it:

.. code:: bash

   vagrant up

.. warning::

  This will take a while.
  It depends on your computer, but it could take up to an hour.
  Your computer may be very slow while Archivematica is being provisioned -
  be sure to save any work and be prepared to step away from your computer
  while Archivematica is building.

5. Re-provisioning

If there's an error, you can re-run the setup.

.. code:: bash

   vagrant provision

Once it's done provisioning, you can log in to your virtual machine:

.. code:: bash

   vagrant ssh

You can also access your Archivematica instance through the web browser:

* Archivematica: `<http://192.168.168.192>`_. Username & password configured on
  installation.
* Storage Service: `<http://192.168.168.192:8000>`_. Username: test, password:
  test.

6. Post Install Configuration

See :ref:`Post Install Configuration <post-install-config>`


.. _post-install-config:

Post Install Configuration
--------------------------

After successfully completing a new installation using one of the methods
above, follow these steps to complete the configuration of your new server.

1. Test the storage service

The storage service runs as a separate web application from the Archivematica
dashboard. Go to the following link in a web browser and log in as user *test*
with the password *test*: http://localhost:8000 (or use the IP address of the
machine you have been installing on).

2. New Storage Service User

Create a new administrative user in the Storage service. The storage service
has its own set of users. In the User menu in the Administrative tab of the
storage service, add at least one administrative user, and modify the
test user, to change the password at a minimum. After you have created
an administrative user, copy its API key to your clipboard.

3. Test the dashboard

You can login to the Archivematica dashboard and finish the installation in a
web browser: http://localhost (again, use the IP address of the machine you
have been installing on). When prompted, enter the URL of the Storage Service,
the name of the administrative user, and that user's API key.

4. Register your installation for full Format Policy Registry interoperability.

Follow the instructions in the web browser to complete the installation.

.. _upgrade:

Upgrade from Archivematica |previous_version|.x to |release|
================================================================================

Archivematica |previous_version|.x is available for Ubuntu 14.04 and Centos
7.x. If you are running a version of Archivematica older than
|previous_release|, you will need to upgrade your operating system from Ubuntu
12.04 to Ubuntu 14.04, and upgrade Archivematica to |previous_release| before
following these instructions. This section of the instructions is focused on
upgrading to Archivematica |release|.

* :ref:`Upgrade Ubuntu Package Install <upgrade-ubuntu>`
* :ref:`Upgrade CentOS/Redhat Package Install <upgrade-centos>`

While it is possible to upgrade a GitHub based source install using ansible,
these instructions do not cover that scenario.

**Backup first**

Before starting any upgrade procedure on a production system, it is prudent to
back up your system.  If you are using a virtual machine, take a snapshot of it
before making any changes.  Alternatively, back up the file systems being used
by your system.  Exact procedures for updating will depend on your local
installation.   At a minimum you should make backups of:

* the storage service sqlite database
* the dashboard mysql database

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

1. Update OS

.. code:: bash

   sudo apt-get update && sudo apt-get upgrade

2. Update python setup tools

This is used to install python dependencies for both the storage service and
the dashboard.  There is a _known issue: https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1658844 with the version of pip installed on
Ubuntu 14.04, which makes this step necessary.

.. code:: bash

   sudo pip install -U setuptools

3. Update Package Sources

.. code:: bash

   sudo add-apt-repository --remove ppa:archivematica/externals
   echo 'deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu trusty main' >> /etc/apt/sources.list
   echo 'deb [arch=amd64] http://packages.archivematica.org/1.7.x/ubuntu-externals trusty main' >> /etc/apt/sources.list

Optionally you can remove the lines referencing
packages.archivematica.org/|previous_version|.x from /etc/apt/sources.list.

4. Update Archivematica Storage Services


.. code:: bash

   sudo apt-get update
   sudo apt-get install archivematica-storage-service

5. Update Application Container

Archivematica Storage Service 0.10.0 uses gunicorn as wsgi server. This means that the old uwsgi server needs to be stopped and disabled after performing the upgrade.

.. code:: bash

   sudo service uwsgi stop
   sudo update-rc.d uwsgi disable

6. Update Archivematica

During the update process you may be asked about updating configuration files.
Choose to accept the maintainers versions. You will also be asked about
updating the database, say 'ok' to each of those steps. If you have set a
password for the root mysql database user, enter it when prompted. It is
better to update the dashboard before updating the mcp components.

.. code:: bash

   sudo apt-get upgrade

7. Disable Unused Services

Archivematica |release| uses nginx as http server, and gunicorn as wsgi server.
This means that some services used in Archivematica |previous_release| should
be stopped and disabled before performing the upgrade.

.. code:: bash

    sudo service apache2 stop
    sudo update-rc.d apache2 disable

8. Restart Services

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

Note, depending on how your Ubuntu system is set up, you may have trouble
restarting gearman with the command in the block above.  If that is the case,
try this command instead:

.. code:: bash

   sudo restart gearman-job-server

9. Remove unused services

.. code:: bash

    sudo apt-get remove --purge python-pip apache2 uwsgi

10. Update Transfer Index

If you are interested in experimenting with the use of these new features,
with a backlog created in an earlier version of Archivematica, these
instructions show how to update your Transfer Backlog Index so it can be
used with the Appraisal Tab and the Backlog tab.

These are experimental instructions. Do not use them on a production system
unless you have a back you can restore from.

* Install devtools

Archivematica devtools is a set of utilities that was built by developers while
working on Archivematica.  Devtools includes helper scripts that make it easier
to perform certain maintenance tasks.  One of those tools is used to rebuild
the Transfer index in Elasticsearch, which is used by the different backlog
tools such as the new Appraisal Tab.  Currently this must be installed using
git.  These instructions will be updated when a packaged version is available.
See the _devtools repo: https:github.com/artefactual/archivematica-devtools for
more details.

.. code:: bash

    sudo apt-get install git ruby-ronn
    git clone https://github.com/artefactual/archivematica-devtools
    cd archivematica-devtools
    make install

* Confirm Location of Transfer Backlog

You need to know the path to the Transfer Backlog Location.  The default
path is '/var/archivematica/sharedDirectory/www/AIPsStore/transferBacklog'.
You can confirm the path for your installation by:

* logging into the Storage Service and clicking on the Locations tab.
* type 'backlog' in the search searchbox
* copy the value in the column labelled 'path' (there should be only one row)

* Rebuild Transfer Index

Using the path you confirmed above, replace the text '/path/to/transfers' with
the correct path for your system.

.. code:: bash

    am rebuild-transfer-backlog /path/to/transfers


This may take a while if you have a large backlog.  Once it completes, you
should be able to see your Transfer Backlog in the Appraisal tab and in the
Backlog tab.



Depending on your browser settings, you may need to clear your browser cache to
make the dashboard pages load properly.  For example in Firefox or Chrome you
should be able to clear the cache with control-shift-R or command-shift-F5.

.. _upgrade-centos:

Upgrade from Archivematica |previous_version| for CentOS/Redhat
--------------------------------------------------------------------------------

* First, upgrade the repositories for |version|:

.. code:: bash

   sudo sed -i 's/1.6.x/1.7.x/g' /etc/yum.repos.d/archivematica*

* Then, upgrade the packages:

.. code:: bash

   sudo yum update

* Once the new packages are installed, we need to upgrade the databases for both, archivematica and the storage service. This can be done with:

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

* After that, we can restart the archivematica related services, and continue using the system:

.. code:: bash

   sudo systemctl restart archivematica-storage-service
   sudo systemctl restart archivematica-dashboard
   sudo systemctl restart archivematica-mcp-client
   sudo systemctl restart archivematica-mcp-server

Depending on your browser settings, you may need to clear your browser cache to
make the dashboard pages load properly.  For example in Firefox or Chrome you
should be able to clear the cache with control-shift-R or command-shift-F5.

* Update Transfer Index

If you are interested in experimenting with the use of these new features,
with a backlog created in an earlier version of Archivematica, these
instructions show how to update your Transfer Backlog Index so it can be
used with the Appraisal Tab and the Backlog tab.

These are experimental instructions. Do not use them on a production system
unless you have a back you can restore from.

* Install devtools

Archivematica devtools is a set of utilities that was built by developers While
working on Archivematica.  Devtools includes helper scripts that make it easier
to perform certain maintenance tasks.  One of those tools is used to rebuild
the Transfer index in Elasticsearch, which is used by the different backlog
tools such as the new Appraisal Tab.  Currently this must be installed using
git.  These instructions will be updated when a packaged version is available.
See the _devtools repo: https:github.com/artefactual/archivematica-devtools for
more details.

.. code:: bash

    sudo yum install -y archivematica-devtools

* Confirm Location of Transfer Backlog

You need to know the path to the Transfer Backlog Location.  The default
path is '/var/archivematica/sharedDirectory/www/AIPsStore/transferBacklog'.
You can confirm the path for your installation by:

* logging into the Storage Service and clicking on the Locations tab.
* type 'backlog' in the search searchbox
* copy the value in the column labelled 'path' (there should be only one row)

* Rebuild Transfer Index

Using the path you confirmed above, replace the text '/path/to/transfers' with
the correct path for your system.

.. code:: bash

    am rebuild-transfer-backlog /path/to/transfers


This may take a while if you have a large backlog.  Once it completes, you
should be able to see your Transfer Backlog in the Appraisal tab and in the
Backlog tab.


.. _advanced:

Advanced
========

.. _docker:

Docker
------

Docker installations are experimental at this time- instructions coming soon.

.. _development:

Install for development
-----------------------

The recommended way to install Archivematica for development is with Ansible and
Vagrant. For instructions on how to install Archivematica from a virtual machine,
see the `Ansible & Vagrant Installation instructions
<https://wiki.archivematica.org/Getting_started#Installation>`_ on the Archivematica
wiki. See also instructions for installation on a virtual machine using Vagrant in
the :ref:`Quick Start Guide <quick-start-install>`

.. _multiple-machines:

Installing across multiple machines
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It is possible to spread Archivematica's processing load across several machines by installing the following services on separate machines:

* Elasticsearch
* gearman
* MySQL

For help, send an email to `Archivematica tech mailing list. <https://groups.google.com/forum/#!forum/archivematica-tech>`_

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

.. _install-aspace:

ArchivesSpace
^^^^^^^^^^^^^

TODO

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
