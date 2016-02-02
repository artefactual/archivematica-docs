.. _import-metadata:

===============
Import metadata
===============

To import metadata with your transfer, you must structure your transfer to
include a directory called ``metadata``. The folder can contain any type of
metadata that you wish to preserve alongside your digital objects. If you
include a ``metadata.csv`` file structured as described on this page,
Archivematica is able to parse the metadata into the dmdSec (descriptive
metadata section) of the METS file. This metadata also becomes searchable
in the :ref:`Archival Storage <archival-storage>` tab.

.. seealso::

   :ref:`Create a transfer with submission documentation <create-submission>`


Workflow
--------

1. Create a transfer folder that contains a folder called ``metadata``. For
   simple objects, the user places files in the objects directory, with or
   without intervening subdirectories.

.. figure:: images/MdfolderMDimport-10.*
   :align: center
   :figwidth: 60%
   :width: 100%
   :alt: Metadata folder in transfer directory contains metadata.csv file

   Metadata folder in transfer directory contains metadata.csv file

2. For compound objects, create one or more subdirectories in the
   objects directory, each containing the files that form a compound object.

.. important::

   The subdirectory names must not contain spaces or other forbidden characters.

3. Add a csv file to the metadata folder for the transfer called
   ``metadata.csv``.

* The first row of the csv file consists of field names. Field names must not
  include spaces.

* Dublin Core field names must contain the "dc" element in the name, eg
  "dc.title". Note that the Dublin Core is not validated, this is up to the
  user.

* Each subsequent row contains the complete set of field values for a single
  directory or file.

* As of version 1.4, mixed directory and object level metadata is allowed
  in the metadata.csv.

* For multi-value fields (such as dc.subject), the entire column is repeated
  and each column contains a single value.

* If the metadata are for simple objects, the csv file must contain a
  "filename" column listing the filepath and filename of each objects: eg
  "objects/BrocktonOval.jp2"

* If the metadata are for compound objects, the "filename" column contains the
  names of the directories containing the items that form the compound object:
  eg "objects/Jan021964"

* Note that filenames can be duplicates of filenames in other subdirectories
  if desired. For example, the name "page01.jp2" can occur in multiple
  subdirectories.


  .. figure:: images/CsvMDimport-10.*
     :align: center
     :figwidth: 60%
     :width: 100%
     :alt:  Example csv file contents

     Example csv file contents

4. At the generate METS micro-service, Archivematica parses the metadata in
   metadata.csv to the METS file, as follows:

* All Dublin Core elements are used to generate a dmdSec for each directory or
  file with MDTYPE="DC"

* All non-Dublin Core elements are used to generate a dmdSec for each
  directory or file with MDTYPE="OTHER" OTHERMDTYPE="CUSTOM"

