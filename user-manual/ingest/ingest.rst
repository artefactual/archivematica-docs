.. _ingest:

======
Ingest
======

During ingest, digital objects are packaged into SIPs and run through several
microservices, including normalization, packaging into an AIP and generation of
a DIP.

If you would like to skip some of the default decision points or make
preconfigured choices for your desired workflow, see :ref:`User administration -
Processing configuration <dashboard-processing>`.

Should you run into an error during ingest, please see :ref:`Error handling
<error-handling>`.

*On this page:*

* :ref:`Create a SIP <create-sip>`
* :ref:`Add descriptive metadata <add-metadata>`
* :ref:`Add PREMIS rights <add-rights>`
* :ref:`Normalize <normalize>`
* :ref:`Bind PIDs <bind-pids>`
* :ref:`Transcribe SIP contents <transcribe-contents>`
* :ref:`Store AIP <store-aip>`
* :ref:`Upload DIP <upload-dip>`
* :ref:`Reingest AIP <reingest>`
* :ref:`Clean up the ingest dashboard <cleanup-ingest>`

.. _create-sip:

Create a SIP
------------

#. Process transfers as described in :ref:`Transfers <transfer>`. If you
   selected "Create single SIP and continue processing" on the Transfer tab,
   your SIP has been created and Archivematica will begin running Ingest tasks.
   Click on the Ingest tab to continue working with your SIP.

#. The single SIP will move through a number of microservices. If you have
   preconfigured Archivematica to do so, processing will stop at a decision
   point that allows you to run file identification again or to use the existing
   file identification information captured during transfer. Archivematica's
   default is to use existing data. For more about this option, see
   :ref:`Processing configuration <dashboard-processing>`.

#. Once the SIP reaches "Normalize", you will be given several options for how
   Archivematica should normalize the SIP. Choose the option most suitable for
   your workflow.

   .. figure:: images/Normalize1.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: Archivematica Normalization microservice

      Normalization microservice

#. To add descriptive metadata, see :ref:`Add metadata <add-metadata>`, below.

#. To add PREMIS rights information, see :ref:`Add PREMIS rights <add-rights>`,
   below.

#. For selecting a normalization option, see :ref:`Normalization <normalize>`,
   below.

The microservices that run on the Ingest tab include:

* **Verify SIP compliance**: verifies that the SIP conforms to the folder
  structure required by Archivematica for processing.

* **Rename SIP directory with SIP UUID**: associates the SIP with its metadata
  by appending the SIP UUID to the SIP directory name and checks if SIP is from
  Maildir transfer type to determine workflow. Both the transfer UUID and the
  SIP UUID are captured in the final AIP.

* **Normalize**: :ref:` normalization <normalize>` converts ingested digital
  objects to preferred preservation and/or access formats according to user
  preference, using rules from :ref:`Preservation planning
  <preservation-planning>`. Choices about normalization can be made at the time
  the service is run, or automated in  :ref:`Processing configuration
  <dashboard-processing>`.

* **Process manually normalized files**: processes files that have been
  normalized prior to transfer or allows :ref:`manual normalization
  <manual-norm>` during ingest.

* **Policy checks for derivatives**: checks access and preservation derivatives
  created during normalization against the :ref:`Format Policy Registry <preservation-planning>`.

* **Add final metadata**: allows the user to :ref:`add metadata
  <add-metadata>` through the UI if desired.

* **Transcribe SIP contents**: runs :ref:`Tesseract <transcription>` OCR tool
  on JPG or TIFF images in the SIP.

* **Process submission documentation**: processes any submission documentation
  included in the SIP and adds it to the ``objects`` directory.

* **Bind PIDs**: this :ref:`microservice <bind-pids>` uses integration with the
  Handle.Net registry to create persistent identifiers.

* **Generate AIP METS**: generates the Archivematica :ref:`AIP METS.xml file
  <mets-file>`.

* **Prepare DIP**: if normalizing for access, creates a DIP containing access
  copies of the objects, thumbnails, and a copy of the METS.xml file.

