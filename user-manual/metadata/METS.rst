.. _METS_schema:

======================
METS in Archivematica
======================

General description
--------------------

The Metadata Encoding & Tranmission Standard, or `METS`_, is a schema for
encoding various metadata, expressed in XML . It essentially acts a wrapper
around other metadata standards, such as PREMIS and Dublin Core that are used in
Archivematica.

The METS file in Archivematica will have a basic generic structure that is
comprised of the following sections:

* metsHdr (METS header) (1 only)
* dmdSec (descriptive metadata section) (1 or more)
* fileSec (file section) (1 only)
* structMap (structural map) (1 or more)

.. literalinclude:: scripts/metsfile.xml
   :language: bash
   :lines: 1-26

Below is a more detailed outline of the above sections present in AIPs created
in Archivematica.

Skip to:

* :ref:`<metsHdr> <metshdr>`
* :ref:`<dmdSec> <dmdsec>`
* :ref:`<amdSec> <amdsec>`
* :ref:`<fileSec> <filesec>`
* :ref:`<structMap> <structmap>`


.. _metshdr:

<metsHdr>
^^^^^^^^^

There will be one METS header section for each METS file. It will contain a
CREATEDATE attribute.

.. code:: xml

  <metsHdr CREATEDATE=”2019-06-18T23:52:11”/>

If the AIP has been reingested, the metsHder section will also contain a
LASTMODDATE.

.. code:: xml

  <metsHdr CREATEDATE=”2019-06-18T23:52:11” LASTMODDATE=”2019-06-27T00:28:56”/>


.. _dmdsec:

<dmdSec>
^^^^^^^^

There will be one dmdSec for the whole AIP, which contains PREMIS Intellectual
Entity information.

.. literalinclude:: scripts/METS.xml
   :language: xml
   :lines: 15-35

There may also be one or more dmdSecs for descriptive metadata. The dmdSecs are
numbered dmdSec_1, dmdSec_2, etc. and contain Dublin Core metadata as a default.

.. literalinclude:: scripts/METS.xml
   :language: xml
   :lines: 64-91

MDTYPE will be **DC** for Dublin Core metadata; if another metadata standard is
included then the MDTYPE will be **OTHER**. 

If the user does not enter any DC metadata during transfer/ingest and no DC
metadata was included with the transfer (e.g. as a metadata.csv file, see
:ref:`Import metadata <import-metadata>`), there will be no additional dmdSecs.


.. _amdsec:

<amdSec>
^^^^^^^^^

There is one amdSec for each object and wraps PREMIS entities as follows:

* PREMIS Object: techMD (tehnical metadata)
* PREMIS Event: digiprovMD (digital provenance metadata)
* PREMIS Agent: digiprovMD (digital provenance metadata)
* PREMIS Rights: rightsMD (rights metadata)

Each amdSec will include one techMD. The techMD is used to wrap PREMIS Object
semantic units, such as objectIdentifier, objectCharacteristics and
originalName. See the example techMD below:

.. literalinclude:: scripts/METS.xml
   :language: xml
   :lines: 212-258

Each amdsec will include multiple digiprovMDs for PREMIS events related to the
PREMIS Object. Below is an example of a PREMIS event for a fixity check:

   .. literalinclude:: scripts/METS.xml
      :language: xml
      :lines: 820-854

An amdSec for an original object may also contain one or more rightsMDs. The
rightsMD may contain a reference to metadata in another file, such as rights.csv
uploaded with a transfer. Below is an example of a PREMIS Rights statement in
rightsMD section of the AIP METS file:

.. literalinclude:: scripts/METS.xml
   :language: xml
   :lines: 2073-2108

An amdSec will also have one ore more sourceMD sections. This is the only
non-PREMIS section in an amdSec and no XML schema is used for the contents.
SourceMD is created from the contents of the bag-info.txt whenever a zipped or
unzipped bag transfer type is used. It is also created for a disk image transfer
if the user entered meteadata about the disk image in the Transfer tab.


.. _filesec:

<fileSec>
^^^^^^^^^

There is one fileSec listing all files. The fileSec is organized into two or
more of the following fileGrps:

* original
* preservation
* service
* submissionDocumentation
* metadata
* license
* text/ocr
* deleted

These are known as USE attributes and must accompany each fileGrp. The fileGrp
original is required for all METS files. If the AIP includes normalized files
then the fileGrp preservation is used. The service fileGrp may be used if the
AIP contains the subfolder (e.g. as the output of digitization workflows).

Each fileGrp must also have a GROUPID and an ID. The GROUPID is the same UUID as
the ID. Related files will have the same GROUPID.  Below is an example of the
original fileGrp section in the AIP METS file:

.. literalinclude:: scripts/METS.xml
   :language: xml
   :lines: 8830-8850


.. _structmap:

<structMap>
^^^^^^^^^^^

There will be at least one structMap in the METS. It is labeled "Archivematica
Default" and lists the directories and files in the objects directory.

.. literalinclude:: scripts/METS.xml
   :language: xml
   :lines: 8903-8919

If the *document empty directories* microservice runs, then a second structMap
is created. It is labeled "Normative Directory Structure." At AIP re-ingest the
new logical structMap will be parsed to re-create the empty directories.

If a user includes a custom structMap in the transfer, then this will also be
included in the METS file.


:ref:`Back to the top <METS_schema>`

.. _METS: http://www.loc.gov/standards/mets/
