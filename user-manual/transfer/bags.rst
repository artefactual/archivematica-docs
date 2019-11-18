.. _bags:

========================
Unzipped and zipped bags
========================

Archivematica supports the ingest of materials packaged in accordance with the
Library of Congress `BagIt`_ specification. Users can ingest both zipped and
unzipped bags by using the appropriate :ref:`transfer type <transfer-types>`.

*On this page:*

* :ref:`Bag structure requirements <bag-structure-requirements>`
* :ref:`Unzipped bags <unzipped-bags>`
* :ref:`Zipped bags <zipped-bags>`
* :ref:`Adding metadata to bags <adding-metadata-bags>`
* :ref:`Index and search bag metadata <searching-bags>`

.. _bag-structure-requirements:

Bag structure requirements
--------------------------

Bags must adhere to requirements of the `BagIt`_ specification. If not,
Archivematica will error and files will be cleaned up and removed.

Some issues that can cause bags to inadvertently fail include:

* Invisible files were added to the bag after it has been created.
* Encoding requirements found in `bagit.txt` do not match the
  encoding of characters in `bag-info.txt`.

.. _unzipped-bags:

Unzipped bags
-------------

Unzipped bags can be created by hand or by using a BagIt tool like
`BagIt-python`_ or `Bagger`_. The bag must comply with the `BagIt`_
specification.

To ingest an unzipped bag, select **Unzipped bag** from the transfer type
dropdown menu in the Transfer tab and then select your material from the
transfer browser.

.. image:: images/unzipped-bag-transfer.*
   :align: center
   :width: 80%
   :alt: Unzipped bag transfer in dashboard

The screenshot above shows a simple bag containing three digital objects to be
preserved (``LICENSE``, ``README``, and ``TRADEMARK``) as well as the
accompanying files required by the BagIt specification (``bag-info.txt``,
``bagit.txt``, and a manifest file, in this case for sha512 checksums.) Note
that the digital objects to be preserved are within a subdirectory called
``data``.

For more information on processing your transfer, see :ref:`process transfer
<process-transfer>` on the Transfer page.

.. _zipped-bags:

Zipped bags
-----------

Zipped bags can be created by hand or by using a BagIt tool like `BagIt-python`_
or `Bagger`_. The bag must comply with the `BagIt`_ specification.

To ingest a zipped bag, select the transfer type **Zipped bag** from the
dropdown menu in the transfer tab of the Dashboard. When you open the transfer
browser, you will notice that only materials that use the compression formats
``.zip``, ``.tgz``, or ``tar.gz`` can be selected for transfer. These are the
only compressed formats that Archivematica accepts for zipped bag transfers.

.. image:: images/zipped-bag.*
   :align: center
   :width: 80%
   :alt: Zipped bag transfer in dashboard

The bag itself should be structured internally like an :ref:`unzipped bag
<unzipped-bags>`, as shown above.

Note that zipped bag transfers always use the name of the bag as the transfer
name.

For more information on processing your transfer, see :ref:`process transfer
<process-transfer>` on the Transfer page.

.. _adding-metadata-bags:

Adding descriptive/rights metadata and submission documentation to bags
-----------------------------------------------------------------------

Similar to standard transfers, it is possible to add descriptive and rights
metadata to unzipped and zipped bag transfers. See :ref:`Adding metadata to bags
<metadata-bags>` for more information.

.. _searching-bags:

Index and search bag metadata
-----------------------------

In Archivematica 1.4 and higher, fields in the ``bag-info.txt`` file are indexed
as source metadata in Elasticsearch, making their contents searchable in the
Archival Storage tab after the bag transfer has been stored.

Labels in the ``bag-info.txt`` file are serialized as XML in the METS
``sourceMD`` field and linked to the objects directory of the AIP.

For example, the bag-info.txt might include the following information (sample
provided via https://tools.ietf.org/html/draft-kunze-bagit-10).

.. code::

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
   Internal-Sender-Description: Uncompressed greyscale TIFFs created from microfilm and are...

When preserved in the resulting AIP's METS XML file, the above information is
represented like so:

.. code:: xml

   <mets:amdSec ID="amdSec_14">
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
   </mets:amdSec>

.. note::

   In order to be parsed into the METS file, bag-info.txt labels (i.e.
   Source-Organization) must be compliant with XML so they cannot contain
   spaces or forbidden characters.

The metadata contained within the ``<transfer_metadata>`` tags can now be used
for searching on the :ref:`Archival Storage <archival-storage>` tab.

Searching for any of the terms (i.e. ``Spengler University``) in the
bag-info.txt using the search parameter **Any** should display stored
packages that includes the search term in any field (or in the AIP name, etc. as
per :ref:`Searching the AIP store <search-aip>`).

.. image:: images/bag-info-basic-search.*
   :align: center
   :width: 80%
   :alt: The image shows a search carried out using the term "Spengler University" with the search parameter set to "Any" and the search type set to "Keyword"

In the above example, the AIP ``coyote`` contained the search phrase in the
descriptive metadata, rather than bag-info.txt. The other two AIPs contained
the search phrase in bag-info.txt.

You can narrow the search results to just search the metadata that comes from
bag-info.txt by selecting **Transfer metadata** as the search parameter. This
will search for anything within the ``<transfer_metadata>`` tags in the METS
file.

.. image:: images/bag-info-transfer-md-search.*
   :align: center
   :width: 80%
   :alt: The image shows a search carried out using the term "Spengler University" with the search parameter set to "Transfer metadata" and the search type set to "Keyword"

You can narrow the search results even further by using the **Transfer metadata
(other)** search parameter, which allows you to define the specific sub-field
within the ``<transfer_metadata>`` that you want to search. For example, you may
want to search for AIPs where the search phrase "Spengler University" is present
in the ``Source-Organization`` field, but not other fields.

.. image:: images/bag-info-transfer-md-other-search.*
   :align: center
   :width: 80%
   :alt: The image shows a search carried out using the term "Spengler University" with the search parameter set to "Transfer metadata (other)", the field name set to "Source-Organization", and the search type set to "Keyword"

To search on a date range in <transfer_metadata> or one if its sub-fields, the
user enters two dates in ISO date format separated by a colon. For example,
``2015-01-03:2015-04-14``.

:ref:`Back to the top <bags>`.

.. _BagIt: https://tools.ietf.org/html/rfc8493
.. _BagIt-python: https://github.com/LibraryOfCongress/bagit-python
.. _Bagger: https://github.com/LibraryOfCongress/bagger
