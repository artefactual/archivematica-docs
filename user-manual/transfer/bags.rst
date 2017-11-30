.. _bags:

================================
Library of Congress Bagit format
================================

Archivematica allows the ingest of the
`Library of Congress Bagit <http://en.wikipedia.org/wiki/BagIt>`_ format. Users
can ingest both zipped and unzipped bags. Bags must be packaged in accordance
with the Bagit specification.

* To ingest a zipped bag, user selects transfer type "Zipped bag" from the
  dropdown menu in the transfer tab of the Dashboard. Do not add the directory
  that the zipped bag is in from the browse dialog, just select the zipped file
  (.zip). Note that you cannot add a new title to the zipped bag transfer, but
  you can add an accession number.

.. image:: images/ZippedBag-10.*
   :align: center
   :width: 80%
   :alt: Zipped bag transfer in dashboard

* To ingest an unzipped bag, user selects transfer type "Unzipped bag" from
  the dropdown menu in the transfer tab of the Dashboard. You may add a new name
  or accession number to this unzipped bag.

.. image:: images/BagTransfer-10.*
   :align: center
   :width: 100%
   :alt: Unzipped bag transfer in dashboard


.. _bag-metadata:

Index and search bag metadata
-----------------------------

In Archivematica 1.4 and higher, fields in the bag-info.txt file are indexed as
source metadata in the Archivematica METS file, making their contents
searchable in the Archival storage tab after a bag transfer has been processed
and stored.

Labels in bag-info.txt file serialized as XML in METS sourceMD, linked to the
objects directory of the AIP.

Sample bag-info.txt (from https://tools.ietf.org/html/draft-kunze-bagit-10)

.. code:: bash

   Source-Organization: Spengler University
   Organization-Address: 1400 Elm St., Cupertino, California, 95014
   Contact-Name: Edna Janssen
   Contact-Phone: +1 408-555-1212
   Contact-Email: ej@spengler.edu
   External-Description: Uncompressed greyscale TIFF images from the Yoshimuri papers colle...
   Bagging-Date: 2008-01-15
   External-Identifier: spengler_yoshimuri_001
   Bag-Size: 260 GB
   Payload-Oxum: 279164409832.1198
   Bag-Group-Identifier: spengler_yoshimuri
   Bag-Count: 1 of 15
   Internal-Sender-Identifier: /storage/images/yoshimuri
   Internal-Sender-Description: Uncompressed greyscale TIFFs created from microfilm and are...</pre>

Sample AIP METS file result:

.. code:: bash

   <pre><mets:amdSec ID="amdSec_14">
     <mets:sourceMD ID="sourceMD_1">
       <mets:mdWrap MDTYPE="OTHER" OTHERMDTYPE="BagIt">
         <mets:xmlData>
           <transfer_metadata>
             <Source-Organization>Spengler University</Source-Organization>
             <Organization-Address>1400 Elm St., Cupertino, California, 95014</Organization-Address>
             <Contact-Name>Edna Janssen</Contact-Name>
             <Contact-Phone>+1 408-555-1212</Contact-Phone>
             <Contact-Email>ej@spengler.edu</Contact-Email>
             <External-Description> Uncompressed greyscale TIFF images from the Yoshimuri papers colle...</External-Description>
             <Bagging-Date>2008-01-15</Bagging-Date>
             <External-Identifier>spengler_yoshimuri_001</External-Identifier>
             <Bag-Size>260 GB</Bag-Size>
             <Payload-Oxum>279164409832.1198</Payload-Oxum>
             <Bag-Group-Identifier>spengler_yoshimuri</Bag-Group-Identifier>
             <Bag-Count>1 of 15</Bag-Count>
             <Internal-Sender-Identifier>/storage/images/yoshimuri</Internal-Sender-Identifier>
             <Internal-Sender-Description>Uncompressed greyscale TIFFs created from microfilm and are...</Internal-Sender-Description>
           </transfer_metadata>
         </mets:xmlData>
       </mets:mdWrap>
     </mets:sourceMD>
   </mets:amdSec></pre>

.. note::

   To be parsed into the METS file, Bag labels must be compliant with XML, so
   cannot contain spaces or forbidden characters.

To search the bag (transfer) metadata in the Archival Storage tab:

.. image:: images/bag-metadata.*
   :align: center
   :width: 80%
   :alt: Search interface using transfer metadata fields


Use keyword field "Transfer metadata" to search all the contents of the
<transfer_metadata> container in the METS file (as indexed in Elasticsearch).

Use keyword field "Transfer metadata (other)" to search individual fields in
the <transfer_metadata> container.  When the user selects "Transfer metadata
(other)" a separate box will appear which will allow the user to enter the
label of the specific field to be searched.

To search on a date range in <transfer_metadata> or one if its sub-fields, the
user enters two dates in ISO date format separated by a colon. For example,
``2015-01-03:2015-04-14``.

:ref:`Back to the top <bags>`.
