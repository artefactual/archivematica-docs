.. _appraisal:

=========
Appraisal
=========

The Appraisal tab provides a space between Transfer and Ingest for archivists to
decide which files from transfers should become SIPs and how these files should
be arranged within the SIP. It includes features for examining the
characteristics and contents of the files as well as for connecting files to
finding aids created in ArchivesSpace. The Arrange a SIP from Backlog feature,
found in previous versions of Archivematica, also has moved to the Appraisal tab
(see :ref:`Arrangement <arrangement>`).

.. note::

   If you are running :ref:`Archivematica without Elasticsearch
   <install-elasticsearch>` or with limited Elasticsearch functionality, the
   Appraisal tab may not appear in your dashboard.

*On this page:*

* :ref:`Transfers in the Backlog <backlog_pane>`
* :ref:`Analysis <analysis_pane>`
* :ref:`File List <File_list_pane>`
* :ref:`ArchivesSpace Resources <archivesspace_pane>`
* :ref:`Adding Files to ArchivesSpace Resources and Starting SIPs <adding_files_archivesspace>`
* :ref:`Arrangement <arrangement>`
* :ref:`Arranging a SIP for AtoM <arranging_sip_for_atom>`

.. _backlog_pane:

Transfers in the backlog
------------------------

Transfers that have been sent to the backlog can be found in the Backlog pane of
the Appraisal tab. Search the backlog by entering search terms and parameters in
the search box at the top of the page.

.. image:: images/search_backlog_2.*
   :align: center
   :width: 80%
   :alt: Search box for searching the backlog in the Appraisal tab

Adding Tags
===========

Tags can be added to selected files in the backlog by entering a tag name and
clicking the “Add tag to selected files” button at the top of the Backlog pane.

.. image:: images/tags_backlog.*
   :align: center
   :width: 60%
   :alt: Adding tags to files in the backlog

Tags that have already been created appear in the Tags drop-down menu. Choosing
a particular tag filters the files that appear within transfers in the Backlog
pane by that tag. Filters added in other panes in the Appraisal tab will also
appear listed under the Tags drop-down menu. Filters can be removed by clicking
the “x” next to them.

.. image:: images/adding_filters.*
   :align: center
   :width: 40%
   :alt: Filters as they appear below the tags drop-down menu

Tags can also be added from within the File list (see below).

.. _analysis_pane:

Analysis
--------

The analysis pane allows the user to explore files in transfers sent to the
backlog. Files selected in the Backlog pane populate the Analysis pane and can
be analyzed through four tabs: Objects, Tags, Examine Contents, and Preview
File.

1) Objects
==========

In the Objects tab, information about selected files can be viewed in the form
of a report or a visualization. The Report view provides information about the
files’ format, PUID, group, number of files, and size. Files can also be
analyzed through visualizations with options for representing the total number
of files in each format and for representing the total size of files for each
format represented in the list.

.. figure:: images/analysis_report.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Report view in the Analysis pane

   Report showing files selected in the Backlog pane


.. figure:: images/analysis_visualization.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: Visualization showing formats by total size of files

   Visualization showing formats by total size of the selected files

Files listed in Analysis can also be filtered by Format, PUID, and Group through
selecting values for these facets in the Report view. For instance, if the user
clicks on the Group “Portable Document Format” listed for one of the files, this
filter is added and only PDF files remain listed in the Analysis pane. Filters
appear under the Tags drop-down menu and can be removed by clicking the “x”
beside the name.

2) Tags
=======

The Tags tab lists any tags that have been added and how many of each tag are
present in the selected files.

.. image:: images/analysis_tags.*
   :align: center
   :width: 60%
   :alt: Tags tab in the analysis pane

3) Examine Contents
===================

If Examine Contents (using the tool `Bulk Extractor`_) was used during transfer,
the Examine Contents tab provides the reports created during this microservice.
This tab includes options for listing files that potentially contain personally
identifiable information (PII) or credit card numbers. Examine Contents also
includes an option for adding tags to these files.

.. figure:: images/analysis_examine_contents.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: Examine contents tab in the anaysis pane

   Examine contents tab showing a selected transfer where no files with PII were
   found

4) Preview File
===============

Files selected in the File List pane (see below) can be previewed in the Preview
File tab.

.. _File_list_pane:

File List
------------
The File List pane is also populated by selecting files in the Backlog
pane. File List provides information about the filenames, sizes, dates files
were last modified (if available), and any tags that have been added to the
selected files.

Any filters that have been applied in the Analysis pane or through the Tags
drop-down menu will affect what files appear in File List. In addition, a date
range can be added to filter files by the date they were last modified.

This pane also provides an option for adding tags. Files can be selected by
checking the checkbox next to their filename, creating a tag name, and clicking
“Add tag to selected files.” Tags can be removed from files by clicking the “-“
next to the tag name.

