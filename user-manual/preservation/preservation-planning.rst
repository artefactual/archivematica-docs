.. _preservation-planning:

=====================
Preservation planning
=====================

The Preservation Planning tab displays the local
:ref:`Format Policy Registry (FPR) <fpr>`. Administrative users can add or edit
format policies using forms on this page. Detailed instructions are below:
:ref:`Altering rules and commands <fpr-instruct>`.

Archivematica's primary format preservation strategy is to normalize files to
preservation and access formats upon ingest. The preservation copies are added
to the AIP and the access copies are used to generate a DIP for upload to the
access system. Note that the original files are always kept, to allow for
different preservation actions in the future, such as normalization to
different archival formats or emulation.

Normalization and other preservation actions such package extraction,
characterization, validation, identification, verification and transcription
are managed in Archivematica's Preservation Planning tab.

*On this page:*

* :ref:`Format Policy Registry (FPR) <fpr>`

* :ref:`Preservation planning policies <pres-policies>`

* :ref:`Altering rules and commands <fpr-instruct>`

.. _fpr:

Format Policy Registry (FPR)
----------------------------

The Format Policy Registry (FPR) allows Archivematica users to define format
policies for handling file formats. A format policy indicates the actions,
tools and commands to apply to a digital object of a particular format (e.g.
conversion to preservation format, conversion to access format, extraction of
package formats). Format policies may change over time as local and community
standards, practices and tools evolve.

When you install Archivematica, default formats, rules and commands are
installed and accessed through the Preservation Planning tab. When you upgrade to
a new release of Archivematica, new formats, rules and commands may be added
(check the release notes for the specific release to find out).  In addition, you
can maintain local rules to add new formats or customize the behaviour of
Archivematica. Your local changes are maintained if you upgrade your
Archivematica pipeline to a new version.

FPR entries
^^^^^^^^^^^

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
  Many identification and characterization tools, use PRONOM ID's to recognize
  formats.

* Access format and Preservation format - Indicates whether this format is
  suitable as an access format for end users, and for preservation.

When a new version of Archivematica is released, typically new formats are
added from recent releases of PRONOM.

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

* Data Visualization

* Database

* Dataset

* Desktop Publishing

* Disk Image

* Email

* Flash

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

Format policy rules and commands
""""""""""""""""""""""""""""""""

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

Identification
""""""""""""""

**Tools**

The identification tool properties in Archivematica control the ways in which
Archivematica identifies files and associates them with the FPR's version
records. The current version of the FPR server contains three tools: the
`Open Preservation Foundation's <http://openpreservation.org//>`_
`Fido <https://github.com/openpreserve/fido/>`_ tool, which identifies based on
the IDs in PRONOM; a simple script which identifies files by their file
extension; and `Siegfried <http://www.itforarchivists.com/siegfried>`_ which like
Fido, is based on PRONOM ID and provides detailed information on the basis for
format matches in its output.  You can use the identification tools portion of
FPR to customize the behaviour of the existing tools, or to write your own.

**Rules**

Identification rules allow you to define the relationship between the
output created by an identification tool, and one of the formats which exists
in the FPR.

Identification rules are necessary only if identifying files by extension- if
using either Fido or Siegfried, the tool will do the identification based on
PUID.

**Commands**

Identification commands contain the actual code that a tool will run when
identifying a file. This command will be run on every file in a transfer.

Format policy registry tools
""""""""""""""""""""""""""""

This is a list of the tools in use by Archivematica for the various preservation
tasks being managed by the FPR. To add a new tool, see
:ref:`Altering rules and commands <fpr-instruct>` below.

Characterization
""""""""""""""""

Characterization is the process of producing technical metadata for an object.
Archivematica's characterization aims both to document the object's
significant properties and to extract technical metadata contained within the
object.

**Rules**

This lists the characterization commands associated with various formats. Note
that formats that are not listed will be characterized by FITS by default.

**Commands**

Output from characterization commands is expected to be valid
XML, and will be included in the AIP's METS document within the file's
``<objectCharacteristicsExtension>`` element. Tools supported by default are:

*Default*

The default characterization tool is FITS; it will be used if no specific
characterization rule exists for the file being scanned.

