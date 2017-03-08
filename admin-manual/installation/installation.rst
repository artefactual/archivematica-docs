.. _installation:

============
Installation
============

*On this page*

* :ref:`Technical requiremnets <tech-requirements>`

* :ref:`Recommended Minimum Requirements for small-scale testing <requirements-small>`

* :ref:`Recommended Minimum Requirements for production processing <requirements-production>`

* :ref:`Install from packages <install-packages>`

* :ref:`Install new source <install-source>`

* :ref:`Install for CentOS/Redhat <centos>`

* :ref:`Upgrade from Archivematica 1.5 for CentOS/Redhat <centos-upgrade>`

* :ref:`Docker <docker>`

* :ref:`Install for development <development>`

* :ref:`Advanced <advanced>`

.. _tech-requirements:

Technical Requirements
----------------------

Version 1.5: Operating System requirement: A current Ubuntu LTS version, which at the moment means version 14.04.  The 64 bit Server Edition of Ubuntu 14.04.4 is recommended.

We plan to release a version 1.5.1 which will be available on Ubuntu 12.04, 16.04 and CentOS/Redhat 7 (more information available soon).

Archivematica is capable of running on almost any hardware supported by Ubuntu; however, processing large collections will require better hardware.

Archivematica can be installed on a single machine, or across many machines to spread the processing workload. See :ref:`Advanced <advanced>`.

Note that Archivematica 1.6.0 has not yet been tested with Elasticsearch 2.x and above.

.. _requirements-small:

Recommended Minimum Requirements for small-scale testing
--------------------------------------------------------

For functionality testing using small collections (transfers with 100 files or
less, 1 GB or smaller)

* Processor: Dual Core+ CPU

* Memory: 2GB+

* Disk space: 7GB plus the disk space required for the collection

.. _requirements-production:

Recommended Minimum Requirements for production processing
----------------------------------------------------------

Archivematica can be installed one or more machines. It is recommended that
each machines have these minimum requirements:

* Processor: dual core i5 5th generation CPU or better
* Memory: 8GB+
* Disk space: 20GB plus the disk space required for the collection.

These requirements may not be suitable for certain types of material, e.g. audio-visual.

.. _install-packages:

Installing from packages
------------------------

Installing from packages is tested for both new installations and upgrading from version 1.5.

Updating from Archivematica 1.5
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you have installed an earlier version Archivematica from packages, it is
possible to update your installation without re-installing. The steps are:


**Update system**

This might be done on your system already, if you have been updating the operating system
on an ongoing basis.

.. code:: bash

   sudo apt-get update
   sudo apt-get upgrade

**Add source code repositories**

.. code:: bash

   sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.6.x/ubuntu trusty main" >> /etc/apt/sources.list'
   sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.6.x/ubuntu-externals trusty main" >> /etc/apt/sources.list'

**Update Archivematica Storage Service**

