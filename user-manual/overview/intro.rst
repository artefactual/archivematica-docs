.. _intro:

======================
What is Archivematica?
======================

Archivematica is a free and open-source digital preservation system that is
designed to maintain standards-based, long-term access to collections of
digital objects. Archivematica is packaged with the web-based content
management system AtoM for access to your digital objects.


.. _intro-oais:

Open source OAIS
----------------

.. image:: images/OAIS.*
   :align: left
   :width: 50%
   :alt: A diagram of the Open Archival Information System

Archivematica provides an integrated suite of free and open-source tools that
allows users to process digital objects from ingest to archival storage and
access in compliance with the `ISO-OAIS <http://en.wikipedia.org/wiki/Open_Archival_Information_System>`_
functional model and other digital preservation standards and best practices.
All of the Archivematica code and documentation is released under AGPL and
Creative Commons open-source licenses.


.. _intro-micro-services:

Micro-services design pattern
-----------------------------

Archivematica implements a micro-service approach to digital preservation. The
Archivematica micro-services are granular system tasks which operate on a
conceptual entity that is equivalent to an OAIS information package:
Submission Information Package (SIP), Archival Information Package (AIP),
Dissemination Information Package (DIP). The physical structure of an
information package will include files, checksums, logs, submission
documentation, XML metadata, etc.

For more information, see Microservices **link**.

.. _intro-dashboard:

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

For more information, see Web-based dashboard **link**.

.. _intro-install:

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

.. _intro-fpr:

Format policies
---------------

Archivematica maintains the original format of all ingested files to
 support
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

For more information, see Format Policy Registry (FPR) **link**


.. _intro-dip:

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


.. _intro-barriers:

Lowering the barriers to best-practice digital preservation
-----------------------------------------------------------

The goal of the Archivematica project is to give archivists and librarians
with limited technical and financial capacity the tools, methodology and
confidence to begin preserving digital information today. The project has
conducted a thorough OAIS use case and process analysis to synthesize the
specific, concrete steps that must be carried out to comply with the OAIS
functional model from Ingest to Access. Through deployment experiences and
user feedback, the project has expanded even beyond OAIS to address analysis
and arrangement of transferred digital objects into SIPs and allow for
archival appraisal at multiple decision points. Wherever possible, these
requirements are assigned to software tools within the Archivematica system.
If it is not possible to automate these steps in the current system iteration,
they are incorporated and documented into a manual procedure to be carried out
by the end user. This ensures that the entire set of preservation requirements
is being carried out, even in the early, pre 1.0 system releases. In short,
the system is conceptualized as an integrated whole of technology, people and
procedures, not just a set of software tools. For institutions that want
technical assistance to install and customize Archivematica, optional
technical support services are provided by Artefactual Systems.

All of the software, documentation and development infrastructure are
available free of charge and released under AGPL and Creative Commons licenses
to give users the freedom to study, adapt and re-distribute these resources as
best suits them. Rather than spend precious funding on proprietary software
licenses that restrict these freedoms, the Archivematica project encourages
memory institutions tackling the challenges of digital preservation to pool
their financial and technical resources in projects like Archivematica to
maximize their long-term investments for the benefit of their colleagues,
users and professional community as a whole.



:ref:`Back to the top <intro>`


