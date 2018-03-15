.. _home:

===========================
Archivematica documentation
===========================

.. toctree::
   :hidden:

   /getting-started/index
   /user-manual/index
   /admin-manual/index

.. _getting-started-home:

Getting started
===============

The getting started manual is intended for users who are considering implementing
Archivematica as a digital preservation solution. This manual includes information
on the Archivematica project as well as a quick-start guide to help new users test
it out. For information about installing and using Archivematica in a production
environment, see the user or administrator manuals below.

.. _home-overview:

Overview
--------

The overview section provides a definition of Archivematica and a description of the
OAIS model on which it is based, its technical architecture, the microservices
framework, and information about system requirements for deploying Archivematica.

* :ref:`What is Archivematica? <intro>`
* :ref:`Web-based dashboard <web-dashboard>`
* :ref:`Technical architecture <technical-arch>`
* :ref:`Micro-services <micro-services>`
* :ref:`System requirements <system-requirements>`

.. _home-quick-start:

Quick-start guide
-----------------

This section is intended to introduce prospective users to Archivematica for testing
purposes, using either the Archivematica sandbox or a local virtual machine. This
is not a guide to installing Archivematica for development or production - please
see the :ref:`Administrator manual <admin-manual-home>` for full installation instructions.

* :ref:`Archivematica quick-start guide <quick-start>`
* :ref:`Configuration <configuration>`

.. _home-troubleshooting:

Troubleshooting
---------------

The troubleshooting section contains information on how Archivematica handles
errors, as well as how to report errors

* :ref:`Error handling <error-handling>`
* :ref:`Error reporting <error-reporting>`
* :ref:`FAQ <faq>`

.. _home-other-resources:

Other resources
---------------

* :ref:`TRAC review tool <trac>`

.. _user-manual-home:

User manual
===========

The user manual is intended for archivists, librarians, and other users who
interact with Archivematica through the web-based user interface. The user manual
is organized based on the tabs in the Archivematica UI.

.. _home-transfer:

Transfer
--------

The Transfer tab is the place where an Archivematica transfer begins. Along
with the transfer widget, this tab displays micro-services and jobs that act upon
content to prepare your transfer to become a SIP (submission information package).

* :ref:`General description <transfer>`
* :ref:`Create a transfer <create-transfer>`
* :ref:`Create a transfer with submission documentation <create-submission>`
* :ref:`Create a transfer with existing checksums <transfer-checksums>`
* :ref:`Process the transfer <process-transfer>`
* :ref:`Extract packages <extract-packages>`
* :ref:`Import metadata <import-metadata>`
* :ref:`Manage a backlog <manage-backlog>`
* :ref:`Bags (Library of Congress Bagit format) <bags>`
* :ref:`Digitized files <digitized>`
* :ref:`Forensic images <forensic>`
* :ref:`DSpace exports <dspace>`
* :ref:`ContentDM (transfer and ingest) <contentdm>`
* :ref:`Scan for viruses <scan-for-viruses>`

.. _home-backlog:

Backlog
-------

The Backlog tab displays content that has been added to the Archivematica backlog and allows users to search, download and delete transfers from the backlog location.

* :ref:`General description <backlog>`
* :ref:`Searching for transfers <backlog-transfer-search>`
* :ref:`Searching for files <backlog-file-search>`
* :ref:`Downloading transfers or files <backlog-download>`
* :ref:`Deletion of transfers <backlog-delete>`

.. _home-appraisal:

Appraisal
---------

The Appraisal and Arrangement tab is used to analyze and arrange material which has been placed in backlog.
It can also be used to arrange materials directly to resources in ArchivesSpace.

* :ref:`General description <appraisal>`
* :ref:`Transfers in the Backlog <backlog_pane>`
* :ref:`Analysis <analysis_pane>`
* :ref:`File List <File_list_pane>`
* :ref:`ArchivesSpace Resources <archivesspace_pane>`
* :ref:`Adding Files to ArchivesSpace Resources and Starting SIPs <adding_files_archivesspace>`
* :ref:`Arrangement <arrangement>`

.. _home-ingest:

Ingest
------

The Ingest tab displays the micro-services and jobs that take place to turn a SIP into an AIP or a DIP. This tab also contains the backlog widget.

