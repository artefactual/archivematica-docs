.. _quick-start:

===============================
Archivematica Quick-Start Guide
===============================

.. quick-start-intro

This guide will get you up and running with Archivematica for testing purposes.
This is not a guide to install Archivematica for development or production - please
see :ref:`Installation <installation>` for full installation instructions.

This guide presents a standard, simple transfer and does not go into detail about
Archivematica's advanced features. For more information about processing more
complex content, see the :ref:`User manual <user-manual>`

The instructions below are applicable to both the sandbox and an Archivematica
virtual machine, unless otherwise noted.

*On this page:*

* :ref:`Using the sandbox <quick-start-sandbox>`
* :ref:`Installing on a local virtual machine <quick-start-vm>`
* :ref:`Starting your first transfer <quick-start-transfer>`
* :ref:`Ingest and normalization <quick-start-ingest>`
* :ref:`AIP and DIP storage <quick-start-storage>`
* :ref:`Uploading a DIP <quick-start-dip-upload>`
* :ref:`Processing configurations <quick-start-config>`
* :ref:`The format policy registry <quick-start-fpr>`


.. _quick-start-sandbox:

Using the sandbox
-----------------

Artefactual maintains an `Archivematica sandbox <sandbox.archivematica.org>`_ with the following
credentials:

* Username: demo@example.com
* Password: demodemo

The sandbox is provided as an easy way to test the latest release of the Archivematica.
Please note that the website will automatically reset daily. Any packages that you
create will not be permanently saved. Additionally, there may be more than one demo
user logged-in at the same time, so you may see changes made by others while you
are using the software.

The demo site is publicly edited and unmoderated. For reasons of security, test
transfers are limited to Artefactual's provided sample data. Users who wish to
test using their own data may download the Vagrant box (described below) and test
locally.

.. note::

  If you are using the sandbox, you can skip the next section.

.. _quick-start-vm:

Installing on a virtual machine
-------------------------------

It is possible to deploy Archivematica on a virtual machine. Users may want to do
this in order to test Archivematica's functionality using their own data. The
recommended way to install Archivematica on a virtual machine is with Ansible and
Vagrant.

To install and run Archivematica on a virtual machine, you must be somewhat
comfortable working on the command line. Note that the commands below are for Ubuntu; if you are installing on Mac or a different Linux distribution, the commands might be slightly different.

Install VirtualBox, Vagrant, and Ansible with the following commands::

  sudo apt-get install virtualbox vagrant

  sudo pip install -U ansible

Vagrant must be at least version 1.5. Check your version with::

  vagrant --version

If it is not up to date, you can download the newest version from the `Vagrant website <https://www.vagrantup.com/downloads.html>`_ .

The deployment repository is the source code from which you will be building your local Archivematica instance. Check out the deployment repository::

  git clone https://github.com/artefactual/deploy-pub.git

Ansible roles govern the deployment - they tell Archivematica how it should be built. Download the Ansible roles::

  cd deploy-pub/playbooks/archivematica

  ansible-galaxy install -f -p roles/ -r requirements.yml

Now that you have the source code and the rules for building Archivematica, it's
time to start building. This step will create your virtual machine and build, or
provision, Archivematica::

  vagrant up

.. warning::

  This will take a while. It depends on your computer, but it could take up to an
  hour. Your computer may be very slow while Archivematica is being provisioned - be
  sure to save any work and be prepared to step away from your computer while
  Archivematica is building.

Once it's done provisioning, you can log in to your virtual machine::

  vagrant ssh

You may also now access your Archivematica instance through the web browser:

* Archivematica: `<http://192.168.168.192>`_
* Storage Service: `<http://192.168.168.192:8000>`_

.. _quick-start-transfer:

Starting your first transfer
----------------------------

To start your first transfer, go to the Archivematica dashboard - the main page
of either the `sandbox <sandbox.archivematica.org>`_ or your `Archivematica VM <http://192.168.168.192>`_



.. _quick-start-ingest:

Ingest and normalization
------------------------

.. _quick-start-storage:

AIP and DIP storage
-------------------

.. _quick-start-dip-upload:

Uploading a DIP
---------------

.. _quick-start-config:

Processing Configurations
-------------------------

.. _quick-start-fpr:

The Format Policy Registry
--------------------------
