.. _contentdm:

=============================
ContentDM ingest and transfer
=============================

Users can process digital content and then upload the DIP to CONTENTdm as the
access system. To configure Archivematica to upload a DIP to CONTENTdm, see
Administrator manual - CONTENTdm upload.

.. note::

   The user must create the target collection in CONTENTdm **before** uploading
   the DIP.

Should you run into an error during this process, please see Error handling.

*On this page*

:ref:`Transfer and ingest of single items <contentdm-single>`

:ref:`Transfer and ingest of multiple items <contentdm-multiple>`

.. _contentdm-single:

Transfer and ingest of single items
-----------------------------------

**Controlling the file order and labels in compound items**

In order to allow users to display digital files in a specified order in
CONTENTdm compound items such as newspapers issues, Archivematica provides the
following options:

* Order of files in the structMap will be determined by the alphabetical order
  of each file's original name

   * Numbers will be respected
   * Case will be ignored
   * If the objects directory has subdirectories, the structMap will sort
     alphabetically by directory and within each directory

* Each file will be placed in its own div

* If desired, div labels can be applied to files via a csv file entitled
  file_labels.csv included in the /metadata directory of the transfer

   * The csv file would consist of two columns: filename and label
   * The div labels would map to the title field in the access system
   * The div labels would be applied only to original versions of the files, not
     normalized versions

.. image:: images/StructMap-09.*
   :align: center
   :width: 80%
   :alt: structMap showing ContentDM transfer


**User-supplied structMaps**

If desired, the user can submit a structMap with a single-item transfer or
SIP. This will be useful if the user desires an upload/display order based on
logical divisions (for example, book chapters):

* Archivematica will automatically detect the structMap file and use it as the
  structMap in the AIP METS file. This will be the only structMap in the AIP
  METS file

* The name of the file must be mets_structmap.xml

* There must be no more than one mets_structmap.xml file per transfer or SIP

* The structMap TYPE must be specified as either logical or physical

* The structMap file must be placed in the /metadata folder of the transfer or SIP

* The structMap must cover all the files in the /objects directory

* All filenames in the /objects directory must be unique

* If the structMap contains <fptr> elements Archivematica will generate a
  fileSec in order to create a valid METS file

* Once the fileSec is added, Archivematica will validate the METS file using e.g.
  xmllint

* Archivematica will apply file UUIDs to the filenames in the <fptr> elements of
  the structMap when the AIP METS file is generated

* Div labels, if included, will be mapped to title field in CONTENTdm and AtoM

Sample user-supplied structMap:

.. image:: images/Mets_structmap1.*
   :align: center
   :width: 80%
   :alt: User supplied structMap image one

.. image:: images/Mets_structmap2.*
   :align: center
   :width: 80%
   :alt: User supplied structMap image two


.. _contentdm-multiple:

Transfer and ingest of multiple items
-------------------------------------

It is also possible to ingest multiple objects in a single transfer. Like a
transfer package that contains a single object, a transfer package containing
multiple objects has two directories, “objects” and “metadata”. In the case of
simple objects (e.g., single-page items), the “objects” directory contains
files, and each of the files corresponds to a simple object. In the case of
compound objects (e.g., books consisting of multiple pages), the “objects”
directory has a directory for each compound object where all files for the
compound item (e.g., pages of a book) are placed. In both cases, the
“metadata” directory contains a CSV file that meets the metadata import
specifications: see :ref:`Metadata import <import-metadata>`. Note that this
file must be named metadata.csv. The image below shows the directory structure
of a transfer package of compound objects "CDMtest02":

.. image:: images/CONTENTdmTransferDirectory.*
   :align: center
   :width: 75%
   :alt: Example ContentDM transfer directory structure

Process the transfer in Archivematica using instructions in
:ref:`Ingest <ingest>`. Note that to create a DIP you must select "Normalize
for access" or "Normalize for preservation and access" at the normalization
step (unless you have included your own access copies in the transfer - see
:ref:`Digitization output <digitized>`).

**Metadata field mappings**

If you are importing multiple items using a metadata.csv file, Archivematica
will look for "custom" (non-Dublin Core) field names in this file that match
field names in the target CONTENTdm collection and map the values for those
fields to the corresponding fields in CONTENTdm. If there are no custom fields
in your metadata.csv file (that is, all fields match Dublin Core elements),
Archivematica will use whatever Dublin Core mappings have been defined in the
target CONTENTdm collection to populate the corresponding fields in CONTENTdm.

.. seealso::

   :ref:`Upload DIP to ContentDM <dip-contentdm>`

:ref:`Back to the top <contentdm>`