* The dmdSecs are linked to their directories or files in the structMap.


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

   <mets xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/METS/" xsi:schemaLocation="http://www.loc.gov/METS/ http://www.loc.gov/standards/mets/version18/mets.xsd">
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
   <dmdSec ID="dmdSec_2">
       <mdWrap MDTYPE="OTHER" OTHERMDTYPE="CUSTOM">
           <xmlData>
               <notes>
                   Originally part of series entitled "Winter in Vancouver"
               </notes>
               <repository>
                   New Caledonia Public Library
               </repository>
               <project_website>http://www.ncpl/donlangfieldphotographs.ca</project_website>
           </xmlData>
       </mdWrap>
   </dmdSec>
   <dmdSec ID="dmdSec_3">
       <mdWrap MDTYPE="DC">
           <xmlData>
               <dublincore xsi:schemaLocation="http://purl.org/dc/elements/1.1 http://dublincore.org/schemas/xmls/qdc/dc.xsd http://purl.org/dc/terms/ http://dublincore.org/schemas/xmls/qdc/2008/2/11/dcterms.xsd">
               <title>Sunset in Queen Elizabeth Park</title>
               <subject>Vancouver (B.C.)--Parks</subject>
               <publisher>Riley Studios, Vancouver BC</publisher>
               <contributor>Don Langfield, photographer</contributor>
               <date>1994-07-13</date>
               <rights>Copyright held by Riley Studios</rights>
           </dublincore>
       </xmlData>
   </mdWrap>
   </dmdSec>
   <dmdSec ID="dmdSec_4">
       <mdWrap MDTYPE="OTHER" OTHERMDTYPE="CUSTOM">
           <xmlData>
               <forms_part_of>Riley Studios collection </forms_part_of>
               <repository>New Caledonia Public Library</repository>
               <project_website>http://www.ncpl/donlangfieldphotographs.ca</project_website>
               <digital_image_format>image/jp2</digital_image_format>
           </xmlData>
       </mdWrap>
   </dmdSec>
   <fileSec>
       <fileGrp USE="original">
           <file ID="BrocktonOval.jp2-aeebe429-9b5f-453c-8f73-57ed53f12b6f" GROUPID="Group-aeebe429-9b5f-453c-8f73-57ed53f12b6f" ADMID="amdSec_1">
               <FLocat xlink:href="objects/BrocktonOval.jp2" LOCTYPE="OTHER" OTHERLOCATYPE="SYSTEM"/>
           </file>
           <file ID="QE_Park_sunset.jp2-47faa4c2-fa23-4484-aa08-8d50945b1c5d" GROUPID="Group-47faa4c2-fa23-4484-aa08-8d50945b1c5d" ADMID="amdSec_2">
               <FLocat xlink:href="objects/QE_Park_sunset.jp2" LOCTYPE="OTHER" OTHERLOCATYPE="SYSTEM"/>
           </file>
       </fileGrp>
   </fileSec>
   <structMap TYPE="physical" LABEL="Archivematica default">
       <div TYPE="directory" LABEL="Simple-0c754dae-6a7f-4837-9ecd-8a0ff36e694b">
           <div TYPE="directory" LABEL="objects">
               <div TYPE="Item" DMDID="dmdSec_1 dmdSec_2">
                   <fptr FILEID="BrocktonOval.jp2-aeebe429-9b5f-453c-8f73-57ed53f12b6f"/>
               </div>
               <div TYPE="Item" DMDID="dmdSec_3 dmdSec_4">
                   <fptr FILEID="QE_Park_sunset.jp2-47faa4c2-fa23-4484-aa08-8d50945b1c5d"/>
               </div>
               <div TYPE="directory" LABEL="submissionDocumentation">
                   <div TYPE="directory" LABEL="transfer-Simple-525a57bb-cec8-4279-ae77-b95171f84c59"/>
               </div>
           </div>
       </div>
   </structMap>
   </mets>


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


**METS file**

