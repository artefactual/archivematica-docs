.. _ingest:

======
Ingest
======

During ingest, digital objects are packaged into SIPs and run through several micro-services, including normalization, packaging into an AIP and generation of a DIP.

If you would like to skip some of the default decision points or make preconfigured choices for your desired workflow, see :ref:`User administration - Processing configuration <dashboard-processing>`.

Should you run into an error during ingest, please see :ref:`Error handling <error-handling>`.

*On this page:*

* :ref:`Create a SIP <create-sip>`
* :ref:`Arrange a SIP from backlog <arrange-sip>`
* :ref:`Arrange a SIP for AtoM <hierarchical-dip>`
* :ref:`Add metadata <add-metadata>`
* :ref:`Add PREMIS rights <add-rights>`
* :ref:`Normalize <normalize>`
* :ref:`Transcribe SIP contents <transcribe-contents>`
* :ref:`Store AIP <store-aip>`
* :ref:`Upload DIP <upload-dip>`
* :ref:`Reingest AIP <reingest>`


.. _create-sip:

Create a SIP
------------

#. Process transfers as described in :ref:`Transfers <transfer>`. If you selected
   "Create single SIP and continue processing" on the Transfer tab, your SIP has
   been created and Archivematica will begin running Ingest tasks. Click on the Ingest
   tab to continue working with your SIP.

#. The single SIP will move through a number of micro-services. If you have
   preconfigured Archivematica to do so, processing will stop at a decision point
   that allows you to choose a file identification method to base normalization
   upon or to choose to use pre-existing data gathered during identification at
   the transfer stage. Archivematica default is to use pre-existing data. For more
   about this option, see :ref:`Administer — Processing configuration <dashboard-processing>`.

#. Once the SIP reaches "Normalize", you will be given several options for how Archivematica
   should normalize the SIP. Choose the option most suitable for your workflow.

   .. figure:: images/Normalize1.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: Archivematica Normalization micro-service

      Normalization micro-service

#. To add descriptive metadata, see :ref:`Add metadata <add-metadata>`, below.

#. To add PREMIS rights information, see :ref:`Add PREMIS rights <add-rights>`, below.

#. For selecting a normalization option, see :ref:`Normalization <normalize>`, below.


.. _arrange-sip:

Arrange a SIP from backlog
--------------------------

This section refers to the backlog arrangement feature on the ingest page, rather
than the Backlog tab. For more information on the Backlog tab, see :ref:`Backlog <backlog>`.

#. Select content from the backlog by either searching for it through the backlog
   search bars at the top of the Ingest tab or by browsing the backlog by clicking
   on the folder icons in the *Originals* pane. Note: Multi-item select is not yet included
   in this feature, though entire folders/directories can be moved.

   .. figure:: images/Ingest-panes.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: Transfer backlog search showing population of the Originals pane

      Transfer backlog search results in populating Originals pane

#. Archivematica will display the directories available in Transfer backlog, including the
   number of objects in each directory. To hide directories from the Originals pane,
   click on the directory and click Hide.

#. Drag and drop the transfer directory(ies) and/or object(s) you wish to arrange
   from the Originals pane to the Arrange pane. By dragging and dropping, you can
   create an arrangement structure for your SIP. Note that all metadata, submission
   documentation, and other associated data is also copied to the arrange pane with
   your object(s). A copy also remains with anything you leave in the Originals pane.
   These files are hidden because they cannot be arranged independently of the objects
   to which they relate.

   .. figure:: images/Backlog-arrange-pane.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: Dragging and dropping directories from Originals pane to Arrange pane

      Drag and drop from Originals pane to Arrange pane

   .. note::

      In the above example, the Project.zip directory was dragged from the Originals pane
      to the Arrange pane. Note that the Project.zip directory in the Originals pane
      has been greyed out to indicate that the file has been added to a potential
      SIP.

#. Click on the directory in the Arrange pane to select, and then click Create SIP.
   Archivematica will confirm that you wish to create a SIP from the selected objects
   and then proceed through the ingest micro-services.

#. To arrange your SIP, create one or more directories in the Arrange pane by clicking
   *Add Directory*. You can create directories nested inside of each other. Note: You
   cannot rename a directory once you have created it; you must delete it and create
   a directory with a new name.

   .. figure:: images/Arrange-new-directory.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: Creating a new directory in the Arrange pane

      Create a new directory in Arrange pane

#. Click and drag files from the Originals pane into your desired directory in the
   arrange panel. You can move either individual files or entire directories. Note:
   All files must be in a directory inside of Arrange. “Arrange” cannot be used as
   the top directory.

