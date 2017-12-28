.. _access:

======
Access
======

During ingest, access copies of digital objects can be generated and packaged
into a DIP (Dissemination Information Package) by choosing Normalize for Access 
at the Normalization micro-service. For more information please see :ref:`Normalize <normalize>`

The user uploads the DIP to the access system, or stores it for future use.

When the DIP is prepared, Archivematica moves the DIP into the uploadDIP
directory, which triggers the dashboard to display the DIP upload options
to the operator. After a DIP is uploaded/stored, it is moved to the
uploadedDIPs directory, which can be emptied in the Administration tab- see
:ref:`Processing storage usage <dashboard-usage>`.

.. note::

   The user must create the description in AtoM (or other access system) before
   uploading the DIP. The user will need to indicate part of the description's
   URL or a target collection in order to send the DIP to the appropriate place
   in the description.

Should you run into an error during this process, please see
:ref:`Error handling <error-handling>`.

.. seealso::

   :ref:`Upload DIP to ContentDM <dip-contentdm>`

   :ref:`Upload DIP metadata to Archivists' Toolkit <archivists-toolkit>`


*On this page:*

* :ref:`Access systems <access-default>`
* :ref:`Upload DIP to AtoM <upload-atom>`
* :ref:`Upload DIP to ArchivesSpace <upload-as>`
* :ref:`Upload DIP to Archivists' Toolkit <upload-at>`
* :ref:`Store DIP <store-dip>`
* :ref:`Review/Download DIP <review-dip>`
* :ref:`Access tab <access-tab>`


.. _access-default:

Access systems
--------------

If you have chosen to generate a DIP (dissemination information package) at the 
Normalize micro-service, you can upload it to one of several content management 
tools (listed below).

The DIP includes the access copies made through either Archivematica's
normalization rules or a manual normalization process, as well as thumbnails, 
and a DIP METS file.

A content management tool called `AtoM <https://www.accesstomemory.org>`_ is
Archivematica's default access system. AtoM supports standards-compliant
hierarchical archival description and digital object management.

AtoM stands for Access to Memory. It is a web-based, open source application
for standards-based archival description and access in a multilingual, multi-
repository environment. User and Administrator manuals for AtoM are available
`here <https://www.accesstomemory.org/en/docs/>`_ .

Archivematica has also been developed to integrate with `ArchivesSpace <http://archivesspace.org/>`_ and `Archivists' Toolkit <http://www.archiviststoolkit.org/>`_ and `ContentDM <http://www.oclc.org/en/contentdm.html>`_


.. _upload-atom:

Upload DIP to AtoM
==================

To upload DIPs to your AtoM instance, you must enter your AtoM
information and credentials in the Administration tab. See :ref:`Administrator manual - AtoM DIP upload <admin-dashboard-atom>` for more information.

.. important::

   You must create the target description in AtoM before uploading the
   DIP. You will need to indicate part of the description's URL or a
   target collection in order to send the DIP to the appropriate place during
   DIP upload.

1. In the ingest tab, select "Upload DIP to AtoM" in the Upload DIP Actions drop-down menu.

2. A dialogue box will appear. Enter the permalink of the description in the dialogue box.

.. tip::

   The permalink is the "slug" from the AtoM target description.
   See ``slug`` in the AtoM glossary.

3. Click the blue "Upload" button. Digital objects are uploaded as items within the description to which the DIP is being uploaded. If you want to create a child level of description under the target description, you must add the title of that level of description using the DC metadata template prior to normalization.

.. IMPORTANT::
    If you :ref:`add metadata <add-metadata>` to the DIP during Ingest, a file-level record will be created in AtoM below the chosen parent record. The metadata will be written to this file-level record and the digital objects will be added as child items. If you do not add metadata, the digital objects will be added to the parent record directly.

4. When the DIP has finished uploading, open the Access tab in the dashboard. This tab shows the AIP and its uploaded DIP.

5. If you are not already logged in to AtoM you will need to log in using your login credentials.

6. You will see an archival description with the metadata you added during ingest, displayed in the context of the level of archival description to which the DIP was uploaded. To view an individual digital object, scroll through the thumbnails click on an image.

7. The digital object is displayed in AtoM. Clicking on the image will open the uploaded object.

.. _upload-metadata-atom:

Upload metadata to AtoM
=======================

In Archivematica 1.6 and higher, you can send AIP object metadata to AtoM without uploading dissemination copies of the files. This may be a helpful workflow if you have digital objects which you wish to make discoverable, but not displayed online for copyright or privacy reasons.

.. important::

   AtoM 2.4 or higher is required to use this workflow.

.. note::

   The following AtoM-Archivematica workflows are not currently supported with this workflow:

   * Descriptive metadata: if descriptive metadata is included by csv or entering in the user interface, the metadata will not display in AtoM in this workflow.
   * SIPs with levels of description assigned using the :ref:`arranging for AtoM <hierarchical-dip>` workflow- the levels of description will be ignored in this workflow.

1. Navigate to Archival Storage and search or browse for the AIP. Click on the name of the AIP, or "View".

2. Under "Actions," in the Upload DIP tab enter the slug of the AtoM description you wish to upload to.

.. image:: images/metadata_only_upload.*
   :align: center
   :width: 80%
   :alt: Entering the slug of the AtoM description to upload metadata to

3. Upon successful upload, AtoM will have created a File level description for the AIP and an Item level description for each object.

.. image:: images/metadata_only_atom_1.*
   :align: center
   :width: 90%
   :alt: AtoM description showing uploaded content

