.. _installation:

============
Installation
============

*On this page*

* :ref:`Technical requiremnets <tech-requirements>`

* :ref:`Recommended Minimum Requirements for small-scale testing <requirements-small>`

* :ref:`Recommended Minimum Requirements for production processing <requirements-production>`

* :ref:`Firewall requirements <firewall>`

* :ref:`Install 1.4 (upgrade 1.3) <install-1_4>`

* :ref:`Install new from packages <install-new>`

* :ref:`Using AtoM 2.x with Archivematica <install-atom>`

.. _tech-requirements:

Technical Requirements
----------------------

Operating System requirement: A current Ubuntu LTS version, which at the moment
means version 14.04 or 12.04.  The 64 bit Server Edition of Ubuntu 14.04.2 is
recommended.

Archivematica is capable of running on almost any hardware supported by Ubuntu;
however, processing large collections will require better hardware.

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

* Processor: dual core i5 3rd generation CPU or better
* Memory: 8GB+
* Disk space: 20GB plus the disk space required for the collection.

.. _firewall:

Firewall requirements
---------------------

When installing Archivematica on multiple machines, all the machines must be
able to reach each other on the following ports:

* http, mysqld, gearman, nfs, ssh

.. _install-1_4:

Updating from Archivematica 1.3
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you have installed an earlier version Archivematica from packages, it is
possible to update your installation without re-installing. The steps are:

**Add source code repository**

.. code:: bash

   sudo add-apt-repository ppa:archivematica/1.4

**Update Archivematica Storage Service**

.. code:: bash

   sudo apt-get update
   sudo apt-get install archivematica-storage-service

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

**Update Elasticsearch **

Archivematica 1.4.0 requires a new version of Elasticsearch.  Full instructions
 on how to upgrade can be found on the 'Elasticsearch website
<https://www.elastic.co/guide/en/elasticsearch/reference/1.3/setup-upgrade.html>'_.
In general it should be possible to upgrade Elasticsearch on a standard
Archivematica machine with the following commands:

.. code:: bash

   sudo /etc/init.d/elasticsearch stop
   sudo echo "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main" >> /etc/apt/sources.list
   sudo apt-get update
   sudo apt-get install elasticsearch
   sudo /etc/init.d/elasticsearch start

**Restart Services**

.. code:: bash

   sudo service uwsgi restart
   sudo service nginx restart
   sudo /etc/init.d/apache2 restart
   sudo /etc/init.d/gearman-job-server restart
   sudo restart archivematica-mcp-server
   sudo restart archivematica-mcp-client
   sudo restart fits

Note, depending on how your Ubuntu system is set up, you may have trouble
restarting gearman with the command in the block above.  If that is the case,
try this command instead:

.. code:: bash

   sudo restart gearman-job-server

.. _install-new:

Installing Archivematica 1.4 packages (new install)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Archivematica packages are hosted on Launchpad, in an Ubuntu PPA (Personal
Package Archive). In order to install software onto your Ubuntu system
from a PPA:

1. Add the archivematica/release PPA to your list of trusted repositories (if
   add-apt-repositories is not available you must install python-software-
   properties first):

.. code:: bash

   sudo apt-get update
   sudo apt-get install python-software-properties
   sudo add-apt-repository ppa:archivematica/1.4

2. Add the ElasticSearch apt repository next:

.. code:: bash

   sudo wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
   sudo sh -c 'echo "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main" >> /etc/apt/sources.list'

3. Update your system to the most recent 12.04 release (12.04.5 at the time of
   this writing).

This step will also fetch a list of the software from the PPAs you just added
to your system.

.. code:: bash

   sudo apt-get update
   sudo apt-get upgrade

4. Install the storage service package

.. code:: bash

   sudo apt-get install archivematica-storage-service

5. Configure the storage service

.. code:: bash

   sudo rm -f /etc/nginx/sites-enabled/default
   sudo ln -s /etc/nginx/sites-available/storage /etc/nginx/sites-enabled/storage
   sudo ln -s /etc/uwsgi/apps-available/storage.ini /etc/uwsgi/apps-enabled/storage.ini
   sudo service uwsgi restart
   sudo service nginx restart

6. Install the Archivematica packages (each of these packages can be installed separately, if
   necessary). Say YES or OK to any prompts you get after entering the following
   into terminal:

.. code:: bash

   sudo apt-get install archivematica-mcp-server
   sudo apt-get install archivematica-mcp-client
   sudo apt-get install archivematica-dashboard
   sudo apt-get install elasticsearch

7. Configure the dashboard

.. code:: bash

   sudo rm -f /etc/apache2/sites-enabled/*default*
   sudo wget -q https://raw.githubusercontent.com/artefactual/archivematica/stable/1.4.x/localDevSetup/apache/apache.default -O /etc/apache2/sites-available/default.conf
   sudo ln -s /etc/apache2/sites-available/default.conf /etc/apache2/sites-enabled/default.conf
   sudo /etc/init.d/apache2 restart
   sudo freshclam
   sudo /etc/init.d/clamav-daemon start
   sudo /etc/init.d/elasticsearch restart
   sudo /etc/init.d/gearman-job-server restart
   sudo start archivematica-mcp-server
   sudo start archivematica-mcp-client
   sudo start fits

If you have trouble with the gearman command try this as an alternative:

.. code:: bash

   sudo restart gearman-job-server

8. Test the storage service

The storage service runs as a separate web application from the Archivematica
dashboard. Go to the following link in a web browser:

http://localhost:8000 (or use the IP address of the machine you have been installing on).

log in as user: test password: test

9. Create a new administrative user in the Storage service

The storage service has its own set of users. In the User menu in the
Administrative tab of the storage service, add at least one administrative
user, and delete or modify the test user.

10. Test the dashboard

You can login to the Archivematica dashboard and finish the installation in a
web browser: http://localhost (again, use the IP address of the machine you
have been installing on)

11. Register your installation for full Format Policy Registry interoperability.

Register Archivematica 1.4

.. _install-atom:

Using AtoM 2.x with Archivematica
---------------------------------

Archivematica has been successfully tested with AtoM 2.x. The best known
configuration is Archivematica 1.4.0 with AtoM deployed from the stable/2.1.x
branch. Archivematica has also been successfully tested with the qa/2.2.x branch.

Installation instructions for Atom 2 are available on the accesstomemory.org
website https://www.accesstomemory.org/en/docs/2.1/ . When following those
instructions, it is best to download Atom from the git repository (rather than
use one of the supplied tarballs). When checking out Atom, use the head of
either the stable/2.1.x or qa/2.2.x branch.

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

:ref:`Back to the top <installation>`
