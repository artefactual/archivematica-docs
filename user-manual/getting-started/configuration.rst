.. _configuration:

Configuration
=============

Browser compatibility
---------------------

Archivematica is tested most extensively in Firefox and Chrome. There have been
known issues in testing with Internet Explorer (see Bug
`#7246 <https://projects.artefactual.com/issues/7246>`_).

Resource allocation
-------------------

For recommended resource allocation, please see:

* :ref:`Recommended Minimum Requirements for small-scale testing <requirements-small>`
* :ref:`Recommended Minimum Requirements for production processing <requirements-production>`

Workflow settings
-----------------

Many workflow choices are pre-configurable through the Administration tab of the
Dashboard. Please see :ref:`Processing configuration <dashboard-processing>`.

Some users have found processing economies by installing multiple Archivematica
pipelines on separate VM's, each with its own processing configuration specific
to the type of material being processed through each pipeline.

Integration settings
--------------------

Archivematica integrates with a number of different access and storage systems.
Please see:

* :ref:`AtoM <dashboard-atom>`
* :ref:`ContentDM <dashboard-CDM>`
* :ref:`Archivist's Toolkit <dashboard-AT>`
* :ref:`DSpace <dspace>`
* :ref:`LOCKSS <storageService:lockss>` (Administrator documentation)
* Duracloud (coming soon)
* Arkivum (coming soon)

Add/edit users and passwords
----------------------------

Administrative users can add/edit users and update passwords. An administrative
user does not need to be a systems administrator and can perform this function
within the Archivematica dashboard Administration page.

Please see :ref:`Users <dashboard-premis>`.

Add/edit PREMIS agents
----------------------

Administrative users can add/edit PREMIS agents, which are recorded in the METS
file to identify the agency performing digital preservation events. This should
be configured before processing begins, and can be set through Archivematica
dashboard Administration page.

Please see :ref:`PREMIS agent <dashboard-premis>`.

:ref:`Back to the top <configuration>`