* **Prepare AIP**: creates an :ref:`AIP in Bagit format <aip-structure>`;
  creates the AIP pointer file; indexes the AIP, then losslessly compresses it.

* **Review AIP**: part of the Prepare AIP microservice, allows the user to
  review the structure and content of the AIP before proceeding.

* **Upload DIP**: when DIP is created, allows the user to :ref:`upload the DIP
  <upload-dip>` to connected access options if desired. [link]

* **Store DIP**: allows the user to choose to store the DIP in a location
  pre-configured in the Storage Service.

* **Store AIP**: :ref:`moves the AIP <store-aip>` to
  ``sharedDirectoryStructure/www/AIPsStore`` or another specified directory.
  Before the AIP has been stored, a copy of it is extracted to a local temp
  directory, where it is subjected to standard BagIt checks: verifyvalid,
  checkpayloadoxum, verifycomplete, verifypayloadmanifests, verifytagmanifests.


.. _add-metadata:

Add descriptive metadata
------------------------

Archivematica can accept descriptive metadata about your digital objects. For
information on including descriptive metadata prior to starting your transfer,
see :ref:`Transfers with descriptive and/or rights metadata
<transfers-with-metadata>`. This section will describe how to add descriptive
metadata to your materials once processing has begun in Archivematica.

Archivematica can be configured to prompt you with a reminder to add metadata by
setting the :ref:`processing configuration <dashboard-processing>` field
``Reminder: add metadata if desired`` to ``None``. This reminder occurs at the
last moment that it is possible to add metadata; once the ingest proceeds past
this point, it is no longer possible to add metadata to the SIP.

There are two methods for adding metadata while materials are being processed:
by :ref:`entering it into a form <metadata-form-ui>` or by :ref:`uploading a CSV
file <metadata-csv-ui>`.

If you are planning to pass descriptive metadata to AtoM, see :ref:`AtoM Dublin
Core <atom:dc-template>` for information about the Dublin Core elements
available.

.. _metadata-form-ui:

Adding metadata using the user interface form
+++++++++++++++++++++++++++++++++++++++++++++

This method is best for users who are creating transfer-level metadata at the
time of processing, or who don't wish to do the extra work to prepare a CSV to
upload metadata to Archivematica. The metadata form implements the
`Dublin Core Metadata Element Set`_.

Note that this method only allows you to add descriptive metadata to the
transfer as a whole. To add metadata on a per-item basis, you must :ref:`import
metadata using a CSV file <import-metadata>` and either :ref:`include the CSV
with your transfer <transfers-with-metadata>` before transfer or :ref:`upload
the CSV through the user interface <metadata-csv-ui>`.

.. important::

   You must carry out the following steps **before** the microservice
   ``Reminder: add metadata if desired`` is completed. After this point, any
   metadata that is entered will not be properly attached to the SIP or entered
   into the METS.

#. While on the Transfer or Ingest tab, click on the metadata template icon to
   the right of the transfer name.

   .. figure:: images/MetadataIcon2.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: Location of the template icon

      To add metadata, click on the template icon

#. This will take you to the SIP detail page. Under the *Metadata* heading,
   click **Add**.

   .. figure:: images/SIPDetailPanel2.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: SIP information page

      SIP information page

#. Add metadata as desired and save it by clicking **Create** at the bottom of
   the screen. Clicking and hovering over a field will show a tooltip that
   defines element and provide a link to the
   `Dublin Core Metadata Element Set`_.

   .. figure:: images/descriptive-metadata-entry-form.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: Metadata entry form

   Metadata entry form

#. When you click **Create**, you will see the metadata entry in the list page.
   To edit it further, click **Edit** on the right-hand side. To delete it,
   click **Delete**. To add more descriptive metadata, click the **Add** button
   below the list.

   .. figure:: images/Metadatalist1.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: SIP metadata list

      SIP metadata list

#. Return to the Transfer or Ingest tab to continue processing the SIP.

.. _metadata-csv-ui:

