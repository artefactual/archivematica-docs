.. _duracloud-setup:

==================================
Using DuraCloud with Archivematica
==================================

DuraCloud is a hosted cloud storage platform from DuraSpace. For more
information about DuraCloud, please see the `DuraCloud documentation`_.

Setting up the DuraCloud integration requires configuration of Archivematica's
Storage Service. It is recommended that you read the :ref:`Storage Service
documentation <storageservice:administrators>` before configuring DuraCloud.

This guide can be used by those who wish to install Archivematica and/or
DuraCloud locally and run the systems themselves and may also be helpful for
those who subscribe to a hosted service. `ArchivesDirect`_ is an Archivematica
in DuraCloud hosting plan offered by Artefactual Systems and DuraSpace.

*On this page*

* :ref:`Configure DuraCloud <duracloud-config>`
* :ref:`Configure the Archivematica Storage Service <duracloud-storage-service>`

.. _duracloud-config:

Configure DuraCloud
-------------------

Your DuraCloud instance must have at least two users:

* A **Client user** who has *read* permissions for the AIP storage and DIP
  storage locations.

* An **Archivematica user** who has *read/write* permissions for the AIP
  storage, DIP storage, and transfer backlog locations.

DuraCloud can be used as a storage space for the following :ref:`purposes
<storageservice:location-purposes>` within Archivematica:

* **AIP storage**: A DuraCloud space where completed AIPs are placed for
  long-term storage.
* **DIP storage**: A DuraCloud space where DIPs can be stored. Note that it is
  not necessary to store DIPs if you are sending them directly to an access
  system.
* **Transfer backlog**: A DuraCloud space used by Archivematica for material
  sent to the :ref:`backlog <backlog>` during processing.

To add a space in DuraCloud, log in with administrator credentials and click on
**Add Space**. You can give the space whatever name you wish. You do not have to
create a space for all of these purposes, just those relevant your particular
configuration. For AIP storage and DIP storage you can create multiple locations
within DuraCloud.

.. _duracloud-storage-service:

Configure the Archivematica Storage Service
-------------------------------------------

The :ref:`Archivematica Storage Service <storageservice:index>` was installed
when you installed Archivematica.

#. In the Storage Service's Spaces tab, click **Create new space** and enter the
   following information:

   * **Access protocol**: DuraCloud
   * **Size**: *This field is optional.*
   * **Path**: Leave this field blank.
   * **Staging path**: A location on your local disk where Archivematica can
     place files for staging purposes, for example
     ``var/archivematica/storage_service/duracloud_staging``
   * **Host**: Hostname of the DuraCloud instance, e.g. ``site.duracloud.org``
   * **Username**: The username for the Archivematica user that you created in
     DuraCloud.
   * **Password**: The password for the Archivematica user that you created in
     DuraCloud.
   * **Duraspace**: The name of the space in DuraCloud you are creating this
     Storage Service space for (e.g. transfer-source, aip-store, etc).

#. You must create a space for each storage location that you have created in
   DuraCloud. For example, if you have AIP storage and DIP storage locations in
   DuraCloud, you should create two spaces by repeating the instructions in Step
   1.

#. In the Storage Service, navigated to the **Spaces** tab. You should see all
   of the DuraCloud spaces that you created in Steps 1 and 2.

#. For each space, click on **Create Location here** to create a storage
   location. Enter the following information:

   * **Purpose**: The purpose of the space (AIP storage, DIP storage, or
     transfer source.)
   * **Pipeline**: Click on the pipeline name so that it is highlighted orange.
   * **Relative path**: the name of the space as it appears in DuraCloud (e.g.
     ``aip-store``.)
   * **Description**: A human-readable description of the location. This will be
     used in the Archivematica interface when you are choosing a AIP or DIP
     storage location.
   * **Quota**: *This field is optional.*
   * **Enabled**: Check this box to make the location available to the
     Archivematica pipeline.
   * **Set as global default location for its purpose**: Check this box if you
     would like this to be the default AIP or DIP storage location.
   * **Replicators**: The DuraCloud integration has not been tested with
     replication.

:ref:`Back to the top <duracloud-setup>`

.. _ArchivesDirect: https://duraspace.org/archivesdirect/
.. _DuraCloud documentation: https://wiki.duraspace.org/display/DURACLOUD/DuraCloud
.. _DuraSpace Downloads page: https://wiki.duraspace.org/display/DURACLOUD/DuraCloud+Downloads
