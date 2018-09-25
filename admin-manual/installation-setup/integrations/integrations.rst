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
* :ref:`Duracloud integration <duracloud-integration>`
* :ref:`Swift integration <swift-integration>`
* :ref:`Islandora integration <islandora-integration>`
* :ref:`Arkivum integration <arkivum-integration>`
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


.. _dataverse-integration:

Dataverse
---------

See :ref:`Dataverse integration <dataverse-transfers>` for an overview of how 
Dataverse datasets are preserved. 
For instructions to configure a Dataverse integration, see 
:ref:`Storage Service docs <storageservice:administrators>`.


:ref:`Back to the top <integrations>`

.. _`AtoM`: https://www.accesstomemory.org/
.. _`ArchivesSpace`: http://archivesspace.org/
.. _`DuraCloud`: https://duraspace.org/duracloud/
.. _`ArchivesDirect`: https://duraspace.org/archivesdirect/
.. _`Swift`: https://wiki.openstack.org/wiki/Swift
.. _`Arkivum`: https://arkivum.com/
.. _`Arkivum Perpetua`: https://arkivum.com/heritage-higher-education-and-corporate-archives/
