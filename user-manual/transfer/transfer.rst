.. _transfer:

========
Transfer
========

In Archivematica, Transfer is the process of transforming any set of digital
objects and/or directories into a SIP. Transformation may include appraisal,
arrangement, description and identification of donor restricted, private or
confidential contents. The Transfer tab prepares your content for preservation in Archivematica.

In the Transfer tab of the Dashboard, the user moves digital objects from
source directories accessible via the Storage Service into Archivematica. See
:ref:`Administrator manual - Storage Service <storageService:administrators>`
for instructions on how to set up shared transfer source directories. Once
uploaded to the dashboard, transfers run through several micro-services: UUID
assignment; checksum verification (if checksums are present); package
extraction (i.e. unzipping of zipped or otherwise packaged files); virus
checking; indexing; format identification and validation; and metadata
extraction.

At the end of transfer, the user creates a SIP from one or more standard
transfer(s). Once this is done, the SIP can be moved into ingest or sent to a
:ref:`backlog <manage-backlog>` for processing later.

*On this page:*

* :ref:`Create a transfer <create-transfer>`

* :ref:`Create a transfer with submission documentation <create-submission>`

* :ref:`Create a transfer with existing checksums <transfer-checksums>`

* :ref:`Process the transfer <process-transfer>`

* :ref:`Cleaning up the transfer dashboard <cleanup>`

* :ref:`Format identification <format-identification>`

* :ref:`Extract packages <extract-packages>`


.. seealso::

   If you would like to import lower-level metadata with your transfer (i.e.
   metadata to be attached to subdirectories and files within a SIP), see
   :ref:`Metadata import <import-metadata>`.

   If your transfer is a DSpace export, please see :ref:`DSpace export <dspace>`.

   If your transfer is a bag or a zipped bag, please see :ref:`Bags <bags>`.

   If your transfer is composed of objects that are the result of digitization,
   please see :ref:`Digitization output <digitized>`.

   If your transfer is composed of digital forensic disk images, please see
   :ref:`Forensic image processing <forensic>`.

   If you would like to skip some of the default choices for dashboard decision
   points or make preconfigured choices for your desired workflow, see
   :ref:`Processing configuration <dashboard-processing>`.


.. _create-transfer:

Create a transfer
-----------------

Open your Archivematica dashboard and sign in with your
username and password. Please note that if this is your first time logging in
to a newly installed instance of Archivematica, you will see a form that
allows you to register your repository in order to get updates to the format policy
registry. See the :ref:`User manual - Format Policy Registry (FPR) <fpr>` and the
:ref:`Administrator manual - Format Policy Registry (FPR) <fpr:index>`.

#. In the transfer tab, select your transfer type in the dropdown menu. Types include Standard, Unzipped Bag, Zipped Bag, DSpace, maildir and Disk Image.

#. Name your transfer. The transfer name will become the name of your AIP, so make
   sure that the name is meaningful.

#. Select your source directory. Click Browse
   to select the directory containing your object(s) for upload. Click on the folder
   icon to expand the directory trees. To select a source folder, click on the name
   of the folder so that it is highlighted and click Add. Your transfer can be composed
   of multiple directories from different sources. Repeat this step if your transfer
   is composed of multiple sources.

   .. figure:: images/Browse1.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: Select transfer(s) from source directory(ies)

      Select transfer source directories

#. If applicable, enter an accession number for the transfer.

#. Once all of your digital object sources have been uploaded, hit the Start Transfer button for the transfer processing to begin.

   .. figure:: images/Start1.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: Start transfer in dashboard

      Start transfer

#. To close the transfer browser, click on Browse again.

.. _create-submission:

Create a transfer with submission documentation
-----------------------------------------------

The structured directory in Archivematica is the basic configuration of the transfer. If you just add a directory to the dashboard and start transfer processing, Archivematica will restructure it so it complies with this structure. Another option is to create a transfer in a structured directory prior to
beginning processing in Archivematica.

To create a transfer that includes submission documentation, such as a donor agreement, you must create a structured directory prior to beginning processing in Archivematica. Your source directory should contain three subdirectories, titled as below:

1. objects: The *objects* directory contains the digital objects that are to be preserved. You can create subdirectories within objects if desired.

2. metadata: The *metadata* directory contains the checksum, the METS file, and a submissionDocumentation subfolder, which can be used for transfer forms, donation agreements or any other documents that relate to the acquisition of the records.

3. logs: The *logs* directory will eventually contain logs generated when processing the transfer in Archivematica.