#. When you have completed moving files and directories into the Arrange pane, select
   your desired top-level directory - this is the directory that will become
   your SIP. Click on Create SIP. Any files or directories which are not inside
   the directory you choose will remain in the Arrange pane until you create a SIP
   that includes these files and directories.

   .. figure:: images/Create-SIP.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: Create a new SIP in Arrange pane

      Create a new SIP by clicking on a directory within Arrange pane

#. Archivematica will confirm that you wish to create a SIP and, after receiving
   confirmation, will proceed to the Ingest microservices.

.. _hierarchical-dip:

Arranging a SIP for AtoM
------------------------

If you plan to create a DIP to :ref:`Upload to AtoM <upload-atom>`, you may wish to add
levels of description to your directories and/or objects. Archivematica will add a logical
structMAP to the METS file, which AtoM will use to create information objects, applying the
chosen levels of description. Note that if you do not apply a level of description to a
digital object, AtoM will automatically assign it the level of "item".

This functionality is supported with AtoM 2.2 and higher.

#. Select a directory or object in the Arrange pane. Click *Edit metadata* to choose the
   level of description.

   .. image:: images/choose_lod.*
      :align: center
      :width: 80%
      :alt: Choosing the AtoM level of description

#. As you add levels of description they will be shown in the arrange pane for you
   to review before finalizing your SIP.

   .. image:: images/view_arrangement.*
      :align: center
      :width: 70%
      :alt: Viewing levels of description applied to SIP

.. note::

   To have the AtoM levels of description appear you must have entered your AtoM
   credentials in Administration. See :ref:`Administer, AtoM DIP upload <dashboard-atom>`.
   Levels of description in AtoM are managed as a taxonomy. To edit, see :ref:`Terms <atom:terms>`.

.. tip::

   If you choose not to assign levels of description to directories in SIP arrange,
   AtoM will flatten the DIP so that all digital objects are child-level descriptions
   of the target description.

.. _add-metadata:

Add metadata
------------

In Archivematica, metadata can be added either prior to the normalization step or after.
Archivematica will prompt you with a reminder to add metadata if desired during the
Process metadata directory micro-service. See :ref:`AtoM Dublin Core <atom:dc-template>`
for information about the Dublin Core elements available.

.. seealso::

    If you are importing lower-level metadata (i.e. metadata to be attached to subdirectories and files within a SIP) see also:

    * :ref:`Transfer <transfer>`

    * :ref:`Import metadata <import-metadata>`


#. Click on the template icon.

   .. figure:: images/MetadataIcon1.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: Location of the template icon

      To add metadata, click on the template icon

#. This will take you to the SIP detail panel. Under the Metadata heading, click Add.

   .. figure:: images/SIPDetailPanel1.*
      :align: center
      :figwidth: 80%
      :width: 100%
      :alt: SIP information page

      SIP information page

#. Add metadata as desired and save it by clicking the Create button at the bottom
   of the screen. Hovering over a field will activate tooltips that define the Dublin
   Core element and provide a link to `ISO 15836 Dublin Core Metadata Element Set <http://dublincore.org/documents/dces/>`_.
   Note that you can only add metadata at the aggregate level when using the template
   - that is, the metadata will be applied to each object in the SIP. If you would
   like to add metadata to a digital object, you must :ref:`Import metadata via CSV <import-metadata>`
   or add the metadata once the object has been uploaded to your access system.

   .. figure:: images/Metadataform1.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: SIP metadata entry form

   SIP metadata entry form

#. When you click Create, you will see the metadata entry in the list page. To edit
   it further, click Edit on the right-hand side. To delete it, click Delete. To
   add more DC metadata, click the Add button below the list.

   .. figure:: images/Metadatalist1.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: SIP metadata list

      SIP metadata list

#. Return to the ingest tab to continue processing the SIP.

.. _add-rights:

Add PREMIS rights
-----------------

Archivematica allows you to add PREMIS rights either prior to the normalization step or
after. Archivematica will prompt you with a reminder to add rights information
if desired during the Process metadata directory micro-service. For more information about the
PREMIS rights fields, see :ref:`PREMIS template <premis-template>`

1. Click on the template icon.

.. figure:: images/MetadataIcon1.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Location of the template icon

   To add rights, click on the template icon

2. This will take you to the SIP detail panel. On the left-hand side, under Rights, click Add.

.. figure:: images/SIPDetailPanel1.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: SIP detail panel

   SIP detail panel

3. Add rights as desired and save it by clicking the Save button at the bottom of the screen, or clicking Next if you are finished and ready to move on to the second page of data entry. Rights entries are made up of two pages of content.

.. figure:: images/CopyrightNext.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: SIP rights template- first page

   SIP rights template- first page

