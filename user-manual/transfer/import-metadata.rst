.. _import-metadata:

===============
Import metadata
===============

You can import metadata by including a directory called ``metadata`` in your
transfer. The directory can contain any type of metadata that you wish to
preserve alongside your digital objects. The Process Metadata Directory
`Microservice`_ will perform a number of preservation actions on objects in this
directory.

Archivematica also supports conventions for importing descriptive metadata
and rights metadata that will tranpose the contents of the metadata files
into the METS file. Metadata in the METS file is searchable in the
:ref:`Archival Storage <archival-storage>` tab.

*On this page:*

* :ref:`Importing descriptive metadata with metadata.csv <metadata.csv>`
* :ref:`Importing rights metadata with rights.csv <rights.csv>`

.. seealso::

   :ref:`Create a transfer with submission documentation <create-submission>`

.. _metadata.csv:

Importing descriptive metadata with metadata.csv
------------------------------------------------

Archivematica natively supports the Dublin Core Metadata Elements Set, the basic
15 Dublin Core metadata elements. Using the metadata.csv method, users can
include non-Dublin Core metadata at the directory level or at the object level.

Archivematica will not be able to pass this metadata to AtoM or to
ArchivesSpace.

Dublin Core metadata is written to the dmdSec of the METS file as MDTYPE="DC".
Non-Dublin Core metadata will be written into a separate dmdSec as
MDTYPE="OTHER". A sample of the METS output is available below.

1. Create a transfer that contains a directory called ``metadata``.

2. For simple objects, digital objects should also be placed in the top-level
   directory.

.. figure:: images/MdfolderMDimport-10.*
   :align: center
   :alt: Metadata folder in transfer directory contains metadata.csv file

   Metadata folder in transfer directory containing metadata.csv file.

2. For compound objects, create one or more subdirectories in the
   objects directory, each containing the files that form a compound object.

.. important::

   The subdirectory names must not contain spaces or other forbidden characters.

3. Add a csv file to the metadata folder for the transfer called
   ``metadata.csv``.

   * The first row of the csv file consists of field names. Field names must not
     include spaces.

   * Dublin Core field names must contain the "dc" element in the name, e.g.
     "dc.title". Note that the Dublin Core is not validated - this is up to the
     user.

   * Dublin Core terms must contain "dcterms" in the name, e.g.
     "dcterms:abstract". As above, the Dublin Core is not validated - this is up
     to the user.

   * Each subsequent row contains the field values for a single directory or
     file.

   * As of version 1.4, both directory and object level metadata is allowed
     in the metadata.csv. The csv can contain only object level, only directory
     level, or a combination of both.

   * For multi-value fields (such as dc.subject), the entire column is repeated
     and each column contains a single value (i.e. there should be multiple
     dc.subject columns if there are multiple subject terms).

   * Empty columns can be deleted, if you prefer.

   * The first column in the metadata.csv file must be a "filename" column
     listing the filepath and filename or directory name of each object or
     directory: e.g. "objects/BrocktonOval.jp2" , or "objects/Jan021964".

   * If you have directory level metadata fill out the fields on the same line
     as the directory (ie objects/)

   * Note that filenames can be duplicates of filenames in other subdirectories
     if desired. For example, the name "page01.jp2" can occur in multiple
     subdirectories.

  .. figure:: images/CsvMDimport-10.*
     :align: center
     :alt:  Example csv file contents

     Example of metadata.csv file contents

4. At the generate METS microservice, Archivematica parses the metadata in
   metadata.csv to the METS file, as follows:

   * All Dublin Core elements are used to generate a dmdSec for each directory
     or file with MDTYPE="DC"

   * All non-Dublin Core elements are used to generate a dmdSec for each
     directory or file with MDTYPE="OTHER" OTHERMDTYPE="CUSTOM"

   * The dmdSecs are linked to their directories or files in the structMap.


Simple objects
--------------

This section provides metadata.csv file and METS file examples for simple
objects - i.e. individual files that are not pages in a compound object such as
a book or a newspaper issue.

**Sample metadata.csv file**

