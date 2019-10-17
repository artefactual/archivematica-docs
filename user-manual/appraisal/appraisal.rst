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

* :ref:`Backlog pane <backlog_pane>`

  * :ref:`Tagging files <adding-tags>`

* :ref:`Analysis pane <analysis_pane>`

  * :ref:`Objects <analysis-objects>`
  * :ref:`Tags <analysis-tags>`
  * :ref:`Examine contents <analysis-examine-contents>`
  * :ref:`Preview file <analysis-preview-file>`

* :ref:`File list pane <file_list_pane>`
* :ref:`ArchivesSpace pane <archivesspace_pane>`

  * :ref:`ArchivesSpace terms <archivesspace-terms>`
  * :ref:`Searching for resources <archivesspace-searching>`
  * :ref:`Creating and editing archival descriptions <archivesspace-child-objects>`
  * :ref:`Adding rights metadata <archivesspace-rights-metadata>`
  * :ref:`Connecting digital objects to ArchivesSpace resources <archivesspace-digital-objects>`

* :ref:`Arrangement pane <arrangement>`

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

   Visualization showing total number of each format for the selected files

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

The ArchivesSpace pane in the Appraisal tab allow users to view ArchivesSpace
resources, add new child records and digital objects, and edit the resource
metadata. Materials that have been transferred into Archivematica can be
associated with resources created in ArchivesSpace. Arranging materials in the
ArchivesSpace pane results in a SIP that contains the materials connected to the
ArchivesSpace resouces.

To enable the ArchivesSpace integration, connect your ArchivesSpace instance to
Archivematica by adding credentials to the :ref:`ArchivesSpace DIP upload
<dashboard-AS>` section of the Administration tab.

.. _archivesspace-terms:

ArchivesSpace terms
^^^^^^^^^^^^^^^^^^^

* **Resources**: top-level descriptive metadata records or finding aids (for
  fonds, collections, record groups, etc.)
* **Archival objects**: lower-level description nested under resources (series,
  files, items, etc.)
* **Digital objects**: metadata about digital objects; can be associated with
  resources or archival objects at any level of description.

More information on ArchivesSpace can be found at https://archivesspace.org/.

.. _archivesspace-searching:

Searching for ArchivesSpace resources
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

When you open the ArchivesSpace pane, it will not be populated. You can populate
it with all resources by clicking on the **Search ArchivesSpace** button with
the *Title* and *Identifier* fields left blank.

Using the search box at the top of the ArchivesSpace pane, you can limit your
search results by the title or identifier of a resource.

Click on the caret (triangle) to expand and navigate through the resource's
hierarchy.

.. figure:: images/archivesspace-search.*
   :align: center
   :width: 60%
   :alt: ArchivesSpace pane showing the search results for "Hugh Acton", with the resulting resource expanded to show the resource's hierarchy

The folder icon indicates an ArchivesSpace resource or archival object that
has a child record nested beneath it in the hierarchy.

The page icon indicates an ArchivesSpace resources and archival objects that
does not have child record nested beneath it in the hierarchy.

Digital objects are designated by the parallel lines icon.

.. note::

   Digital objects that were created in ArchivesSpace will not appear in the
   ArchivesSpace pane in Archivematica. Only digital objects added to a resource
   from within Archivematica are displayed.

.. _archivesspace-child-objects:

Creating and editing archival objects
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

From the ArchivesSpace pane in Archivematica, users can add a new child archival
object to any existing resource or archival object.

#. Navigate to the resource or archival object you would like to add a child
   archival object to and click on the name of the resource or archival object.

#. Click **Add new child record**. A metadata box will pop up where you can
   enter basic metadata for the record. At a minimum, the new archival object
   must have a title and a level of description.

   .. figure:: images/archivesspace-add-new-child.*
      :align: center
      :width: 60%
      :alt: "Add new child record" dialog box, showing fields for title, level of description, general note, conditions governing access note, start date, end date, and date expression.

#. Click **Save** once you are satisfied with the metadata. The new child
   archival object will appear in the hierarchy, and will also be added to
   your ArchivesSpace repository.

#. To remove a resource or archival object, select the name of the resource or
   archival object and click **Delete selected**. Please note that this cannot
   be reversed, and that the deletion will happen in your ArchivesSpace
   repository as well.

#. To edit the title or level of description of a resource or archival object,
   select the name of the resource or archival object and click **Edit
   metadata**.

   .. figure:: images/archivesspace-edit-metadata.*
      :align: center
      :width: 60%
      :alt: "Edit metadata" dialogue box, showing fields to change the title or level of description.

.. _archivesspace-rights-metadata:

Adding rights metadata
^^^^^^^^^^^^^^^^^^^^^^

You can add rights metadata to a resource or archival object using the
ArchivesSpace pane in Archivematica. Archivematica uses `PREMIS rights`_ for
rights metadata.

.. important::

   Rights can only be added at the SIP level - that is, to the resource or
   archival object that will eventually become the SIP.

#. To add rights metadata to a resource or archival object, select the name of
   the resource or archival object and click **Edit rights metadata**. A new tab
   will open showing the metadata information page. Select **Add** under the
   Rights heading. This will open the first page of the rights metadata entry
   form.

   .. figure:: images/archivesspace-add-rights-basis.*
      :align: center
      :width: 80%
      :alt: Form for adding rights information.

#. Add the rights basis information for the resource or archival object and
   click **Save** to save the data.

#. Click **Next** to add the rights act. Once you are done adding the act
   information, click **Done**.

   .. figure:: images/archivesspace-add-rights-act.*
      :align: center
      :width: 80%
      :alt: Form for adding rights information.

