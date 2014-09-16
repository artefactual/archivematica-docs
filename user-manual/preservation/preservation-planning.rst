.. _preservation-planning:

=====================
Preservation planning
=====================

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
with more comprehensive, administrative instructions in the Administrator
manual under Format Policy Registry (FPR)

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
policies is maintained by Artefactual Systems, Inc. at
`fpr.archivematica.org <http://fpr.archivematica.org>`_.
This server stores structured information about normalization format policies
for preservation and access. You can update your local FPR from the FPR server
using the UPDATE button in the preservation planning tab of the dashboard. In
addition, you can maintain local rules to add new formats or customize the
behaviour of Archivematica. The Archivematica dashboard communicates with the
FPR server via a REST API.

.. note::

   As of version 1.2, there is no public facing data at fpr.archivematica.org.
   Please see the public roadmap to review development planning for the public
   interface and future functionality of the FPR.

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

Updating format policies
^^^^^^^^^^^^^^^^^^^^^^^^

FPR rules can be updated at any time from within the Preservation Planning tab
in Archivematica. Selecting the "update" button will initiate an FPR pull
which will bring in any new or altered rules since the last time an update was
performed.


Types of FPR entries
^^^^^^^^^^^^^^^^^^^^

Format
""""""

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

Format Group
""""""""""""

A format group is a convenient grouping of related file formats which share
common properties. For instance, the FPR includes an "Image (raster)" group
which contains format records for GIF, JPEG, and PNG. Each format can belong
to one (and only one) format group.

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

Instructions on writing commands can be found in the administrator manual.

Identification
""""""""""""""

**Tools**

The identification tool properties in Archivematica control the ways in which
Archivematica identifies files and associates them with the FPR's version
records. The current version of the FPR server contains two tools: a script
based on the `Open Planets Foundation's <http://www.openplanetsfoundation.org/>`_
`FIDO <https://github.com/openplanets/fido/>`_ tool, which identifies based on
the IDs in PRONOM, and a simple script which identifies files by their file
extension. You can use the identification tools portion of FPR to customize
the behaviour of the existing tools, or to write your own.

**Commands**

Identification commands contain the actual code that a tool will run when
identifying a file. This command will be run on every file in a transfer.

Instructions on writing an identification command can be found in the administrator
manual.

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

Instructions on writing an identification rule can be found in the administrator
manual.

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

**Writing a new characterization command**

Information on writing new characterization commands can be found in the FPR
administrator's manual.

A characterization command is designed to run a tool and produce output to
standard out. Output from characterization commands is expected to be valid
XML, and will be included in the AIP's METS document within the file's
``<objectCharacteristicsExtension>`` element.




.. _pres-policies:

Preservation planning policies
------------------------------

''We should also include a write up about establishing local policies and
monitoring the preservation environment, as well as an explanation that the
groups are relatively arbitrary and can be adjusted to suit local policies.''


