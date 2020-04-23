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

The getting started manual is intended for users who are considering
implementing Archivematica as a digital preservation solution. This manual
includes information on the Archivematica project as well as a quick-start guide
to help new users test it out. For information about installing and using
Archivematica in a production environment, see the user or administrator manuals
below.

.. _home-overview:

Overview
--------

The overview section provides a definition of Archivematica and a description of
the OAIS model on which it is based, its technical architecture, the
microservices framework, and information about system requirements for deploying
Archivematica.

* :ref:`What is Archivematica? <intro>`
* :ref:`Web-based dashboard <web-dashboard>`
* :ref:`Technical architecture <technical-arch>`
* :ref:`Microservices <microservices>`
* :ref:`External tools <external-tools>`
* :ref:`System requirements <system-requirements>`

.. _home-quick-start:

Quick-start guide
-----------------

This section is intended to introduce prospective users to Archivematica for
testing purposes, using either the Archivematica sandbox or a local virtual
machine. This is not a guide to installing Archivematica for development or
production - please see the :ref:`Administrator manual <admin-manual-home>` for
full installation instructions.

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
interact with Archivematica through the web-based user interface. The user
manual is organized based on the tabs in the Archivematica UI.

.. _home-transfer:

Transfer
--------

The Transfer tab is the place where an Archivematica transfer begins. Along with
the transfer widget, this tab displays microservices and jobs that act upon
content to prepare your transfer to become a SIP (submission information
package).

* :ref:`General description <transfer>`
* :ref:`Preparing digital objects for transfer <prepare-transfer>`
* :ref:`Processing a transfer <process-transfer>`
* :ref:`Cleaning up the Transfer tab <cleanup>`
* :ref:`Import metadata <import-metadata>`
* :ref:`Bags (Library of Congress Bagit format) <bags>`
* :ref:`Forensic disk images <forensic>`
* :ref:`DSpace exports <dspace>`
* :ref:`Dataverse transfers <dataverse-transfers>`
* :ref:`ContentDM (transfer and ingest) <contentdm>`
* :ref:`Scan for viruses <scan-for-viruses>`

.. _home-backlog:

Backlog
-------

The Backlog tab displays content that has been added to the Archivematica
backlog and allows users to search, download and delete transfers from the
backlog location.

* :ref:`General description <backlog>`
* :ref:`Searching for transfers and files <backlog-transfer-search>`
* :ref:`Downloading transfers or files <backlog-download>`
* :ref:`Deleting transfers from the backlog <backlog-delete>`
* :ref:`Retrieving transfers from the backlog <backlog-retrieve>`

.. _home-appraisal:

Appraisal
---------

The Appraisal and Arrangement tab is used to analyze and arrange material which
has been placed in backlog. It can also be used to arrange materials directly to
resources in ArchivesSpace.

* :ref:`General description <appraisal>`
* :ref:`Backlog pane <backlog_pane>`
* :ref:`Analysis pane <analysis_pane>`
* :ref:`File list pane <file_list_pane>`
* :ref:`ArchivesSpace pane <archivesspace_pane>`
* :ref:`Arrangement pane <arrangement>`

.. _home-ingest:

Ingest
------

The Ingest tab displays the microservices and jobs that take place to turn a
SIP into an AIP or a DIP. This tab also contains the backlog widget.

* :ref:`Create a SIP <create-sip>`
* :ref:`Add descriptive metadata <add-metadata>`
* :ref:`Add PREMIS rights <add-rights>`
* :ref:`Normalize <normalize>`
* :ref:`Bind PIDs <bind-pids>`
* :ref:`Transcribe SIP contents <transcribe-contents>`
* :ref:`Store AIP <store-aip>`
* :ref:`Upload DIP <upload-dip>`
* :ref:`Reingest AIP <reingest>`
* :ref:`Clean up the ingest dashboard <cleanup-ingest>`


.. _home-storage:

Archival Storage
----------------

The Archival Storage tab displays AIPs that have been processed by the
Archivematica pipeline and related metadata such as size of AIP, UUID and date
stored.

* :ref:`General description <archival-storage>`
* :ref:`Searching the AIP store <search-aip>`

  * :ref:`Conducting a search <conducting-search>`
  * :ref:`Searching for AICs <search-for-aics>`

