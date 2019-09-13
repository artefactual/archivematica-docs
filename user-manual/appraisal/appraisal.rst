.. _appraisal:

=========
Appraisal
=========

The Appraisal tab provides an opportunity for users to appraise and analyze the
files included in a transfer. The Appraisal tab includes features for examining
the characteristics and contents of the files, allows users to connect files to
finding aids created in ArchivesSpace, and lets users decide which files from a
transfer should be added to a SIP and how these files should be arranged within
the SIP.

In order to use the Appraisal tab, you must send the transfer to the backlog
when you reach the end of the :ref:`Transfer tab microservices
<transfer-tab-microservices>`.

.. note::

   If you are running :ref:`Archivematica without Elasticsearch
   <install-elasticsearch>` or with limited Elasticsearch functionality, the
   Appraisal tab may not appear in your dashboard.

*On this page:*

* :ref:`Backlog <backlog_pane>`

  * :ref:`Tagging files <adding-tags>`

* :ref:`Analysis <analysis_pane>`

  * :ref:`Objects <analysis-objects>`
  * :ref:`Tags <analysis-tags>`
  * :ref:`Examine contents <analysis-examine-contents>`
  * :ref:`Preview file <analysis-preview-file>`

* :ref:`File list <file_list_pane>`
* :ref:`ArchivesSpace <archivesspace_pane>`

  * :ref:`Adding files to ArchivesSpace resources and starting a SIP <adding_files_archivesspace>`

* :ref:`Arrangement <arrangement>`

  * :ref:`Arranging a SIP through drag-and-drop <arrangement-drag-drop>`
  * :ref:`Creating SIPs using tags <creating-sips-tags>`
  * :ref:`Adding AtoM levels of description <adding-atom-lod>`

.. _backlog_pane:

Backlog
-------

Transfers that have been sent to the backlog can be found in the Backlog pane of
the Appraisal tab. You can see everything in the backlog by doing a blank search
using the search boxes at the top of the page, or narrow your search by entering
search terms and parameters.

.. image:: images/backlog-search.*
   :align: center
   :width: 80%
   :alt: A simple search for "abcd", with results shown in the backlog pane.

The Backlog pane will display a list of transfer names. You can expand each one
by clicking on the yellow folder icon, or by selecting **Expand all**. Click on
**Collapse all** to collapse all open folders.

.. image:: images/backlog-search-expand-all.*
   :align: center
   :width: 60%
   :alt: The backlog pane with all search result folders expanded to show contents.

Tick **Show metadata & logs directory** to the right of the search boxes to
include metadata and log files in the search results, if you wish.

.. image:: images/backlog-search-md-logs.*
   :align: center
   :width: 60%
   :alt: Search results with logs and metadata files

There are two reasons that files may be shown greyed out and with a
strikethrough:

* The file is a metadata or log file and therefore cannot be manipulated by the
  user.
* The file has already been :ref:`arranged <arrangement>` into a SIP and
  therefore it no longer exists in the backlog - the entry is being maintained
  in the backlog pane for context.

.. _adding-tags:

Tagging files
^^^^^^^^^^^^^

The Backlog pane allows users to add a tag to a file in order to aid in
appraisal. The tag is not recorded in any way and does not persist beyond the
Appraisal tab.

#. Select one or more files in the Backlog pane by clicking on the file name. If
   you would like to add the tag to all of the files in a directory, select the
   directory name.

   .. image:: images/backlog-select-files.*
      :align: center
      :width: 60%
      :alt: Several files have been selected and are highlighted in blue.

#. Enter the tag name in the text box and select **Add tag to selected files**.

   .. image:: images/backlog-add-tag.*
      :align: center
      :width: 60%
      :alt: The selected files have the tag "keep" next to them.

#. To remove a tag, click on the minus sign next to the tag name.

Once you have created a tag, you can filter your search results to only show
files that have been tagged by selecting your tag from the **Tags** dropdown
below the search boxes at the top of the Appraisal page.

.. image:: images/backlog-tag-filter.*
   :align: center
   :width: 80%
   :alt: The backlog pane now only displays files with the "keep" tag.

Tags can also be added in the :ref:`File list pane<file_list_pane>`.