=========================  ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= =========================
filename                   dc.title                  dc.creator                dc.subject                dc.subject                dc.subject                dc.description            dc.publisher              dc.contributor            dc.date                   dc.type                   dc.format                 dc.identifier             dc.source                 dc.language               dc.relation               dc.coverage               dc.rights
=========================  ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= =========================
objects/bird.mp3           14000 Caen, France - Bird Nicolas Germain           field recording           soundscapes               radio aporee              Bird singing in my        Radio Aporee                                        2017-05-27                sound                     audio/mp3                                           Internet Archive                                                                                        Public domain
                           in my garden                                                                                                                      garden, Caen, France,
                                                                                                                                                             Zoom H6
objects/beihai.tif         Beihai, Guanxi, China,    NASA/GSFC/METI/ERSDAC/    China                     Beihai                                              Beihai is a city in the   NASA Jet Propulsion                                 February 29, 2016         image                     image.tif                                           NASA Jet Propulsion                                                                                     Public domain
                           1988                      JAROS and U.S./Japan                                                                                    south of Guangxi,         Laboratory                                                                                                                                                  Laboratory
                                                     ASTER Science Team                                                                                      People's  republic of
                                                                                                                                                             China.
=========================  ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= ========================= =========================

Note that empty columns (i.e. dc.contributor) were left in to demonstrate the
full range of possible Dublin Core values. If you prefer, you can delete empty
columns.

**METS file**

Below is a snippet of the METS file, containing two descriptive metadata
sections (dmdSec), one for each file. These contain the Dublin Core metadata
parsed from the metadata.csv. Note in the mdWrap that they are given an MDTYPE
of "DC". If there had been non-Dublin Core metadata in the metadata.csv, there
would be a separate mdWrap with an MDTYPE of "OTHER".

.. code:: xml

   <mets xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/METS/" xsi:schemaLocation="http://www.loc.gov/METS/ http://www.loc.gov/standards/mets/version18/mets.xsd">
    <dmdSec ID="dmdSec_1">
      <mdWrap MDTYPE="DC">
        <xmlData>
          <dcterms:dublincore xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xsi:schemaLocation="http://purl.org/dc/terms/ http://dublincore.org/schemas/xmls/qdc/2008/02/11/dcterms.xsd">
            <dc:title>Beihai, Guanxi, China, 1988</dc:title>
            <dc:creator>NASA/GSFC/METI/ERSDAC/JAROS and U.S./Japan ASTER Science Team</dc:creator>
            <dc:subject>satellite imagery</dc:subject>
            <dc:subject>China|Beihai</dc:subject>
            <dc:description>Beihai is a city in the south of Guangxi, Peoples republic of China.</dc:description>
            <dc:publisher>NASA Jet Propulsion Laboratory</dc:publisher>
            <dc:contributor></dc:contributor>
            <dc:date>February 29,2016</dc:date>
            <dc:type>image</dc:type>
            <dc:format>image/tif</dc:format>
            <dc:identifier></dc:identifier>
            <dc:source>NASA Jet Propulsion Laboratory</dc:source>
            <dc:language></dc:language>
            <dc:relation></dc:relation>
            <dc:coverage></dc:coverage>
            <dc:rights>Public domain</dc:rights>
          </dublincore>
        </xmlData>
      </mdWrap>
    </dmdSec>
    <mets:dmdSec ID="dmdSec_2">
      <mets:mdWrap MDTYPE="DC">
        <mets:xmlData>
          <dcterms:dublincore xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/" xsi:schemaLocation="http://purl.org/dc/terms/ http://dublincore.org/schemas/xmls/qdc/2008/02/11/dcterms.xsd">
            <dc:title>14000 Caen, France - Bird in my garden</dc:title>
            <dc:creator>Nicolas Germain</dc:creator>
            <dc:subject>field recording</dc:subject>
            <dc:subject>phonography|soundscape|sound art|soundmap|radio|ephemeral|listening|radio aporee</dc:subject>
            <dc:description>Bird singing in my garden, Caen, France, Zoom H6</dc:description>
            <dc:publisher>Radio Aporee</dc:publisher>
            <dc:contributor></dc:contributor>
            <dc:date>2017-05-27</dc:date>
            <dc:type>sound</dc:type>
            <dc:format>audio/mp3</dc:format>
            <dc:identifier></dc:identifier>
            <dc:source>Internet Archive</dc:source>
            <dc:language></dc:language>
            <dc:relation></dc:relation>
            <dc:coverage></dc:coverage>
            <dc:rights>Public domain</dc:rights>
          </dcterms:dublincore>
        </mets:xmlData>
      </mets:mdWrap>
    </mets:dmdSec>
   </mets>