Uploading metadata CSV files through the user interface
+++++++++++++++++++++++++++++++++++++++++++++++++++++++

Descriptive metadata CSV files are ideal if you are creating hierarchical
metadata, want to apply metadata to individual objects, or if you want to use
metadata fields other than those available in the Dublin Core Metadata Element
Set.

In order to upload a CSV file, it must be available in a transfer source
location connected to Archivematica, the same way that digital objects are made
available. For more information about transfer source locations, see
:ref:`Transfer source locations <admin-dashboard-transfer-source>`.

For more information about importing metadata into Archivematica, including how
to structure metadata CSV files, see :ref:`Import metadata <import-metadata>`.

.. important::

   You must carry out the following steps **before** the microservice
   ``Reminder: add metadata if desired``. After this point, any metadata that is
   entered will not be properly attached to the SIP or entered into the METS.

#. While on the Ingest tab, click on the metadata template icon to the right of
   the transfer name.

   .. figure:: images/MetadataIcon2.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: Location of the template icon

      To add metadata, click on the template icon

#. This will take you to the SIP detail page. Under the *Metadata* heading,
   click **Add metadata files**.

   .. figure:: images/SIPDetailPanel2.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: SIP information page

      SIP information page

#. Select a transfer source location and click **Browse**. Navigate through
   the folders to find your CSV file. Once you have located the CSV file, click
   **Add** to the right of the file name. Repeat as needed.

#. Once you've added all of your files, click **Add files**. A spinning wheel
   will indicate that the file is being uploaded. Once it disappears, return to
   the Ingest tab to continue processing the SIP.

.. _add-rights:

Add PREMIS rights
-----------------

Archivematica can accept PREMIS rights metadata about your digital objects and
parse this information into the METS file. For information on including
rights metadata prior to starting your transfer, see :ref:`Transfers with
descriptive and/or rights metadata <transfers-with-metadata>`. This section will
describe how to add rights metadata to your materials once processing has
begun in Archivematica.

Archivematica can be configured to prompt you with a reminder to add metadata by
setting the :ref:`processing configuration <dashboard-processing>` field
``Reminder: add metadata if desired`` to ``None``. This reminder occurs at the
last moment that it is possible to add metadata; once the ingest proceeds past
this point, it is no longer possible to add metadata to the SIP.

.. note::

   The rights form consists of two pages: one for the rights basis, and another
   for acts. For more information about Archivematica's PREMIS rights
   implementation, see :ref:`PREMIS template <premis-template>`.

#. While on the Transfer or Ingest tab, click on the metadata template icon to
   the right of the transfer name.

   .. figure:: images/MetadataIcon2.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: Location of the template icon

      To add rights, click on the template icon.

#. This will take you to the SIP detail panel. On the left-hand side, under
   *Rights*, click **Add**.

   .. figure:: images/SIPDetailPanel2.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: SIP detail panel

      SIP detail panel

#. Add the rights basis information and save the data by clicking the **Save**
   button at the bottom of the screen, or click **Next** if you are finished and
   ready to move on to the second page of data entry.

   .. figure:: images/CopyrightNext.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: SIP rights template- first page

      SIP rights template- first page

#. Enter act information and the associated grants/restrictions and save the
   data by clicking **Save**.

   .. figure:: images/RightsPg2AddAct.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: SIP rights template- second page

      SIP rights template- second page

#. When you click **Save** on the acts page, you will be given the option to add
   another act and further grants/restrictions.

   .. figure:: images/Createnewgrant.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: Button to repeat acts in rights template

      Repeatable acts in rights template

#. Once you have finished adding acts, click **Done**. You will see the rights
   entry in the list page. You can add more rights by clicking **Add** again, or
   edit or delete existing rights from this page.

   .. figure:: images/RightsPanelwRights.*
      :align: center
      :figwidth: 75%
      :width: 100%
      :alt: SIP detail panel with rights

      SIP detail panel with rights

6. Return to the Transfer or Ingest tab to continue processing the SIP.


.. _normalize:

Normalize
---------

