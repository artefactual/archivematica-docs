.. _appraisal:

======
Appraisal
======

The Appraisal tab provides a space between Transfer and Ingest for archivists to make decisions about what files from transfers should become SIPs and how these files should be arranged within the SIP. It includes features for examining the characteristics and contents of the files as well as for connecting files to finding aids created in ArchivesSpace. The Arrange a SIP from Backlog feature, found in previous versions of Archivematica, also has moved to the Appraisal tab (see :ref:`Arrangement <arrangement>`).

*On this page:*

* :ref:`Transfers in the Backlog <backlog_pane>`
* :ref:`Analysis <analysis_pane>`
* :ref:`File List <File_list_pane>`
* :ref:`ArchivesSpace Resources <archivesspace_pane>`
* :ref:`Adding Files to ArchivesSpace Resources and Starting SIPs <adding_files_archivesspace>`
* :ref:`Arrangement <arrangement>`

.. _backlog_pane:

Transfers in the Backlog
------------
Transfers that have been sent to the backlog can be found in the Backlog pane of the Appraisal tab. Search the backlog by entering search terms and parameters in the search box at the top of the page.

.. image:: images/search_backlog.*
   :align: center
   :width: 60%
   :alt: Search box for searching the backlog in the Appraisal tab

Adding Tags
=========
Tags can be added to selected files in the backlog by entering a tag name and clicking the “Add tag to selected files” button at the top of the Backlog pane.

.. image:: images/tags_backlog.*
   :align: center
   :width: 60%
   :alt: Adding tags to files in the backlog
   
Tags that have already been created appear in the Tags drop-down menu. Filtering by a particular tag causes only files to which that tag has been applied to appear in transfers in the Backlog pane. Filters added in other panes in the Appraisal tab will also appear listed under the Tags drop-down menu. Filters can be removed by clicking the “x” next to them.

.. image:: images/adding_filters.*
   :align: center
   :width: 60%
   :alt: Filters as they appear below the tags drop-down menu

.. _analysis_pane:

Analysis
------------

The analysis pane allows the user to explore files in transfers sent to the backlog. Files selected in the Backlog pane populate the Analysis pane and can be analyzed through four tabs: Objects, Tags, Examine Contents, and Preview File.

1) Objects
=========
In the Objects tab, information about selected files can be viewed in the form of a report or a visualization. The Report view provides information about the files’ format, PUID, group, number of files, and size. Files can also be analyzed through visualizations with options for representing the total number of files in each format and for representing the total size of files with each format represented in the list.

.. figure:: images/analysis_report.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: Report view in the Analysis pane

   Report showing files selected in the Backlog pane

   
.. figure:: images/analysis_visualization.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: Visualization showing formats by total size of files
   
   Visualization showing formats by total size of files for files selected in the Backlog pane
   
Files listed in Analysis can also be filtered by Format, PUID, and Group through selecting values for these facets in the Report view. For instance, if the user clicks on the Group “Portable Document Format” listed for one of the files, this filter is added and only PDF files remain listed in the Analysis pane. Filters appear under the Tags drop-down menu and can be removed by clicking the “x” beside the name.

2) Tags
=========
The Tags tab lists any tags that have been added and how many of each tag are present in the selected files.

.. image:: images/analysis_tags.*
   :align: center
   :width: 80%
   :alt: Tags tab in the analysis pane

3) Examine Contents
=========
If Examine Contents (using the tool Bulk Extractor) was used during transfer, the Examine Contents tab provides the reports created during this micro-service. This tab includes options for listing files that potentially contain personally identifiable information (PII) or credit card numbers. Examine Contents also includes the option to add tags to these files. 

.. figure:: images/analysis_examine_contents.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Examine contents tab in the anaysis pane
   
   Examine contenst tab showing a selected transfer where no files with PII were found

4) Preview File
=========
Files selected in the File List pane (see below) can be previewed in the Preview File tab.

.. _File_list_pane:

File List
------------
The File List pane is also populated through selecting files in the Backlog pane. File List provides information about the filenames, sizes, dates files were last modified (if available), and any tags that have been added to the selected files.

Any filters that have been applied in the Analysis pane or through the Tags drop-down menu will affect what files appear in File List. In addition, a date range can be added to filter files by the date they were last modified. 

This pane also provides the option for adding tags. Files can be selected by checking the checkbox next to their filename, creating a tag name, and clicking “Add tag to selected files.” Tags can be removed from files by clicking the “-“ next to the tag name.

Clicking on the name of the file opens a preview in the Analysis pane.

.. figure:: images/analysis_file_list.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: File list pane
   
   File list pane showing adding tags and filtering by date range

.. _archivesspace_pane:

