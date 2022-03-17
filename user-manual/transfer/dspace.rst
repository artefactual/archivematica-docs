.. _dspace:

==============
DSpace exports
==============

Archivematica can be used to build a "dark archive" for a DSpace repository -
that is, it can provide back-end preservation functionality while DSpace remains
the user deposit and access system. Material exported from DSpace must be placed
in a :ref:`transfer source location <storageService:locations>` that the
Archivematica pipeline can access.

*On this page*

* :ref:`DSpace version compatibility <dspace-version>`
* :ref:`DSpace export structure <dspace-export-structure>`
* :ref:`Processing DSpace exports <processing-dspace-exports>`

.. _dspace-version:

DSpace version compatibility
----------------------------

Archivematica has been tested using exports from DSpace 1.7.x. Ingest has not
been tested on exports from DSpace 1.8.x; however, there were no changes in the
DSpace AIP export structure between 1.7.x and 1.8.x so it is anticipated that
performance will be identical.

.. _dspace-export-structure:

DSpace export structure
-----------------------

Archivematica expects standard DSpace exports, where each DSpace item is
packaged as a ZIP file. Typically, the DSpace item ZIP file will contain the
uploaded object plus a license file, a METS file and possibly an OCR text file.

.. image:: images/dspace-item-contents.*
   :align: center
   :width: 80%
   :alt: An unzipped DSpace export package, showing the four files that comprise the item.

In the example pictured above, the DSpace item includes four files:

* ``bitstream_39691.txt``: the OCR text file.
* ``bitstream_8272.pdf``: the original object deposited in DSpace.
* ``bitstream_8273``: the license file.
* ``mets.xml``: the METS file for the item.

Archivematica will reuse portions of the DSpace METS file to populate the METS
file that is generated for the AIP.

You can either transfer items one-by-one or place them within a directory to
transfer multiple items at a time. Depending on the setup of your DSpace
instance and your export parameters, the export may contain multiple individual
items as well as a collection-level description, as in the example below.

.. _processing-dspace-exports:

Processing DSpace exports
-------------------------

#. Place your exported material in a :ref:`transfer source location
   <storageService:locations>` that your Archivematica pipeline can access.

#. On the Transfer tab in Archivematica, use the **Transfer type** dropdown menu to
   select the DSpace transfer type.

   .. image:: images/dspace-select-transfer-type.*
      :align: center
      :width: 80%
      :alt: Archivematica transfer tab showing "DSpace" selected as the transfer type.

#. Use the **Browse** button to find your DSpace export and select either an
   individual item or a collection of items. In the screenshot below, a
   collection of items has been selected. Click **Add**.

   .. image:: images/dspace-select-items.*
      :align: center
      :width: 80%
      :alt: Archivematica transfer tab showing a folder called "DSpaceExport", containing many DSpace items, selected for transfer.

#. If you selected a collection of items, enter a name for the transfer in the
   **Transfer name** box.

   If you selected an individual DSpace item, you do not need to give your
   transfer a name. The name of the item (e.g. ``ITEM@2429-1521.zip``) will be
   used as the transfer name.

#. Click **Start transfer** and process as required.

.. _dspace-mets:

DSpace AIP METS files
---------------------

Each object in the AIP has 2 DSpace-specific descriptive metadata sections (dmdSec).
The first contains Xpointers to descriptive and rights metadata in
the original mets.xml files exported from DSpace.

.. literalinclude:: scripts/dspace-mets.xml
   :language: xml
   :lines: 19-21

The second dmdSec reflects the parent-child relationship between a DSpace object
and its collection, using the handles as identifiers:

.. literalinclude:: scripts/dspace-mets.xml
   :language: xml
   :lines: 22-31

In the file section (``fileSec``) of the AIP METS file, you can find information
about the different types of DSpace files contained in the AIP. They are sorted
by file group (``fileGrp``): ``original``, ``submissionDocumentation`` (the
original DSpace mets.xml files), ``preservation`` (if the material was
normalized for preservation), ``license``, and ``text/ocr``.

.. literalinclude:: scripts/dspace-mets.xml
   :language: xml
   :lines: 2707-2731

:ref:`Back to the top <dspace>`
