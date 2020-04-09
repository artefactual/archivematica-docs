.. _dublin_core:

============================
Dublin Core in Archivematica
============================

General description
-------------------

The use of `Dublin Core`_ descriptive metadata, `DCMI Metadata Terms`_, is
supported in Archivematica through both import and manual entry.

For instructions on importing metadata with a transfer, please see :ref:`Import
metadata <import-metadata>`. Archivematica's metadata import workflow accepts both ``dc.elements``
and ``dcterms.elements``.

For instructions on adding descriptive metadata through the user interface
during ingest, please see :ref:`Add metadata <add-metadata>`.


Metadata handling
-----------------

When descriptive metadata is added through either of the methods described
above, Archivematica handles this metadata by parsing it to the METS file. For
example:

.. literalinclude:: scripts/dublinCore.xml
   :language: xml
   :lines: 1-28


When a DIP is sent to :ref:`AtoM <upload-atom>`, Dublin Core metadata is parsed
into the appropriate fields in the AtoM descriptive template. Descriptive
metadata is also indexed in the Archival Storage tab in Archivematica; search
results will show the AIP, not individual files.

:ref:`Back to the top <dublin_core>`.

.. _Dublin Core: https://dublincore.org/
.. _DCMI Metadata Terms: https://www.dublincore.org/specifications/dublin-core/dcmi-terms/