It is possible to create new default characterization commands, which can
either replace FITS or run alongside it on every file.

*Multimedia*

If using Archivematica's default commands, all three of these tools are run on
multimedia files:

* `FFprobe <http://ffmpeg.org/>`_, a characterization tool built on top of the
   same core as FFmpeg, the normalization software used by Archivematica

* `MediaInfo <http://mediaarea.net/en/MediaInfo>`_, a characterization tool
   oriented towards audio and video data

* `ExifTool <http://www.sno.phy.queensu.ca/~phil/exiftool/index.html>`_, a
   characterization tool oriented towards still image data and extraction of
   embedded metadata

*Disk images*

The fiwalk command from Sleuthkit is used for characterization of disk image
formats.

Event Detail
""""""""""""

Event detail ensures that information about the software running a command is
written to the METS file as the "event detail" property.

**Rules**

Rules are not required for Event detail, only commands.

**Commands**

The commands describe the event detail output written to the METS file when using
various FPR commands; typically, the name and version of the tool being used.


Extraction
""""""""""

Extraction refers to the extraction of content from package formats, such as
disk images and various zip formats.

**Rules**

This lists the extraction commands associated with various formats.

**Commands**

Archivematica by default supports three extraction commands- 7zip, for most
7zip compatible formats, unrar-free, for RAR formats, and Sleuthkit, for
many disk image formats.

Normalization
"""""""""""""

Normalization rules determine how Archivematica will handle the creation of
access and preservation copies during the Ingest of packages.

**Rules**

This lists the normalization (format conversion) commands associated with various
formats. Normalization rules have three purposes: Access, for use in the DIP,
Preservation, for use in the AIP, and Thumbnail, for use in both the AIP and DIP.
You may only have one normalization rule per format per purpose.

The success rate of each normalization rule is show in the "Success" column.

**Commands**

Archivematica by default has 15 normalization commands, some of which use
Archivematica-specific scripts, the rest of which use tools such as ImageMagick
(convert command), Ghostscript, Inkscape, ps2pdf and ffmpeg.

Transcription
"""""""""""""

Transcription runs an OCR tool on image files which contain text.

**Rules**

This lists the transcription commands associated with various formats.

**Commands**

By default, Archivematica supports one transcription command, which uses
the OCR tool Tesseract.

Validation
""""""""""

Format validation ensures that files are well-formed and compliant with any
relevant format specifications.

File validation can also be used to create institution-specific policies for
multimedia using the MediaConch tool.

**Rules**

This lists the commands associated with validating various formats.

**Commands**

Archivematica by default supports two tools for validation: JHOVE, which is used
on a wide variety of formats, and MediaConch which is used to validate Matroska
(mkv) files. MediaConch can also be used to create custom validation commands
which check files against a local policy on a variety of multimedia formats.
These policy checks can be performed on originals, preservation derivatives and
access derivatives. For more information please see:
`MediaConch workflow <https://wiki.archivematica.org/MediaConch_workflow>`_.

Verification
""""""""""""
Verification is run after normalization commands. Archivematica will run two
commands: one checks if a file exists, and the other checks if the file exists
and is greater than 0 bytes in size.

Verification is run on the output of normalization, not on the original file.

.. _pres-policies:

Preservation planning policies
------------------------------

It is important for institutions to establish local policies and practices
that include monitoring the digitial preservation environment to help inform
format normalization rules over time as standards and tools evolve.

We recommend documenting your policies and pratices, in accordance with the TRAC
standard for auditing Trusted Digital Repositories
(`ISO 16363:2012 <http://www.iso.org/iso/catalogue_detail.htm?csnumber=56510>`_).

.. seealso::

   :ref:`TRAC auditing tool <trac>`

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

.. code:: bash

   import os.path, sys
   (_, extension) = os.path.splitext(sys.argv[1])
   if len(extension) == 0:
           exit(1)
   else:
           print extension.lower()

Here's a more complex Python example, which uses
`Exiftool's <http://www.sno.phy.queensu.ca/~phil/exiftool/>`_ XML output to
return the MIME type of a file:

.. code:: bash

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



:ref:`Back to the top <preservation-planning>`