* :ref:`AIP information page <aip-information-page>`

  * :ref:`Downloading an AIP <download-aip>`
  * :ref:`Metadata-only DIP upload <metadata-only-dip-upload>`
  * :ref:`AIP reingest <reingest-aip>`
  * :ref:`Deleting an AIP <delete-aip>`

* :ref:`AIP encryption <aip-encryption>`
* :ref:`AIP structure <aip-structure>`
* :ref:`AICs - managing multi-part AIPs <aic>`


.. _home-access:

Access
------

Most of Archivematica's access integrations take place within the Ingest tab.
The Access tab displays DIPs which have been sent to AtoM.

* :ref:`General description <access>`
* :ref:`Access systems <access-default>`
* :ref:`Upload a DIP to AtoM <upload-atom>`
* :ref:`Upload a DIP to Binder <upload-binder>`
* :ref:`Upload a DIP to ArchivesSpace <upload-as>`
* :ref:`Upload a DIP to ContentDM <contentdm>`
* :ref:`Store DIP <store-dip>`
* :ref:`Review and download DIPs <review-dip>`
* :ref:`Access tab <access-tab>`

.. _home-preservation:

Preservation planning
---------------------

The Preservation Planning tab is the de facto user interface for the Format
Policy Registry (FPR), the extensive format database that controls how
Archivematica handles file formats. The Preservation Planning tab allows users
to add or edit format policies for normalization, characterization, validation,
and other tools and workflows that act upon content preserved through
Archivematica.

* :ref:`General description <preservation-planning>`
* :ref:`Definitions <preservation-planning-definitions>`
* :ref:`Preservation policies <pres-policies>`
* :ref:`Altering rules and commands <altering-commands-rules>`


.. _home-administer:

Administration
--------------

The Administration tab allows administrative users to set processing
configurations, transfer and storage locations, DIP upload configurations, and
to add and remove users, among other things.

* :ref:`Dashboard administration tab <dashboard-admin>`
* :ref:`Storage service documentation <storageservice:index>`


.. _metadata:

Metadata
--------

Archivematica employs several metadata standards. This section describes how
Archivematica implements and makes use of them.

* :ref:`Import metadata <import-metadata>`
* :ref:`METS <METS_schema>`
* :ref:`PREMIS <premis-template>`
* :ref:`Dublin Core <dublin_core>`


Translations
------------

Beginning with Archivematica 1.6.1, the community has been able to support the
project by volunteering their time and effort to translate the Archivematica
documentation, the interface, and the Storage Service into other languages.

* :ref:`Contributing translations to the Archivematica project <translations>`

.. _admin-manual-home:

Administrator manual
====================

The administrator manual is intended for systems administrators who are
responsible for installing, configuring, setting up, and maintaining
Archivematica and related systems.


.. _home-install:

Installation and setup
----------------------

* :ref:`Installing Archivematica <installation>`
* :ref:`Upgrading Archivematica <upgrade>`
* :ref:`Customization and automation <customization>`
* :ref:`Setting up integrations <integrations>`
* :ref:`Administering the Storage Service <storageservice:administrators>`
* :ref:`Preservation planning <preservation-planning>`

.. _maintenance:

Maintenance
-----------

* :ref:`Maintaining Elasticsearch <elasticsearch>`

  * :ref:`Rebuild Elasticsearch indexes <elasticsearch-indexes>`
  * :ref:`External Elasticsearch access <elasticsearch-external>`

* :ref:`Data backup <data-backup>`

* :ref:`FAQ <admin-faq>`

  * :ref:`How to clean up a full disk <disk-full>`
  * :ref:`How to restart services <restart-services>`
  * :ref:`Error stack trace <stack-trace>`
  * :ref:`Resolve hanging decisions <hanging-decisions>`
  * :ref:`Transfer won't start <transfer-wont-start>`


.. _home-security:

Security
--------

* :ref:`Elasticsearch <elasticsearch-security>`
* :ref:`MySQL <mysql-security>`
* :ref:`AtoM <atom-security>`
* :ref:`Gearman <gearman-security>`
* :ref:`User security <user-security>`
* :ref:`LDAP setup <ldap-setup>`
* :ref:`Shibboleth setup <shibboleth-setup>`
* :ref:`CA certificates <ca-root-certificates>`
