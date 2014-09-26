.. _installation:

============
Installation
============

*On this page*

* :ref:`Technical requiremnets <tech-requirements>`

* :ref:`Recommended Minimum Requirements for small-scale testing <requirements-small>`

* :ref:`Recommended Minimum Requirements for production processing <requirements-production>`

* :ref:`Firewall requirements <firewall>`

* :ref:`Install 1.2 (upgrade 1.1) <install-1_2>`

* :ref:`Install new from packages <install-new>`

* :ref:`Using AtoM 2.x with Archivematica <install-atom>`

.. _tech-requirements:

Technical Requirements
----------------------

Operating System requirement: Ubuntu 12.04. Archivematica is designed to work
with Ubuntu 12.04, it will not work with other versions of Ubuntu, or other
Linux distributions. Archivematica 1.2.1 has been tested with Ubuntu 14.04,
but official packages are not yet available.

Archivematica is capable of running on almost any hardware supported by Ubuntu
12.04; however, processing large collections will require better hardware.

Archivematica can be installed on a single machine, or across many machines to
spread the processing workload.

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

* Processor: dual core i5 2nd generation CPU or better
*  Memory: 8GB+
*  Disk space: 10GB plus the disk space required for the collection.

.. _firewall:

Firewall requirements
---------------------

When installing Archivematica on multiple machines, all the machines must be
able to reach each other on the following ports:

* http, mysqld, gearman, nfs, ssh

.. _install-1_2:

Install release 1.2
-------------------

.. note::

   Archivematica 1.2 requires Ubuntu 12.04.04. Artefactual has tested against
   12.04.4 with success and cannot verify functionality with later releases of
   Ubuntu. Ubuntu Server (either 64bit or 32bit) is recommended.

   Artefactual is actively testing Archivematica 1.2 with Ubuntu 14.04. We are
   planning on releasing 12.04 and 14.04 packages for the 1.x releases,
   starting probably with 1.2.0. Archivematica code works fine on Ubuntu
   14.04, however there are issues with some of the dependencies. In most
   cases using 14.04 makes things easier,  as there are some software packages
   that Artefactual has had to package and make available in our externals
   ppa, and with trusty that list is smaller. Once Artefactual has done more
   testing, we will add trusty packages to our release ppa. As this is
   unfunded work, we do not have a deadline but it is in the project's best
   interest. We want to use trusty in our hosted Archivematica service and to
   provide that option to our customers who are on maintenance agreements.

Updating from Archivematica 1.1
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you have installed Archivematica 1.1.0 from packages, it is possible to
update your installation without re-installing. The steps are:

**Update Archivematica Storage Service**

.. code:: bash

   sudo apt-get update
   sudo apt-get install archivematica-storage-service

**Update Archivematica**

It is always a good idea to make a backup of your archivematica database
before performing any updates. Exact procedures for updating will depend on
your local installation, but a simple example would be to use mysqldump:

.. code:: bash

   mysqldump -u root -p MCP > ~/am110_backup.sql

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

**Update ElasticSearch (optional)**

Archivematica 1.2.0 has been tested most extensively against version 0.90.13
of ElasticSearch. This is the same version that was distributed with
Archivematica 1.1.0, so no changes to ElasticSearch should be required in most
cases. Do not attempt to use ElasticSearch 1.0 or greater.

**Restart Services**

.. code:: bash

   sudo service uwsgi restart
   sudo service nginx restart
   sudo /etc/init.d/apache2 restart
   sudo /etc/init.d/elasticsearch restart
   sudo /etc/init.d/gearman-job-server restart
   sudo restart archivematica-mcp-server
   sudo restart archivematica-mcp-client
   sudo restart fits

.. _install-new:

Installing Archivematica 1.2 packages (new install)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Archivematica packages are hosted on Launchpad, in an Ubuntu PPA (Personal
Package Archive). In order to install software onto your Ubuntu 12.04.5 system
from a PPA:

1. Add the archivematica/release PPA to your list of trusted repositories (if
   add-apt-repositories is not available you must install python-software-
   properties first):

.. code:: bash

   sudo apt-get update
   sudo apt-get install python-software-properties
   sudo add-apt-repository ppa:archivematica/release
   sudo add-apt-repository ppa:archivematica/externals


