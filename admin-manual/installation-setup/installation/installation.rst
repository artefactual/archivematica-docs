.. _installation:

========================
Installing Archivematica
========================

*On this page*

* :ref:`Overview <overview>`
* :ref:`Technical requirements <treq>`
* :ref:`Instructions for new installations <instructions>`
* :ref:`Advanced installation options <advanced>`

.. _overview:

Overview
========

The following table lists all help topics on installing Archivematica for various intended uses and host environments.

If you need assistance or clarification regarding the installation instructions,
the `Archivematica user forum`_ is a good place ask questions.

.. csv-table::
   :file: _csv/install-landing.csv

.. _treq:

Technical requirements
======================

Operating system
----------------

Archivematica |release| installation instructions are provided here for the
following operating systems:

* Ubuntu 14.04 64-bit Server Edition
* Ubuntu 16.04 64-bit Server Edition
* Ubuntu 18.04 64-bit Server Edition (experimental support)
* CentOS 7 64-bit

Archivematica |version| is the first release to be tested on Ubuntu 16.04. Support
for this OS is still considered beta; installation has been tested but production
deployments are limited.

Other Linux distributions should work, but will require customization of these
installation instructions.

Support for macOS is possibly in theory, but is not being tested, and would
require more significant deviation from these instructions.

Archivematica is unlikely to ever run directly in a Windows environment.
Consider the use of a virtualization platform to run Linux VMs.

Dependencies
------------

Archivematica has a long list of software it depends on. All of these
dependencies are installed when following the instructions below.

Note that it is possible to install some of the components on separate machines
in order to improve performance, such as:

* MySQL
* Gearman
* Elasticsearch (optional as of Archivematica 1.7, see below)

Using additional machines will require additional configuration. For more
information, see :ref:`Advanced <advanced>`.

.. note::
   Archivematica |version| has been tested with MySQL 5.5, including
   the Percona and MariaDB alternatives. Archivematica uses MySQL 5.7 on
   Ubuntu 16.04.

   Some of the tools run by Archivematica require Java to be
   installed (primarily Elasticsearch and fits). On Ubuntu 14.04, Open JDK 7
   is used. On Ubuntu 16.04, Open JDK 8 is the default. It is possible to use
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

Browser compatability
---------------------

Archivematica has been tested most extensively with Firefox and Chrome. There are
known issues with Internet Explorer 11 which result in an inability to start
transfers in the dashboard (`Issue 7246`_). Minimal, but successful,
testing has been done with Microsoft Edge.

.. _requirements-small:

Minimum hardware requirements
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For small-scale functionality testing using small collections (transfers with 100
files or less, total file size 1 GB or smaller), we recommend the following minimum
hardware requirements:

* Processor: 2 CPU cores
* Memory: 2GB+
* Disk space (processing): 7GB plus two to three times the disk space required for the
  collection being processed (e.g., 3GB to process a 1GB transfer)

.. _requirements-production:

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

.. _instructions:

Instructions for new installations
==================================

Archivematica can be installed using packages or Ansible scripts in either
CentOS/Red Hat or Ubuntu environments. It can also be installed using Docker.
At this time, installation instructions are provided for officially tested and
supported installation environments:

* :ref:`Automated install on Ubuntu (14.04 and 16.04) using Ansible <install-ansible>`. Ansible playbooks for Ubuntu 18.04 are also available, but experimental

* :ref:`Manual install of OS packages on CentOS/Red Hat <install-pkg-centos>`

:ref:`Manual install of OS packages on Ubuntu (14.04 and 16.04) <install-pkg-ubuntu>`
is documented but not officially supported.

Installing Archivematica using :ref:`Docker <development>` is not officially
supported for production deployments. However, it is the preferred development
environment for those who work on Archivematica's code.

For more information about installation environments, please see the
`ansible-archivematica-src`_ repo, the `deploy-pub`_ repo, and ask on the
`Archivematica user forum`_ for more details.

If you are upgrading from a previous version of Archivematica, please see the
:ref:`upgrading instructions <upgrade>`.

.. _advanced:

Advanced installation options
=============================

There are many ways to install Archivematica, depending on the needs of the
individual user. We have documented some common advanced installation setups.

* :ref:`Installing for development <development>`
* :ref:`Installing across multiple machines <multiple-machines>`
* :ref:`Configure Archivematica with SSL <SSL-support>`
* :ref:`Configure Archivematica with task output capturing disabled <task-output-capturing-admin>`


:ref:`Back to the top <installation>`

.. _`archivematica-tech`: https://groups.google.com/forum/#!forum/archivematica-tech
.. _`deploy-pub`: https://github.com/artefactual/deploy-pub
.. _`ansible-archivematica-src`: https://github.com/artefactual-labs/ansible-archivematica-src
.. _`Archivematica user forum`: https://groups.google.com/a/artefactual.com/forum/#!forum/archivematica
.. _`docker`: https://github.com/artefactual-labs/am/tree/master/compose
.. _`Issue 7246`: https://projects.artefactual.com/issues/7246
