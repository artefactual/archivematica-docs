.. _access:

======
Access
======

During ingest, Archivematica can generate access copies of digital objects and
package them into a Dissemination Information Package (DIP). DIPs can be
uploaded to an access system or stored for future use. As a general rule, we
recommend only creating DIPs when you need them to save on storage space - you
can create DIPs on demand by :ref:`re-ingesting your AIP <reingest>` at a later
date.

After a DIP has been uploaded and/or stored it is moved to the uploadedDIPs
directory. If this data is no longer needed, the uploadedDIPs directory can be
cleared out. See :ref:`Processing storage usage <dashboard-usage>` for more
information.

Archivematica's Access tab displays DIPs that have been uploaded to AtoM or
Binder. It does not display DIPs that have been sent to other access systems,
like ArchivesSpace.

*On this page:*

* :ref:`Access systems <access-default>`
* :ref:`Upload a DIP to AtoM <upload-atom>`
* :ref:`Upload a DIP to Binder <upload-binder>`
* :ref:`Upload a DIP to ArchivesSpace <upload-as>`
* :ref:`Upload a DIP to Archivists' Toolkit <upload-at>`
* :ref:`Store DIP <store-dip>`
* :ref:`Review/Download DIP <review-dip>`
* :ref:`Access tab <access-tab>`

.. _access-default:

Access systems
--------------

If you have chosen to create a Dissemination Information Package (DIP) by
selecting either ``Normalize for preservation and access`` or ``Normalize for
access`` at the Normalization microservice, you can upload it to a content
management tool as a way of providing access to your archival material. For more
information on normalization options in Archivematica, please see
:ref:`Normalize <normalize>`.

The DIP includes access copies of the original digital objects in the transfer,
created through either Archivematica's normalization rules or a manual
normalization process. The DIP also includes a DIP METS file and, optionally,
a thumbnail for each digital object.

A content management tool called `AtoM`_  is Archivematica's default access
system. AtoM is a web-based, open source application for standards-based
archival description and access in a multilingual, multi- repository
environment. Access integration workflows also exist for `ArchivesSpace`_,
`Archivists' Toolkit`_ , `CONTENTdm`_, and `Binder`_.

.. _upload-atom:

Upload a DIP to AtoM
--------------------

To upload DIPs to your AtoM instance, you must enter your AtoM information and
credentials in the Administration tab. See :ref:`AtoM/Binder DIP upload
<admin-dashboard-atom>` for more information.

.. important::

   You must create the target description in AtoM **before** uploading the DIP.
   You will need to indicate part of the description's URL or a target
   collection in order to send the DIP to the appropriate place during DIP
   upload.

Digital objects uploaded to AtoM are added as children of the target description
and are by default given the level of description of ``item``. It is possible to
arrange your transfer to crate a hierarchy that AtoM will recognize by
:ref:`arranging materials for AtoM <hierarchical-dip>` on the Appraisal or
Ingest tab.

You can also :ref:`add descriptive metadata <add-metadata>` to your transfer
using either the metadata form or the metadata CSV file. This descriptive
metadata will be passed to AtoM. Note that the AtoM DIP upload integration
supports Dublin Core descriptive metadata only.

There are two ways to provide the target description to Archivematica. The first
is by providing the slug during the Upload DIP microservice.

1. Process your transfer. You must select ``Normalize for preservation and
   access`` or ``Normalize for access`` at the Normalization microservice. When
   you reach the Upload DIP microservice, select "Upload DIP to AtoM/Binder"
   from the drop-down menu.

2. A dialogue box will appear. Enter the permalink of the description in the
   dialogue box. For example, if the URL of the archival description is
   http://myAtoM.ca/my-target-description;rad, enter ``my-target-
   description``. See ``slug`` in the `AtoM glossary`_ for more information.

.. image:: images/atom-dip-upload.*
   :align: center
   :width: 60%
   :alt: Image shows a popup window where a user can enter the slug for an AtoM description

3. Click the blue "Upload" button. Digital objects will be uploaded as child
   items within the target description.

4. When the DIP has finished uploading, open the Access tab in the dashboard.
   This tab shows the AIP and the uploaded DIP. Note that due to a known issue,
   if you want to navigate to the uploaded DIP using the link provided, you must
   manually edit the URL to remove ``/sword/deposit``.

5. Check the target description in AtoM. The digital object(s) should be
   displayed as child objects of the record.

In a more automated environment, you can add the slug to the **Access system
ID** box when you are setting up your transfer. Archivematica will automatically
grab this value when it reaches the Upload DIP microservice.

1. Create a new transfer. In the ``Access system ID`` box, enter the permalink
   of the description in the dialogue box. For example, if the URL of the
   archival description is http://myAtoM.ca/my-target-description;rad, enter
   ``my-target-description``. See ``slug`` in the `AtoM glossary`_ for more
   information.