.. code:: bash

   <mets xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/METS/" xsi:schemaLocation="http://www.loc.gov/METS/ http://www.loc.gov/standards/mets/version18/mets.xsd">
   <dmdSec ID="dmdSec_1">
       <mdWrap MDTYPE="DC">
           <xmlData>
               <dublincore xsi:schemaLocation="http://purl.org/dc/elements/1.1 http://dublincore.org/schemas/xmls/qdc/dc.xsd http://purl.org/dc/terms/ http://dublincore.org/schemas/xmls/qdc/2008/2/11/dcterms.xsd">
               <title>Coast News, January 02, 1964</title>
               <subject>Gibsons (B.C.)--Newspapers</subject>
               <description>Serving the Growing Sunshine Coast</description>
               <publisher>Fred Cruice</publisher>
               <date>1964/01/02</date>
               <language>English</language>
           </dublincore>
       </xmlData>
   </mdWrap>
   </dmdSec>
   <dmdSec ID="dmdSec_2">
       <mdWrap MDTYPE="OTHER" OTHERMDTYPE="CUSTOM">
           <xmlData>
               <alternative_title>Sunshine Coast News</alternative_title>
               <dates_of_publication>1945-1995</dates_of_publication>
               <frequency>Weekly</frequency>
               <forms_part_of>British Columbia Historical Newspapers Collection</forms_part_of>
               <repository>
                   Sunshine Coast Museum and Archives
               </repository>
               <project_website>http://historicalnewspapers.library.ubc.ca</project_website>
               <digital_image_format>image/jp2</digital_image_format>
           </xmlData>
       </mdWrap>
   </dmdSec>
   <dmdSec ID="dmdSec_3">
       <mdWrap MDTYPE="DC">
           <xmlData>
               <dublincore xsi:schemaLocation="http://purl.org/dc/elements/1.1 http://dublincore.org/schemas/xmls/qdc/dc.xsd http://purl.org/dc/terms/ http://dublincore.org/schemas/xmls/qdc/2008/2/11/dcterms.xsd">
               <title>Coast News, January 09, 1964</title>
               <subject>Gibsons (B.C.)--Newspapers</subject>
               <description>Serving the Growing Sunshine Coast</description>
               <publisher>Fred Cruice</publisher>
               <date>1964/01/09</date>
               <language>English</language>
           </dublincore>
       </xmlData>
   </mdWrap>
   </dmdSec>
   <dmdSec ID="dmdSec_4">
       <mdWrap MDTYPE="OTHER" OTHERMDTYPE="CUSTOM">
           <xmlData>
               <alternative_title>Sunshine Coast News</alternative_title>
               <dates_of_publication>1945-1995</dates_of_publication>
               <frequency>Weekly</frequency>
               <forms_part_of>British Columbia Historical Newspapers Collection</forms_part_of>
               <repository>Sunshine Coast Museum and Archives</repository>
               <project_website>http://historicalnewspapers.library.ubc.ca</project_website>
               <digital_image_format>image/jp2</digital_image_format>
           </xmlData>
       </mdWrap>
   </dmdSec>
   <fileSec>
       <fileGrp USE="original">
           <file ID="page01.jp2-31e3ee5c-ff7a-4fb9-818d-e325345a5766" GROUPID="Group-31e3ee5c-ff7a-4fb9-818d-e325345a5766" ADMID="amdSec_1">
               <FLocat xlink:href="objects/Jan021964/page01.jp2" LOCTYPE="OTHER" OTHERLOCTYPE="SYSTEM"/>
           </file>
           <file ID="page02.jp2-626bc937-5a6e-4a32-adf4-7db7ab5a3e66" GROUPID="Group-626bc937-5a6e-4a32-adf4-7db7ab5a3e66" ADMID="amdSec_2">
               <FLocat xlink:href="objects/Jan021964/page02.jp2" LOCTYPE="OTHER" OTHERLOCTYPE="SYSTEM"/>
           </file>
           <file ID="page01.jp2-38e939e0-74fe-4ace-81ff-da4b89fa3481" GROUPID="Group-38e939e0-74fe-4ace-81ff-da4b89fa3481" ADMID="amdSec_3">
               <FLocat xlink:href="objects/Jan091964/page01.jp2" LOCTYPE="OTHER" OTHERLOCTYPE="SYSTEM"/>
           </file>
           <file ID="page02.jp2-f42aaa1b-3816-45ed-9419-193474462481" GROUPID="Group-f42aaa1b-3816-45ed-9419-193474462481" ADMID="amdSec_4">
               <FLocat xlink:href="objects/Jan091964/page02.jp2" LOCTYPE="OTHER" OTHERLOCTYPE="SYSTEM"/>
           </file>
       </fileGrp>
   </fileSec>
   <structMap TYPE="physical" LABEL="Archivematica default">
       <div TYPE="directory" LABEL="Compound-6ef65864-d8ce-46df-b6e7-cd7d75498110">
           <div TYPE="directory" LABEL="objects">
               <div TYPE="directory" LABEL="Jan021964" DMDID="dmdSec_1 dmdSec_2">
                   <div TYPE="item">
                       <fptr FILEID="page01.jp2-31e3ee5c-ff7a-4fb9-818d-e325345a5766"/>
                   </div>
                   <div TYPE="item">
                       <fptr FILEID="page02.jp2-626bc937-5a6e-4a32-adf4-7db7ab5a3e66"/>
                   </div>
               </div>
               <div TYPE="directory" LABEL="Jan091964" DMDID="dmdSec_3 dmdSec_4">
                   <div TYPE="item">
                       <fptr FILEID="page01.jp2-38e939e0-74fe-4ace-81ff-da4b89fa3481"/>
                   </div>
                   <div TYPE="item">
                       <fptr FILEID="page02.jp2-f42aaa1b-3816-45ed-9419-193474462481"/>
                   </div>
               </div>
               <div TYPE="directory" LABEL="submissionDocumentation">
                   <div TYPE="directory" LABEL="transfer-Compound-03e22333-4ce3-415f-adbf-9d392931bfb6"/>
               </div>
           </div>
       </div>
   </structMap>
   </mets>


:ref:`Back to the top <import-metadata>`