.. _analysis_pane:

Analysis
--------

The Analysis pane allows the user to analyse transfer materials in bulk as well
as individual files. Files selected in the Backlog pane populate the Analysis
pane and can be analyzed using four tabs: Objects, Tags, Examine contents, and
Preview file.

.. _analysis-objects:

Objects
^^^^^^^

The Objects tab of the Analysis pane displays format and size information about
selected files.

The Report view provides a list of information about the format, PRONOM unique
identifier (PUID), format group, number of files, and size of the selected
files.

.. figure:: images/analysis-objects-report.*
   :align: center
   :width: 80%
   :alt: The left-hand side of the image shows the backlog pane with a number of files selected. The right-hand side of the image shows information about those files, including the file format name, PUID, and size.

   Report showing information about the files that have been selected in the Backlog pane.

The Visualizations view provides two visualization options: the total number of
files for each format, or the total size of files for each format.

.. figure:: images/analysis-objects-visualizations.*
   :align: center
   :width: 80%
   :alt: The left-hand side of the image shows the backlog pane with a number of files selected. The right-hand side of the image shows a pie chart depicting the number of files for each format.

   Visualization showing formats by total size of the selected files

Files listed in Analysis can also be filtered by Format, PUID, and Group through
selecting values for these facets in the Report view. For instance, if the user
clicks on the Group “Portable Document Format” listed for one of the files, this
filter is added and only PDF files remain listed in the Analysis pane. Filters
appear under the Tags drop-down menu and can be removed by clicking the “x”
beside the name.

.. _analysis-tags:

Tags
^^^^

The Tags tab lists any tags that have been added and how many files with each
tag are present in the selected files.

.. image:: images/analysis-tags.*
   :align: center
   :width: 80%
   :alt: The left-hand side of the image shows the backlog pane with a number of files selected. The right-hand side of the image shows that 5 files have been given the tag "keep".

.. _analysis-examine-contents:

Examine contents
^^^^^^^^^^^^^^^^

During the Transfer process, users can choose whether or not to *Examine
contents*. This is a microservice that runs the tool `Bulk Extractor`_, a
forensics tool that scans the contents of a file to look for useful information.
Bulk Extractor looks for many different patterns, such as social security
numbers, credit card numbers, postal addresses, and email addresses.

On the Examine contents tab of the Analysis pane, users can review transfers to
see if any of the files contain PII (personally identifying information, or more
specifically American social security numbers) or credit card numbers.

.. figure:: images/analysis-examine-contents.*
   :align: center
   :width: 80%
   :alt: The left-hand side of the image shows the backlog pane with a transfer directory selected. The right-hand side of the image shows that one of the files in the transfer may contain credit card numbers.

   This transfer contains a file that may include credit card numbers.

Selecting the file name will show a preview of the data.

.. figure:: images/analysis-examine-contents-cc-data.*
   :align: center
   :width: 60%
   :alt: A list of credit card numbers is displayed in the Examine contents tab.

   The file clearly contains credit card data, with the credit card number shown
   in the "Content" column and the context for the number shown in the "Context"
   column.

Clicking on **Preview** will display the file in the Preview file tab, if
possible (see :ref:`Preview file <analysis-preview-file>`, below).

You can also add tags to files containing sensitive information by selecting the
checkbox next to the file name, adding a tag to the text box, and clicking **Add
tag to checked files**. The tag will appear attached to the file in the Backlog
pane.

.. note::

   More Bulk Extractor data can be reviewed by downloading the transfer
   from the Backlog tab.

.. _analysis-preview-file:

Preview file
^^^^^^^^^^^^

The Preview file pane allows users to take a look at a file without having to
download it to their computer. The preview window only works for files that can
be rendered in a browser - for example, JPEG images or MP3 audio files.

To preview a file, you must select it from the File list pane.

#. In the Backlog pane, select the file, or directory of files, that you would
   like to view.

#. Open the Analysis pane and click on the Preview file tab.

#. In the File list pane, select the file that you would like to preview. Image
   files will be displayed in the window; audio and video files will be
   displayed in a media player.