.. image:: images/atom-access-system-id.*
   :align: center
   :width: 60%
   :alt: Image shows new transfer with an AtoM slug defined as the access system identifier

2. Process your transfer. You must select ``Normalize for preservation and
   access`` or ``Normalize for access`` at the Normalization microservice. When
   you reach the Upload DIP microservice, select "Upload DIP to AtoM/Binder"
   from the drop-down menu (or set this as the preconfigured choice in the
   processing configuration).

3. Check the target description in AtoM. The digital object(s) should be
   displayed as child objects of the record.

.. _upload-metadata-atom:

Metadata-only upload to AtoM
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In Archivematica 1.6 and higher, you can send AIP object metadata to AtoM
without uploading access copies of the files. This may be a helpful workflow if
you have digital objects which you wish to make discoverable but you can't
display online for copyright or privacy reasons.

.. important::

   AtoM 2.4 or higher is required to use this workflow.

.. note::

   The following AtoM-Archivematica workflows are not currently supported
   with this workflow:

   * Descriptive metadata: if descriptive metadata is included by csv or
     entering in the user interface, the metadata will not display in AtoM
     in this workflow.
   * SIPs with levels of description assigned using the :ref:`arranging for AtoM
     <hierarchical-dip>` workflow - the levels of description will be ignored in
     this workflow.

1. Navigate to Archival Storage and search or browse for the AIP. Click on the
   name of the AIP, or "View".

2. Under "Actions," in the Upload DIP tab enter the slug of the AtoM description
   you wish to upload to.

.. image:: images/metadata_only_upload.*
   :align: center
   :width: 80%
   :alt: Entering the slug of the AtoM description to upload metadata to

3. Upon successful upload, AtoM will have created a File level description for
   the AIP and an Item level description for each object.

.. image:: images/metadata_only_atom_1.*
   :align: center
   :width: 90%
   :alt: AtoM description showing uploaded content

Each item will have a generic thumbnail associated with it and digital object
metadata about the original object, including filename, filesize, date uploaded,
object and AIP UUIDs, format name, format version, format registry and key.

.. image:: images/metadata_only_atom_2.*
   :align: center
   :width: 90%
   :alt: AtoM description showing uploaded item with digital object metadata

.. _upload-binder:

Upload a DIP to Binder
----------------------

To upload DIPs to your Binder instance, you must enter your Binder information
and credentials in the Administration tab. See :ref:`AtoM/Binder DIP upload
<admin-dashboard-atom>` for more information.

.. important::

   You must create the target resource in binder **before** uploading the DIP.
   You will need to indicate the resource's identifier in order to send the DIP
   to the appropriate place during DIP upload.

DIPs can be uploaded to an artwork record or a supporting technology record in
Binder.

There are two ways to provide the target resource to Archivematica. The first is
by providing the identifier during the Upload DIP microservice.

1. Process your transfer. You must select ``Normalize for preservation and
   access`` or ``Normalize for access`` at the Normalization microservice. When
   you reach the Upload DIP microservice, select "Upload DIP to AtoM/Binder"
   from the drop-down menu.

2. A dialogue box will appear. Enter the identifier for the resource in the
   dialogue box, preceded by either ``ar:`` for an artwork record or ``tr:`` for
   a supporting technology record. For example, if the identifier for an artwork
   record is "2", enter ``ar:2``.

.. image:: images/binder-dip-upload.*
   :align: center
   :width: 60%
   :alt: Image shows a popup window where a user can enter identifier for the resource in Binder

3. Click the blue "Upload" button. The DIP will be uploaded to Binder and
   connected to the appropriate resource.

In a more automated environment, you can add the identifier to the **Access
system ID** box when you are setting up your transfer. Archivematica will
automatically grab this value when it reaches the Upload DIP microservice.

1. Create a new transfer. In the ``Access system ID`` box, enter the identifier
   for the resource, preceded by either ``ar:`` for an artwork record or ``tr:``
   for a supporting technology record. For example, if the identifier for an
   artwork record is "2", enter ``ar:2``.

.. image:: images/binder-access-system-id.*
   :align: center
   :width: 60%
   :alt: Image shows new transfer with a Binder identifier defined as the access system ID

2. Process your transfer. You must select ``Normalize for preservation and
   access`` or ``Normalize for access`` at the Normalization microservice. When
   you reach the Upload DIP microservice, select "Upload DIP to AtoM/Binder"
   from the drop-down menu (or set this as the preconfigured choice in the
   processing configuration).

3. Check the target description in AtoM. The digital object(s) should be
   displayed as child objects of the record.

.. _upload-as:

Upload a DIP to ArchivesSpace
-----------------------------

