.. _faq:

===
FAQ
===

#. **What technical skills are required to install/maintain/operate Archivematica?**

   To install and maintain Archivematica successfully, you or someone in your
   organization should be comfortable using and maintaining Linux-based servers,
   logging in to the server and performing operations via the command line. This
   individual should also be able to read and understand and/or research errors
   in Linux based systems to assist with troubleshooting.

   Operating Archivematica takes place in a web-based dashboard so an
   archivist/librarian/curator does not necessarily need to have the same skill
   set described above, so long as someone in their organization is able to provide
   technical support. Some familiarity with
   `OAIS <http://en.wikipedia.org/wiki/Open_Archival_Information_System>`_ will
   make Archivematica more intuitive to use but is not necessarily a prerequisite.

   Organizations that are unable to provide in-house technical support may
   consider a `maintenance contract <http://www.artefactual.com/services/maintenance/>`_
   through Artefactual Systems.

#. **I'm having a problem with installation/Why is Archivematica difficult to install?**

   Archivematica is a complex piece of software with many dependencies, all
   of which are open-source. Because of its complex, open-source nature,
   it is not feasible to create a click-through executible file for installation.

   If you encounter errors during :ref:`installation <installation>` you are
   welcome to post your errors to our
   `user forum <https://groups.gtoogle.com/forum/#!forum/archivematica>`_.
   Artefactual Systems, or other Archivematica community members, will do their
   best to help you. Please be patient: answering questions from users is
   unsponsored work and it can take a while for us to respond when we are busy.

#. **What does Archivematica do?**

   The main purpose of Archivematica is to create standards-based, self-documenting
   and system-independent archival information packages (AIPs). An AIP includes
   a METS XML file with a robust PREMIS preservation metadata implementation,
   and is packaged in the Library of Congress BagIt format, which includes file
   manifests and information about the AIP contents. The physical and logical
   structure of the AIP is described in the METS structMap.

#. **Does Archivematica perform fixity checks?**

   Archivematica generates checksums upon transfer of objects into the system,
   and will verify those checksums before storing the AIP. It is also
   possible to include :ref:`pre-existing checksums <transfer-checksums>`, which
   Archivematica will also verify.

   To check fixity of AIPs in storage, Artefactual has written a separate
   command-line app called `Fixity <https://github.com/artefactual/fixity>`_
   (further user documentation for Fixity is pending).

#. **Is Archivematica a storage system?**

   Archivematica is purposefully designed to be storage system agnostic, leaving
   the door open for integration with a wide variety of existing storage systems.

#. **What is the Archivematica Storage Service and why is there a separate application?**

   The Archivematica Storage Service manages the storage and transfer source
   locations for Archivematica installations. Our recommendation is for each
   institution to have one or two administrators who are responsible for
   managing the Storage Service and restrict access to only those individuals.
   This is one of the reasons why it is maintained as a separate application;
   another reason is so that multiple Archivematica pipelines can be managed
   through one Storage Service.

#. **What is Archivematica’s capacity?  How much can it handle?**

   Capacity is highly dependent on the resources allocated to the servers on
   which the software is installed. Archivematica has been successfully tested
   with SIPs of 100,000 files and with video files of several TB each. No maximum
   size or number of files can be specified; Artefactual works with clients to
   determine optimal use cases and workflows on a per-institution basis.

#. **What is the format and structure of the Archival Information Package (AIP)?**

   The `Archivematica AIP <https://www.archivematica.org/en/docs/archivematica-1.6/user-manual/archival-storage/aip-structure/#aip-structure>`_ consists primarily of the
   ingested objects, any preservation masters generated during processing, and
   technical, preservation, audit and descriptive metadata encoded in METS XML.
   The METS file contains a robust PREMIS implementation, including the Object,
   Event, Agent and Rights entities. Dublin Core is supported as a descriptive
   metadata standard.