#. Once you have saved your rights metadata, you can add another by selecting
   **Add** from the metadata information page again.

.. _archivesspace-digital-objects:

Connecting digital objects to ArchivesSpace resources
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Materials that are stored in the backlog can be associated with ArchivesSpace
resources by creating a digital object component and then dragging and dropping
files from the Backlog pane to the new digital object component in the
ArchivesSpace pane.

.. note::

   Digital object components will not appear in the ArchivesSpace repository
   until the AIP for the digital object is stored.

#. Populate the Backlog pane by doing a blank search using the search boxes at
   the top of the page, or narrow your search by entering search terms and
   parameters.

#. Populate the ArchivesSpace pane by doing a blank search using the search
   boxes in the ArchivesSpace pane, or :ref:`search by title or identifier of a
   resource <archivesspace-searching>`. A hierarchical view of the
   ArchivesSpace resources will be displayed in the pane.

#. Select the name of the resource or archival object for which you would like
   to create a digital object component and click **Add new digital object**.
   A digital object record will appear as a child of the resource or archival
   object.

   .. figure:: images/archivesspace-add-digital-object.*
      :align: center
      :width: 80%
      :alt: The left-hand side of the image shows the Backlog pane. The right hand side of the image shows the ArchivesSpace pane, with a new digital object record added as a child of "This is a new child record, 2005-2009".

      A new digital object has been added under the archival object titled "This is a new child record".

#. From the Backlog pane, select a digital object and drag it over to the new
   digital object record in the ArchivesSpace pane. Only one file or directory
   from a transfer can be moved at a time. A file can only be added once to an
   ArchivesSpace resource. Repeat this step as many times as needed.

   .. figure:: images/archivesspace-drag-from-backlog.*
      :align: center
      :width: 80%
      :alt: Backlog and analysis panes

      The file Landing_zone.jpg has been attached to the digital object record in the ArchivesSpace pane.

#. Once all files have been added and you are happy with the arrangement, select
   the name of the resource or archival object where materials have been
   arranged and click **Finalize arrangement**. This will start a SIP on the
   Ingest tab in Archivematica.

.. tip::

   Before you start the SIP in the ArchivesSpace pane, verify that all required
   metadata associated with an ArchivesSpace resource is in place, particularly
   at the parent-level of the arrangement. In ArchivesSpace, verify that the
   description record is linked to an agent record.

.. _arrangement:

Arrangement
-----------

The Arrangement pane allows users to organize materials stored in the backlog
before turning the material into a SIP. The Arrangement pane allows users to
combine material from multiple transfers into one SIP or, by only dragging and
dropping selected files, weed the transfer so that the resulting SIP only
includes the files that you would like to preserve.

.. _arrangement-drag-drop:

Arranging materials through drag-and-drop
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. Populate the Backlog pane by doing a blank search using the search boxes at
   the top of the page, or narrow your search by entering search terms and
   parameters.

   .. note::

      Files with a strikethrough cannot be dragged over to the arrangement tab, either
      because the file is a metadata or log file that will be added to the SIP
      automatically or because the file has already been included in another SIP.

#. In the Arrangement pane, click on **Add directory** to create a structure for
   the SIP. Use the same button to create separate SIP directories or to create
   nested sub-directories. To create a sub-directory, select the name of the
   parent directory before clicking **Add directory**.

#. Drag and drop the transfer directory and/or individual objects you wish
   to arrange from the Backlog pane to the Arrangement pane. Note that all
   metadata, submission documentation, and other associated data is also copied
   to the arrange pane with your object(s).

#. Once all relevant files have been dragged from the Backlog pane to
   directories in the Arrangement pane, select the top-level directory
   corresponding to the intended SIP, and click **Create SIP**. This will start
   a SIP on the Ingest tab.

Once your arrangement is complete and the SIP has been turned into an AIP for
long-term storage, you can delete any files remaining in the transfer that you
would like to discard by follow the instructions to :ref:`delete transfers
<backlog-delete>` on the Backlog tab.

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

.. note::

   To have the AtoM levels of description appear, you must configure the
   :ref:`AtoM integration <dashboard-atom>` in the Administration tab.

#. Select a directory or object in the Arrange pane. Click the *Edit metadata*
   button to choose the level of description.

   .. image:: images/choose_lod.*
      :align: center
      :width: 60%
      :alt: Choosing the AtoM level of description

#. As you add levels of description they will be shown in the arrange pane for
   you to review before finalizing your SIP.

   .. image:: images/view_arrangement.*
      :align: center
      :width: 60%
      :alt: Viewing levels of description applied to SIP

#. Once you have added the levels of description, click **Create SIP**. This
   will start a SIP on the Ingest tab.

.. important::

   If you choose not to assign levels of description to directories in SIP
   arrange, AtoM will flatten the DIP so that all digital objects are
   child-level descriptions of the target description.

.. _creating-sips-tags:

Creating a SIP using tags
^^^^^^^^^^^^^^^^^^^^^^^^^

You can also use tags as a quick way to generate new SIPs. For more information
on adding tags, see :ref:`tagging files <adding-tags>`.

#. Tag all of the material in the backlog that you would like to combine into
   one SIP.

#. At the top of the Arrangement pane, select a tag from the dropdown.

#. Click **Create SIP**. Archivematica will automatically generate a new SIP and
   send it to Ingest using all the files that share this tag and using the tag
   as the SIP name.

.. image:: images/create_sip_from_tag.*
  :align: center
  :width: 80%
  :alt: Creating a SIP from a tag

:ref:`Back to the top <appraisal>`

.. _Bulk Extractor: https://www.forensicswiki.org/wiki/Bulk_extractor
.. _PREMIS rights: http://www.loc.gov/standards/premis/
