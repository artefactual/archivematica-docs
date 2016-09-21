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

.. _home-overview:

Overview
--------

* :ref:`What is Archivematica? <intro>`
* :ref:`Web-based dashboard <web-dashboard>`
* :ref:`Technical architecture <technical-arch>`
* :ref:`Micro-services <micro-services>`

.. _home-quick-start:

Quick-start guide
-----------------

* :ref:`Configuration <configuration>`
* :ref:`TRAC review tool <trac>`

.. _home-troubleshooting:

Troubleshooting
---------------

* :ref:`Error handing <error-handling>`
* :ref:`Error reporting <error-reporting>`
* :ref:`FAQ <faq>`

.. _home-other-resources:

Other resources
---------------

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
* :ref:`Storage Service <storage-service>`
* :ref:`Upload DIP to ArchivesSpace <upload-AS>`
* :ref:`Upload DIP to Archivists Toolkit <upload-AT>`
* :ref:`Manual normalization <manual-norm>`

.. _home-backlog:

Backlog
-------

The Backlog tab displays content that has been added to the Archivematica backlog.
Adding content to the backlog is possible from the


.. _home-storage:

Storage
-------

The Storage tab displays AIPs that have been processed by the Archivematica
pipeline alongside their current storage location.

* :ref:`Storing an AIP <storing-aip>`
* :ref:`Searching the AIP store <search-aip>`
* :ref:`Deleting an AIP <delete-aip>`
* :ref:`Delete an AIP <delete-aip>`
* :ref:`AIP structure <aip-structure>`
* :ref:`AICs <aic>`- managing multi-part AIPs


.. _home-access:

Access
------

The Access page displays DIPs that have been processed by the Archivematica
pipeline alongside their current access location.

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
* :ref:`Preservation planning tab <pres-tab>`
* :ref:`Format Policy Registry (FPR) <fpr>`
* :ref:`Preservation policies <pres-policies>`


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

* :ref:`Import metadata <import-metadata>`
* :ref:`PREMIS <premis-template>`
* :ref:`Dublin Core <dublin_core>`


.. _admin-manual-home:

Administrator manual
====================

The administrator manual is intended for archivists, librarians, and/or systems
administrators who are responsible for installing, configuring, setting up, and
maintaining Archivematica and related systems.


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
