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
those who subscribe to a hosted service.

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

You can use one DuraCloud space for multiple purposes (e.g. one DuraCloud space
could be used as both the AIP storage and transfer backlog), but we recommend
managing these package types separately by creating DuraCloud spaces that are
dedicated to the space's purpose. You do not have to create a space for all of
these purposes, just those relevant your particular configuration. For AIP
storage and DIP storage you can create multiple locations within DuraCloud.

To add a space in DuraCloud, log in with administrator credentials and click on
**Add Space**. You can give the space whatever name you wish.

.. _duracloud-storage-service:

Configure the Archivematica Storage Service
-------------------------------------------

The :ref:`Archivematica Storage Service <storageservice:index>` was installed
when you installed Archivematica.

#. In the Storage Service's Spaces tab, click **Create new space** and fill out
   the form following the instructions in the :ref:`DuraCloud Storage Service
   documentation <storageservice:duracloud>`.

#. You must create a space for each storage location that you have created in
   DuraCloud. For example, if you have AIP storage and DIP storage locations in
   DuraCloud, you should create two spaces by repeating the instructions in Step
   1.

#. In the Storage Service, navigate to the **Spaces** tab. You should see all
   of the DuraCloud spaces that you created in Steps 1 and 2.

#. For each space, you need to create a corresponding :ref:`location
   <storageservice:locations>`. Click on **Create Location here** to create a
   storage location and enter the following information:

   * **Purpose**: The purpose of the space (AIP storage, DIP storage, or
     transfer backlog.)
   * **Pipeline**: Click on the pipeline name so that it is highlighted.
   * **Relative path**: The name of the space exactly as it appears in DuraCloud
     (e.g. ``aip-store``.)
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

.. important::

   When you are configuring the location, you must enter the name of the space
   exactly as it appears in the DuraCloud user interface. Please ensure that the
   relative path does not include a leading slash.

:ref:`Back to the top <duracloud-setup>`

.. _DuraCloud documentation: https://wiki.lyrasis.org/display/DURACLOUD/DuraCloud
.. _DuraSpace Downloads page: https://wiki.lyrasis.org/display/DURACLOUD/DuraCloud+Downloads
