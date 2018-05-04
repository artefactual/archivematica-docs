.. _preservation-planning:

=====================
Preservation planning
=====================

.. IMPORTANT::

  As of Archivematica 1.7, the FPR server was turned off. For more information
  about this decision, see the `Archivematica 1.7 release notes`_. Note that the
  **Update** button will still appear on the Preservation Planning tab in
  versions of Archivematica prior to 1.7, but it will not work.

Archivematica's primary preservation strategy is to normalize files to
preservation and access formats upon ingest. The preservation copies are added
to the AIP and the access copies are used to generate a DIP for upload to the
access system. Note that the original files are always kept, to allow for
different preservation actions in the future, such as normalization to
different archival formats or emulation.

Not all digital objects can be normalized on ingest. For example, for some
digital objects like CAD drawings or Microsoft Visio files there are no
available Linux-based open-source tools to handle the conversions and/or no
agreed upon preservation formats. In addition, some formats such as Microsoft
Word documents are not necessarily in the best preservation format but are
still so ubiquitous and well-supported that they need not be normalized at the
present time. In these cases, the Archivematica default is to keep them in
their original formats; format risk assessment and information received from
our users over time will allow Artefactual to expand the defaults over time to
include more formats via the :ref:`Format Policy Registry (FPR) <fpr>`.

*On this page:*

* :ref:`Preservation planning tab <pres-tab>`

* :ref:`Format Policy Registry (FPR) <fpr>`

* :ref:`Preservation planning policies <pres-policies>`

.. _pres-tab:

Preservation planning tab
-------------------------

The Preservation Planning tab displays the local
:ref:`Format Policy Registry (FPR) <fpr>`

Administrative users can add or edit format policies using forms on this page.
Detailed instructions are in the User manual - Format Policy Registry (FPR)
with more comprehensive, administrative instructions in Format Policy Registry
(FPR) :ref:`Administrators manual <fpr:index>`

A format policy consists of the business rules and tool commands for format
normalization. The FPR lists all of Archivematica's default format policy rules.

In your Archivematica instance you can download updates from the FPR by
selecting Update in the Preservation Planning tab.

To see the success rate of any given format policy, go to the Normalization
rules table in the Preservation Planning tab.

.. _fpr:

Format Policy Registry (FPR)
----------------------------

The Format Policy Registry (FPR) allows Archivematica users to define format
policies for handling file formats. A format policy indicates the actions,
tools and settings to apply to a digital object of a particular format (e.g.
conversion to preservation format, conversion to access format, extraction of
package formats). Format policies will change over time as local and community
standards, practices and tools evolve.

A public Format Policy Registry server containing Archivematica default format
policies is maintained by Artefactual Systems, Inc. at fpr.archivematica.org.
(Note: there is currently no public interface for this server). This server
stores structured information about normalization format policies for
preservation and access. You can update your local FPR from the FPR server
using the UPDATE button in the preservation planning tab of the dashboard. In
addition, you can maintain local rules to add new formats or customize the
behaviour of Archivematica. The Archivematica dashboard communicates with the
FPR server via a REST API.

.. note::

   As of version 1.4, there is no public facing data at fpr.archivematica.org.
   Please see the
   `public roadmap <https://www.archivematica.org/wiki/Development_roadmap:_Archivematica>`_
   to review development planning for the public interface and future
   functionality of the FPR.

First-time configuration
^^^^^^^^^^^^^^^^^^^^^^^^

The first time a new Archivematica installation is set up, it will attempt to
connect to the FPR server as part of the initial configuration process. As a
part of the setup, it will register the Archivematica install with the server
and pull down the current set of format policies. In order to register the
server, Archivematica will send the following information to the FPR Server,
over an encrypted connection:

1. Agent Identifier (supplied by the user during registration while installing
   Archivematica)

2. Agent Name (supplied by the user during registration while installing
   Archivematica)

3. IP address of host

4. UUID of Archivematica instance

5. current time

The only information that will be passed back and forth between Archivematica
and the FPR Server would be these format policies - what tool to run when
normalizing for a given purpose (access, preservation) when a specific File
Identification Tool identifies a specific File Format. No information about
the content that has been run through Archivematica, or any details about the
Archivematica installation or configuration would be sent to the FPR Server.

