.. _import-metadata:

===============
Import metadata
===============

This page documents the workflow and METS content for lower-level metadata
import - i.e. metadata to be attached to subdirectories and files within a
SIP.

Workflow
--------

1. For simple objects, the user places files in the objects directory, with or
without intervening subdirectories. The imported metadata are attached to each
object.

.. figure:: images/MdfolderMDimport-10.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: Metadata folder in transfer directory contains metadata.csv file

   Metadata folder in transfer directory contains metadata.csv file

.. figure:: images/CsvMDimport-10.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt:  Example csv file contents

   Example csv file contents


2. For compound objects, the user creates one or more subdirectories in the
objects directory, each containing the files that form a compound object. The
imported metadata are attached to each subdirectory.

.. important::

   The subdirectory names must not contain spaces or other forbidden characters.

3. The user adds a csv file to the metadata folder for the transfer entitled
metadata.csv

* The first row of the csv file consists of field names. Field names must not
  include spaces.

* Dublin Core field names must contain the "dc" element in the name, eg
  "dc.title"

* Each subsequent row contains the complete set of field values for a single
  directory or file.

* For multi-value fields (such as dc.subject), the entire column is repeated
  and each column contains a single value.

* If the metadata are for simple objects, the csv file must contain a
  "filename" column listing the filepath and filename of each objects: eg
  "objects/BrocktonOval.jp2"

* If the metadata are for compound objects, the csv file must contain a
  "parts" column listing the names of the directories containing the items
  that form the compound object: eg "objects/Jan021964"

* Note that filenames can be duplicates of filenames in other subdirectories
  if desired. For example, the name "page01.jp2" can occur in multiple
  subdirectories.

4. At the generate METS micro-service, Archivematica parses the metadata in
metadata.csv to the METS file, as follows:

* All Dublin Core elements are used to generate a dmdSec for each directory or
  file with MDTYPE="DC"

* All non-Dublin Core elements are used to generate a dmdSec for each
  directory or file with MDTYPE="OTHER" OTHERMDTYPE="CUSTOM"

* The dmdSecs are linked to their directories or files in the structMap


Simple objects
--------------

This section provides csv file and METS file examples for simple objects -
i.e. individual files that are not pages in a compound object such as a book
or a newspaper issue.

**CSV file**

Sample headings and values

========================  ========================= ==============  ==============  =========================== ======================= ==========  ========== ========================= ================================== ======================== ============================ =============================== ========================================== =========
filename                  dc.title                  dcterms.issued  dc.publisher    dc.contributor              dc.subject              dc.subject  dc.date    dc.description            notes                              dcterms.isPartOf         repository                   dc.rights                       project_website                            dc.format
========================  ========================= ==============  ==============  =========================== ======================= ==========  ========== ========================= ================================== ======================== ============================ =============================== ========================================== =========
objects/BrocktonOval.jp2  Stanley Park in December  1996-01-17      Riley Studios,  Don Langfield, photographer Vancouver (B.C.)--Parks Landscapes  1992/12/04 Image shows Brockton Oval Originally part of series entitled Riley Studios collection New Caledonia Public Library Copyright held by Riley Studios http://www.ncpl/donlangfieldphotographs.ca image/jp2
                                                                    Vancouver BC                                                                               after light snowfall      "Winter in Vancouver"
objects/QEParksunset.jp2  Sunset in Queen Elizabeth                 Riley Studios,  Don Langfield, photographer Vancouver (B.C.)--Parks             1994/07/13                                                              Riley Studios collection New Caledonia Public Library Copyright held by Riley Studios http://www.ncpl/donlangfieldphotographs.ca image/jp2
                          Park                                      Vancouver BC
========================  ========================= ==============  ==============  =========================== ======================= ==========  ========== ========================= ================================== ======================== ============================ =============================== ========================================== =========

**METS file**

.. code:: bash




Compound objects
----------------

This section provides csv file and METS file examples for compound objects -
i.e. multi-page digital objects such as newspapers and books.

**CSV file**

Sample headings and values

=================  ============================ ===================  ============ ==================== ==========================  ==========  ==================================  =========   ===========  =================================================  ==================================  ==========================================  ===================
parts              dc.title                     alternative_title    dc.publisher dates_of_publication dc.subject                  dc.date     dc.description                      frequency   dc.language  forms_part_of                                      repository                          project_website                             digital_file_format
=================  ============================ ===================  ============ ==================== ==========================  ==========  ==================================  =========   ===========  =================================================  ==================================  ==========================================  ===================
objects/Jan021964  Coast News, January 02, 1964 Sunshine Coast News  Fred Cruice  1945-1995            Gibsons (B.C.)--Newspapers  1964/01/02  Serving the Growing Sunshine Coast  Weekly      English      British Columbia Historical Newspapers collection  Sunshine Coast Museum and Archives  http://historicalnewspapers.library.ubc.ca  image/jp2
objects/Jan091964  Coast News, January 09, 1964 Sunshine Coast News  Fred Cruice  1945-1995            Gibsons (B.C.)--Newspapers  1964/01/09  Serving the Growing Sunshine Coast  Weekly      English      British Columbia Historical Newspapers collection  Sunshine Coast Museum and Archives  http://historicalnewspapers.library.ubc.ca  image/jp2
=================  ============================ ===================  ============ ==================== ==========================  ==========  ==================================  =========   ===========  =================================================  ==================================  ==========================================  ===================




