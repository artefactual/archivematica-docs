.. _microservices:

=============
Microservices
=============

Archivematica implements a microservice approach to digital preservation. The
Archivematica microservices are granular system tasks which operate on a
conceptual entity that is equivalent to an OAIS information package:
Submission Information Package (SIP), Archival Information Package (AIP),
Dissemination Information Package (DIP). The physical structure of an
information package will include files, checksums, logs, submission
documentation, XML metadata, etc.

.. image:: images/Microservice.*
   :align: right
   :width: 40%
   :alt: Diagram showing general microservice workflow.

These information packages are processed using a series of microservices.
microservices are provided by a combination of Archivematica Python scripts
and one or more of the free, open-source
`software tools <https://www.archivematica.org/wiki/External_tools>`_ bundled in
the Archivematica system. Each microservice results in a success or error state
and the information package is processed accordingly by the next micro-
service. There are a variety of mechanisms used to connect the various micro-
services together into complex, custom workflows, resulting in a complete
ingest to access system.

Archivematica implements a default ingest to access workflow that is compliant
with the ISO-OAIS functional model. Microservices can be distributed to
processing clusters for highly scalable configurations.

:ref:`Back to the top <microservices>`