Normalization is the process of converting an ingested digital object to a
preferred preservation and/or access format.

Note that the original objects are always kept along with their normalized
versions. For more information about Archivematica's preservation strategy, go
to the :ref:`Preservation Planning <preservation-planning>` section of the
manual.

1. At the normalization microservice, the SIP will appear in the dashboard with
   a bell icon next to it. Select one of the normalization options from the
   Actions drop-down menu:

.. figure:: images/NormPresAccess2.*
   :align: right
   :figwidth: 50%
   :width: 100%
   :alt: Selecting a normalization option

   Selecting a normalization option

* **None** - the user is prompted for a decision.
* **Normalize for preservation and access** - creates preservation copies of the
  objects plus access copies which will be used to generate the DIP.
* **Normalize for preservation** - creates preservation copies only. No access
  copies are created and no DIP will be generated.
* **Normalize manually** - see :ref:`Manual Normalization <manual-norm>` for
  more information.
* **Do not normalize** - the AIP will contain originals only. No preservation or
  access copies are generated and no DIP will be generated.
* **Normalize service files preservation** - see :ref:`Transferring material
  with service (mezzanine) files <transfer-service-files>` for more
  information.
* **Normalize for access** - the AIP will contain originals only. No
  preservation copies will be generated. Access copies will be created which
  will be used to generate the DIP.

Note that depending on the setup of your transfer, you may not see all of the
options listed above.

2. Once normalization is completed you can review the results in the
   normalization report. Click on the report icon next to the Actions drop-down
   menu.

.. figure:: images/ReportIcon2.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Location of the report icon to open the normalization report

   Click on the report icon to open the normalization report

The report shows what has been normalized and what is already in an acceptable
preservation and access format.

.. image:: images/NormReport1.*
   :align: center
   :width: 80%
   :alt: Normalization report

3. You may review the normalization results in a new tab by clicking on Review.
   If your browser has plug-ins to view a file, you may open it in another tab
   by clicking on it. If you click on a file and your browser cannot open it, it
   will download locally so you can view it using the appropriate software on
   your machine.

.. figure:: images/ReviewNorm1.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Review normalization results in new tab

   Review normalization results in new tab


4. Approve normalization in the Actions drop-down menu to continue processing
   the SIP. You may also Reject the SIP or re-do normalization. If you see
   errors in normalization, follow the instructions in Error handling to learn
   more about the problem.

.. seealso::

   :ref:`Manual normalization <manual-norm>`

.. _bind-pids:

Bind PIDs
---------

Bind PIDs refers to making use of Archivematica's integration with Handle.Net,
a registry that assigns persistent identifiers, or handles, to information
resources. If you do not use Handle.Net, consider setting your default
:ref:`dashboard processing <dashboard-processing>` configuration setting for
this Microservice to "No".

If you do use Handle.Net, you can configure Archivematica to mint persistent
identifiers (PIDs) for digital objects, directories, or AIPs by defining the
PIDs in a configured Handle.Net registry. Handle.Net can then create persistent
URLs (PURLs) from the PIDs and can reroute requests to the persistent URLs to a
target URL that is configured in Handle.Net.

To configure Archivematica and Handle.Net, first fill in the
:ref:`Handle server config <admin-handlenet>` settings in the Administration
tab.

During processing, selecting *Yes* at the Bind PIDs decision point will send a
request to the Handle.Net HTTP REST API server to mint a PID. By default, the
PID is based on the UUID of the object. You may also use the accession number
if you entered an accession number on the transfer screen.

.. IMPORTANT::

   If you are generating PIDs for the AIP as a whole, only use the accession number
   as the basis for the PID if you can guarantee that no other AIP will use the
   same accession number. If you will be creating multiple AIPs with the same
   accession number, set the AIP PID source to UUID.

   Note that files and directories will always use the UUID of the file or
   directory as the basis for the PID.

.. _transcribe-contents:

Transcribe SIP contents
-----------------------

