.. _dublin_core:

============================
Dublin Core in Archivematica
============================

General description
-------------------

The use of `Dublin Core`_ descriptive metadata is supported in Archivematica
through both import and manual entry.

For instructions on importing metadata with a transfer, please see
:ref:`Import metadata <import-metadata>`.

For instructions on adding descriptive metadata through the user interface
during ingest, please see :ref:`Add metadata <add-metadata>`.

Artefactual's archival description software, `AtoM (Access to Memory)`_ provides
a field-by-field description of the Dublin Core metatadata template :ref:`here
<atom:dc-template>`.

Metadata handling
-----------------

When descriptive metadata is added through either of the methods described above,
Archivematica handles this metadata by parsing it to the METS file. For example:


.. code:: bash

      <dmdSec ID="dmdSec_1">
       <mdWrap MDTYPE="DC">
          <xmlData>
             <dublincore xsi:schemaLocation="http://purl.org/dc/elements/1.1 http://dublincore.org/schemas/xmls/qdc/dc.xsd http://purl.org/dc/terms/ http://dublincore.org/schemas/xmls/qdc/2008/2/11/dcterms.xsd">
               <title>Stanley Park in December</title>
               <issued>1996-01-17</issued>
               <subject>Vancouver (B.C.)--Parks</subject>
               <subject>Landscapes</subject>
               <description>Image shows Brockton Oval after light snowfall</description>
               <publisher>Riley Studios, Vancouver B.C.</publisher>
               <contributor>Don Langfield, photographer</contributor>
               <date>1992-12-04</date>
               <isPartOf>Riley Studios collection</isPartOf>
               <rights>Copyright held by Riley Studios</rights>
               <format>image/jp2</format>
              </dublincore>
          </xmlData>
         </mdWrap>
      </dmdSec>

When a DIP is sent to :ref:`AtoM <upload-atom>`, Dublin Core metadata is parsed
into the appropriate fields in the AtoM descriptive template. Descriptive metadata
is also indexed in the Archival Storage tab in Archivematica; search results will
show the AIP, not individual files.

:ref:`Back to the top <dublin_core>`.

.. _Dublin Core: http://dublincore.org/
.. _AtoM (Access to Memory): https://www.accesstomemory.org/
