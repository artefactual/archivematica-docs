.. _aip-structure:

=============
AIP structure
=============

This page describes the standard structure of an AIP produced by Archivematica.

*On this page:*

* :ref:`Name <aip-name>`
* :ref:`AIP contents <aip-contents>`

  * :ref:`BagIt files <aip-bagit-files>`
  * :ref:`Data directory <aip-data-directory>`

    * :ref:`AIP METS file <aip-mets>`
    * :ref:`README file <aip-readme>`
    * :ref:`Logs <aip-logs>`
    * :ref:`Objects <aip-objects>`
    * :ref:`Thumbnails <aip-thumbnails>`

.. _aip-name:

Name
----

The AIP name is composed of the following:

1. The name assigned to the transfer. This may come from human input or it may
   be the name of the transfer directory, depending on the transfer type and
   the transfer method.
2. A UUID assigned to the AIP during ingest.

For example, looking at the AIP name
``my-aip-d31cc44f-ce01-4e67-affe-513868d9cf3d``, ``my-aip`` is the name assigned
by the user and ``d31cc44f-ce01-4e67-affe-513868d9cf3d`` is the UUID generated
during ingest.

.. _aip-contents:

AIP contents
------------

Archivematica AIPs are structurally consistent regardless of variables in
original content, processing, and storage. They are is packaged into a bag in
accordance with the `IETF Trust BagIt File Packaging Format`_. This tree
structure depicts a typical Archivematica AIP:

.. code::

   [1] my-aip-d31cc44f-ce01-4e67-affe-513868d9cf3d
   [2] ├── bag-info.txt
   [3] ├── bagit.txt
   [4] ├── manifest-sha512.txt
   [5] ├── tagmanifest-md5.txt
   [6] └── data
   [7]     ├── logs
   [8]     ├── objects
   [9]     ├── thumbnails
   [10]    ├── METS.d31cc44f-ce01-4e67-affe-513868d9cf3d.xml
   [11]    └── README.html

* [1] AIP root directory
* [2 - 5] :ref:`AIP BagIt files <aip-bagit-files>`: standard packaging files
  produced in accordance with the `IETF Trust BagIt File Packaging Format`_.
* [6] :ref:`Data directory <aip-data-directory>`: a standard directory
  required by the BagIt specification. The data directory contains the AIP
  Content Information and Preservation Description Information (PDI).
* [7] :ref:`Logs directory <aip-logs>`: contains log outputs of some of the
  tools that Archivematica uses to generate the AIP.
* [8] :ref:`Objects directory <aip-objects>`: contains the original digital
  objects as well as any normalized versions.
* [9] :ref:`Thumbnails directory <aip-thumbnails>`: contains any thumbnails
  generated from the original object.
* [10] :ref:`AIP METS file <aip-mets>`
* [11] :ref:`README file <aip-readme>`

For more information about each of these components, see the appropriate section
below.

.. _aip-bagit-files:

BagIt files
^^^^^^^^^^^

Archivematica uses a very simple implementation of BagIt. All AIPs contain the
following BagIt files:

* ``bag-info.txt``: a tag file that contains metadata about the bag, including:

   * ``Payload-Oxum``: the octet stream sum of the bag payload.
   * ``Bagging-Date``: a yyyy-mm-dd formatted date on which the bag was created
     (e.g. 2018-11-01).
   * ``Bag-Size``: a human-readable file size (e.g. 42kB).
   * ``External-Identifier``: the UUID of the AIP.

* ``bagit.txt``: the bag declaration, stating the version and encoding.
* ``manifest-sha256.txt``: a list of each payload file name with corresponding
  SHA256 checksums.
* ``tagmanifest-md5.txt``: a tag file that lists other tag files with
  corresponding MD5 checksums.

This example shows the contents of the top-level directory of the AIP.

.. code:: bash

   my-aip-d31cc44f-ce01-4e67-affe-513868d9cf3d
   ├── bag-info.txt
   ├── bagit.txt
   ├── data
   ├── manifest-sha256.txt
   └── tagmanifest-sha256.txt