ArchivesSpace Resources
-----------------
The ArchivesSpace pane in the Appraisal tab allows for retrieving and adding to resources that have been created in an ArchivesSpace repository. Settings for ArchivesSpace DIP upload should be configured in the :ref:`Dashboard administration tab <dashboard-admin>` to associate the ArchivesSpace repository. In the ArchivesSpace pane, files transferred into Archivematica can be associated with resources created in ArchivesSpace and SIPs can be sent to Ingest.

ArchivesSpace Terms 
=========
Finding aids in ArchivesSpace are called “resources” (i.e. fonds, collection, record group, etc.). Lower levels of description nested under resources are “archival objects” (series, files, items, etc.). Metadata about digital files is managed separately as “digital objects” which can be associated with resources/archival objects at any level of description. More information on ArchivesSpace can be found at http://archivesspace.org/

Searching for ArchivesSpace Resources
=============
The search box at the top of the ArchivesSpace panel allows for searching for resources within an ArchivesSpace repository. A user can search by the title or identifier of a resource.

ArchivesSpace resources can be expanded to show lower levels of description. Folder icons indicate ArchivesSpace resources and archival objects which have child records nested under them. Page icons indicate resources and archival objects that do not have child records. Digital object components are designated by the parallel lines icon.

.. image:: images/archivesspace_search.*
   :align: center
   :width: 80%
   :alt: ArchivesSpace pane with an ArchivesSpace resource expanded to show levels of heirarchy

Creating Archival Description
========
Options at the top of the ArchivesSpace pane allow for adding to and changing an existing ArchivesSpace resource, such as adding new archival objects and digital object components. 

Selecting a resource or archival object and using “Add New Child Record” adds a new archival object nested underneath the selected level of description. Clicking this button brings up a dialog box for entering metadata. At a minimum, a new archival object must have a title and a level of description, otherwise “save” is not available. 

.. image:: images/archivesspace_add_new_child.*
   :align: center
   :width: 80%
   :alt: Add new child record dialog box 

The new archival object will appear in the ArchivesSpace pane and the change will be reflected in the ArchivesSpace repository. The “Delete Selected” button can be used to remove mistakenly created archival objects.

“Add New Digital Object Component” similarly allows for adding digital object components to ArchivesSpace resources/archival objects. 

.. note::
Digital object components will not appear in the ArchivesSpace repository until later in the workflow when the AIP for the digital object is stored. 

Both archival objects and digital object components can be created in the ArchivesSpace pane at any level of description; however, new resources can only be created in ArchivesSpace. 

Basic metadata for existing archival objects and digital object components can be edited using the “Edit Metadata” button. 

.. image:: images/archivesspace_edit_metadata.*
   :align: center
   :width: 60%
   :alt: Edit metadata dialog box 

“Edit Rights Metadata” leads to a form for adding PREMIS rights information. 

.. figure:: images/archivesspace_add_rights_metadata1.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Adding PREMIS rights information
   
   Click "Add" to add rights.
   
   .. figure:: images/archivesspace_add_rights_metadata2.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: Form for adding rights information
   
   Specify the type of rights information from the drop-down menu and fill out the relevant fields.

The form for adding rights includes two pages of fields. Once added, acts can be edited or deleted and further acts can be added.

.. image:: images/archivesspace_add_rights metadata3.*
   :align: center
   :width: 60%
   :alt: Added rights in Archivematica

.. note::
Rights can only be added at the SIP level. 


.. _adding_files_archivesspace:

Adding Files to ArchivesSpace Resources and Starting SIPs
-----------
Files from transfers in the Backlog pane can be associated with ArchivesSpace resources by dragging files from the backlog to digital object components. 

.. image:: images/backlog_and_archivesspace.*
   :align: center
   :width: 80%
   :alt: Backlog and analysis panes  

Digital object components must be created in the Appraisal tab (digital objects created and linked to resources in ArchivesSpace will not appear in the Appraisal tab). 

One file or directory from a transfer can be moved at a time. A file can only be added once to an ArchivesSpace resource. Files that have been added to a digital object component will appear with a strike-through in the backlog.

Once all files have been added to their place in the arrangement, SIPs can be started in Ingest by selecting the resource/archival object and clicking “Finalize Arrangement.” SIPs can be created from any level of description (i.e. a SIP can be started for an entire resource or from an archival object within a resource such as a series).

.. _arrangement:

Arrangement
---------
The Arrangement pane replaces the Arrange a SIP from Backlog feature from previous versions of Archivematica. This pane provides options for appraising and arranging files from the backlog for users not using ArchivesSpace.

Files from the Backlog pane can be dragged to the Arrangement pane to arrange the files and create SIPs. 

To create structure within the SIP or to create multiple SIPs, use “Add directory.” This button can be used to create separate directories or to create directories nested within other directories.  

Once all relevant files have been dragged from the Backlog pane to directories in Arrangement, select the top-level directory corresponding to the intended SIP, and click “Create SIP” to send the SIP to Ingest. Other directories will remain in the Arrange pane until arrangement is complete and they are sent to Ingest.

:ref:`Back to the top <appraisal>`
