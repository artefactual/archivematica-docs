.. _ingest:

======
Ingest
======

During ingest, digital objects are packaged into SIPs and run through several
micro-services, including normalization, packaging into an AIP and generation
of a DIP.

If you would like to skip some of the default decision points or make
preconfigured choices for your desired workflow, see User administration -
Processing configuration

Should you run into an error during ingest, please see Error handling.

*On this page:*

* :ref:`Create a SIP <create-sip>`
* :ref:`Arrange a SIP from backlog <arrange-sip>`
* :ref:`Add metadata <add-metadata>`
* :ref:`Add PREMIS rights <add-rights>`
* :ref:`Normalize <normalize>`
* :ref:`Transcribe SIP contents <transcribe-contents>`
* :ref:`Store AIP <store-aip>`

.. _create-sip:

Create a SIP
------------

1. Process transfers as described in Transfer.

2. Click on the Ingest tab.You will get a pop-up warning you that if you wish
to add metadata or PREMIS rights you must do it prior to normalization.
Dismiss or wait until it disappears.

3. The single SIP will move through a number of micro-services. If the user
has preconfigured Archivematica to do so, processing will stop at a decision
point that allows the user to choose a file identification method to base
normalization upon or to choose to use pre-existing data gathered during
identification at the transfer stage. Archivematica default is to use pre-
existing data. For more about this option, see User Administration -
Processing configuration

4. Wait until the SIP reaches "Normalize" and a bell icon appears.

.. figure:: images/Normalize1.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Archivematica Normalization micro-service

   Normalization micro-service

5. To add descriptive metadata, see Add metadata, below.

6. To add PREMIS rights information, see Add PREMIS rights, below.

7. For selecting a normalization option, see Normalization, below.


.. _arrange-sip:

Arrange a SIP from backlog
--------------------------

1. Retrieve content from transfer backlog. Use the Transfer backlog search
bars at the top of the Ingest tab to find the transfer(s) and/or object(s)
you'd like to ingest, or browse the entire backlog by clicking Search transfer
backlog with a blank search. This will populate the Originals pane of the
Ingest dashboard. Note: Multi-item select is not yet included in this
feature, though entire folders/directories can be moved.

.. figure:: images/Ingest-panes.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Transfer backlog search showing population of the Originals pane

   Transfer backlog search results in populating Originals pane

To hide directories from the Originals pane, click on the directory and click
Hide.

2. Drag and drop the transfer directory(ies) and/or object(s) you wish to
arrange and ingest as a SIP from the Originals pane to the Arrange pane, or
create an arrangement structure for your SIP (see step 4, below).

.. figure:: images/Backlog-arrange-pane.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Dragging and dropping directories from Originals pane to Arrange pane

   Drag and drop from Originals pane to Arrange pane

3. Click on the directory in the Arrange pane to select, and then click Create
SIP. Archivematica will confirm that you wish to create a SIP, and then
continue through the ingest process.

4. To create an arrangement for your SIP, create one or more directories in
the Arrange pane by clicking on the Add Directory button. You can add
separate directories or directories nested inside of each other. Note: You
cannot rename a directory once you have created it; you must delete it and
create a directory with a new name.

.. figure:: images/Arrange-new-directory.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Creating a new directory in the Arrange pane

   Create a new directory in Arrange pane


5. Click and drag files from the Originals pane into your desired directory
in the arrange panel. You can move either individual files or entire
directories. Note: All files must be in a directory inside of Arrange.
“Arrange” cannot be used as the top directory.

6. When you have completed moving files and directories into the Arrange pane,
click on the top level directory which you wish to include in your SIP. Click
on Create SIP. Any files or directories which are not inside the directory you
chose will remain in the Arrange pane until you create a SIP using these files
and directories.

.. figure:: images/Create-SIP.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Create a new SIP in Arrange pane

   Create a new SIP by clicking on a directory within Arrange pane

Archivematica will confirm that you wish to create a SIP and after receiving
confirmation, proceed to the next micro-services to create AIPs and DIPs as
selected by the user.

.. note::

   The arrangement that you made in the Arrange pane will be reflected in both
   the structure of the AIP and the structMap in the METS file. When uploaded to
   AtoM, the SIP structure will not be maintained- all objects will be uploaded
   as children to the same level of description.


.. _add-metadata:

Add metadata
------------

In version 1.2, metadata can be added either prior to the normalization step
or after. Archivematica will prompt you with a reminder to add metadata if
desired during the Process metadata directory micro-service. See
`ICA-AtoM (Qubit) Dublin Core  <https://www.archivematica.org/wiki/UM_ingest_1.2>`_
for information about the Dublin Core elements available.