.. _aip-data-directory:

Data directory
^^^^^^^^^^^^^^

The data directory consists of the METS file for the AIP, a README file, and
three folders: ``logs``, ``objects`` and ``thumbnails``.

This example shows the contents of the AIP's data directory.

.. code:: bash

   my-aip-d31cc44f-ce01-4e67-affe-513868d9cf3d
   └── data
       ├── logs
       ├── METS.d31cc44f-ce01-4e67-affe-513868d9cf3d.xml
       ├── objects
       ├── README.html
       └── thumbnails

.. _aip-mets:

AIP METS file
+++++++++++++

The AIP `METS file`_, ``/data/METS.uuid.xml``, lists all of the digital objects
in the AIP (original files, preservation masters, license files, OCR text files,
submission documentation, etc.), describes their relationships to each other,
and links digital objects to their descriptive, technical, provenance, and
rights metadata.

The AIP METS file name is composed from the prefix ``METS.``, the UUID of the
AIP, and the extension ``.xml``. Note that the presence of the UUID
differentiates the AIP METS file from the transfer METS file, described in the
:ref:`Objects <aip-objects>` section below.

For more information about Archivematica's METS implementation, see :ref:`METS
in Archivematica <METS_schema>`.

.. _aip-readme:

README file
++++++++++++++++

The AIP README file, ``/data/README.html``, is a human-readable file that
describes the basic structure of an Archivematica AIP. It introduces
Archivematica, OAIS, METS and PREMIS, and other concepts that future users may
find helpful when they encounter an AIP.

.. _aip-logs:

Logs
++++

The logs directory, ``/data/logs``, contains log outputs for some of the tools
and tasks that run inside of Archivematica.

This is an example of the contents of an AIP's logs directory:

.. code:: bash

   my-aip-d31cc44f-ce01-4e67-affe-513868d9cf3d
   └── data
       └── logs
           ├── arrange.log
           ├── fileFormatIdentification.log
           ├── filenameCleanup.log
           └── transfers
               ├── first-transfer-abbff451-f077-4f66-a6e0-d83f6ebbeebf
               │   └── logs
               │       ├── fileFormatIdentification.log
               │       └── filenameCleanup.log
               └── second-transfer-52fd11fa-fca8-4bc7-9214-e6510863759a
                   └── logs
                       ├── fileFormatIdentification.log
                       └── filenameCleanup.log

The top-level logs (``arrange.log``, ``fileFormatIdentification.log``, etc.) are
outputs for tasks that took place either in the Appraisal tab or on the Ingest
tab. For example, ``data/logs/fileFormatIdentification.log`` is the log that was
created during the *Identify file format* job that takes place during the
Normalize microservice on the Ingest tab.

The logs directory has a transfers subdirectory, ``/data/logs/transfers``, which
contains logs for tools that ran on the Transfer tab. Since it is possible to
combine multiple transfers into one SIP (which becomes one AIP), the transfers
subdirectory may contain multiple directories. Continuing to use the example
above, two transfers (``first-transfer`` and ``second-transfer``) were combined
to create one AIP (``my-aip``). Therefore, there are two more
``fileFormatIdentification.log`` files:

* ``data/logs/transfers/first-transfer-abbff451-f077-4f66-a6e0-d83f6ebbeebf/logs/fileFormatIdentification.log``
  is the log that was created during *Microservice: Identify file format* on the
  Transfer tab when ``first-transfer`` was processed.
* ``data/logs/transfers/second-transfer-52fd11fa-fca8-4bc7-9214-e6510863759a/logs/fileFormatIdentification.log``
  is the log that was created during *Microservice: Identify file format* on the
  Transfer tab when ``second-transfer`` was processed.

The example above does not show all possible logs. Depending on how you have
set your :ref:`Processing configuration <dashboard-processing>`, you may see a
greater or lesser number of logs or logs of different types in your AIP.

.. _aip-objects:

Objects
+++++++

The objects directory, ``/data/objects``, contains original objects,
preservation masters, and two folders: ``/metadata`` and
``/submissionDocumentation``. If the SIP contained any lower-level directories,
either from the original transfer or because it was arranged on the Appraisal
tab, the lower-level directories will be present as well.

.. code::

   my-aip-d31cc44f-ce01-4e67-affe-513868d9cf3d
   └── data
       └── objects
           ├── 799px-Euroleague-LE_Roma_vs_Toulouse_IC-27-3e2bcabd-f33f-485b-a566-ff71c141b930.tif
           ├── 799px-Euroleague-LE_Roma_vs_Toulouse_IC-27.bmp
           ├── BBhelmet.ai
           ├── G31DS-60559b5e-38a5-44f5-8c63-bb41bda5d2e8.tif
           ├── G31DS.TIF
           ├── metadata
           │   └── transfers
           │       ├── first-transfer-abbff451-f077-4f66-a6e0-d83f6ebbeebf
           │       │   ├── directory_tree.txt
           │       │   └── metadata.csv
           │       └── second-transfer-52fd11fa-fca8-4bc7-9214-e6510863759a
           │           └── directory_tree.txt
           └── submissionDocumentation
               ├── transfer-first-transfer-abbff451-f077-4f66-a6e0-d83f6ebbeebf
               │   └── METS.xml
               └── second-transfer-52fd11fa-fca8-4bc7-9214-e6510863759a
                   └── METS.xml

The filenames of original objects will be unchanged. Preservation master copies
have a UUID appended to the filename. In the example above,
``799px-Euroleague-LE_Roma_vs_Toulouse_IC-27.bmp`` is the original object and
``799px-Euroleague-LE_Roma_vs_Toulouse_IC-27-3e2bcabd-f33f-485b-a566-ff71c141b930.tif``
is the preservation master. The creation of preservation master copies is guided
by the rules on the :ref:`Preservation planning tab <preservation-planning>`.

The ``/metadata`` directory contains metadata associated with the AIP. The
metadata directory has a transfers subdirectory, ``/data/metadata/transfers``,
which separates the metadata files into folders specific to the transfer where
they originated. Since it is possible to combine multiple transfers into one SIP
(which becomes one AIP), the transfers subdirectory may contain multiple
folders.

The ``/submissionDocumentation`` directory contains :ref:`submission
documentation <create-submission>` for the AIP. Similar to the metadata
directory, there is a transfers subdirectory,
``/data/submissionDocumentation/transfers``, which separates the submission
documentation files into folders specific to the transfer where they originated.
Since it is possible to combine multiple transfers into one SIP (which becomes
one AIP), the transfers subdirectory may contain multiple folders. Note that the
transfer folders contain a METS.XML file - this is the transfer METS, which was
generated for each transfer on the Transfer tab. When the transfer (or multiple
transfers combined) become a SIP, the transfer METS files are combined into a new
METS file which becomes the :ref:`AIP METS file <aip-mets>`.

.. _aip-thumbnails:

Thumbnails
++++++++++

The objects directory, ``/data/thumbnails``, will contain thumbnail images if
you chose to generate them during the *Normalize for thumbnails* job.

.. code::

   my-aip-d31cc44f-ce01-4e67-affe-513868d9cf3d
   └── data
       └── thumbnails
           ├── 0e9fd6db-ac57-453c-ba0f-c9cff9d0ac56.jpg
           ├── 7d1c5e44-f1e1-4cf7-8b79-ca2284a6ce79.jpg
           └── dd1a6fb8-7e49-47ca-921b-87b234c939b9.jpg

The creation of thumbnails is optional and configurable in the
:ref:`processing configuration <dashboard-processing>`.

:ref:`Back to the top <aip-structure>`

.. _IETF Trust BagIt File Packaging Format: https://tools.ietf.org/html/rfc8493
.. _PREMIS: https://www.loc.gov/standards/premis/
.. _METS file: http://www.loc.gov/standards/mets/