To upload DIPs to your ArchivesSpace instance, you must enter your ArchivesSpace
information and credentials in the Administration tab. See
:ref:`ArchivesSpace dashboard configuration <dashboard-AS>` for more
information.

Create a SIP using the :ref:`Transfer <transfer>` process as normal.
During Normalization, choose one of the options that normalizes the package for
access. During the Upload DIP micro-service, select Upload DIP to Archives
Space. The Match page should automatically open.

#. Find the ArchivesSpace collection to which you would like to upload the DIP.
   By clicking on the name of the resource, you can drill down into the
   collection to upload the DIP at a lower level of description.

#. When you have navigated to the level of description where you want to store
   the DIP, select *Assign DIP objects to this resource*.

#. On the Assign Objects screen, select which objects you would like to assign
   to which resources. Using the filter boxes in the top right allow you to
   search for specific objects or resources by name.

#. Once you have selected the objects and the resource you would like to pair
   them with, click *Pair* in the top right corner. Repeat steps 2-4 as needed.

#. When you are done pairing objects and resources, click on *Review matches.*

#. To remove all pairs and restart, click on *Restart matching*.

#. If everything is correct, click on *Finish matching*.

This will take you back to the Ingest tab, where you can finish ingesting the
AIP.

Alternatively, you can manually create the matches and place them in the
metadata folder of the transfer in a file named `archivesspaceids.csv`. For
example, given the following transfer tree::

  pictures
  ├── extra
  │   └── oakland03.jp2
  ├── Landing zone.jpg
  ├── MARBLES.TGA
  └── metadata
    └── archivesspaceids.csv

The CSV file needs two columns, one with a relative path to the original file
in the transfer directory and the other with the `Ref ID` from the ArchivesSpace
Archival Object, which can be obtained from the "Basic information" section in
the Archival Object view page. E.g.::

  "Landing zone.jpg",49807e9587de87dbafb459b34bd20b78
  MARBLES.TGA,468050a6add84d6d89d47a975ce5440f
  extra/oakland03.jp2,40caf1e2dd47675a92e25011c190fed5

If the `Upload DIP to ArchivesSpace` option is selected in the working
processing configuration, the CSV file will be used to create the matches in
the upload. Otherwise, after selecting `Upload DIP to ArchivesSpace` in the
ingest tab you will be taken to the Match page and, to check the matches
created from the CSV file instead of creating new ones, you can click directly
on `Review matches` and finalize or restart the matching.

.. _upload-at:

Upload a DIP to Archivists' Toolkit
-----------------------------------

To upload DIPs to your Archivists' Toolkit instance, you must enter your
Archivists' Toolkit information and credentials in the Administration tab.
See :ref:`Archivists' Toolkit dashboard configuration <dashboard-AT>` for more
information.

Create a SIP using the :ref:`Transfer <transfer>` process as normal. During
Normalization, choose one of the options that normalizes the package for access.
During the Upload DIP micro-service, select Upload DIP to Archivists' Toolkit.
The Match page should automatically open.

#. A page will open allowing the user to select the Archivists' Toolkit
   collection where the objects should be added. This page allows the user to
   match digital objects to resource components in Archivists' Toolkit.

#. Archivematica will upload the DIP metadata to Archivists' Toolkit.


.. _store-dip:

Store DIP
---------

Archivematica also provides the option to store the DIP to a location that you
have configured via the :ref:`Storage Service <storageservice:index>`. This can
be configured to be a local server, NFS-mounted or another storage protocol such
as DuraCloud.

To store a DIP:

#. Ensure that at least one DIP storage location has been configured in the
   :ref:`Storage Service <storageservice:index>`.

#. At the Store DIP job at the Upload DIP microservice on the Archival Storage
   tab, choose Store DIP.

#. At Store DIP location, select the DIP storage location from the configured
   options.


.. _review-dip:

Review/download DIP
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

By clicking the Access tab in the Dashboard, you can see a table showing all
DIPs upload to AtoM or Binder including the URL, the associated AIP, the upload
date and status, and the option to delete from the Access tab. Note that this
link will delete the record of the DIP in the Access tab, not the actual DIP.

At this time, the Access tab only provides links to DIPs uploaded to AtoM, not
to other access systems or DIPs that have been stored.

:ref:`Back to the top <access>`

.. _`AtoM`: https://www.accesstomemory.org
.. _`ArchivesSpace`: http://archivesspace.org/
.. _`Archivists' Toolkit`: http://www.archiviststoolkit.org/
.. _`CONTENTdm`: http://www.oclc.org/en/contentdm.html
.. _`Binder`: https://binder.readthedocs.io/en/latest/contents.html
.. _`AtoM glossary`: https://www.accesstomemory.org/docs/latest/user-manual/glossary/glossary/