.. note::

   There are test packages available for Ubuntu 14.04. If you would like to
   evaluate or test Archivematica on Ubuntu 14.04, use the archivematica/qa
   ppa instead of archivematica/release in the instructions above. Please note
   that this is not yet verified to actually work.


2. Add the ElasticSearch apt repository next (from
   http://www.elasticsearch.org/guide/en/elasticsearch/reference/current/setup-repositories.html):

.. code:: bash

   sudo wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -

Then add this line to the bottom of ``/etc/apt/sources.list``

.. code:: bash

   deb http://packages.elasticsearch.org/elasticsearch/0.90/debian stable main

3. Update your system to the most recent 12.04 release (12.04.5 at the time of
   this writing).

This step will also fetch a list of the software from the PPAs you just added
to your system.

.. code:: bash

   sudo apt-get update
   sudo apt-get upgrade

4. Install all packages (each of these packages can be installed seperately, if
   necessary). Say YES or OK to any prompts you get after entering the following
   into terminal:

.. code:: bash

   sudo apt-get install archivematica-storage-service
   sudo apt-get install elasticsearch
   sudo apt-get install archivematica-mcp-server
   sudo apt-get install archivematica-mcp-client
   sudo apt-get install archivematica-dashboard

5. Configure the dashboard and storage service

.. warning::

   These steps are safe to do on a desktop, or a machine dedicated to
   Archivematica. They may not be advisable on an existing web server.
   Consult with your web server administrator if you are unsure.

.. code:: bash

   sudo wget -q https://raw.githubusercontent.com/artefactual/archivematica/stable/1.2.x/localDevSetup/apache/apache.default -O /etc/apache2/sites-available/default
   sudo rm /etc/nginx/sites-enabled/default
   sudo ln -s /etc/nginx/sites-available/storage /etc/nginx/sites-enabled/storage
   sudo ln -s /etc/uwsgi/apps-available/storage.ini /etc/uwsgi/apps-enabled/storage.ini
   sudo service uwsgi restart
   sudo service nginx restart
   sudo /etc/init.d/apache2 restart
   sudo freshclam
   sudo /etc/init.d/clamav-daemon start
   sudo /etc/init.d/elasticsearch restart
   sudo /etc/init.d/gearman-job-server restart
   sudo start archivematica-mcp-server
   sudo start archivematica-mcp-client
   sudo start fits

6. Test the storage service

The storage service runs as a separate web application from the Archivematica
dashboard. Go to the following link in a web browser:

http://localhost:8000 (or use the IP address of the machine you have been installing on).

log in as user: test password: test

7. Create a new administrative user in the Storage service

The storage service has its own set of users. In the User menu in the
Administrative tab of the storage service, add at least one administrative
user, and delete or modify the test user.

8. Test the dashboard

You can login to the Archivematica dashboard and finish the installation in a
web browser: http://localhost (again, use the IP address of the machine you
have been installing on)

9. Register your installation for full Format Policy Registry interoperability.

Register Archivematica 1.2

.. _install-atom:

Using AtoM 2.x with Archivematica
---------------------------------

Archivematica has been successfully tested with AtoM 2.x. The best known
configuration is Archivematica 1.2.0 with AtoM deployed from the stable/2.0.x
branch. Archivematica has also been successfully tested with the qa/2.1.x branch.

Installation instructions for Atom 2 are available on the accesstomemory.org
website https://www.accesstomemory.org/en/docs/2.0/ . When following those
instructions, it is best to download Atom from the git repository (rather than
use one of the supplied tarballs). When checking out Atom, use the head of
either the stable/2.0.x or qa/2.1.x branch.

Once you have a working AtoM installation, you can configure dip upload
between Archivematica and Atom. The basic steps are:

* update atom dip upload configuration in the Archivematica dashboard

* confirm atom-worker is configured on the Atom server (copy the atom-
  worker.conf file from atom source to /etc/init/)

* enable the Sword Plugin in the AtoM plugins page

* enable job scheduling in the AtoM settings page

* confirm gearman is installed on the AtoM server

* configure ssh keys to allow rsync to work for the archivematica user, from
  the Archivematica server to the Atom server

* start gearman on the Atom server

* start the atom worker on the AtoM server

These steps are detailed on the DIP Upload page.

:ref:`Back to the top <installation>`