* :ref:`General description <ingest>`
* :ref:`Create a SIP <create-sip>`
* :ref:`Arrange a SIP from backlog <arrange-sip>`
* :ref:`Add metadata <add-metadata>`
* :ref:`Add PREMIS rights <add-rights>`
* :ref:`Normalize <normalize>`
* :ref:`Store the AIP <store-aip>`
* :ref:`Reingest AIP <reingest>`
* :ref:`Upload DIP to ArchivesSpace <upload-AS>`
* :ref:`Upload DIP to Archivists Toolkit <upload-AT>`
* :ref:`Manual normalization <manual-norm>`


.. _home-storage:

Archival Storage
----------------

The Archival Storage tab displays AIPs that have been processed by the Archivematica
pipeline and related metadata such as size of AIP, UUID and date stored.

* :ref:`Storing an AIP <storing-aip>`
* :ref:`Searching the AIP store <search-aip>`
* :ref:`Deleting an AIP <delete-aip>`
* :ref:`AIP structure <aip-structure>`
* :ref:`AICs - managing multi-part AIPs <aic>`


.. _home-access:

Access
------

Most of Archivematica's access integrations take place within the Ingest tab. The Access tab displays DIPs which have been sent to AtoM.

* :ref:`General description <access>`
* :ref:`Default access system <access-default>`
* :ref:`Upload DIP to AtoM <upload-atom>`
* :ref:`Store DIP <store-dip>`
* :ref:`Review/Download DIP <review-dip>`
* :ref:`Access tab <access-tab>`
* :ref:`Upload DIP metadata to Archivists' Toolkit <archivists-toolkit>`
* :ref:`Upload DIP to ContentDM <contentdm>`


.. _home-preservation:

Preservation planning
---------------------

The Preservation Planning tab is the de facto user interface for the Format Policy
Registry, the extensive format database that informs how Archivematica handles
files. The Preservation Planning tab allows users to add or edit format policies
for normalization, characterization, validation, and other tools and workflows
that act upon content preserved through Archivematica.

* :ref:`General description <preservation-planning>`
* :ref:`Format Policy Registry (FPR) <fpr>`
* :ref:`Preservation policies <pres-policies>`
* :ref:`Altering rules and commands <fpr-instruct>`


.. _home-administer:

Administration
--------------

The Administration tab allows administrative users to set processing configurations,
transfer and storage locations, DIP upload configurations, and to add and remove
users, among other things.

* :ref:`Dashboard administration tab <dashboard-admin>`
* :ref:`Update Format Policy Registry (FPR) <fpr-update>`
* :ref:`Storage service users <storageservice:users>`


.. _metadata:

Metadata
--------

Archivematica employs several metadata standards. This section describes how Archivematica
implements and makes use of them.

* :ref:`Import metadata <import-metadata>`
* :ref:`PREMIS <premis-template>`
* :ref:`Dublin Core <dublin_core>`


Translations
------------

Beginning with Archivematica 1.6.1, the community has been able to support the project
by volunteering their time and effort to translate the Archivematica documentation,
the interface, and the Storage Service into other languages.

* :ref:`Contributing translations to the Archivematica project <translations>`

.. _admin-manual-home:

Administrator manual
====================

The administrator manual is intended for systems administrators who are
responsible for installing, configuring, setting up, and maintaining Archivematica
and related systems.


.. _home-install:

Installation and setup
----------------------

* :ref:`Installation <installation>`
* :ref:`Storage Service <storageservice:administrators>`
* :ref:`Dashboard Administration tab <dashboard-config>`
* :ref:`Format Policy Registry (FPR) <fpr:index>`
* :ref:`Customization and automation <customization>`
* :ref:`Duracloud setup <duracloud-setup>`


.. _maintenance:

Maintenance
-----------

* :ref:`Elasticsearch <elasticsearch>`
* :ref:`Data back-up <data-backup>`
* :ref:`FAQ <admin-faq>`


.. _home-security:

Security
--------

* :ref:`Elasticsearch <elasticsearch-security>`
* :ref:`MySQL <mysql-security>`
* :ref:`AtoM <atom-security>`
* :ref:`Gearman <gearman-security>`
* :ref:`User security <user-security>`
