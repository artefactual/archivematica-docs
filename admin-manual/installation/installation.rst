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

* :ref:`Docker <docker>`

* :ref:`Advanced <advanced>`

.. _tech-requirements:

Technical Requirements
----------------------

Version 1.5: Operating System requirement: A current Ubuntu LTS version, which at the moment means version 14.04.  The 64 bit Server Edition of Ubuntu 14.04.4 is recommended.

We plan to release a version 1.5.1 which will be available on Ubuntu 12.04, 16.04 and CentOS/Redhat 7 (more information available soon).

Archivematica is capable of running on almost any hardware supported by Ubuntu; however, processing large collections will require better hardware.

Archivematica can be installed on a single machine, or across many machines to spread the processing workload. See :ref:`Advanced <advanced>.`

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

Installing from packages is tested for both new installations and upgrading from version 1.4.

Updating from Archivematica 1.4
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you have installed an earlier version Archivematica from packages, it is
possible to update your installation without re-installing. The steps are:


**Update python**

This might be done on your system already, if you have been updating the operating system
on an ongoing basis.

.. code:: bash

   apt-get update
   apt-get install python-pip

**Add source code repositories**

.. code:: bash

   sudo add-apt-repository ppa:archivematica/externals
   wget -O - https://packages.archivematica.org/1.5.x/key.asc | apt-key add -
   echo 'deb [arch=amd64] http://packages.archivematica.org/1.5.x/ubuntu trusty main' >> /etc/apt/sources.list

**Update Archivematica Storage Service**

Ensure that the default user 'test' exists in the Storage Service before updating (create it if it doesn't). Database migrations may not be correctly applied if not.

.. code:: bash

   sudo apt-get update
   sudo apt-get install archivematica-storage-service

**Create new Storage Service user**

Archivematica Storage Service 0.8.0 introduces a new security feature - each user is assigned an API key.
All api interactions with the storage service require the use of an api key, including from the Archivematica Dashboard.

Log into the Storage Service with your existing credentials.  Go to the Administration tab, and then select 'users'
from the menu on the left.  Create a new user.  Once you have finished creating the new user, copy the api key that
is displayed on the 'edit user' page.  You will need this later after upgrading the Dashboard.

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

.. code:: bash

   sudo apt-get install archivematica-common
   sudo apt-get install archivematica-dashboard
   sudo apt-get install archivematica-mcp-server
   sudo apt-get install archivematica-mcp-client

**(Optional) Update Elasticsearch**

Archivematica 1.4.1 uses Elasticsearch version 1.4.  Archivematica 1.5.0 will work with any version of Elasticsearch from 1.4 to 1.7.5.  You do not have to upgrade Elasticsearch when upgrading Archivematica, although we recommend doing so, to make future upgrades easier.

Instructions on how to upgrade can be found on the
`Elasticsearch website <https://www.elastic.co/guide/en/elasticsearch/reference/1.3/setup-upgrade.html>`_.
In general it should be possible to upgrade Elasticsearch on a standard Archivematica machine with the following commands:

.. code:: bash

   sudo /etc/init.d/elasticsearch stop
   sudo echo "deb http://packages.elasticsearch.org/elasticsearch/1.7/debian stable main" >> /etc/apt/sources.list
   sudo apt-get update
   sudo apt-get install elasticsearch
   sudo /etc/init.d/elasticsearch start

You will be prompted with questions about modifying configuration files.  If you have not made any modifications to your Elasticsearch configuration, it should be safe to use the new versions of the configuration files that come with Elasticsearch.

**Restart Services**

.. code:: bash

   sudo service uwsgi restart
   sudo service nginx restart
   sudo /etc/init.d/apache2 restart
   sudo service gearman-job-server restart
   sudo restart archivematica-mcp-server
   sudo restart archivematica-mcp-client
   sudo restart fits
   sudo freshclam

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

Installing Archivematica 1.5 packages (new install)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Archivematica packages in the past have been hosted on Launchpad, in an Ubuntu PPA (Personal
Package Archive). With the 1.5.0 release, there is now a new repository at packages.archivematica.org.
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

   sudo wget -O - https://packages.archivematica.org/1.5.x/key.asc | sudo apt-key add -
   sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.5.x/ubuntu trusty main" >> /etc/apt/sources.list'

3. Add the ElasticSearch apt repository next:

.. code:: bash

   sudo wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
   sudo sh -c 'echo "deb http://packages.elasticsearch.org/elasticsearch/1.7/debian stable main" >> /etc/apt/sources.list'

4. Update your system to the most recent 14.04 release. This step will also fetch a list of the software from the PPAs you just added to your system.

.. code:: bash

   sudo apt-get update
   sudo apt-get upgrade

4. Install the storage service package

.. code:: bash

   sudo apt-get install -y archivematica-storage-service

5. Configure the storage service

.. code:: bash

   sudo rm -f /etc/nginx/sites-enabled/default
   sudo ln -s /etc/nginx/sites-available/storage /etc/nginx/sites-enabled/storage
   sudo ln -s /etc/uwsgi/apps-available/storage.ini /etc/uwsgi/apps-enabled/storage.ini
   sudo service uwsgi restart
   sudo service nginx restart

6. Install the Archivematica packages (each of these packages can be installed separately, if necessary). Say YES or OK to any prompts you get after entering the following into terminal:

.. code:: bash

   sudo apt-get install archivematica-mcp-server
   sudo apt-get install archivematica-mcp-client
   sudo apt-get install archivematica-dashboard
   sudo apt-get install elasticsearch

7. Configure the dashboard

.. code:: bash

   sudo rm -f /etc/apache2/sites-enabled/*default* [this might change]
   sudo wget -q https://raw.githubusercontent.com/artefactual/archivematica/stable/1.4.x/localDevSetup/apache/apache.default -O /etc/apache2/sites-available/default.conf
   sudo ln -s /etc/apache2/sites-available/default.conf /etc/apache2/sites-enabled/default.conf
   sudo /etc/init.d/apache2 restart
   sudo freshclam
   sudo /etc/init.d/clamav-daemon start
   sudo /etc/init.d/elasticsearch restart
   sudo service gearman-job-server restart
   sudo start archivematica-mcp-server
   sudo start archivematica-mcp-client
   sudo start fits

If you have trouble with the gearman command try this as an alternative:

.. code:: bash

   sudo restart gearman-job-server

8. Test the storage service. The storage service runs as a separate web application from the Archivematica dashboard. Go to the following link in a web browser and log in as user *test* with the password *test*: http://localhost:8000 (or use the IP address of the machine you have been installing on)

9. Create a new administrative user in the Storage service. The storage service has its own set of users. In the User menu in the Administrative tab of the storage service, add at least one administrative user, and delete or modify the test user. After you have created an administrative user, copy its API key to your clipboard.

10. Test the dashboard. You can login to the Archivematica dashboard and finish the installation in a web browser: http://localhost (again, use the IP address of the machine you have been installing on). When prompted, enter the URL of the Storage Service, the name of the administrative user, and that user's API key.

11. Register your installation for full Format Policy Registry interoperability.

.. _install-source:

Install from source
-------------------

Installing from source has been tested using ansible scripts. Ansible installations have been tested for new installations but are not fully tested for upgrades.

Instructions coming soon.

.. _docker:

Docker
------

Docker installations are experimental at this time- instructions coming soon.


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
