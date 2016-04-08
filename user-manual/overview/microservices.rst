.. _micro-services:

==============
Micro-services
==============

Archivematica implements a micro-service approach to digital preservation. The
Archivematica micro-services are granular system tasks which operate on a
conceptual entity that is equivalent to an OAIS information package:
Submission Information Package (SIP), Archival Information Package (AIP),
Dissemination Information Package (DIP). The physical structure of an
information package will include files, checksums, logs, submission
documentation, XML metadata, etc.

.. image:: images/Micro-service.*
   :align: right
   :width: 40%
   :alt: Diagram showing general micro-service workflow.

These information packages are processed using a series of micro-services.
Micro-services are provided by a combination of Archivematica Python scripts
and one or more of the free, open-source
`software tools <https://www.archivematica.org/wiki/External_tools>`_ bundled in
the Archivematica system. Each micro-service results in a success or error state
and the information package is processed accordingly by the next micro-
service. There are a variety of mechanisms used to connect the various micro-
services together into complex, custom workflows, resulting in a complete
ingest to access system.

Archivematica implements a default ingest to access workflow that is compliant
with the ISO-OAIS functional model. Micro-services can be distributed to
processing clusters for highly scalable configurations.


Micro-services in Archivematica Releases
----------------------------------------

The Archivematica wiki contains an updated `list of micro-services <https://wiki.archivematica.org/Micro-services>`._

`Archivematica 1.1 Micro-services <https://www.archivematica.org/wiki/Archivematica_1.1_Micro-services>`_

`Archivematica 1.0 Micro-services <https://www.archivematica.org/wiki/Archivematica_1.0_Micro-services>`_

`Archivematica 0.10 Micro-services <https://www.archivematica.org/wiki/Archivematica_0.10_Micro-services>`_

`Archivematica 0.9 Micro-services <https://www.archivematica.org/wiki/Archivematica_0.9_Micro-services>`_

`Archivematica 0.8 Micro-services <https://www.archivematica.org/wiki/Archivematica_0.8_Micro-services>`_

`Archivematica 0.7.1 Micro-services <https://www.archivematica.org/wiki/Archivematica_0.7.1_Micro-services>`_


:ref:`Back to the top <micro-services>`
