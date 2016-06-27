.. _access_and_service:

===================================
Processing access and service files
===================================

If an institution has created master and derivative objects, Archivematica can
recognize the relationships between them and generate a DIP from access or service/mezzanine
copies included in the transfer.

Access copies
-------------

For transfers that include pre-existing access derivatives:

1. Place the master digital objects in the ``transfer`` directory.

2. In the top level of the transfer directory, create a subdirectory called ``access`` (no capitalization).

3. Place the access copies in the ``access`` directory.

.. IMPORTANT::
  The master and access copies must have the same filename, although the extensions
  can be different. For example, image-1.tif (master object) and image-1.jpg (access copy).

4. Process the transfer.

5. At the normalization step, choose "Do not normalize".

6. Archivematica will keep the master digital objects in the AIP and generate a DIP from the copies in the access directory.

.. NOTE::
  If you would like to assign levels of description to your content in order to
  upload content to AtoM, you must assign the levels of description to the master
  digital objects, not the access copies.

Service copies
--------------

For transfers that include pre-existing service or mezzanine copies (for example, intermediate-state video formats that may be edited versions of the master copies):

1. Place the master digital objects in the ``transfer`` directory.

2. In the the top level of the transfer directory, create a subdirectory called ``service`` (no capitalization).

3. Place the service copies in the ``service`` directory.

.. IMPORTANT::
  The master and service copies must have the same filename, although the extensions
  can be different. For example, image-1.tif (master object) and image-1.jpg (service copy).

4. If there is an access directory with access derivatives, process the transfer as before, choosing "Do not normalize". Archivematica will generate a DIP from the objects in the access directory. If there are no access derivatives, choose "Normalize service files for access." Archivematica will generate access derivatives from the service copies.

5. The service copies will be retained along with the master objects in the AIP and Archivematica will capture their derivation relationships in the AIP METS file.

6. A sample transfer that includes service files is included in Archivematica's sampledata: sampledata/SampleTransfers/DigitizationOutput.

.. NOTE::
  If you would like to assign levels of description to your content in order to
  upload content to AtoM, you must assign the levels of description to the master
  digital objects, not the service copies.

:ref:`Back to the top <access_and_service>`
