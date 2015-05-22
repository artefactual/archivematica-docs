.. _faq:

===
FAQ
===

#. What technical skills are required to install/maintain/operate Archivematica?

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

   Oragnizations that are unable to provide in-house technical support may
   consider a `maintenance contract <http://www.artefactual.com/services/maintenance/>`_
   through Artefactual Systems.

#. Does Archivematica perform fixity checks?

   Archivematica generates checksums upon transfer of objects into the system,
   and will verify those checksums before storing the AIP. It is also
   possible to include :ref:`pre-existing checksums <transfer-checksums>`, which
   Archivematica will also verify.

   To check fixity of AIPs in storage, Artefactual has written a separate
   command-line app called `Fixity <https://github.com/artefactual/fixity>`_
   (further user documentation for Fixity is pending).

#. Is Archivematica a storage system?

   Archivematica is purposefully designed to be storage system agnostic, leaving
   the door open for integration with a wide variety of existing storage systems.

#. What is the Archivematica Storage Service and why is there a separate application?

   The Archivematica Storage Service manages the storage and transfer source
   locations for Archivematica installations. Our recommendation is for each
   institution to have one or two administrators who are responsible for
   managing the Storage Service and restrict access to only those individuals.
   This is one of the reasons why it is maintained as a separate application;
   another reason is so that multiple Archivematica pipelines can be managed
   through one Storage Service.

#. Why doesn't Archivematica have a module for providing access to digital
   materials?

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

#. I need to user Archivematica in conjunction with another system (for access,
   storage, etc). How can I integrate the two systems?

   The list of systems and tools that Archivematica is integrated with grows with almost
   every release. If you are interested in having Archivematica integrate with a
   system which is not currently on our `Roadmap <https://www.archivematica.org/wiki/Development_roadmap:_Archivematica>`_,
   here are a few ideas:

   * Post to the `user forum <https://groups.gtoogle.com/forum/#!forum/archivematica>`_
     and ask community members if they have any experience creating a workflow
     between Archivematica and the other system.
   * If you have software development skills, consider writing to code required
     to integrate the two systems. If practical, we would gladly accept the
     code into the Archivematica code base via a `pull request <https://www.archivematica.org/wiki/Contribute_code>`_.
   * Contract Artefactual Systems to `write the code <http://www.artefactual.com/services/development/>`_.
     We will work with you to identify requirements and include the new integration
     code in the next software release, for the entire community's benefit.

#. I'm having a problem with installation/Why is Archivematica difficult to
   install?

   If you encounter errors during :ref:`installation <installation>` you are
   welcome to post your errors to our
   `user forum <https://groups.gtoogle.com/forum/#!forum/archivematica>`_.
   Artefactual Systems, or other Archivematica community members, will do their
   best to help you. Please be patient: answering questions from users is
   unsponsored work and it can take a while for us to respond when we are busy.
   Information that we might ask you for includes:

   * What version of Archivematica are you installing.
   * Are you upgrading or installing fresh.
   * Are you using something other than the recommended requirements from our
     :ref:`installation <installation>` instructions.
   * Include stack traces or results from error logs if possible.

   Archivematica is a complex piece of software with many dependencies, all
   of which are open-source. Because of it's complex, open-source nature,
   it is not feasible to create a click-through executible file for installation.


:ref:`Back to the top <faq>`