To get to the second page to complete data entry, click Next. Note
that you can only add rights at the SIP level. If you would like to add rights
to an individual digital object, you will need to do that once the object has
been uploaded to your access system.

.. figure:: images/RightsPg2AddAct.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: SIP rights template- second page

   SIP rights template- second page


4. When you click Save on the second page, you will be given the option to add another act with its associated grants and/or restrictions.

.. figure:: images/Createnewgrant.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: Button to repeat acts in rights template

   Repeatable acts in rights template

5. If you have finished adding acts, click Done. You will see the rights entry in the list page . To edit it further, click Edit on the right-hand side.

.. figure:: images/RightsPanelwRights.*
   :align: center
   :figwidth: 75%
   :width: 100%
   :alt: SIP detail panel with rights

   SIP detail panel with rights

6. Return to the ingest tab to continue processing the SIP.


.. _normalize:

Normalize
---------

Normalizing is the process of converting ingested digital objects to
preservation and/or access formats. Note that the original objects are always
kept along with their normalized versions. For more information about
Archivematica's preservation strategy, go to the Preservation Planning section
of the manual.

1. At the normalization step, the SIP will appear in the dashboard with a bell icon next to it. Select one of the normalization options from the Actions drop-down menu:

.. figure:: images/NormPresAccess1.*
   :align: right
   :figwidth: 50%
   :width: 100%
   :alt: Selecting a normalization option

   Selecting a normalization option

* Normalize for preservation and access: creates preservation copies of the
  objects plus access copies which will be used to generate the DIP.

* Normalize for access: no preservation copies are created. Creates access
  copies which will be used to generate the DIP.

* Normalize for preservation: creates preservation copies. No access copies
  are created and no DIP will be generated.

* Do not normalize: no preservation copies are created. No access copies are
  created and no DIP will be generated.

* You may also Reject SIP at this stage.


2. Once normalization is completed you can review the results in the normalization report. Click on the report icon next to the Actions drop-down menu.

.. figure:: images/ReportIcon1.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Location of the report icon to open the normalization report

   Click on the report icon to open the normalization report

The report shows what has been normalized and what is already in an acceptable
preservation and access format:

.. image:: images/NormReport1.*
   :align: center
   :width: 80%
   :alt: Normalization report

3. You may review the normalization results in a new tab by clicking on Review. If your browser has plug-ins to view a file, you may open it in another tab by clicking on it. If you click on a file and your browser cannot open it, it will download locally so you can view it using the appropriate software on your machine.

.. figure:: images/ReviewNorm1.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Review normalization results in new tab

   Review normalization results in new tab


4. Approve normalization in the Actions drop-down menu to continue processing the SIP. You may also Reject the SIP or re-do normalization. If you see errors in normalization, follow the instructions in Error handling to learn more about the problem.

.. seealso::

   :ref:`Manual normalization <manual-norm>`


.. _transcribe-contents:

Transcribe SIP contents
-----------------------

Archivematica gives users the option to Transcribe SIP contents using
`Tesseract <https://code.google.com/p/tesseract-ocr/>`_ OCR tool. If Yes is
selected by the user during this micro-service, an OCR file will be included in
the DIP and stored in the AIP.

.. note::

   This feature is designed to transcribe the text from single images (e.g.
   individual pages of a book scanned as image files). It does not support
   transcription of multi-page objects or word processing files, PDF files, etc.


.. _store-aip:

Store AIP
---------

1. After normalization is approved, the SIP runs through a number of micro-services, including processing of the submission documentation, generation of the METS file, indexing, generation of the DIP and packaging of the AIP.

.. figure:: images/StoreAIPUpDIP1.*
   :align: center
   :figwidth: 70%
   :width: 100%
   :alt: Archivematica ready to store AIP and upload DIP

   Archivematica ready to store the AIP and upload the DIP

2. If desired, review the contents of the AIP in another tab by clicking on Review. More information on Archivematica's AIP structure and the METS/PREMIS file is available in the Archivematica documentation: see :ref:`AIP structure <aip-structure>`. You can download the AIP at this stage by clicking on it.

3. From the Action dropdown menu, select "Store AIP" to move the AIP into archival storage. You can store an AIP in any number of preconfigured directories. For instructions to configure AIP storage locations, see :ref:`Administrator manual - Storage Service <storageService:administrators>`.

4. From the Action dropdown menu, select the AIP storage location from the pre-configured set of options.

.. note::

   We recommend storing the AIP before uploading the DIP. If there is a problem
   with the AIP at this point and the DIP has already been uploaded, you will have
   to delete the DIP from the upload location.

   For information on viewing and managing stored AIPs go to
   :ref:`Archival storage <archival-storage>`.

.. _upload-dip:

Upload DIP
----------

