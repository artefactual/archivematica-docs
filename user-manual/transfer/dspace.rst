.. _dspace:

==============
DSpace exports
==============

Archivematica can act to facilitate a "dark archive" for a DSpace repository -
i.e. providing back-end preservation functionality while DSpace remains the
user deposit and access system.

.. note::

   Archivematica has been tested using exports from DSpace 1.7.x. Ingest has
   not been tested on exports from DSpace 1.8.x; however, there were no changes
   in the DSpace AIP export structure between 1.7.x and 1.8.x so it is
   anticipated that performance will be identical.

1. The transfer should be structured similar to the one in Archivematica's
sample data at sampledata/SampleTransfers/DSpaceExport. This is a standard
DSpace export with one DSpace AIP for the collection-level description and one
for each of the deposited objects.

.. image:: images/DSpace1g.*
   :align: center
   :width: 80%
   :alt: A DSpace export with collection and item-level zipped files

.. note::

   The inclusion of the collection level export (eg aip_1314.zip) is not
   mandatory.


2. A typical zipped item folder will contain the uploaded object plus a
license file, a METS file and possibly an OCR text file. An example is shown
below:

.. image:: images/DSpace2g.*
   :align: center
   :width: 80%
   :alt:  A DSpace item export

* bitstream_39691_txt = the OCR text file

* bitstream_8272.pdf = the object deposited in DSpace

* bitstream_8273 = the license file

* mets.xml = the METS file for the item

3. To process, configure the source directory containing the transfer in the
Administration tab of the browser. See Administrator manual - Transfer source
directories

4. In the transfer tab, use the dropdown menu to select the DSpace transfer
type.

.. image:: images/UploadDSpaceTransfer.*
   :align: center
   :width: 80%
   :alt: DSpace transfer type


Then, browse to the appropriate source directory and add your DSpace export.

.. image:: images/AddDSpace.*
   :align: center
   :width: 80%
   :alt: Add DSpace export from source directory


5. When the DSpace transfer has loaded to the dashboard, click Start Transfer
to begin processing.

.. image:: images/DSpaceTransferMicros.*
   :align: center
   :width: 80%
   :alt: DSpace transfer micro services

6. At the normalization step, choose "Normalize for preservation".

.. image:: images/DSpaceNormForPres.*
   :align: center
   :width: 80%
   :alt: Select Normalize for preservation for DSpace export

7. The METS file for the AIP will show fileGrps for the different file types:
original, submissionDocumentation (the mets.xml files), preservation, license
and text/ocr. It also contains Xpointers to descriptive and rights metadata in
the original mets.xml files exported from DSpace.

.. image:: images/DSpace3g.*
   :align: center
   :width: 80%
   :alt: An excerpt from a METS file for an Archivematica AIP that has been
         generated from a DSpace export

:ref:`Back to the top <dspace>`
