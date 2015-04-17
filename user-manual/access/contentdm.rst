.. _contentdm:

==========
ContentDM
==========

Archivematica can prepare DIPS for upload to CONTENTdm. As of Archivematica
version 1.4, no configuration with your CONTENTdm installation is necessary.
Rather, Archivematica will prepare the DIP and allow you to download via the
Dashboard or by SFTP to the server Archivematica is installed on.

In Archivematica version 1.4, direct upload to CONTENTdm is no longer
available. The process descrived below assumes the user will use
`Project Client <http://www.contentdm.org/help6/projectclient/index.asp>`_
to upload DIPs to CONTENTdm.

Should you run into an error during this process, please see
:ref:`Error handling <error-handling>`.

*On this page*

* :ref:`Preparing a transfer for CONTENTdm <transfer-contentdm>`

* :ref:`

.. _transfer-contentdm:

Preparing a transfer for CONTENTdm
----------------------------------

.. seealso::

   :ref:`Manual normalization <manual-norm>`

   :ref:`Import metadata <import-metadata>`

Note that it is possible to follow these instructions for either a single simple
or compound object, or multiple simple or compound objects.


**Preparing the transfer**

For a transfer of simple objects:

1. Inside the directory you wish to use as a transfer, create two subdirectories:
``metadata``, and ``objects``.

2. Inside ``objects``, place the digital objects you wish to transfer.

3. Inside ``metadata``, place a file called ``metadata.csv``. See preparation
instructions below.

Example:

.. code:: bash

   /transferName
       /objects
           file1.tif
           file2.tif
           etc
       /metadata
           metadata.csv


For a transfer of compound objects:

1. Inside the directory you wish to use as a transfer, create two subdirectories:
``metadata``, and ``objects``.

2. Inside ``objects``, create or place directories, one corrsponding to each
compound object. Place the digital objects inside those directories.

3. Inside metadata, place a file called ``metadata.csv``. See preparation
instructions below.


Example:

.. code:: bash

   /transferName
       /objects
           /directoryOne
                file1.tif
                file2.tif
                etc
           /directoryTwo
                file3.tif
                file4.tif
                etc
       /metadata
           metadata.csv


**Preparing the metadata.csv**

The first column in the metadata.csv must be called filename. The contents will
be the path to the object and/or the directory. For a simple transfer:

``objects/filename.tif``

For a compound transfer:

``objects/directoryName``

Or, for a compound transfer with object-level metadata

``objects/directoryName/filename.tif``

Archivematica will look for "custom" (non-Dublin Core) field names in the
metadata.csv file file and create a tab delimited file based on those fields.
This allows the operator to use the field names as they appear exactly as they
do in the CONTENTdm collection, which eases the field matching in Project Client.
It is also recommended that you enter the non-Dublin Core fields in the same
order as in your CONTENTdm collection.

If you wish to include Dublin Core metadata in your METS file, you can include
duplicate fields in the metadata.csv which are namespaced to Dublin Core (see:
:ref:`Import metadata <import-metadata>`. To create the tab delimited file for
CONTENTdm purposes, Archivematica will ignore the Dublin Core metadata and use
the non-Dublin Core metadata fields instead.


.. _contentdm-order:

Controlling the file order and labels
-------------------------------------

In order to allow users to display digital files in a specified order in
CONTENTdm compound items such as newspapers issues, Archivematica provides the
following options:

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


.. _dip-contentdm:

Upload DIP to CONTENTdm
-----------------------

.. important::

   Ensure that your CONTENTdm target collection has a field called "AIP UUID
   and a field called "File UUID". The tab file produced by Archivematica
   will populate these two fields.

1. In the Archivematica dashboard at “Upload DIP”, choose the action “Upload
DIP to CONTENTdm” from the drop-down menu.

2. Archivematica will create a DIP consisting of normalized or
:ref:`manually normalized <manual-norm>` access objects and a tab delimited
file for use in Project Client.

To review the DIP in the dashboard and

The DIP will be stored in
``/share/sharedDirectoryStructure/watchedDirectories/uploadedDIPs/CONTENTdm/.``


:ref:`Back to the top <contentdm>`
