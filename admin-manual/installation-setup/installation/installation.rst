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
--------

The following table lists various ways to install and use Archivematica. Further
down the page, you will find more detailed information about new installations
and advanced installation options.

If you need assistance or clarification regarding the installation instructions,
the `Archivematica user forum`_ is a good place ask questions.

.. csv-table::
   :file: _csv/install-new.csv
   :header-rows: 1

.. csv-table::
   :file: _csv/install-testing.csv
   :header-rows: 1

.. csv-table::
   :file: _csv/install-development.csv
   :header-rows: 1

.. csv-table::
   :file: _csv/install-multiple-machines.csv
   :header-rows: 1

.. _treq:

Technical requirements
----------------------

Operating system
^^^^^^^^^^^^^^^^

Archivematica |release| installation instructions are provided here for the
following operating systems:

* Ubuntu 16.04 64-bit Server Edition
* Ubuntu 18.04 64-bit Server Edition
* CentOS 7 64-bit

Other Linux distributions should work, but will require customization of these
installation instructions.

Support for macOS is possibly in theory, but is not being tested, and would
require more significant deviation from these instructions.

Archivematica is unlikely to ever run directly in a Windows environment.
Consider the use of a virtualization platform to run Linux VMs.

Dependencies
^^^^^^^^^^^^

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
   Ubuntu 16.04 and Ubuntu 18.04.

   Some of the tools run by Archivematica require Java to be
   installed (primarily Elasticsearch and fits). On Ubuntu 18.04, Open JDK 8
   is used, but Open JDK 11 is the default. On Ubuntu 16.04, Open JDK 8 is the
   default. It is possible to use Oracle Java 7 or 8 instead.

   The remaining dependencies should be kept at the versions installed
   by Archivematica.

.. _install-elasticsearch:

Elasticsearch
^^^^^^^^^^^^^

As of Archivematica 1.7, installing Elasticsearch is optional. Elasticsearch
powers the indexes that are used for searching in the :ref:`Backlog <backlog>`,
:ref:`Appraisal <appraisal>`, and/or :ref:`Archival Storage <archival-storage>`.
Installing Archivematica without Elasticsearch results in reduced consumption of
compute resources and lower operational complexity. Disabling Elasticsearch
means that the Backlog, Appraisal, and/or Archival Storage tabs will not appear
in the user interface and their functionality will not be available.

By setting the ``archivematica_src_search_enabled``
configuration attribute, administrators can define how many things Elasticsearch
is indexing, if any. This can impact searching across several different
dashboard pages.

Possible ``archivematica_src_search_enabled`` configuration attribute values:

* ``transfers``: Only transfers are indexed. Search is enabled on the Backlog
  and Appraisal tabs, but not the Archival Storage tab.
* ``aips``: Only AIPs are indexed. Search is enabled on the Archival Storage
  tab, but not the Backlog or Appraisal tabs.
* ``aips,transfers``, or ``true``: Both AIPs and transfers are indexed.
  Search works on the Backlog, Appraisal, and Archival Storage tabs.
* ``false``: Indexless mode. Neither AIPs nor transfers are indexed. The
  Backlog, Appraisal, and Archival Storage tabs will be non-functional.

When Elasticsearch is used, Archivematica |release| requires version 6.x (tested
with 6.5.4).

For more information on disabling Elasticsearch, please see the README for
Archivematica's ansible role,

Hardware
^^^^^^^^

Archivematica is capable of running on almost any hardware supported by Linux;
however, processing large collections will require better hardware.

.. _requirements-small:

Minimum hardware requirements
+++++++++++++++++++++++++++++

For small-scale functionality testing using small collections (transfers with
100 files or less, total file size 1 GB or smaller), we recommend the following
minimum hardware requirements:

* Processor: 2 CPU cores
* Memory: 2GB+
* Disk space (processing): 7GB plus two to three times the disk space required
  for the collection being processed (e.g., 3GB to process a 1GB transfer)

.. _requirements-production:

Recommended minimum production requirements
+++++++++++++++++++++++++++++++++++++++++++

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

These requirements may not be suitable for certain types of material - for
example, audio-visual material requires more processing power than images or
documents.

Browser compatability
^^^^^^^^^^^^^^^^^^^^^

Archivematica has been tested most extensively with Firefox and Chrome. There
are known issues with Internet Explorer 11 which result in an inability to start
transfers in the dashboard (`Issue 7246`_). Minimal, but successful, testing has
been done with Microsoft Edge.

.. _instructions:

Instructions for new installations
----------------------------------

Archivematica can be installed using packages or Ansible scripts in either
CentOS/Red Hat or Ubuntu environments. It can also be installed using Docker.
At this time, installation instructions are provided for officially tested and
supported installation environments:

* :ref:`Automated install on Ubuntu (16.04 and 18.04) using Ansible
  <install-ansible>`.
* :ref:`Manual install of OS packages on CentOS/Red Hat <install-pkg-centos>`

Note that :ref:`manual install of OS packages on Ubuntu (16.04 and 18.04)
<install-pkg-ubuntu>` is documented but not officially supported.

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
-----------------------------

There are many ways to install Archivematica, depending on the needs of the
individual user. We have documented some common advanced installation setups.

* :ref:`Installing for development <development>`
* :ref:`Configure Archivematica with SSL <SSL-support>`
* :ref:`Configure Archivematica with task output capturing disabled <task-output-capturing-admin>`
* :ref:`Scaling Archivematica <scaling-archivematica>`

:ref:`Back to the top <installation>`

.. _`deploy-pub`: https://github.com/artefactual/deploy-pub
.. _`ansible-archivematica-src`: https://github.com/artefactual-labs/ansible-archivematica-src
.. _`Archivematica user forum`: https://groups.google.com/forum/#!forum/archivematica
.. _`docker`: https://github.com/artefactual-labs/am/tree/master/compose
.. _`Issue 7246`: https://projects.artefactual.com/issues/7246