.. important::

   Please do not include submission documentation that has non-standard
   characters in the filename, as submission documentation names are not
   sanitized. Any filenames other than plain ASCII names may cause errors in
   processing.

1. Open the file browser by clicking on the Home folder on the Archivematica desktop.

2. The structured directory should contain three subdirectories: logs, metadata, objects. Copy the digital files to be preserved into the objects directory. Note that you can create subdirectories within objects.

3. Add submission documentation. In the transfer you have just created, navigate to the /metadata/ folder and add a /submissionDocumentation directory. Add files to that folder like donor agreements, transfer forms, copyright agreements and any correspondence or other documentation relating to the transfer. Any SIPs subsequently made from this transfer will automatically contain copies of this documentation.

.. _transfer-checksums:

Create a transfer with existing checksums
-----------------------------------------

Standard transfers
++++++++++++++++++

You can include existing checksums with your transfer if you have them. Archivematica
will verify .md5, .sha1 and .sha256 checksums during the *Verify transfer checksums*
micro-service.

Checksum files should be named checksum.md5, checksum.sha1, or checksum.sha256.
The file itself should contain one line for each checksum, beginning with the checksum,
followed by a space, followed by the file name. For example: ``7f42199657dea535b6ad1963a6c7a2ac bird.mp3``.

.. image:: images/checksum-file.*
   :align: center
   :width: 80%
   :alt: Structure of checksum file

To add the checksum file to your transfer:

1. Place the digital objects into an ``/objects`` folder below the first level of the transfer.

2. Create a ``/metadata`` folder at the same level as the ``/objects`` folder. Place
   checksum files in the /metadata folder.

3. Begin your standard transfer in the Archivematica dashboard interface.

4. If your checksum check fails, the *Verify transfer checksums* micro-service will show an error and the transfer will fail. Expanding the micro-service will show that the job *Verify metadata directory checksums* is red. To review the error, click on the gear icon for the job.

Disk image transfers
++++++++++++++++++++

To add the checksum file to a disk image transfer, prepare your checksum files as
above. However, there is a slight variation in how the folder should be structured:

1. Place your disk image file at the first level of the transfer (do **not** place in an /objects subdirectory).

2. Create a ``/metadata`` folder in the first level of the transfer. Place checksum files in the /metadata folder.

3. Begin your standard transfer in the Archivematica dashboard interface.

4. If your checksum check fails, the *Verify transfer checksums* micro-service will show an error and the transfer will fail. Expanding the micro-service will show that the job *Verify metadata directory checksums* is red. To review the error, click on the gear icon for the job.

.. _process-transfer:

Process the transfer
--------------------

1. In the dashboard transfer tab, the transfer will appear in the dashboard with a bell icon next to it. This means that it is awaiting a decision by the user.

2. Click on the micro-service to display jobs that have completed, including the one requiring action.

3. In the Actions drop-down menu, select "Approve transfer" to begin processing the transfer. You may also "Reject transfer" and quit processing.

.. figure:: images/Approve1.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt:  In the Actions drop-down menu, select "Approve transfer"

   In the Actions drop-down menu, select "Approve transfer"

4. The transfer will now run through a series of micro-services. These include:

   * Verify transfer compliance: verifies that the transfer is properly
     structured - i.e. with the logs, metadata and objects folders.

   * Rename with transfer UUID: assigns a unique universal identifier for the
     transfer as a whole; directly associates the transfer with its metadata.

   * Assign file UUIDs and checksums to objects: assigns a unique universal
     identifier and sha-256 checksum to each file in the /objects directory.

   * Verify transfer checksums: verifies any checksums included with the transfer
     in its metadata directory.

   * Generate METS.xml document: creates a METS file capturing the original order
     of the transfer. This METS file is added to any SIPs generated from this
     transfer.

   * Quarantine: quarantines the transfer to a set duration based on
     preconfiguration settings in the Administration tab of the dashboard. This
     can be used to allow virus definitions to update before a virus scan.

   * Scan for viruses: scans for viruses and malware.

   * Generate transfer structure report: generates a directory tree of the original
     transfer and places as a text file in the AIP.

   * Clean up file and directory names: removes prohibited characters from folder
     and filenames, such as ampersands.

   * Identify file format: this is the identification that normalization will be
     based upon, the user can choose between FIDO and extension or skipping
     format identification at this stage. See :ref:`Format identification <format-identification>` below for
     more information.

   * Extract packages: extracts contents from zipped or otherwise packaged
     files. You can change your preconfigured workflow settings to allow for
     some choices about package extraction. See :ref:`Extract Packages <extract-packages>` below for more information.

   * Characterize and extract metadata: identifies and validates file formats;
     extracts technical metadata embedded in the files. If you have
     preconfigured it to do so, Archivematica will stop during this micro-service
     and allow the user to choose a file identification command from a dropdown
     menu. To learn about preconfigured options, please see
     :ref:`Administrator manual - Processing configuration <process-config>`.
     Archivematica's file identification default is set to identification by file
     extension. You can also choose to skip identification and run it later,
     during Ingest, instead.

   * Complete transfer: Includes indexing the transfer.