Each item will have a generic thumbnail associated with it and digital object metadata about the original object, including filename, filesize, date uploaded, object and AIP UUIDs, format name, format version, format registry and key.

.. image:: images/metadata_only_atom_2.*
   :align: center
   :width: 90%
   :alt: AtoM description showing uploaded item with digital object metadata


.. _upload-as:

Upload DIP to ArchivesSpace
===========================

To upload DIPs to your ArchivesSpace instance, you must enter your ArchivesSpace
information and credentials in the Administration tab. See :ref:`ArchivesSpace dashboard
configuration <dashboard-AS>` for more information.

Create a SIP using the :ref:`Transfer <transfer>` process as normal. During Normalization, choose one of
the options that normalizes the package for access. During the Upload DIP micro-service,
select Upload DIP to Archives Space. The Match page should automatically open.

#. Find the ArchivesSpace collection to which you would like to upload the DIP. By clicking on the name of the resource, you can drill down into the collection to upload the DIP at a lower level of description.

#. When you have navigated to the level of description where you want to store the DIP, select *Assign DIP objects to this resource*.

#. On the Assign Objects screen, select which objects you would like to assign to which resources. Using the filter boxes in the top right allow you to search for specific objects or resources by name.

#. Once you have selected the objects and the resource you would like to pair them with, click *Pair* in the top right corner. Repeat steps 2-4 as needed.

#. When you are done pairing objects and resources, click on *Review matches.*

#. To remove all pairs and restart, click on *Restart matching*.

#. If everything is correct, click on *Finish matching*.

This will take you back to the Ingest tab, where you can finish ingesting the AIP.

Alternatively, you can manually create the matches and place them in the metadata folder of the transfer in a file named `archivesspaceids.csv`. For example, given the following transfer tree::

  pictures
  ├── extra
  │   └── oakland03.jp2
  ├── Landing zone.jpg
  ├── MARBLES.TGA
  └── metadata
    └── archivesspaceids.csv

The CSV file needs two columns, one with a relative path to the original file in the transfer directory and the other with the `Ref ID` from the ArchivesSpace Archival Object, which can be obtained from the "Basic information" section in the Archival Object view page. E.g.::

  "Landing zone.jpg",49807e9587de87dbafb459b34bd20b78
  MARBLES.TGA,468050a6add84d6d89d47a975ce5440f
  extra/oakland03.jp2,40caf1e2dd47675a92e25011c190fed5

If the `Upload DIP to ArchivesSpace` option is selected in the working processing configuration, the CSV file will be used to create the matches in the upload. Otherwise, after selecting `Upload DIP to ArchivesSpace` in the ingest tab you will be taken to the Match page and, to check the matches created from the CSV file instead of creating new ones, you can click directly on `Review matches` and finalize or restart the matching.

.. _upload-at:

Upload DIP to Archivists' Toolkit
=================================

To upload DIPs to your Archivists' Toolkit instance, you must enter your Archivists' Toolkit
information and credentials in the Administration tab. See :ref:`Archivists' Toolkit
dashboard configuration <dashboard-AT>` for more information.

Create a SIP using the :ref:`Transfer <transfer>` process as normal. During Normalization,
choose one of the options that normalizes the package for access. During the Upload DIP
micro-service, select Upload DIP to Archivists' Toolkit. The Match page should
automatically open.

#. A page will open allowing the user to select the Archivists' Toolkit collection where the objects should be added. This page allows the user to match digital objects to resource components in Archivists' Toolkit.

#. Archivematica will upload the DIP metadata to Archivists' Toolkit.


.. _store-dip:

Store DIP
---------

Archivematica also provides the option to store the DIP to a location that you
have configured via the :ref:`Storage Service <storageservice:index>`. This can
be configured to be a local server, NFS-mounted or another storage protocol such
as DuraCloud.

To store a DIP:

#. Ensure that at least one DIP storage location has been configured in the :ref:`Storage Service <storageservice:index>`.

#. At the Store DIP job at the Upload DIP microservice on the Archival Storage tab, choose Store DIP.

#. At Store DIP location, select the DIP storage location from the configured options.


.. _review-dip:

Review/Download DIP
-------------------

Regardless of the access path chosen (an integrated access system, or storing
the DIP) the dashboard will present the operator with the option of reviewing
and downloading the DIP objects. When the Upload DIP micro-service is complete,
a "review" link will appear:

.. image:: images/ReviewDIP.*
   :align: center
   :width: 80%
   :alt: Click on the "review" link in the Upload DIP micro-service

This will present the operator with a page displaying the uploadedDIPs directory
which can then be navigated to locate any DIP in this directory. As shown below,
when expanded, the DIP objects, thumbnails and METS files can be viewed or
downloaded within the browser window.

.. image:: images/DownloadDIP.*
   :align: center
   :width: 80%
   :alt: Download DIP screen showing a DIP directory expanded.

Your ability to view the objects in the browser will be dependent on your browser
having plugins for the particular filetypes. However, all files can be
downloaded locally in this manner.


.. _access-tab:

Access tab
----------

By clicking the Access tab in the Dashboard, you can see a table showing all DIPs
upload to AtoM including the URL, the associated AIP, the upload date and status,
and the option to delete from the Access tab. Note that this link will delete the
record of the DIP in the Access tab, not the actual DIP.

At this time, the Access tab only provides links to DIPs uploaded to AtoM, not
to other access systems or DIPs that have been stored.

:ref:`Back to the top <access>`