.. figure:: images/analysis_file_list.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: File list pane

   File list pane showing options for adding tags and filtering by date range


Clicking on the name of the file opens a preview in the Analysis pane.


.. image:: images/analysis_preview_file.*
   :align: center
   :width: 80%
   :alt: Preview file window in the Analysis pane

.. _archivesspace_pane:

ArchivesSpace Resources
-----------------------

The ArchivesSpace pane in the Appraisal tab allows for retrieving and adding to
resources that have been created in an ArchivesSpace repository. Settings for
ArchivesSpace DIP upload should be configured in the :ref:`Dashboard
administration tab <dashboard-admin>` to associate the ArchivesSpace repository.
In the ArchivesSpace pane, files transferred into Archivematica can be
associated with resources created in ArchivesSpace and SIPs can be sent to
Ingest.

ArchivesSpace Terms
===================

Finding aids in ArchivesSpace are called “resources” (i.e. fonds, collection,
record group, etc.). Lower levels of description nested under resources are
“archival objects” (series, files, items, etc.). Metadata about digital files is
managed separately as “digital objects” which can be associated with
resources/archival objects at any level of description. More information on
ArchivesSpace can be found at https://archivesspace.org/.

.. _searching-ArchivesSpace-resources:

Searching for ArchivesSpace Resources
=====================================

The search box at the top of the ArchivesSpace panel enables searching for
resources within an ArchivesSpace repository. A user can search by the title or
identifier of a resource.

ArchivesSpace resources can be expanded to show lower levels of description.
Folder icons indicate ArchivesSpace resources and archival objects that have
child records nested under them. Page icons indicate resources and archival
objects that do not have child records. Digital object components are designated
by the parallel lines icon.

.. note::

   Digital objects created and linked to resources in ArchivesSpace will
   not appear in the ArchivesSpace panel. However, digital objects added
   to a resource from within the ArchivesSpace panel are displayed.

.. image:: images/archivesspace_search.*
   :align: center
   :width: 60%
   :alt: ArchivesSpace pane with an ArchivesSpace resource expanded to show levels of hierarchy

Creating Archival Description
=============================

Options at the top of the ArchivesSpace pane allow for adding to and changing an
existing ArchivesSpace resource, such as adding new archival objects and digital
object components.

Selecting a resource or archival object and using “Add new child record” adds
a new archival object nested underneath the selected level of description.
Clicking this button brings up a dialog box for entering metadata. At a minimum,
a new archival object must have a title and a level of description, otherwise
“save” is not available.

.. image:: images/archivesspace_add_new_child.*
   :align: center
   :width: 60%
   :alt: Add new child record dialog box

The new archival object will appear in the ArchivesSpace pane and the change
will be reflected in the ArchivesSpace repository. The “Delete Selected” button
can be used to remove mistakenly created archival objects.

“Add New Digital Object Component” similarly allows for adding digital object
components to ArchivesSpace resources/archival objects.

.. note::

   Digital object components will not appear in the ArchivesSpace repository
   until later in the workflow when the AIP for the digital object is stored.

Both archival objects and digital object components can be created in the
ArchivesSpace pane at any level of description; however, new resources can only
be created in ArchivesSpace.

Basic metadata for existing archival objects and digital object components can
be edited using the “Edit Metadata” button.

.. image:: images/archivesspace_edit_metadata.*
   :align: center
   :width: 60%
   :alt: Edit metadata dialog box

“Edit Rights Metadata” leads to a form for adding PREMIS rights information.

.. figure:: images/archivesspace_edit_rights_metadata1.*
   :align: center
   :figwidth: 70%
   :width: 100%
   :alt: Form for adding rights information

   Click "Add" to add rights.

.. figure:: images/archivesspace_edit_rights_metadata2.*
   :align: center
   :figwidth: 70%
   :width: 100%
   :alt: Adding PREMIS rights information

   Specify the type of rights information from the drop-down menu and fill out
   the relevant fields.

The form for adding rights includes two pages of fields. Once added, acts can be
edited or deleted and further acts can be added.

.. image:: images/archivesspace_edit_rights_metadata3.*
   :align: center
   :width: 70%
   :alt: Added rights in Archivematica

.. note::

   Rights can only be added at the SIP level.

.. _adding_files_archivesspace:

Adding Files to ArchivesSpace Resources and Starting SIPs
---------------------------------------------------------

Transfer files in backlog can easily be associated with ArchivesSpace resources
by dragging and dropping files from the Backlog pane to digital object
components in the ArchivesSpace pane.

To add files to ArchivesSpace resources:

1. Search the backlog by entering terms and parameters in the search box at the
   top of the page. For a list of all transfers in backlog, simply click within
   the search box leaving the edit field blank, and then click **Search transfer
   backlog**.

