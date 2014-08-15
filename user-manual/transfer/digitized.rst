.. _digitized:

==============================
Processing digitization output
==============================

If an institution has created master and derivative digitized objects,
Archivematica can recognize the relationships between them and generate a DIP
from access or service copies included in the transfer.

For digitized output with pre-existing access derivatives:

1. In the top level of the transfer directory, create a subdirectory called
access (no capitalization).

2. Place the master digital objects in the transfer directory.

3. Place the access copies in the access directory. Note: the master and
access copies must have the same filename, although the extensions can be
different. For example, image-1.tif (master) and image-1.jpg (access).

4. Process the transfer.

5. At the normalization step, choose "Do not normalize".

6. Archivematica will keep the master digital objects in the AIP and generate
a DIP from the copies in the access directory.


For digitized output with pre-existing service copies:

1. If there are service copies (for example, intermediate-state video formats
that may be edited versions of the master copies), in the the top level of the
transfer directory create a subdirectory called service (no capitalization).
Place the service copies in this subdirectory. As with the access copies, the
filenames must match those of the master digitized objects.

2. If there is an access directory with access derivatives, process the
transfer as before, choosing "Do not normalize". Archivematica will generate a
DIP from the objects in the access directory. If there are no access
derivatives, choose "Normalize service files for access"; Archivematica will
generate access derivatives from the service copies.

3. The service copies will be retained along with the master digitized objects
in the AIP and Archivematica will capture their derivation relationships in
the AIP METS file.

4. A sample digitization output transfer is included in Archivematica's
sampledata: sampledata/SampleTransfers/DigitizationOutput.


.. seealso::

   For a detailed example of one institution's digitized output ingest
   workflow using Archivematica 0.8, see City of Vancouver's digital
   conservator, Sue Bigelow's presentation on Slideshare:
   `Archivematica 0.8 for Digitized Content <http://www.slideshare.net/sbigelow/using-archivematica-08-for-digitized-content>`_.

:ref:`Back to the top <digitized>`
