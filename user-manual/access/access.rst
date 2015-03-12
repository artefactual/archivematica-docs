.. _access:

======
Access
======

During ingest, access copies of digital objects are generated and packaged
into a DIP (Dissemination Information Package). The user uploads the DIP to
the access system. Please note the user must create the description in AtoM
(or other access system) before uploading the DIP. The user will need to
indicate part of the description's URL or a target collection in order to send
the DIP to the appropriate place in the description.

Should you run into an error during this process, please see
:ref:`Error handling <error-handling>`.

.. seealso::

   :ref:`Upload DIP to ContentDM <dip-contentdm>`

   :ref:`Upload DIP metadata to Archivists' Toolkit <archivists-toolkit>`


*On this page:*

* :ref:`Default access system <access-default>`
* :ref:`Upload DIP to AtoM <upload-atom>`
* :ref:`Store DIP <store-dip>`
* :ref:`Access tab <access-tab>`

.. _access-default:

Default access system
---------------------

A content management tool called `AtoM <https://www.accesstomemory.org>`_ is
Archivematica's default access system. AtoM supports standards-compliant
hierarchical archival description and digital object management.

AtoM stands for Access to Memory. It is a web-based, open source application
for standards-based archival description and access in a multilingual, multi-
repository environment. User and Administrator manuals for AtoM are available
`here <https://www.accesstomemory.org/en/docs/>`_ .

To configure Archivematica for uploading the DIP to AtoM, see the
:ref:`Administrator manual - AtoM DIP upload <admin-dashboard-atom>`.

.. _upload-atom:

Upload DIP to AtoM
------------------

.. important::

   The user must create the target description in AtoM before uploading the
   DIP. The user will need to indicate part of the description's URL or a
   target collection in order to send the DIP to the appropriate place during
   DIP upload

In this example, we will upload a DIP to a sample description in AtoM called
"Sample fonds".

1. In the ingest tab, select "Upload DIP to AtoM" in the upload DIP Actions
drop-down menu.

2. A dialogue box will appear.

Enter the permalink of the description in the dialogue box: sample-fonds

.. tip::

   The permalink is the "slug" from the AtoM target description.
   See :ref:`slug <atom:slug>` in the AtoM glossary.

3. Click the blue "Upload" button.

Digital objects are uploaded as items within the description to which the DIP
is being uploaded.

If you want to create a child level of description under the target
description, you must add the title of that level of description using the DC
metadata template prior to normalization.

4. When the DIP has finished uploading, open the Access tab in the dashboard.
This tab shows the AIP and its uploaded DIP. Click on the DIP URL to go to the
uploaded DIP in AtoM.

5. If you are not already logged in to AtoM you will need to log in using your
login credentials.

6. You will see an archival description with the metadata you added during
ingest, displayed in the context of the level of archival description to which
the DIP was uploaded. To view an individual digital object, scroll
through the thumbnails on the left of the screen and click on an image.

7. Below, the digital is object displayed in AtoM.

Clicking on the image will open the uploaded object.

.. _store-dip:

Store DIP
---------

Archivematica also provides the option to store the DIP to a location that you
have configured via the :ref:`Storage Service <storageservice:index>`. This can
be configured to be a local server, NFS-mounted or another storage protocal such
as DuraCloud.

To store a DIP:

1. Ensure that at least one DIP storage location has been configured in the
:ref:`Storage Service <storageservice:index>`.

2. When prompted to Upload DIP, choose Store DIP.

3. Choose the DIP storage location from the configured options.

The DIP will include the access copies made through either Archivematica's
normalization rules or a manual normalization process, and the METS file.

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