5. A transfer that is in the middle of processing will show which micro-services
   have been completed (green) and which are in progress (orange).

6. When a micro-service fails or encounters an error, the micro-service
   background turns from green to pink and a "failed" icon appears next to the
   transfer or SIP name. See Error handling for more information about how to
   handle an error.

7. Once the transfer micro-services are completed, a bell icon will appear next
   to the transfer. This means that the transfer is ready to be packaged into a
   SIP for ingest or sent to a backlog, indexed and stored to be retrieved for
   processing at a later date

   * Option 1: Select "Create single SIP and continue processing"

   * Option 2: Select "Send transfer to backlog". In this case, your transfer
     will be stored in a backlog in the same location as your AIP store so that
     you can retrieve one or more transfers from the Ingest tab for processing at
     a later date. See :ref:`Managing a backlog <manage-backlog>`.

   * Option 3: Select "Reject the transfer".

   .. figure:: images/CreateSIP.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: A transfer that is ready to be packaged into a SIP or stored in backlog

      A transfer that is ready to be packaged into a SIP or stored in backlog

8. See :ref:`Ingest <ingest>` for next steps.

.. _cleanup:

Cleaning up the transfer dashboard
----------------------------------

The dashboard in the Transfer tab should be cleaned up from time to time. As the
list of transfers grows, it takes Archivematica longer and longer to parse this
information which can create browser timeout issues.

Remove a single transfer
++++++++++++++++++++++++

#. Ensure that the transfer you want to remove doesn't require any user input.
   You must complete all user inputs and either complete the transfer (i.e.
   send to backlog or create a SIP) or reject the transfer before it can be
   removed from the dashboard.

#. When you are ready to remove a transfer from the dashboard, click the red circle
   icon found next to the add metadata icon, to the right of the transfer name.

#. Click the Confirm button to remove the transfer from the dashboard.

.. figure:: images/remove-sip.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: A transfer that is ready to be removed from the dashboard


.. NOTE::
   This does not delete the transfer or related entities, including the source
   directory. It merely removes them from the dashboard.

Remove all completed transfers
++++++++++++++++++++++++++++++

#. Ensure that the transfers you want to remove are complete (i.e. sent to
   backlog or ingest). Note that this feature only works on completed transfers;
   rejected transfers will have to be removed one at a time.

#. When you are ready to remove all completed transfers, click the red circle
   icon in the table header of the list of transfers.

#. Click the Confirm button to remove all completed transfers from the dashboard.

.. _format-identification:

Format identification
---------------------

Archivematica's default is to allow the user to choose identification options
to base normalization actions upon during transfer and then use those results
to base normalization upon in ingest. However, you can set your
preconfiguration options to allow for the opposite (skip at transfer and
identify before normalization) or for both transfer and ingest to allow for
user choice in the dashboard.

Artefactual included the ability to skip identification at transfer and/or to
change identification tool before normalization mainly to allow for the
possibility that content in the transfer backlog may contain formats for which
there are not currently entries in the :ref:`Format Policy Registry (FPR) <fpr>`.
While the transfers are in the backlog, you can add rules that allow for the
format(s) not identified or identifiable at time of transfer to the FPR so
that, when they are processed through ingest, all formats will be identified
and normalization attempted based on those identifications.

There may be other use case scenarios in the future that this configuration
flexibility facilitates. In general, we aim to include as much flexibility as
possible when it comes to workflow choices so that the archivist is as central
as possible to AIP and DIP processing rather than hardcoding and automating so
much that the archivist is left less influence on ingest.

Format identification is logged as a PREMIS event in the METS.xml using the
results of running whichever tool chosen during processing.

.. _extract-packages:

Extract packages
----------------

If you adjust your processing configuration settings, Archivematica will stop
after format identification and allow you to extract any packages in your
transfer. Additionally, you can decide whether you would like to keep the
package with the extracted objects or not.


:ref:`Back to the top <transfer>`