Compound objects
----------------

This section provides csv file and METS file examples for compound objects -
i.e. multi-page digital objects such as newspapers and books.

**metadata.csv file**

Sample headings and values

=================  ============================ ===================  ============ ==================== ==========================  ==========  ==================================  =========   ===========  =================================================  ==================================  ==========================================  ===================
parts              dc.title                     alternative_title    dc.publisher dates_of_publication dc.subject                  dc.date     dc.description                      frequency   dc.language  forms_part_of                                      repository                          project_website                             digital_file_format
=================  ============================ ===================  ============ ==================== ==========================  ==========  ==================================  =========   ===========  =================================================  ==================================  ==========================================  ===================
objects/Jan021964  Coast News, January 02, 1964 Sunshine Coast News  Fred Cruice  1945-1995            Gibsons (B.C.)--Newspapers  1964/01/02  Serving the Growing Sunshine Coast  Weekly      English      British Columbia Historical Newspapers collection  Sunshine Coast Museum and Archives  http://historicalnewspapers.library.ubc.ca  image/jp2
objects/Jan091964  Coast News, January 09, 1964 Sunshine Coast News  Fred Cruice  1945-1995            Gibsons (B.C.)--Newspapers  1964/01/09  Serving the Growing Sunshine Coast  Weekly      English      British Columbia Historical Newspapers collection  Sunshine Coast Museum and Archives  http://historicalnewspapers.library.ubc.ca  image/jp2
=================  ============================ ===================  ============ ==================== ==========================  ==========  ==================================  =========   ===========  =================================================  ==================================  ==========================================  ===================


**METS file**

.. code:: xml

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


.. _rights.csv:

Importing rights metadata with rights.csv
-----------------------------------------

Rights information can be associated to specific files in a transfer by creating
a rights.csv file that conforms to the structure below.

You can enter multiple acts for the same rights basis. Rows for the same object
with the same rights basis will be treated as separate acts for the basis and
merged. For example, the first two rows below will be merged, while the third
row will be separate. You can read more about rights metadata here: :ref:`PREMIS
metadata in Archivematica <premis-template>`.

=============  ==========  ===========  ===================  ============  ==========  ==========  ===================  ======================  =====================  ===========  =================  =================  ===============  ==========  ========================================  ==========================================  =========================================
file           basis       status       determination_date   jurisdiction  start_date  end_date    terms                citation                note                   grant_act    grant_restriction  grant_start_date   grant_end_date   grant_note  doc_id_type                               doc_id_value                                doc_id_role
=============  ==========  ===========  ===================  ============  ==========  ==========  ===================  ======================  =====================  ===========  =================  =================  ===============  ==========  ========================================  ==========================================  =========================================
image1.tif     copyright   copyrighted  2011-01-01           ca            2011-01-01  2013-12-31  Terms of copyright.  Citation of copyright.  Note about copyright.  disseminate  disallow           2011-01-01         2013-12-31       Grant note  Copyright documentation identifier type.  Copyright documentation identifier value.   Copyright documentation identifier role.
image1.tif     copyright   copyrighted  2011-01-01           ca            2011-01-01  2013-12-31  Terms of copyright.  Citation of copyright.  Note about copyright.  use          disallow           2011-01-01         2013-12-31       Grant note  Copyright documentation identifier type.  Copyright documentation identifier value.   Copyright documentation identifier role.
document.pdf   license                                                     2000-09-09  2010-09-08  Terms of license.    Note about license.     migrate                allow                                              2000-09-00       Grant note  License documentation identifier type.    License documentation identifier value.     License documentation identifier role.
=============  ==========  ===========  ===================  ============  ==========  ==========  ===================  ======================  =====================  ===========  =================  =================  ===============  ==========  ========================================  ==========================================  =========================================

The rights.csv file is parsed by the job "Load Rights" within the "Characterize
and Extract Metadata" microservice run during :ref:`transfer <transfer>`.

:ref:`Back to the top <import-metadata>`

.. _`Microservice`: https://wiki.archivematica.org/Micro-services
