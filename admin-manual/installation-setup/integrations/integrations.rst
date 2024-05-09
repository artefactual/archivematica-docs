.. _integrations:

============
Integrations
============

Archivematica is built to integrate widely with a number of external systems,
including dedicated storage and access systems. The current integrations are
listed below.

*On this page*

* :ref:`AtoM integration <atom-integration>`
* :ref:`ArchivesSpace integration <archivesspace-integration>`
* :ref:`Avalon Media System integration <avalon-media-system-integration>`
* :ref:`Duracloud integration <duracloud-integration>`
* :ref:`Swift integration <swift-integration>`
* :ref:`Islandora integration <islandora-integration>`
* :ref:`Arkivum integration <arkivum-integration>`
* :ref:`Handle.Net integration <handlenet-integration>`
* :ref:`Dataverse integration <dataverse-integration>`

.. _atom-integration:

AtoM integration
----------------

`AtoM`_ (Access to Memory) is a web-based, open source application for
standards-based archival description and access in multilingual,
multi-repository environment.

See :ref:`Using AtoM 2.x with Archivematica <atom-setup>`.

.. _archivesspace-integration:

ArchivesSpace integration
-------------------------

`ArchivesSpace`_ is an open source archives information management application
for managing and providing web access to archives, manuscripts and digital
objects.

See :ref:`Using ArchivesSpace with Archivematica <archivesspace-setup>`.

.. _avalon-media-system-integration:

Avalon Media System integration
-------------------------------

`Avalon Media System`_ is an open source system for managing and providing
access to large collections of digital audio and video. Integration between the
systems can be found in the `Avalon Media System Technical Documentation`_. This
workflow includes integration with Archivematica's `validation API endpoint` and
`Automation-Tools`_ DIP creation script.

.. _duracloud-integration:

Duracloud
---------

`DuraCloud`_ is a hosted archival cloud storage and preservation service from
DuraSpace that makes it easy for organizations and end users to use cloud
services. Archivematica can automatically transfer AIP packages to DuraCloud for
long-term secure archival storage. DuraCloud is used as the storage layer for
`ArchivesDirect`_ clients.

See :ref:`Archivematica DuraCloud quick start guide <duracloud-setup>`.

.. _swift-integration:

Swift
-----

`Swift`_ is a simple API developed by OpenStack that offers cloud storage and
retrieval intended to work at scale. Swift is optimized for durability,
availability, and concurrency across the entire data set. Archivematica
integrates with Swift through the Storage Service.

See :ref:`Swift Storage Service integration documentation <storageservice:swift>`.

.. _islandora-integration:

Islandora
---------

`Islandora`_ is an open-source software framework designed to help
institutions and organizations and their audiences collaboratively manage, and
discover digital assets. Archivematica integrates with Islandora through the
Storage Service, which connects to Islandora's underlying Fedora repository.

See :ref:`Fedora Storage Service integration documentation <storageservice:fedora>`.

.. _arkivum-integration:

Arkivum
-------

`Arkivum`_ is an archival storage back-end for Archivematica packages that
provides both cloud- and tape-based storage. Arkivum is used as the storage
layer for `Arkivum Perpetua`_ clients.

See :ref:`Arkivum Storage Service integration documentation <storageservice:arkivum>`.

.. _handlenet-integration:

Handle.Net integration
----------------------

`Handle.Net`_ (also called Handle System) is a registry that assigns persistent
identifiers, or handles, to information resources. Archivematica can mint
persistent identifiers (PIDs) for digital objects, directories, or AIPs by
defining the PIDs in a configured Handle.Net registry. Handle.Net can then
create persistent URLs (PURLs) from the PIDs and can reroute requests to the
persistent URLs to a target URL that is configured in Handle.Net.

See :ref:`Handle.Net integration documentation <handlesystem-setup>`

.. _dataverse-integration:

Dataverse
---------

See :ref:`Dataverse integration <dataverse-transfers>` for an overview of how
Dataverse datasets are preserved.
For instructions to configure a Dataverse integration, see
:ref:`Storage Service docs <storageservice:administrators>`.


:ref:`Back to the top <integrations>`

.. _`AtoM`: https://www.accesstomemory.org/
.. _`ArchivesSpace`: https://archivesspace.org/
.. _`Avalon Media System`: https://www.avalonmediasystem.org/
.. _`Avalon Media System Technical Documentation`: https://samvera.atlassian.net/wiki/spaces/AVALON/pages/1957954154/Archivematica+for+Avalon
.. _`Automation-Tools`: https://github.com/artefactual/automation-tools
.. _`DuraCloud`: https://duraspace.org/duracloud/
.. _`ArchivesDirect`: https://duraspace.org/archivesdirect/
.. _`Swift`: https://wiki.openstack.org/wiki/Swift
.. _`Arkivum`: https://arkivum.com/
.. _`Arkivum Perpetua`: https://arkivum.com/heritage-higher-education-and-corporate-archives/
.. _`Handle.Net`: https://www.handle.net/index.html
.. _`TMS`: https://www.gallerysystems.com/products-and-services/tms-suite/tms/
.. _`validation API endpoint`: https://wiki.archivematica.org/Archivematica_API#Validate