Archivematica supports DIP uploads to AtoM, ArchivesSpace, CONTENTdm and Archivists' Toolkit. For information about uploading DIPs to your access system, see :ref:`Access <access>`.

.. _reingest:

Reingest AIP
------------

In Archivematica, AIP reingest is supported for three purposes: adding/updating
descriptive and/or rights metadata, normalizing for access, or full re-ingest which
re-runs all major micro-services.  There are three methods of starting
AIP reingest: through the dashboard, through the Storage Service, or through
the API.

.. _reingest-dashboard:

Dashboard
=========

1. In the Archival Storage tab, find the AIP you wish to reingest by searching or browsing. Click on the name of the AIP or View to open that AIP's view page. Under Actions, click on Re-ingest.

.. image:: images/storage_reingest.*
   :align: center
   :width: 80%
   :alt: Click on reingest beside the AIP

2. Choose if you wish to perform a metadata re-ingest, a partial re-ingest (which sends the AIP to the beginning of Ingest to re-normalize for Access and update the metadata if desired) or a full re-ingest (which sends the AIP to the beginning of transfer and re-runs all major micro-services, including re-normalization for preservation if desired).

2a. If performing full re-ingest, enter the name of the processing configuration you wish to use. To add new processing configurations, see :ref:`Processing configuration <dashboard-processing>`.

Full re-ingest can also be used to update the metadata, and re-normalize for access.

.. image:: images/reingest_type.*
   :align: center
   :width: 80%
   :alt: Choose type of reingest and name of processing configuration

Click on Re-ingest. Archivematica will tell you that the AIP has been
sent to the pipeline for reingest.

.. note::

   If you attempt to reingest an AIP which is already in the process of being
   reingested in the pipeline, Archivematica will alert you with an error.

.. important::

   The following workflows are **not** supported in full AIP re-ingest:

   * Examine contents if not performed on first ingest
   * Transfer structure report if not performed on first ingest
   * Extract packages in the AIP and then delete them
   * Send AIP to backlog for re-arrangement during re-ingest

   A note about package extraction in re-ingest: Archivematica will not appear to
   prevent you from extracting packages on re-ingest, and then deleting the packages.
   However, the resulting AIP will still contain the packages, and in the METS
   file they will not have re-ingestion events correctly associated with them.
   This is documented as a bug here:
   https://projects.artefactual.com/issues/10699


3. Proceed to the Transfer or Ingest tab and approve the AIP reingest.

.. image:: images/reingest_approve.*
   :align: center
   :width: 80%
   :alt: Approve AIP reingest in Ingest tab.


4. When the package proceeds to Normalization:

**For metadata only** choose "Do not normalize"

**For partial re-ingest** choose "Normalize for access"

**For full re-ingest** use the normalization path of your choosing

.. important::

   All normalization options will appear as for any SIP being normalized, but
   when performing metadata only or partial re-ingest, **only** the normalization
   paths noted above are supported.

5. To add new metadata or edit existing metadata, click on the metadata report icon:

.. image:: images/reingest_metadata.*
   :align: center
   :width: 80%
   :alt: Click on the metadata report icon

.. tip::

   You can update the metadata either before or after Normalization, but to
   ensure the metadata is written to the database before the AIP METS
   is prepared, it is recommended practice to add the metadata before
   Normalization, or set the metadata reminder to unchecked in Processing
   Configuration.

Descriptive or rights metadata can updated or deleted. ``metadata.csv`` files
can also be added by clicking on Add Metadata files. This will launch a file
browser with the same locations available as configured for Transfer Source.

.. image:: images/reingest_metadata_upload.*
   :align: center
   :width: 80%
   :alt: Add new metadata files

7. After normalization and metadata updating, continue processing the SIP as normal. Note that when performing a metadata-only reingest, there will be no objects in your AIP in the review stage- Archivematica replaces the METS file in the existing AIP upon storage.

.. _re-ingest-storage-service:

Storage Service
===============

1. From the Packages tab in the Storage Service, click on Re-ingest beside the AIP you wish to reingest.

.. image:: images/reingest_ss.*
   :align: center
   :width: 80%
   :alt: Reingest link in Storage Service Packages tab

2. The Storage Service will ask you to choose a pipeline, the types of reingest (see above for thorough descriptions of each), and for full re-ingest, the name of the processing configuration.

.. image:: images/reingest_ss_2.*
   :align: center
   :width: 80%
   :alt: Screen to choose pipeline and type of reingest

3. The Storage Service will confirm that the AIP has been sent to the pipeline for reingest. Proceed to the Transfer or Ingest tab of your pipeline, and follow steps 3-6 above.

.. _re-ingest-api:

API
===

Documentation to come.

:ref:`Back to the top <ingest>`
