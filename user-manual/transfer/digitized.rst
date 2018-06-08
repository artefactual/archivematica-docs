.. _digitized:

==============================
Processing digitization output
==============================

During a digitization project, it is common to create a master digital object (such
as a high-resolution TIFF) as well as an access or service copy of the object (such
as a lower-resolution JPG). Archivematica can recognize the relationship between
the master and access or service versions of the object and use them to generate
a DIP.

Generating a DIP using access derivatives
-----------------------------------------

#. Place the master digital objects in the transfer directory.

#. In the top level of the transfer directory, create a subdirectory called *access*
   (no capitalization).

#. Place the access copies in the access directory. The master and access
   copies must have the same filename, although the extensions can be different -
   for example, image-1.tif (master) and image-1.jpg (access).

#. Process the transfer.

#. At the normalization microservice, choose "Do not normalize".

#. Archivematica will keep the master digital objects in the AIP and generate a
   DIP from the copies in the access directory.


Generating a DIP using service files
------------------------------------

#. Place the master digital objects in the transfer directory.

#. Create a subdirectory called *service* (no capitalization). Place the service
   copies in this subdirectory.  The master and service copies must have the same
   filename, although the extensions can be different - for example, image-1.tif
   (master) and image-1.jpg (service).

#. If there is an access directory created as per the instructions above, process
   the transfer as before, choosing "Do not normalize" at the normalization
   microservice. Archivematica will generate a DIP from the objects in the access
   directory.

#. If there are no access derivatives, choose "Normalize service files for access"
   at the normalization microservice. Archivematica will use the service copies
   as the basis for generating the access derivatives, instead of the master objects.

#. The service copies will be retained along with the master digitized objects in
   the AIP and Archivematica will capture their derivation relationships in the
   AIP METS file.

:ref:`Back to the top <digitized>`