Archivematica gives users the option to Transcribe SIP contents using
`Tesseract`_ OCR tool. If Yes is selected by the user during this microservice,
an OCR file will be included in the DIP and stored in the AIP.

.. note::

   Tesseract transcribes the text from single images (e.g. individual pages of a
   book scanned as image files). It does not support transcription of multi-page
   objects or word processing files, PDF files, etc.

.. _store-aip:

Store AIP
---------

After normalization is complete, the SIP runs through a number of microservices,
including submission documentation and metadata processing, METS file
generation, indexing, DIP generation, and AIP packaging.

.. figure:: images/StoreAIP.*
   :align: center
   :figwidth: 70%
   :width: 100%
   :alt: Archivematica ready to store AIP and upload DIP

   Archivematica ready to store the AIP

1. Before storing the AIP, you can review the contents of the AIP by clicking
   **Review**. A new tab will open where you can browse your AIP. To review the
   individual objects in the AIP, click on the 7z file to download it. You can
   also view the METS file (the file with the name ``METS-uuid.xml``) by
   clicking on it.

   .. figure:: images/AIP-review.*
      :align: center
      :figwidth: 70%
      :width: 100%
      :alt: The AIP review page showing an expanded AIP file structure

   If you want to validate the METS file, you can click on the
   temporary file that ends in ``validatorTester.html``. This will open the
   METS file in a new window where you can validate it against the METS
   specification using the `PREMIS in METS validator`_.

   For more information on Archivematica's AIP structure and the METS file, see
   :ref:`AIP structure <aip-structure>`.

2. Once you are ready to store the AIP, select **Store AIP** from the action
   dropdown menu. You can also reject the AIP, if needed.

3. Next, select the storage location where you would like to store the AIP.
   There may be several storage locations configured for your Archivematica
   pipeline. For instructions to configure AIP storage locations, see the
   :ref:`Storage Service <storageService:administrators>` documentation.

4. Once your AIP has been stored, you can view and manage it on the
   :ref:`Archival storage <archival-storage>` tab.

.. note::

   It is possible to designate one storage location as the default location for
   AIP storage in the :ref:`Storage Service <storageService:administrators>`.
   The default location is represented as ``Default location`` in the Store AIP
   location dropdown menu, but the storage location will also be listed by name
   alongside any other storage location options. If there is only one AIP
   storage location, it will automatically be set as the default location, and
   both ``Default location`` and the storage location itself will appear in the
   dropdown menu.

.. _upload-dip:

Upload DIP
----------

Archivematica supports DIP uploads to AtoM, Binder, ArchivesSpace, and
CONTENTdm. For information about uploading DIPs to your access system, see
:ref:`Access <access>`.

DIPs can be stored similar to AIPs; however, DIPs can also be generated when
required by doing a partial :ref:`reingest <reingest>` of the AIP.

.. note::

   We recommend storing the AIP before uploading the DIP. If there is a problem
   with the AIP during storage and the DIP has already been uploaded, you will
   have to delete the DIP from the upload location.

.. note::

   It is possible to designate one storage location as the default location for
   DIP storage in the :ref:`Storage Service <storageService:administrators>`.
   The default location is represented as ``Default location`` in the Store DIP
   location dropdown menu, but the storage location will also be listed by name
   alongside any other storage location options. If there is only one DIP
   storage location, it will automatically be set as the default location, and
   both ``Default location`` and the storage location itself will appear in the
   dropdown menu.

.. _reingest:

Re-ingest AIP
-------------

There are three different types of AIP re-ingest:

1. Metadata only
++++++++++++++++

This method is for adding or updating descriptive and/or rights metadata. Doing
so will update the dmdSec of the AIP's METS file.  Note that the original
metadata will still be present but if you scroll down you'll also see another
dmdSec that says STATUS="updated", like so:

``<mets:dmdSec ID="dmdSec_792149" CREATED="2017-10-17T20:32:36" STATUS="updated">``

Choosing metadata only AIP re-ingest will take you back to the Ingest tab.

2. Partial re-ingest
++++++++++++++++++++