Because Archivematica is an open source project, it is possible for any
organization to conduct a software audit/code review before running
Archivematica in a production environment in order to independently verify the
information being shared with the FPR Server. An organization could choose to
run a private FPR Server, accessible only within their own network(s), to
provide at least a limited version of the benefits of sharing format policies,
while guaranteeing a completely self-contained preservation system. This is
something that Artefactual is not intending to develop, but anyone is free to
extend the software as they see fit, or to hire us or other developers to do
so.

Types of FPR entries
^^^^^^^^^^^^^^^^^^^^

Formats
"""""""

In the FPR, a "format" is a record representing one or more related format
versions, which are records representing a specific file format. For example,
the format record for "Graphics Interchange Format" (GIF) is comprised of
format versions for both GIF 1987a and 1989a.

When creating a new format version, the following fields are available:


* Description (required) - Text describing the format. This will be saved in
  METS files.

* Version (required) - The version number for this specific format version (not
  the FPR record). For example, for Adobe Illustrator 14 .ai files, you might
  choose "14".

* PRONOM ID - The specific format version's unique identifier in
  `PRONOM <http://www.nationalarchives.gov.uk/PRONOM/Default.aspx>`_, the UK
  National Archives's format registry. This is optional, but highly recommended.
  Many tools, including FIDO which is available as an identification tool option
  in the format identification micro-service in transfer and ingest, use PRONOM
  ID's to recognize formats.

* Access format and Preservation format - Indicates whether this format is
  suitable as an access format for end users, and for preservation.

Groups
""""""
A format group is a convenient grouping of related file formats which share
common properties. For instance, the FPR includes an "Image (raster)" group
which contains format records for GIF, JPEG, and PNG. Each format can belong
to one (and only one) format group.

The following format groups come pre-populated in the FPR:

* Audio

* Binary (Data)

* Binary (Executable)

* CAD

* Database

* Desktop Publishing

* Disk Image

* Email

* Font

* GIS

* Image (Raster)

* Image (Vector)

* Package

* Portable Document Format

* Presentation

* Spreadsheet

* Statistics

* Text (Markup)

* Text (Plain)

* Text (Source Code)

* Test (Structured)

* Unknown

* Video

* Word Processing

The groups as determined by Artefactual should be perceived as arbritrary and
are simply meant to make the Format Policy Registry easier to read and navigate.
If an institution so desired, they could change the names and population of the
groups in their local Preservation planning tab.

Format policy rules
"""""""""""""""""""

Throughout the FPR, Format policy rules allow commands to be associated with
specific file types. For example, in the case of Normalization rules, this
allows you to configure the command that uses ImageMagick to create thumbnails
to be run on .gif and .jpeg files, while selecting a different command to be
run on .png files.

When creating a format policy rule, the following mandatory fields must be
filled out:

* Purpose - Allows Archivematica to distinguish rules that should be used to
  normalize for preservation, normalize for access, to extract information, etc.

* Format - The file format the associated command should be selected for.

* Command - The specific command to call when this rule is used.

Instructions on writing commands can be found in the
:ref:`FPR Administrators manual <fpr:index>`.

Identification
""""""""""""""

**Tools**

The identification tool properties in Archivematica control the ways in which
Archivematica identifies files and associates them with the FPR's version
records. The current version of the FPR server contains three tools: a script
based on the `Open Planets Foundation's <http://www.openplanetsfoundation.org/>`_
`FIDO <https://github.com/openplanets/fido/>`_ tool, which identifies based on
the IDs in PRONOM; a simple script which identifies files by their file
extension; and `Siegfried <http://www.itforarchivists.com/siegfried>`_ which like
FIDO, is based on PRONOM ID and provides detailed information on the basis for
format matches in its output.  You can use the identification tools portion of
FPR to customize the behaviour of the existing tools, or to write your own.