#. **What kinds of preservation metadata is included in an AIP’s METS XML file?**

   Archivematica by default includes a very robust PREMIS implementation which
   includes the Object, Event, Agent and Rights entities. Standard Events include
   ingestion, fixity check, message digest calculation,  unpacking, decompression,
   virus check, format identification, format validation and normalization. The
   names of the software platform, the organization and the logged-in user are
   captured as Agents for each Event. Rights statements can be ingested as csv
   metadata or added by the user via a metadata-entry template during processing.

#. **Can I appraise and arrange records in Archivematica?**

   Yes! In Archivematica 1.6 an appraisal dashboard allows the user to perform
   archival appraisal and arrangement activities on ingested files. Submission
   documentation such as donor agreements, transfer forms and accession records
   can be added to the SIP for preservation along with the ingested digital objects,
   and are identified as submission documentation in the preservation metadata
   in the AIP. In AtoM, an accessions module allows users to record accessions,
   accruals and deaccessions and to record information about appraisal and selection.

#. **Why doesn't Archivematica have a module for providing access to digital
   materials?**

   In a manner of speaking, it does! It's called :ref:`AtoM <atom:home>` and
   it is another open-source, freely available software application managed
   and developed by Artefactual Systems. Archivematica and AtoM are developed
   in conjunction with one another, and you can send access copies from
   Archivematica to AtoM, while maintaining a link between your preservation
   copies and the access copies. AtoM can also be used to manage archival
   descriptions for all of your digital and analogue material, so your users
   do not have to consult multiple systems to do their research.

   We recognize that you may wish to use a different access system than AtoM,
   which is why we have developed workflows with CONTENTdm, Islandora, DSpace,
   Archivist's Toolkit and ArchivesSpace, for example. Other integrations are
   possible; see the next question below.

#. **Can I describe content in Archivematica?**

   You can ingest metadata as a CSV file or through the dashboard while processing.
   However, Archivematica is not an archival description system.  In-depth
   contextual and content description can be done through an access system like
   AtoM.

#. **How does Archivematica prevent viruses?**

   All ingested content is automatically scanned for viruses and malware using
   clamAV, a well-established open-source software tool that comes bundled with
   Archivematica. Virus definitions are updated on a regular basis.

#. **What is normalization and how does normalization work?**

   Transcoding, or normalization, is automated through the use of preservation
   commands entered into the `Format Policy Registry <https://www.archivematica.org/en/docs/archivematica-1.6/user-manual/preservation/preservation-planning/#fpr>`_.
   Bundled tools for transcoding include ffmpeg, Inkscape, Ghostscript and
   ImageMagick. The FPR comes with hundreds of format-specific commands which
   can be edited by the user.

#. **How do I know if there are errors during ingest?**

   Errors are indicated in the Archivematica dashboard during processing. Alerts
   can also be :ref:`emailed <email-config>` to designated users and certain
   types of error reports  are retained in the Administration tab of the
   dashboard. The corrective action  will depend on the nature of the error;
   examples include rejecting the transfer  or SIP and starting again, accepting
   the error and continuing the process,  taking corrective action and
   re-running the micro-service or troubleshooting  the issue through the
   command-line.

#. **I need to use Archivematica in conjunction with another system (for access,
   storage, etc). How can I integrate the two systems?**

   The list of systems and tools that Archivematica is integrated with grows with
   almost every release. If you are interested in having Archivematica integrate
   with a system which is not currently on our `Roadmap <https://www.archivematica.org/wiki/Development_roadmap:_Archivematica>`_, here are a few ideas:

  * Post to the `user forum <https://groups.gtoogle.com/forum/#!forum/archivematica>`_
    and ask community members if they have any experience creating a workflow
    between Archivematica and the other system.

  * If you have software development skills, consider writing to code required
    to integrate the two systems. If practical, we would gladly accept the code
    into the Archivematica code base via a
    `pull request <https://www.archivematica.org/wiki/Contribute_code>`_ .

  * Contract Artefactual Systems to `write the code <http://www.artefactual.com/services/development/>`_.
    We will work with you to identify requirements and include the new integration
    code in the next software release, for the entire community's benefit.




:ref:`Back to the top <faq>`