Ensure that the default user 'test' exists in the Storage Service before updating (create it if it doesn't). Database migrations may not be correctly applied if not.

.. code:: bash

   sudo apt-get update
   sudo apt-get install archivematica-storage-service
   
**Disable old wsgi server and enable the new one**

Archivematica Storage Service 0.10.0 uses gunicorn as wsgi server. This means that the old uwsgi server needs to be stopped and disabled after perfoming the upgrade

.. code:: bash

   sudo service uwsgi stop
   sudo update-rc.d uwsgi disable
   sudo service archivematica-storage-service start
   

**Update Archivematica**

It is always a good idea to make a backup of your archivematica database
before performing any updates. Exact procedures for updating will depend on
your local installation, but a simple example would be to use mysqldump:

.. code:: bash

   mysqldump -u root -p MCP > ~/am_backup.sql


If you do not have a password set for the root user in mysql, you can take out
the '-p' portion of that command. If there is a problem during the upgrade
process, you can restore your mysql database from this backup and try the
upgrade again.

During the update process you may be asked about updating configuration files.
Choose to accept the maintainers versions. You will also be asked about
updating the database, say 'ok' to each of those steps. If you have set a
password for the root mysql database user, enter it when prompted. It is
better to update the dashboard before updating the mcp components.

*This step will fail!*

.. code:: bash

   sudo apt-get upgrade
   
*This step will fail!*

**Remove python-pip system package and install it from source**

Due to a bug in ubuntu's python-pip package (https://bugs.launchpad.net/ubuntu/+source/python-pip/+bug/1658844) , we need to remove python-pip in order to finish the upgrade:

.. code:: bash

   sudo apt-get remove python-pip
   wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py
   sudo python /tmp/get-pip.py
 
 This step cannot be done in advance, as python-pip was a requirement for Archivematica 1.5. The upgrade can finish with:
 
 
.. code:: bash

   sudo apt-get -f install 
   sudo dpkg-reconfigure archivematica-dashboard
 

**Disable unused services**

Archivematica 1.6.0 uses nginx as http server, and gunicorn as wsgi server. This means that some services used in Archivematica 1.5.0 should be stopped and disabled before performing the upgrade.

.. code:: bash

   sudo service apache2 stop
   sudo update-rc.d apache2 disable
   
**Restart Services**

.. code:: bash

   sudo ln -s /etc/nginx/sites-available/dashboard.conf /etc/nginx/sites-enabled/dashboard.conf
   sudo service nginx restart
   sudo restart archivematica-mcp-server
   sudo restart archivematica-mcp-client
   sudo service nginx restart

Note, depending on how your Ubuntu system is set up, you may have trouble
restarting gearman with the command in the block above.  If that is the case,
try this command instead:

.. code:: bash

   sudo restart gearman-job-server

**Update Dashboard Configuration**

Log into the Archivematica dashboard with your existing credentials.  Go to the administration tab,
and click on 'general configuration' in the menu on the left.  You will see a new 'api key' property
in the Storage Service configuration section.  Copy the api key you generated earlier, when creating
a new Storage Service user, into this box and click save.

.. _install-new:

Installing Archivematica 1.6 packages (new install)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Archivematica packages in the past have been hosted on Launchpad, in an Ubuntu PPA (Personal
Package Archive). With the 1.6.0 release, there are repositories at packages.archivematica.org.
This has been introduced to allow one central place to store packages for multiple operating systems.

There are some dependencies still hosted on Launchpad, that have not yet been migrated to packages.archivematica.org.
In a future release, all the requirements will be hosted in one repository, for the time being it is necessary to set up
two different sources of packages.

1. Add the archivematica/externals PPA to your list of trusted repositories (if add-apt-repositories is not available you must install python-software-properties first):

.. code:: bash

   sudo apt-get update
   sudo apt-get install python-software-properties
   sudo add-apt-repository ppa:archivematica/externals

2. Add packages.archivematica.org to your list of trusted repositories

.. code:: bash

   sudo wget -O - https://packages.archivematica.org/1.6.x/key.asc | sudo apt-key add -
   sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.6.x/ubuntu trusty main" >> /etc/apt/sources.list'
   sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.6.x/ubuntu-externals trusty main" >> /etc/apt/sources.list'

3. Add the ElasticSearch apt repository next:

.. code:: bash

   sudo wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
   sudo sh -c 'echo "deb http://packages.elasticsearch.org/elasticsearch/1.7/debian stable main" >> /etc/apt/sources.list'

4. Update your system to the most recent 14.04 release. This step will also fetch a list of the software from the PPAs you just added to your system.

.. code:: bash

   sudo apt-get update
   sudo apt-get upgrade

5. Install Elasticsearch

.. code:: bash

   sudo apt-get install elasticsearch

6. Install the storage service package

.. code:: bash

   sudo apt-get install -y archivematica-storage-service

7. Install pip

.. code:: bash

   wget -O /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py
   sudo python /tmp/get-pip.py

8. Configure the storage service

.. code:: bash

   sudo rm -f /etc/nginx/sites-enabled/default
   sudo ln -s /etc/nginx/sites-available/storage /etc/nginx/sites-enabled/storage

9. Install the Archivematica packages (each of these packages can be installed separately, if necessary). Say YES or OK to any prompts you get after entering the following into terminal:

.. code:: bash

   sudo apt-get install archivematica-mcp-server
   sudo apt-get install archivematica-dashboard
   sudo apt-get install archivematica-mcp-client

10. Configure the dashboard

.. code:: bash

   sudo ln -s /etc/nginx/sites-available/dashboard.conf /etc/nginx/sites-enabled/dashboard.conf

11. Start the Elasticsearch service and configure it to start when the system is booted. This step ensures that the Elasticsearch service will start automatically each time the server is rebooted.

.. code:: bash

   sudo /etc/init.d/elasticsearch restart
   sudo update-rc.d elasticsearch defaults 95 10

12. Start the remaining services

.. code:: bash

   sudo freshclam
   sudo /etc/init.d/clamav-daemon start
   sudo service gearman-job-server restart
   sudo start archivematica-mcp-server
   sudo start archivematica-mcp-client
   sudo start archivematica-storage-service
   sudo start archivematica-dashboard
   sudo service nginx restart
   sudo start fits

If you have trouble with the gearman command try this as an alternative:

.. code:: bash

   sudo restart gearman-job-server

13. Test the storage service. The storage service runs as a separate web application from the Archivematica dashboard. Go to the following link in a web browser and log in as user *test* with the password *test*: http://localhost:8000 (or use the IP address of the machine you have been installing on)

14. Create a new administrative user in the Storage service. The storage service has its own set of users. In the User menu in the Administrative tab of the storage service, add at least one administrative user, and delete or modify the test user. After you have created an administrative user, copy its API key to your clipboard.

15. Test the dashboard. You can login to the Archivematica dashboard and finish the installation in a web browser: http://localhost (again, use the IP address of the machine you have been installing on). When prompted, enter the URL of the Storage Service, the name of the administrative user, and that user's API key.

16. Register your installation for full Format Policy Registry interoperability.

.. _install-source:

Install from source
-------------------

Installing from source has been tested using ansible scripts. Ansible 
installations have been tested for new installations but are not fully tested 
for upgrades.

These instructions are designed to create a test environment on your local 
machine. The ansible roles referenced here can be used in production deployments 
by creating your own ansible playbook to run them. See 
https://github.com/artefactual/deploy-pub/playbooks/archivematica for more 
details.

The following instructions detail how to install and run Archivematica from 
source on a virtual machine.

1. Install VirtualBox, Vagrant, and Ansible:

   .. code:: bash

      sudo apt-get install virtualbox vagrant
      sudo pip install -U ansible

   Vagrant must be at least version 1.5. Check your version with:

   .. code:: bash

      vagrant --version

   If it is not up to date, you can download the newest version from the 
   `Vagrant website <https://www.vagrantup.com/downloads.html>`_ .

#. Checkout the deployment repo:

   .. code:: bash

      git clone https://github.com/artefactual/deploy-pub.git

#. Download the Ansible roles:

   .. code:: bash

      cd deploy-pub/playbooks/archivematica
      ansible-galaxy install -f -p roles/ -r requirements.yml

#. Create the virtual machine and provision it:

   .. code:: bash

      vagrant up

   .. warning::

     This will take a while.
     It depends on your computer, but it could take up to an hour.
     Your computer may be very slow while Archivematica is being provisioned - 
     be sure to save any work and be prepared to step away from your computer 
     while Archivematica is building.

#. If there's an error, you can re-run the setup.

   .. code:: bash

      vagrant provision

Once it's done provisioning, you can log in to your virtual machine::

  vagrant ssh

You can also access your Archivematica instance through the web browser:

* Archivematica: `<http://192.168.168.192>`_. Username & password configured on 
  installation.
* Storage Service: `<http://192.168.168.192:8000>`_. Username: test, password: 
  test.

To get the Storage Service API key, go to `<http://192.168.168.192:8000>`_
and click on the Administration tab. In the left sidebar, click on *Users*, then 
click on *Edit* for the default user. Scrolling down, you will see the API key 
for the default user at the bottom of the screen. Copy this into the API key 
field when prompted during installation.


.. _centos:

Install for CentOS/Redhat
-------------------------

Archivematica version 1.5.1 and higher support installation on CentOS/Redhat.

**Prerequisites**

Update your system

.. code:: bash

   sudo yum update

Extra repos:

Some repositories need to be installed in order to fullfill the installation procedure:

* Extra packages for enterprise linux

.. code:: bash

   sudo yum install -y epel-release

* Elasticsearch

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
   baseurl=https://packages.archivematica.org/1.6.x/centos
   gpgcheck=0
   enabled=1
   EOF'

**Service depencencies**

Common services like elasticsearch, mariadb and gearmand should be installed and enabled before the archivematica install. It can be done with:

.. code:: bash

   sudo -u root yum install -y java-1.8.0-openjdk-headless elasticsearch mariadb-server gearmand
   sudo -u root systemctl enable elasticsearch
   sudo -u root systemctl start elasticsearch
   sudo -u root systemctl enable mariadb
   sudo -u root systemctl start mariadb
   sudo -u root systemctl enable gearmand
   sudo -u root systemctl start gearmand

**Install Archivematica Storage Service**

* First, we install the packages:

.. code:: bash

   sudo -u root yum install -y python-pip archivematica-storage-service

* After the package is installed, we need to populate the sqlite database, and collect some static files used by django. Those tasks must be run as “archivematica” user.

.. code:: bash

   sudo -u archivematica bash -c " \
   set -a -e -x
   source /etc/sysconfig/archivematica-storage-service
   cd /usr/share/archivematica/storage-service
   /usr/lib/python2.7/archivematica/storage-service/bin/python manage.py migrate
   /usr/lib/python2.7/archivematica/storage-service/bin/python manage.py collectstatic --noinput
   ";

* And now, we enable and start the archivematica-storage-service and it’s nginx frontend

.. code:: bash

   sudo -u root systemctl enable archivematica-storage-service
   sudo -u root systemctl start archivematica-storage-service
   sudo -u root systemctl enable nginx
   sudo -u root systemctl start nginx

.. note::

   The storage service will be avaliable at http://<ip>:8001

**Installing Archivematica Dashboard and MCP Server**

* First, install the pacakges:

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
   /usr/lib/python2.7/archivematica/dashboard/bin/python manage.py syncdb --noinput
   ";

* Start and enable services:

.. code:: bash

   sudo -u root systemctl enable archivematica-mcp-server
   sudo -u root systemctl start archivematica-mcp-server
   sudo -u root systemctl enable archivematica-dashboard
   sudo -u root systemctl start archivematica-dashboard

* Reload nginx in order to load the dashboard config file:

.. code:: bash

   sudo -u root systemctl reload nginx

.. note::

   The dashboard will be avaliable at http://ip:81

**Installing Archivematica MCP client**

* First, we need to add some extra repos with the MCP Client dependencies:

* Archivematica supplied external packages:

.. code:: bash

   sudo -u root bash -c 'cat << EOF > /etc/yum.repos.d/archivematica-extras.repo
   [archivematica-extras]
   name=archivematica-extras
   baseurl=https://packages.archivematica.org/1.6.x/centos-extras
   gpgcheck=0
   enabled=1
   EOF'

* Nux multimedia repo

.. code:: bash

   sudo rpm -Uvh https://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm

* Forensic tools repo

.. code:: bash

   sudo rpm -Uvh https://forensics.cert.org/cert-forensics-tools-release-el7.rpm

* Then, install the package:

.. code:: bash

   sudo -u root yum install -y archivematica-mcp-client

* The MCP Client expect some programs in certain paths, so we put things in place:

.. code:: bash

   sudo cp /usr/bin/clamscan /usr/bin/clamdscan
   sudo ln -s /usr/bin/7za /usr/bin/7z

After that, we can enable and start services

.. code:: bash

   sudo -u root systemctl enable archivematica-mcp-client
   sudo -u root systemctl start archivematica-mcp-client
   sudo -u root systemctl enable fits-nailgun
   sudo -u root systemctl start fits-nailgun

**Finalizing installation**

The dashboard will be available on port 81, and the storage service on port 8001.
You will need to complete the installation by opening up the dashboard in a web browser, and filling in the form you are presented with.
On the 2nd page of the installer, you are asked for information about the storage service.
You will need to log into the storage service and find the api key that was generated for your user (in admin->users).

**Configuration**

Each service have a configuration file in /etc/sysconfig/archivematica-packagename

**Troubleshooting**

If IPv6 is disabled, Nginx may refuse to start. If that is the case make sure that the listen directives used under /etc/nginx are not using IPv6 addresses like [::]:80.

CentOS will install firewalld which will be running default rules likely blocking ports 81 and 8001. If you are not able to access the dashboard and storage service, check if firewalld is running. If it is, you will likely need to modify the firewall rules to allow access to ports 81 and 8001 from your location.

.. _centos-upgrade:

Upgrade from Archivematica 1.5 for CentOS/Redhat
------------------------------------------------

* First, upgrade the repositories for 1.6:

.. code:: bash

   sudo sed -i 's/1.5.x/1.6.x/g' /etc/yum.repos.d/archivematica*

* Then, upgrade the packages:

.. code:: bash

   sudo yum update

* Once the new packages are installed, we need to upgrade the databases for both, archivematica and the storage service. This can be done with:

.. code:: bash

   sudo -u archivematica bash -c " \
   set -a -e -x
   source /etc/sysconfig/archivematica-storage-service
   cd /usr/share/archivematica/storage-service
   /usr/lib/python2.7/archivematica/storage-service/bin/python manage.py migrate
   /usr/lib/python2.7/archivematica/storage-service/bin/python manage.py collectstatic --noinput
   ";

   sudo -u archivematica bash -c " \
   set -a -e -x
   source /etc/sysconfig/archivematica-dashboard
   cd /usr/share/archivematica/dashboard
   /usr/lib/python2.7/archivematica/dashboard/bin/python manage.py syncdb --noinput
   ";

* After that, we can restart the archivematica related services, and continue using the system:

.. code:: bash

   sudo systemctl restart archivematica-storage-service
   sudo systemctl restart archivematica-dashboard
   sudo systemctl restart archivematica-mcp-client
   sudo systemctl restart archivematica-mcp-server


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
wiki.

.. _advanced:

Advanced
--------

.. _multiple-machines:

Installing across multiple machines
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It is possible to spread Archivematica's processing load across several machines by installing the following services on separate machines:

* Elasticsearch
* gearman
* mySQL

For help, send an email to `Archivematica tech mailing list. <https://groups.google.com/forum/#!forum/archivematica-tech>`_


.. _firewall:

Firewall requirements
^^^^^^^^^^^^^^^^^^^^^

When installing Archivematica on multiple machines, all the machines must be
able to reach each other on the following ports:

* http, mysqld, gearman, nfs, ssh


.. _install-atom:

Using AtoM 2.x with Archivematica
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Archivematica 1.5 has been tested with and is recommended for use with AtoM
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

TODO

.. _install-arkivum:

Arkivum
^^^^^^^

See: :ref:`Arkivum Storage Service docs <storageservice:arkivum>`

:ref:`Back to the top <installation>`