This method is typically used by institutions who want to create a DIP sometime
after they've made an AIP.  They can then send their DIP to their access system
or store it.

Choosing partial re-ingest will take you back to the Ingest tab.

3. Full re-ingest
+++++++++++++++++

This method is for institutions who want to be able to run all the major
microservices (including re-normalization for preservation if desired). A
possible use case for full re-ingest might be that after a time new file
characterization or validation tools have been developed and integrated with a
future version of Archivematica. Running the microservices with these updated
tools will result in a updated and better AIP.

Full re-ingest can also be used to update the metadata, and re-normalize for
access.

When performing full re-ingest, you will need to enter the name of the
processing configuration you wish to use. To add new processing configurations,
see :ref:`Processing configuration <dashboard-processing>`.

.. important::

   The following workflows are **not** supported in full AIP re-ingest:

   * Examine contents if not performed on first ingest
   * Transfer structure report if not performed on first ingest
   * Extract packages in the AIP and then delete them
   * Send AIP to backlog for re-arrangement during re-ingest


Choosing full re-ingest will take you back to the Transfer tab.

How to tell in the METS file if an AIP has been re-ingested
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

1. Look at the Header of the METS file, which will display a ``CREATEDATE`` and
a ``LASTMODDATE``: ``<mets:metsHdr CREATEDATE="2017-10-17T20:29:21"
LASTMODDATE="2017-10-17T20:32:36"/>``

2. You can also search for the reingest premis:event
``<premis:eventType>reingestion</premis:eventType>``

3. If you've updated the descriptive or rights metadata you will find an updated
dmdSec: ``<mets:dmdSec ID="dmdSec_792149" CREATED="2017-10-17T20:32:36"
STATUS="updated">``


.. _reingest-dashboard:

Where to start the re-ingest process
++++++++++++++++++++++++++++++++++++

You can start the re-ingest process through the Archival Storage tab on the
Dashboard, the Storage Service, or the API.

Archival Storage tab on the Dashboard
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Go to the Archival Storage tab and find the AIP you wish to re-ingest by
searching or browsing.

1. Click on the name of the AIP or View to open that AIP's view page. Under
Actions, click on Re-ingest.

.. image:: images/storage_reingest.*
   :align: center
   :width: 80%
   :alt: Click on reingest beside the AIP

2. Choose the type of re-ingest (metadata, partial or full).

.. image:: images/reingest_type2.*
   :align: center
   :width: 80%
   :alt: Choose type of reingest and name of processing configuration

3. Click on Re-ingest. Archivematica will tell you that the AIP has been
   sent to the pipeline for re-ingest.

.. Note::

   If you attempt to re-ingest an AIP which is already in the process of being
   re-ingested in the pipeline, Archivematica will alert you with an error.

.. Note::

   Archivematica will appear to allow you to extract and then delete packages.
   However, the resulting AIP will still actually contain the packages, and in
   the METS file they will not have re-ingestion events correctly associated
   with them. This is documented as a bug here:
   https://projects.artefactual.com/issues/10699

4. Proceed to the Transfer or Ingest tab and approve the AIP re-ingest.

.. image:: images/reingest_approve2.*
   :align: center
   :width: 80%
   :alt: Approve AIP reingest in Ingest tab.


5. At the Normalization microservice you will make different choices depending
   on the type of AIP re-ingest you've selected.

   **Metadata-only re-ingest**

   1. Add or update your metadata *before* you approve Normalization to ensure
      the metadata is written to the database, which means it will be written to
      the AIP METS file. There are two ways to add or update metadata:

      A. Add metadata directly into Archivematica

         a. Click on the paper and pencil icon on the same line as the name of
            the SIP to take you to the "Add metadata" page.

         b. Click "Add" under "Rights" if you have rights-related metadata to
            add.

         c. Click on "Add" under "Metadata" if you have descriptive metadata to
            add.

         d. Enter your metadata.

         e. Click on "Ingest" (top left corner) to go back to the Ingest tab
            when you're done.

      B. Add metadata files

         a. Click on the metadata report icon on the same line as the name of
            the SIP to take you to the "Add metadata" page.

         b. Click on "Add metadata files" under "Metadata"

         c. Click on "Browse"

         d. Select a ``metadata.csv`` file.  Note name of the file must be
            exactly ``metadata.csv`` and the file must follow the structure
            outlined in :ref:`Import metadata <import-metadata>`.  The file must
            also be staged in the same Transfer Source location that you stage
            your objects for transfer to Archivematica.

   2. Select "Do not normalize" when you have finished adding your metadata.

   3. Continue processing the SIP as normal.