.. figure:: images/analysis-preview-file.*
   :align: center
   :width: 80%
   :alt: The left-hand column shows the backlog pane with a transfer directory selected. The right-hand colum shows a list of the files in the transfer. The centre column shows a media player with a file called bird.mp3 playing.

   The file *bird.mp3* being played in the Preview file tab.

.. _file_list_pane:

File list
---------

The File list pane is populated by selecting files in the Backlog pane. File
list provides information about the filenames, sizes, dates files were last
modified (if available), and any tags that have been added to the selected
files.

.. figure:: images/file-list.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: File list pane

Any filters that have been applied in the Analysis pane or through the Tags
drop-down menu will affect what files appear in File list.

You can sort the file list by clicking on the filename, size, or last modified
column headers.

You can add tags to files on the File list pane by selecting the checkbox
next to the file name, adding a tag to the text box, and clicking **Add tag to
selected files**. The tag will appear attached to the file in the Backlog pane
and in the Tags column on the File list pane. Click on the minus sign next to
the tag name to remove the tag.

Clicking on the name of the file will allow you to view the file, if possible,
in the :ref:`Preview file <analysis-preview-file>` tab of the Analysis pane.

You can also toggle the full file path on and off by clicking on **Show path**.

.. _archivesspace_pane:

ArchivesSpace
-------------

The ArchivesSpace pane in the Appraisal tab allows for retrieving and adding to
resources that have been created in an ArchivesSpace repository. Settings for
ArchivesSpace DIP upload should be configured in the :ref:`Dashboard
administration tab <dashboard-admin>` to associate the ArchivesSpace repository.
In the ArchivesSpace pane, files transferred into Archivematica can be
associated with resources created in ArchivesSpace and SIPs can be sent to
Ingest.

ArchivesSpace terms
^^^^^^^^^^^^^^^^^^^

Finding aids in ArchivesSpace are called “resources” (i.e. fonds, collection,
record group, etc.). Lower levels of description nested under resources are
“archival objects” (series, files, items, etc.). Metadata about digital files is
managed separately as “digital objects” which can be associated with
resources/archival objects at any level of description. More information on
ArchivesSpace can be found at https://archivesspace.org/.

.. _searching-ArchivesSpace-resources:

Searching for ArchivesSpace resources
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

Creating archival descriptions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

Adding files to ArchivesSpace resources and starting SIPs
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

.. _arrangement-drag-drop:

Arranging a SIP through drag-and-drop
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Files from the Backlog pane can be dragged to the Arrangement pane to arrange
the files and create SIPs. To find files to include in the SIPs, search the
backlog by entering search terms and parameters in the search box at the top of
the page.

Files with a strikethrough cannot be dragged over to the arrangement tab, either
because the file is a metadata or log file that will be added to the SIP
automatically or because the file has already been included in another SIP.

#. In the Arrangement pane, click on **Add directory** to create a structure for
   the SIP. Use the same button to create separate SIP directories or to create
   nested sub-directories.

#. Drag and drop the transfer directory and/or indiviual object(s) you wish
   to arrange from the Backlog pane to the Arrangement pane. By dragging and
   dropping, you can create an arrangement structure for your SIP. Note that all
   metadata, submission documentation, and other associated data is also copied
   to the arrange pane with your object(s).

#. Once all relevant files have been dragged from the Backlog pane to
   directories in the Arrangement pane, select the top-level directory
   corresponding to the intended SIP, and click **Create SIP** to send the SIP
   to Ingest. Note that any material that is not selected will remain in the
   Arrangement pane until arrangement is complete and they are sent to Ingest.

Using the method above, you can combine material from multiple transfers into
one SIP or, by only dragging and dropping selected files, weed the transfer so
that the resulting SIP only includes the files that you would like to preserve.

Once your arrangement is complete and the SIP has been turned into an AIP for
long-term storage, you can delete any files remaining in the transfer that you
would like to discard by follow the instructions to :ref:`delete transfers
<backlog-delete>` on the Backlog tab.

.. _creating-sips-tags:

Creating a SIP using tags
^^^^^^^^^^^^^^^^^^^^^^^^^

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

.. _adding-atom-lod:

Adding AtoM levels of description
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