2. Click **ArchivesSpace** to enable the ArchivesSpace panel, :ref:`search by
   title or identifier of a resource <searching-ArchivesSpace-resources>`, and
   then click **Search ArchivesSpace**. A hierarchical view of the resource is
   displayed.

3. Create digital object components within the ArchivesSpace panel by clicking
   **Add new digital object**. Digital object components must be created in the
   Appraisal tab.

.. note::

   Digital objects created and linked to resources in ArchivesSpace will not
   appear in the Appraisal tab.

4. Now click and drag files in the Backlog panel to digital object components in
   the ArchivesSpace panel.

.. image:: images/backlog_and_archivesspace.*
   :align: center
   :width: 80%
   :alt: Backlog and analysis panes

.. note::

   One file or directory from a transfer can be moved at a time. A file can only
   be added once to an ArchivesSpace resource. Files that have been added to a
   digital object component will appear with a strike-through in the backlog.

5. Once all files have been added and the arrangement has been set, SIPs can be
   started in Ingest. Select the resource/archival object and click
   **Finalize arrangement**. SIPs can be created from ArchivesSpace archival
   objects at any level of description.

.. tip::

   Before starting a SIP in the ArchivesSpace panel, verify that all required
   metadata associated with an ArchivesSpace resource is in place, particularly
   at the parent-level of the arrangement. In ArchivesSpace, verify that a
   material description record is linked to an agent record.

.. _arrangement:

Arrangement
-----------

The arrangement pane provides options for appraising and arranging files from
the backlog for users not using ArchivesSpace.

Files from the Backlog pane can be dragged to the Arrangement pane to arrange
the files and create SIPs. To find files to include in the SIPs, search the
backlog by entering search terms and parameters in the search box at the top of
the page. Tick the "Show metadata & logs directory" box to include these in the
search results.

.. image:: images/search_results_with_logs.*
   :align: center
   :width: 80%
   :alt: Search results with logs and metadata files

Only those objects from the transfer that are eligible for inclusion in the SIP
will appear without a strikethrough (e.g. "Landing_zone.jpg and MARBLES.TGA")

In the Arrangement pane use the “Add directory” button to create a structure for
the SIP. Use the same button to create separate SIP directories or to create
nested sub-directories. Drag and drop the transfer directory(ies) and/or
object(s) you wish to arrange from the Backlog pane to the Arrangement pane.
By dragging and dropping, you can create an arrangement structure for your SIP.
Note that all metadata, submission documentation, and other associated data is
also copied to the arrange pane with your object(s).

Once all relevant files have been dragged from the Backlog pane to directories
in Arrangement, select the top-level directory corresponding to the intended
SIP, and click “Create SIP” to send the SIP to Ingest. Other directories will
remain in the Arrange pane until arrangement is complete and they are sent to
Ingest.

Creating SIPs with tags
=======================
You can also use tags as a quick way to generate new SIPs. Tags can be added to
selected files in the Backlog pane by entering a tag name and clicking the “Add
tag to selected files” button at the top of the Backlog pane.

At the top of the Arrangement pane you can select a tag and press "Create SIP".
Archivematica will automatically generate a new SIP and send it to Ingest using
all the files that share this tag and using the tag as the SIP name.

.. image:: images/create_sip_from_tag.*
   :align: center
   :width: 80%
   :alt: Creating a SIP from a tag


.. _arranging_sip_for_atom:

Arranging a SIP for AtoM
------------------------

If you plan to create a DIP to :ref:`Upload to AtoM <upload-atom>`, you may wish
to add levels of description to your directories and/or objects. Archivematica
will add a logical structMAP to the METS file, which AtoM will use to create
information objects, applying the chosen levels of description. Note that if you
do not apply a level of description to a digital object, AtoM will automatically
assign it the level of "item".

This functionality is supported with AtoM 2.2 and higher.

#. Select a directory or object in the Arrange pane. Click the *Edit metadata*
   button to choose the level of description.

   .. image:: images/choose_lod.*
      :align: center
      :width: 80%
      :alt: Choosing the AtoM level of description

#. As you add levels of description they will be shown in the arrange pane for
   you to review before finalizing your SIP.

   .. image:: images/view_arrangement.*
      :align: center
      :width: 70%
      :alt: Viewing levels of description applied to SIP

.. note::

   To have the AtoM levels of description appear you must have entered your AtoM
   credentials in Administration. See :ref:`Administer, AtoM DIP upload
   <dashboard-atom>`. Levels of description in AtoM are managed as a taxonomy.
   To edit, see :ref:`Terms <atom:terms>`.

.. tip::

   If you choose not to assign levels of description to directories in SIP
   arrange, AtoM will flatten the DIP so that all digital objects are
   child-level descriptions of the target description.

:ref:`Back to the top <appraisal>`

.. _`Bulk Extractor`: https://www.forensicswiki.org/wiki/Bulk_extractor