.. Note::

   When performing a metadata-only re-ingest, there will be no objects
   in your AIP in the review stage- Archivematica replaces the METS file in the
   existing AIP upon storage.

   **Partial re-ingest**

   1. Add metadata if desired. See **Metadata-only re-ingest** for instructions

   2. Select "Normalize for access".

   3. Continue processing the SIP as normal.


   **Full re-ingest**

   1. Add metadata if desired. See **Metadata-only re-ingest** for instructions.

   2. Select the normalization path of your choosing.

   3. Continue processing the SIP as normal.


.. important::

   All normalization options will appear as for any SIP being normalized, but
   when performing metadata only or partial re-ingest, **only** the
   normalization paths noted above are supported.

.. tip::

   You can add or update the metadata either before or after Normalization, but
   to ensure the metadata is written to the database before the AIP METS
   is prepared, it is recommended practice to add the metadata before
   Normalization, or set the metadata reminder to unchecked in Processing
   Configuration.

.. _re-ingest-storage-service:

Storage Service
^^^^^^^^^^^^^^^

1. From the Packages tab in the Storage Service, click on Re-ingest beside the
   AIP you wish to reingest.

.. image:: images/reingest_ss.*
   :align: center
   :width: 80%
   :alt: Reingest link in Storage Service Packages tab

2. The Storage Service will ask you to choose a pipeline, the types of reingest
   (see above for thorough descriptions of each), and for full re-ingest, the
   name of the processing configuration.

.. image:: images/reingest_ss_2.*
   :align: center
   :width: 80%
   :alt: Screen to choose pipeline and type of reingest

3. The Storage Service will confirm that the AIP has been sent to the pipeline
   for reingest. Proceed to the Transfer or Ingest tab of your pipeline, and
   follow steps 3-6 above.

.. _re-ingest-api:

API
^^^

Documentation to come.

.. _cleanup-ingest:

Clean up the ingest dashboard
-----------------------------

The dashboard in the Ingest tab should be cleaned up from time to time. As the
list of SIPs grows, it takes Archivematica longer and longer to parse this
information which can create browser timeout issues.

.. NOTE::
   This does not delete the SIP or related entities. It merely removes them
   from the dashboard.

Remove a single ingest
++++++++++++++++++++++

#. Ensure that the SIP you want to remove doesn't require any user input.
   You must complete all user inputs and either complete the SIP (i.e.
   AIPs/DIPs are created and stored/uploaded) or reject the SIP before it can be
   removed from the dashboard.

#. When you are ready to remove a SIP from the dashboard, click the red circle
   icon found next to the add metadata icon, to the right of the SIP name.

#. Click the Confirm button to remove the SIP from the dashboard.


Remove all completed ingests
++++++++++++++++++++++++++++

#. Ensure that the SIPs you want to remove are complete (i.e. AIPs/DIPs are
   created and stored/uploaded). Note that this feature only works on completed
   SIPs; rejected SIPs will have to be removed one at a time.

#. When you are ready to remove all completed SIPs, click the red circle
   icon in the table header of the list of SIPs.

#. Click the Confirm button to remove all completed SIPs from the dashboard.


:ref:`Back to the top <ingest>`

.. _Dublin Core Metadata Element Set: http://dublincore.org/documents/dces/
.. _Tesseract: https://github.com/tesseract-ocr/
.. _PREMIS in METS validator: http://pim.fcla.edu/validate