.. note::

   The FIDO command by default in the FPR is set to a buffer size of 1MB, which
   is higher than the FIDO default of 256KB. The reason for this configuration in
   the FPR is to facilitate the identification of certain file formats that have
   their header information later in the file (see `Issue 5941 <https://projects.artefactual.com/issues/5941>`_.
   If you experience slowness using FIDO in Archivematica, you may consider either
   1., increasing the available RAM or 2., editing the FIDO identification rule
   so that the buffer size is smaller.

**Rules**

Identification rules allow you to define the relationship between the
output created by an identification tool, and one of the formats which exists
in the FPR. This must be done for the format to be tracked internally by
Archivematica, and for it to be used by normalization later on. For instance,
if you created a FIDO configuration which returns MIME types, you could create
a rule which associates the output "image/jpeg" with the "Generic JPEG" format
in the FPR.

Identification rules are necessary only when a tool is configured to return
file extensions or MIME types. Because PUIDs are universal, Archivematica will
always look these up for you without requiring any rules to be created,
regardless of what tool is being used.

Instructions on writing an identification rule can be found in the
:ref:`FPR Administrators manual <fpr:index>`.

**Commands**

Identification commands contain the actual code that a tool will run when
identifying a file. This command will be run on every file in a transfer.

Instructions on writing an identification command can be found in the
:ref:`FPR Administrators manual <fpr:index>`.

Format policy registry tools
""""""""""""""""""""""""""""

Format policy tools control how Archivematica processes files during ingest.
The most common kind of these tools are normalization tools, which produce
preservation and access copies from ingested files. Archivematica comes
configured with a number of commands and scripts to normalize several file
formats, and you can use this section of the FPR to customize them or to
create your own. These are organized similarly to the Identification Tools
documented above.

Archivematica uses the following kinds of format policy rules:

* Characterization

* Extraction

* Normalization - Access, preservation and thumbnails

* Event detail - Extracts information about a given tool in order to be inserted
  into a generated METS file.

* Transcription

* Verification - Validates a file produced by another command. For instance, a
  tool could use Exiftool or JHOVE to determine whether a thumbnail produced by
  a normalization command was valid and well-formed.


Characterization
""""""""""""""""

Characterization is the process of producing technical metadata for an object.
Archivematica's characterization aims both to document the object's
significant properties and to extract technical metadata contained within the
object.

Prior to Archivematica 1.2, the characterization micro-service always ran the
`FITS <http://projects.iq.harvard.edu/fits>`_ tool. As of Archivematica 1.2,
characterization is fully customizable by the Archivematica administrator.

**Tools**

Archivematica has four default characterization tools upon installation. Which
tool will run on a given file depends on the type of file, as determined by
the selected identification tool.

*Default*

The default characterization tool is FITS; it will be used if no specific
characterization rule exists for the file being scanned.

It is possible to create new default characterization commands, which can
either replace FITS or run alongside it on every file.

*Multimedia*

Archivematica 1.2 introduced three new multimedia characterization tools.
These tools were selected for their rich metadata extraction, as well as for
their speed. Depending on the type of the file being scanned, one or more of
these tools may be called instead of FITS.

* `FFprobe <http://ffmpeg.org/>`_, a characterization tool built on top of the
   same core as FFmpeg, the normalization software used by Archivematica

* `MediaInfo <http://mediaarea.net/en/MediaInfo>`_, a characterization tool
   oriented towards audio and video data

* `ExifTool <http://www.sno.phy.queensu.ca/~phil/exiftool/index.html>`_, a
   characterization tool oriented towards still image data and extraction of
   embedded metadata

**Commands**

Information on writing new characterization commands can be found in the FPR
administrator's manual.

A characterization command is designed to run a tool and produce output to
standard out. Output from characterization commands is expected to be valid
XML, and will be included in the AIP's METS document within the file's
``<objectCharacteristicsExtension>`` element.

Event Detail
""""""""""""
A command to provide information about the software running a command. This
will be written to the METS file as the "event detail" property. For example,
the normalization commands which use ffmpeg use an event detail command to
extract ffmpeg's version number.

For more information, see the :ref:`FPR Administrators manual <fpr:index>`.


Extraction
""""""""""

Archivematica supports extracting contents from files during the transfer phase.

Many transfers contain files which are packages of other files; examples of
these include compressed archives, such as ZIP files, or disk images.
Archivematica provides a transcription microservice which comes with several
predefined rules to extract packages, and which is fully customizeable by
Archivematica administrators. Administrators can write new commands, and
assign existing formats to run for other file formats.

**Commands**

An extraction command is passed two arguments: the file to extract, and the
path to which the package should be extracted. Similar to normalization
commands, these arguments will be interpolated directly into "bashScript" and
"command" scripts, and passed as positional arguments to "pythonScript" and
"asIs" scripts.

Information on writing a new Extraction command can be found in the
:ref:`FPR Administrators manual <fpr:index>`.

Normalization
"""""""""""""

Normalization rules determine how Archivematica will handle the creation of
access and preservation copies during the Ingest of packages.  Normalization
commands take those rules and express them as actions that Archivematica will
perform with one of its integrated tools.

Information on writing a new Normalization command can be found in the
:ref:`FPR Administrators manual <fpr:index>`.

Transcription
"""""""""""""

Archivematica 1.2 introduces a new transcription microservice. This
microservice provides tools to transcribe the contents of media objects. In
Archivematica 1.2 it is used to perform OCR on images of textual material, but
it can also be used to create commands which perform other kinds of
transcription.

**Commands**

Writing a transcription command is very similar to writing an identification
command or a normalization command.

Transcription commands are expected to write their data to disk inside the
SIP. For commands which perform OCR, metadata can be placed inside the
``metadata/OCRfiles"`` directory inside the SIP; other kinds of transcription
should produce files within``metadata``.

Information on writing a new Transcription command can be found in the
:ref:`FPR Administrators manual <fpr:index>`.

Validation
""""""""""

Archivematica runs commands to validate files on transfer using
`JHOVE <http://jhove.sourceforge.net/>`_. As of version 1.2, rules for valiadation
are defined in the Format Policy Registry.

Verification
""""""""""""
Verification is run after normalization commands. Archivematica will run two
commands: one checks if a file exists, and the other checks if the file exists
and is greater than 0 bytes in size.

Verification is run on the output of normalization, not on the original file.

.. _pres-policies:

Preservation planning policies
------------------------------

At Artefactual, we have a long-term vision that the Format Policy Registry will
be a collaborative tool for the digital preservation community.

It is important though for institutions to establish local policies and practices
that include monitoring the digitial preservation environment to help inform
format normalization rules over time as standards and tools evolve.

We recommend documenting your policies and pratices, in accordance with the TRAC
standard for auditing Trusted Digital Repositories
(`ISO 16363:2012 <http://www.iso.org/iso/catalogue_detail.htm?csnumber=56510>`_).

.. seealso::

   :ref:`TRAC auditing tool <trac>`

<<<<<<< HEAD
=======
.. _fpr-instruct:

Altering rules and commands
---------------------------

Changing Format Policy Rules
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Format policy rules allow existing commands to be associated with specific file
types. To create a new rule, click on "Create new rule" while viewing the page
of rules for the relevant micro-service (Characteriaztion, Normalization, etc.)

When creating a format policy rule, the following mandatory fields must be
filled out:

* Purpose - Allows Archivematica to distinguish rules that should be used to
  normalize for preservation, normalize for access, to extract information, etc.
* Format - The file format the associated command should be selected for.
* Command - The specific command to call when this rule is used.

You can also replace an existing rule by clicking on "Replace" beside the rule.
The revision history is tracked and can be viewed by clicking "View," and then
"Revision history."

Writing commands
^^^^^^^^^^^^^^^^

Identification commands
"""""""""""""""""""""""

Identification commands are very simple to write, though they require some
familiarity with Unix scripting.

An identification command run once for every file in a transfer. It will be
passed a single argument (the path to the file to identify), and no switches.

On success, a command should:

* Print the identifier to stdout
* Exit 0

On failure, a command should:

* Print nothing to stdout
* Exit non-zero (Archivematica does not assign special significance to non-zero
  exit codes)

A command can print anything to stderr on success or error, but this is purely
informational - Archivematica won't do anything special with it. Anything
printed to stderr by the command will be shown to the user in the
Archivematica dashboard's detailed tool output page. You should print any
useful error output to stderr if identification fails, but you can also print
any useful extra information to stderr if identification succeeds.

Here's a very simple Python script that identifies files by their file extension:

.. code::

   import os.path, sys
   (_, extension) = os.path.splitext(sys.argv[1])
   if len(extension) == 0:
           exit(1)
   else:
           print extension.lower()

Here's a more complex Python example, which uses
`Exiftool's <http://www.sno.phy.queensu.ca/~phil/exiftool/>`_ XML output to
return the MIME type of a file:

.. code::

   #!/usr/bin/env python

   from lxml import etree
   import subprocess
   import sys

   try:
       xml = subprocess.check_output(['exiftool', '-X', sys.argv[1]])
       doc = etree.fromstring(xml)
       print doc.find('.//{http://ns.exiftool.ca/File/1.0/}MIMEType').text
   except Exception as e:
       print >> sys.stderr, e
       exit(1)

Once you've written an identification command, you can register it in the FPR
using the following steps:

1. Navigate to the "Preservation Planning" tab in the Archivematica dashboard.
2. Navigate to the "Identification Tools" page, and click "Create New Tool".
3. Fill out the name of the tool and the version number of the tool in use. In
   our example, this would be "exiftool" and "9.37".
4. Click "Create".

Next, create a record for the command itself:

1. Click "Create New Command".
2. Select your tool from the "Tool" dropdown box.
3. Fill out the Identifier with text to describe to a user what this tool does.
   For instance, we might choose "Identify MIME-type using Exiftool".
4. Select the appropriate script type - in this case, "Python Script".
5. Enter the source code for your script in the "Command" box.
6. Click "Create Command".

Finally, you must create rules which associate the possible outputs of your
tool with the FPR's format records. This needs to be done once for every
supported format; we'll show it with MP3, as an example.

1. Navigate to the "Identification Rules" page, and click "Create New Rule".
2. Choose the appropriate foramt from the Format dropdown - in our case, "Audio:
   MPEG Audio: MPEG 1/2 Audio Layer 3".
3. Choose your command from the Command dropdown.
4. Enter the text your command will output when it identifies this format. For
   example, when our Exiftool command identifies an MP3 file, it will output
   "audio/mpeg".
5. Click "Create".

Once this is complete, any new transfers you create will be able to use your
new tool in the identification step.

Normalization Commands
""""""""""""""""""""""

The goal of a normalization command is to take an input file and transform it
into a new format. For instance, Archivematica provides commands to transform
video content into FFV1 for preservation, and into H.264 for access.

Archivematica provides several parameters specifying input and output
filenames and other useful information. Several of the most common are shown
in the examples below; a more complete list is in a later section of the
documentation: :ref:`Normalization command variables and arguments <norm_command>`.

When writing a bash script or a command line, you can reference the variables
directly in your code, like this:

.. code:: bash

   inkscape -z "%fileFullName%" --export-pdf="%outputDirectory%%prefix%%fileName%%postfix%.pdf"

When writing a script in Python or other languages, the values will be passed
to your script as commandline options, which you will need to parse. The
following script provides an example using the argparse module that comes with
Python:

.. code:: bash

   import argparse
   import subprocess

   parser = argparse.ArgumentParser()

   parser.add_argument('--file-full-name', dest='filename')
   parser.add_argument('--output-file-name', dest='output')
   parsed, _ = parser.parse_known_args()
   args = [
       'ffmpeg', '-vsync', 'passthrough',
       '-i', parsed.filename,
       '-map', '0:v', '-map', '0:a',
       '-vcodec', 'ffv1', '-g', '1',
       '-acodec', 'pcm_s16le',
       parsed.output+'.mkv'
   ]

   subprocess.call(args)

Once you've created a command, the process of registering it is similar to
creating a new identification tool. The folling examples will use the Python
normalization script above.

First, create a new tool record:

1. Navigate to the "Preservation Planning" tab in the Archivematica dashboard.
2. Navigate to the "Identification Tools" page, and click "Create New Tool".
3. Fill out the name of the tool and the version number of the tool in use.
   In our example, this would be "exiftool" and "9.37".
4. Click "Create".

Next, create a record for your new command:

1. Click "Create New Tool Command".
2. Fill out the Description with text to describe to a user what this tool does.
   For instance, we might choose "Normalize to mkv using ffmpeg".
3. Enter the source for your command in the Command textbox.
4. Select the appropriate script type - in this case, "Python Script".
5. Select the appropriate output format from the dropdown. This indicates to
   Archivematica what kind of file this command will produce. In this case,
   choose "Video: Matroska: Generic MKV".
6. Enter the location the video will be saved to, using the script variables.
   You can usually use the ``%outputFileName%`` variable, and add the file
   extension - in this case ``%outputFileName%.mkv``
7. Select a verification command. Archivematica will try to use this tool to
   ensure that the file your command created works. Archivematica ships with
   two simple tools, which test whether the file exists and whether it's larger
   than 0 bytes, but you can create new commands that perform more complicated
   verifications.
8. Finally, choose a command to produce the "Event detail" text that will be
   written in the section of the METS file covering the normalization event.
   Archivematica already includes a suitable command for ffmpeg, but you can
   also create a custom command.
9. Click "Create command".

Finally, you must create rules which will associate your command with the
formats it should run on.

.. _norm_command:

Normalization command variables and arguments
"""""""""""""""""""""""""""""""""""""""""""""

The following variables and arguments control the behaviour of format policy
command scripts.

+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| Name (bashScript       |  Commandline option         |  Description                               |  Sample value                                           |
| and command)           |  (pythonScript and asIs)    |                                            |                                                         |
+========================+=============================+============================================+=========================================================+
| %SIPUUID%              |  --sipuuid=                 |  The UUID of the SIP or transfer being     |  4941c1e7-722b-41dc-900a-a17f7cfd32a9                   |
|                        |                             |  processed.                                |                                                         |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %sipName%              |  --sip-name=                |  The name of the SIP or transfer being     |  this-is-a-sip                                          |
|                        |                             |  processed, parsed from its path.          |                                                         |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %SIPDirectory%         |  --sip-directory=           |  The full path of the SIP or transfer.     |  /dir/this-is-a-sip-4941c1e7-722b-41dc-900a-a17f7cfd32a9|
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %SIPDirectoryBasename% |  --sip-directory-basename=  |  The basename of the SIP or transfer.      |  this-is-a-sip-4941c1e7-722b-41dc-900a-a17f7cfd32a9     |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %SIPLogsDirectory%     |  --sip-logs-directory=      |  The full path of the SIP or transfer's    |  /dir/sip-4941c1e7-722b-41dc-900a-a17f7cfd32a9/logs     |
|                        |                             |  logs directory.                           |                                                         |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %SIPObjectsDirectory%  |  --sip-objects-directory=   |  The full path of the SIP or transfer's    |  /dir/sip-4941c1e7-722b-41dc-900a-a17f7cfd32a9/objects  |
|                        |                             |  objects directory.                        |                                                         |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %fileUUID%             |  --file-uuid=               |  The UUID of the file being processed.     |  baa67175-f04d-4df6-8615-d05d0651eae2                   |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %originalLocation%     |  --original-location=       |  The original path of the file, as first   |  /dir/sip-4941c1e7-722b-41dc-900a-a17f7cfd32a9/objects/ |
|                        |                             |  recorded by Archivematica. Note that the  |  .../file name unsanitized.jpeg                         |
|                        |                             |  filename component of this path is        |                                                         |
|                        |                             |  unsanitized, so it is possible for this   |                                                         |
|                        |                             |  string to contain data in arbitrary text  |                                                         |
|                        |                             |  encodings, including mixed encodings.     |                                                         |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %fileName%             |  --input-file=              |  The filename of the file to process.      |  video.mov                                              |
|                        |                             |  This variable holds the file's basename,  |                                                         |
|                        |                             |  not the whole path.                       |                                                         |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %fileDirectory%        |  --file-directory=          |  The directory containing the input file.  |  /path/to                                               |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %inputFile%            |  --file-name=               |  The fully-qualified path to the file to   |  /path/to/video.mov                                     |
|                        |                             |  process.                                  |                                                         |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %fileExtension%        |  --file-extension=          |  The file extension of the input file.     |  mov                                                    |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %fileExtensionWithDot% |  --file-extension-with-dot= |  As above, without stripping the period.   |  .mov                                                   |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %outputFileUUID%       |  --output-file-uuid=        |  The unique identifier assigned by         |  1abedf3e-3a4b-46d7-97da-bd9ae13859f5                   |
|                        |                             |  Archivematica to the output file.         |                                                         |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %outputDirectory%      |  --output-directory=        |  The fully-qualified path to the directory | /var/archivematica/sharedDirectory/www/AIPsStore/uuid   |
|                        |                             |  where the new file should be written.     |                                                         |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %outputFileName%       |  --output-file-name=        |  The fully-qualified path to the output    | /path/to/access/copies/video-uuid                       |
|                        |                             |  file, minus the file extension.           |                                                         |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+
| %fileGrpUse%           |  --file-grp-use=            |  The file grouping for this file. Possible |  original                                               |
|                        |                             |  values are:                               |                                                         |
|                        |                             |  * original                                |                                                         |
|                        |                             |  * submissionDocumentation                 |                                                         |
|                        |                             |  * preservation                            |                                                         |
|                        |                             |  * access                                  |                                                         |
|                        |                             |  * service                                 |                                                         |
|                        |                             |  * license                                 |                                                         |
|                        |                             |  * text/ocr                                |                                                         |
|                        |                             |  * metadata                                |                                                         |
+------------------------+-----------------------------+--------------------------------------------+---------------------------------------------------------+


Extraction commands
"""""""""""""""""""

An extraction command is passed two arguments: the file to extract, and the
path to which the package should be extracted. Similar to normalization
commands, these arguments will be interpolated directly into ``bashScript`` and
``command`` scripts, and passed as positional arguments to ``pythonScript`` and
``asIs`` scripts.

=============================   ============================================  ===================================    =======================
Name (bashScript and command)   Commandline position (pythonScript and asIs)  Description                            Sample value
=============================   ============================================  ===================================    =======================
%outputDirectory%               First                                         The full path to the directory in
                                                                              which the package's contents should
                                                                              be extracted                           /path/to/filename-uuid/
%inputFile%                     Second                                        The full path to the package file      /path/to/filename
=============================   ============================================  ===================================    =======================

Here's a simple example of how to call an existing tool (7-zip) without any
extra logic:

.. code:: bash

   7z x -bd -o"%outputDirectory%" "%inputFile%"

This Python script example is more complex, and attempts to determine whether
any files were extracted in order to determine whether to exit 0 or 1 (and
report success or failure):

.. code:: bash

   from __future__ import print_function
   import re
   import subprocess
   import sys

   def extract(package, outdir):
       # -a extracts only allocated files; we're not capturing unallocated files
       try:
           process = subprocess.Popen(['tsk_recover', package, '-a', outdir],
               stdout=subprocess.PIPE, stderr=subprocess.PIPE, stdin=subprocess.PIPE)
           stdout, stderr = process.communicate()

           match = re.match(r'Files Recovered: (\d+)', stdout.splitlines()[0])
           if match:
               if match.groups()[0] == '0':
                   raise Exception('tsk_recover failed to extract any files with the message: {}'.format(stdout))
               else:
                   print(stdout)
       except Exception as e:
           return e

       return 0

   def main(package, outdir):
       return extract(package, outdir)

   if __name__ == '__main__':
       package = sys.argv[1]
       outdir = sys.argv[2]
       sys.exit(main(package, outdir))


Transcription commands
""""""""""""""""""""""

Transcription commands are expected to write their data to disk inside the
SIP. For commands which perform OCR, metadata can be placed inside the
"metadata/OCRfiles" directory inside the SIP; other kinds of transcription
should produce files within "metadata".

For example, the following bash script is used by Archivematica to transcribe
images using the `Tesseract <https://code.google.com/p/tesseract-ocr/>`_ software:

.. code:: bash

   ocrfiles="%SIPObjectsDirectory%metadata/OCRfiles"
   test -d "$ocrfiles" || mkdir -p "$ocrfiles"

   tesseract %fileFullName% "$ocrfiles/%fileName%"
>>>>>>> 0e96a35... Add admonition re: FPR server to 1.6 docs

:ref:`Back to the top <preservation-planning>`

.. _`Archivematica 1.7 release notes`: https://wiki.archivematica.org/Archivematica_1.7_and_Storage_Service_0.11_release_notes#Archivematica_decoupled_from_the_FPR_server