.. seealso::

    If you are importing lower-level metadata (i.e. metadata to be attached to
    subdirectories and files within a SIP) see also:

    * Metadata import
    * Transfer


1. Click on the template icon.

.. figure:: images/MetadataIcon1.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Location of the template icon

   To add metadata, click on the template icon


2. This will take you to the SIP detail panel. On the left-hand side, under
metadata click Add.

.. figure:: images/SIPDetailPanel1.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: SIP detail panel

   SIP detail panel

3. Add metadata as desired and save it by clicking the Create button at the
bottom of the screen. Hovering in a field will activate tooltips that define
the Dublin Core element and provide a link to
`ISO 15836 Dublin Core Metadata Element Set <http://dublincore.org/documents/dces/>`_.
Note that you can only add metadata at the SIP level when using the template. If
you would like to add metadata to a digital object, you will need to do that once
the object has been uploaded to your access system.

.. figure:: images/Metadataform1.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: SIP metadata entry form

   SIP metadata entry form

.. important::

    If you would like to upload your DIP to AtoM as a child of an existing
    target description, you must add at least a Title in the Dublin Core
    template.

4. When you click Create, you will see the metadata entry in the list page.
To edit it further, click Edit on the right-hand side.To delete it, click
Delete. To add more DC metadata, click the Add button below the list.

.. figure:: images/Metadatalist1.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: SIP metadata list

   SIP metadata list

5. Return to the ingest tab to continue processing the SIP.

.. _add-rights:

Add PREMIS rights
-----------------

In version 1.2 you can add rights either prior to the normalization step or
after. Archivematica will prompt you with a reminder to add rights information
if desired during the Process metadata directory micro-service. See
`AtoM Rights Entity <https://www.accesstomemory.org/en/docs/2.0/user-manual/add-edit-content/rights/#rights>`_
for information about the rights elements available.

1. Click on the template icon.


.. figure:: images/MetadataIcon1.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Location of the template icon

   To add rights, click on the template icon

2. This will take you to the SIP detail panel. On the left-hand side, under
Rights click Add.

.. figure:: images/SIPDetailPanel1.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: SIP detail panel

   SIP detail panel

3. Add rights as desired and save it by clicking the Save button at the bottom
of the screen, or clicking Next if you are finished and ready to move on to
the second page of data entry. Rights entries are made up of two pages of
content.

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


4. When you click Save on the second page, you will be given the option to add
another act with its associated grants and/or restrictions.

.. figure:: images/Createnewgrant.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: Button to repeat acts in rights template

   Repeatable acts in rights template

5. If you have finished adding acts, click Done. You will see the rights entry
in the list page . To edit it further, click Edit on the right-hand side.

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

1. At the normalization step, the SIP will appear in the dashboard with a bell
icon next to it. Select one of the normalization options from the Actions
drop-down menu:

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


2. Once normalization is completed you can review the results in the
normalization report. Click on the report icon next to the Actions drop-down
menu.

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

3. You may review the normalization results in a new tab by clicking on
Review. If your browser has plug-ins to view a file, you may open it in
another tab by clicking on it. If you click on a file and your browser cannot
open it, it will download locally so you can view it using the appropriate
software on your machine.

.. figure:: images/ReviewNorm1.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Review normalization results in new tab

   Review normalization results in new tab


4. Approve normalization in the Actions drop-down menu to continue processing
the SIP. You may also Reject the SIP or re-do normalization.

If you see errors in normalization, follow the instructions in Error handling
to learn more about the problem.

.. seealso::

   Manual normalization


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



.. _store-AIP:
ar
Store AIP
---------

1. After normalization is approved, the SIP runs through a number of micro-
services, including processing of the submission documentation, generation of
the METS file, indexing, generation of the DIP and packaging of the AIP.

2. When these micro-services are complete, the user can upload DIP and store AIP.

.. figure:: images/StoreAIPUpDIP1.*
   :align: center
   :figwidth: 70%
   :width: 100%
   :alt: Archivematica ready to store AIP and upload DIP

   Archivematica ready to store AIP and upload DIP

3. If desired, review the contents of the AIP in another tab by clicking on
Review. More information on Archivematica's AIP structure and the METS/PREMIS
file is available in the Archivematica documentation: see AIP structure and
METS. You can download the AIP at this stage, as well, by clicking on it.

4. From the Action dropdown menu, select "Store AIP" to move the AIP into
archival storage. You can store an AIP in any number of preconfigured
directories. For instructions to configure AIP storage locations, see
Administrator manual - Storage Service.

5. From the Action dropdown menu, select the AIP storage location from the
pre-configured set of options.

.. seealso::

   For information on viewing and managing stored AIPs go to Archival storage.

   For information on uploading the DIP, go to Access.


:ref:`Back to the top <ingest>`
