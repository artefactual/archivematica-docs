.. _technical-arch:

======================
Technical architecture
======================

.. figure:: images/AMarch.*
   :align: center
   :figwidth: 40%
   :width: 100%
   :alt: Diagram of the Archivematica ingest overview

   Archivematica Ingest infrastructure overview

This page provides a high-level overview of Archivematica's technical
architecture.


.. _technical-micro-services:

Micro-services design pattern
-----------------------------

Archivematica implements a micro-service approach to digital preservation. The
Archivematica micro-services are granular system tasks which operate on a
conceptual entity that is equivalent to an OAIS information package:
Submission Information Package (SIP), Archival Information Package (AIP),
Dissemination Information Package (DIP). The physical structure of an
information package will include files, checksums, logs, submission
documentation, XML metadata, etc.

For more information, see :ref:`Micro-services <micro-services>`.

.. _technical-dashboard:

Web-based dashboard
-------------------

The web dashboard allow users to process, monitor and control the
Archivematica workflow processes. It is developed using Python-based Django
MVC framework. The Dashboard provides a multi-user interface that will report
on the status of system events and make it simpler to control and trigger
specific micro-services. This interface allows users to easily add or edit
metadata, coordinate AIP and DIP storage and provide preservation planning
information. Notifications include error reports, monitoring of MCP tasks and
manual approvals in the workflow.

For more information, see :ref:`Web-based dashboard <web-dashboard>`.


.. _technical-fpr:

Format policies
---------------

Archivematica maintains the original format of all ingested files to  support
migration and emulation strategies. However, the primary preservation strategy
is to normalize files to preservation and access formats upon ingest.
Archivematica groups file formats into format policies (e.g. text, audio,
video, raster image, vector image, etc.). Archivematica's preservation formats
must all be open standards. Additionally, the choice of formats is based on
community best practices, availability of free and open-source normalization
tools, and an analysis of the significant characteristics for each media type.
The choice of access formats is based largely on the ubiquity of web-based
viewers for the file format.

Since the 1.0 production release, Archivematica format policies have been
moved to a structured, online format policy registry (FPR) that brings
together format identification information with significant characteristic
analysis, risk assessments and normalization tool information to arrive at
default preservation format and access format policies for Archivematica.

For more information, see :ref:`Preservation Planning <preservation-planning>`.


.. _technical-dip:

From Transfer to SIP to AIP and DIP
-----------------------------------

The primary function of Archivematica is to process digital transfers
(accessioned digital objects), turn them into SIPs, apply format policies and
create high-quality, repository-independent Archival Information Packages
(AIP) using `METS <http://www.loc.gov/standards/mets/>`_,
`PREMIS <http://www.loc.gov/standards/premis/>`_ and
`Bagit <https://confluence.ucop.edu/download/attachments/16744580/BagItSpec.pdf?version=1>`_.
Archivematica is bundled with `AtoM <http://www.accesstomemory.org>`_ but
is designed to upload Dissemination Information Packages (DIP), containing
descriptive metadata and web-ready access copies, to any access system (e.g.
Dspace, ContentDM, etc.).

.. _technical-install:

Single install
--------------

Using the latest in virtualization technology, each release of the
Archivematica system packages a customized Xubuntu environment as a
`virtual appliance <http://en.wikipedia.org/wiki/Virtual_appliance>`_, making it
possible to run on top of any consumer-grade hardware and operating system.
This means the entire suite of digital preservation tools is now available
from one simple installation. Archivematica can also be installed directly on
dedicated hardware via its own Ubuntu repository. Its client/server processing
architecture allows it to be deployed in multi-node, distributed processing
configurations to support large-scale, resource- intensive production
environments.

:ref:`Back to the top <technical-arch>`
