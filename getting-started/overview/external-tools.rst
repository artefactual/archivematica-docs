.. _external-tools:

==============
External tools
==============

Archivematica is built upon open-source frameworks and services (e.g. Django,
Gearman below), as well as integrating a suite(s) of free and open-source tools
that allows users to process digital objects from ingest to access based on the
ISO-OAIS functional model. In addition to the core software which is released
under `GNU Affero General Public License (AGPL)`_, the following tools are
bundled with Archivematica.

`BagIt`_
^^^^^^^^
Standard and script to package digital objects and metadata for archival
storage. Archivematica uses the bagit-python library.

**License**: Public domain

`bulk_extractor`_
^^^^^^^^^^^^^^^^^
Disk image and file contents analysis tool.

**License**: Public domain

`ClamAV`_
^^^^^^^^^
Anti-virus toolkit for UNIX.

**License**: `GNU General Public License`_

`Django`_
^^^^^^^^^
Django is a high-level Python Web framework that encourages rapid development
and clean, pragmatic design.

**License**: `BSD (3-clause)`_

`ElasticSearch`_
^^^^^^^^^^^^^^^^
Elasticsearch is a search engine based on the Lucene library. It provides a
distributed, multitenant-capable full-text search engine with an HTTP web
interface and schema-free JSON documents. Elasticsearch is developed in Java.

**License**: `Apache License, Version 2.0 (the "License")`_

`ExifTool`_
^^^^^^^^^^^
ExifTool is a platform-independent Perl library plus a command-line application
for reading, writing and editing meta information in a wide variety of files.

**License**: `GNU General Public License, version 1`_ or `Artistic License`_

`FFmpeg`_
^^^^^^^^^
A complete, cross-platform solution to record, convert and stream audio and
video.

**License**: `GNU Lesser General Public License, version 2.1`_

`fido`_
^^^^^^^
Format Identification for Digital Objects (FIDO) is a Python command-line tool
to identify the file formats of digital objects.

**License**: `Apache License, Version 2.0 (the "License")`_

`File Information Tool Set (FITS)`_
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
File format identification and validation software integration tool.

**License**: `GNU Lesser General Public License`_

`Gearman`_
^^^^^^^^^^
Gearman provides a generic application framework to farm out work to other
machines or processes that are better suited to do the work.

**License**: BSD License

`Ghostscript`_
^^^^^^^^^^^^^^
An interpreter for the PostScript language and for PDF.

**License**: `GNU Affero General Public License (AGPL)`_

`Imagemagick`_
^^^^^^^^^^^^^^
ImageMagick is a free and open-source software suite for displaying, converting,
and editing raster image and vector image files. It can read and write over 200
image file formats.

**License**: `Imagemagick license`_ (GPL compatible)

`Inkscape`_
^^^^^^^^^^^
Converts vector images to Scalable Vector Graphic (SVG) format.

**License**: `GNU General Public License, version 2`_

`JHOVE`_
^^^^^^^^
File format validation tool.

**License**: `GNU Lesser General Public License`_

`MediaConch`_
^^^^^^^^^^^^^
MediaConch is an extensible, open source software project consisting of an
implementation checker, policy checker, reporter, and fixer that targets
preservation-level audiovisual files.

**License**: `BSD (2-clause)`_

`MediaInfo`_
^^^^^^^^^^^^
MediaInfo is a convenient unified display of the most relevant technical and tag
data for video and audio files.

**License**: `BSD (2-clause)`_

`Nailgun`_
^^^^^^^^^^
A client, protocol, and server for running Java programs from the command line.

**License**: `Apache License, Version 2.0 (the "License")`_

`NFS-common`_
^^^^^^^^^^^^^
Network File System Access - allows access to files on network storage devices.

**License**: `GNU General Public License`_

`p7zip`_
^^^^^^^^
7-Zip is a file archiver with a high compression ratio.

**License**: `GNU General Public License`_

`Python-lxml`_
^^^^^^^^^^^^^^
Python binding for libxml2 and libxslt.

**License**: `GNU General Public License`_

`rsync`_
^^^^^^^^
A fast, versatile, remote (and local) file-copying tool.

**License**: `GNU General Public License`_


`Siegfried`_
^^^^^^^^^^^^
File format identification tool.

**License**: `Apache License, Version 2.0 (the "License")`_

`Sleuthkit`_
^^^^^^^^^^^^
Disk image management and extraction toolkit.

**License**: `Common Public License`_

`Tesseract`_
^^^^^^^^^^^^
Optical Character Recognition tool (reads image files and convert to text).

**License**: `Apache License, Version 2.0 (the "License")`_

`Ubuntu Linux`_
^^^^^^^^^^^^^^^
Interface with computing hardware. Ubuntu Linux server edition.

**License**: `GNU General Public License`_

`UUID`_
^^^^^^^
Command line interface (CLI) for the generation of DCE 1.1, ISO/IEC 11578:1996
and IETF RFC-4122 compliant Universally Unique Identifier (UUID).

**License**: `GNU General Public License`_

`unar`_
^^^^^^^
The Unarchiver is an archive unpacker program.

**License**: `GNU General Public License`_

:ref:`Back to the top <external-tools>`

.. _Apache License, Version 2.0 (the "License"): https://www.apache.org/licenses/LICENSE-2.0
.. _Artistic License: http://dev.perl.org/licenses/artistic.html
.. _BagIt: https://github.com/LibraryOfCongress/bagit-python
.. _BSD (2-clause): https://opensource.org/licenses/BSD-2-Clause
.. _BSD (3-clause): https://opensource.org/licenses/BSD-3-Clause
.. _bulk_extractor: https://github.com/simsong/bulk_extractor
.. _ClamAV: http://www.clamav.net/
.. _`Common Public License`: https://opensource.org/licenses/cpl1.0.php
.. _Django: https://www.djangoproject.com/
.. _ElasticSearch: http://www.elasticsearch.org/
.. _ExifTool: http://www.sno.phy.queensu.ca/~phil/exiftool/index.html
.. _FFmpeg: http://ffmpeg.org/
.. _fido: https://github.com/openpreserve/fido/
.. _File Information Tool Set (FITS): https://projects.iq.harvard.edu/fits
.. _Gearman: http://gearman.org/
.. _Ghostscript: https://www.ghostscript.com/
.. _GNU Affero General Public License (AGPL): https://www.gnu.org/licenses/agpl-3.0.en.html
.. _GNU General Public License: https://www.gnu.org/licenses/gpl-3.0.en.html
.. _GNU General Public License, version 1: https://www.gnu.org/licenses/old-licenses/gpl-1.0.html
.. _GNU General Public License, version 2: https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
.. _GNU Lesser General Public License, version 2.1: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html
.. _GNU Lesser General Public License: http://www.gnu.org/licenses/lgpl-3.0.html
.. _hashdeep/md5deep: http://md5deep.sourceforge.net/
.. _Imagemagick: http://www.imagemagick.org/script/index.php
.. _Imagemagick license: http://www.imagemagick.org/script/license.php
.. _Inkscape: http://www.inkscape.org/
.. _JHOVE: https://github.com/openpreserve/jhove
.. _MediaConch: https://mediaarea.net/MediaConch
.. _MediaInfo: https://mediaarea.net/en/MediaInfo
.. _Nailgun: https://github.com/facebook/nailgun
.. _NFS-common: https://pkgs.org/download/nfs-common
.. _p7zip: http://p7zip.sourceforge.net/
.. _Python-lxml: https://lxml.de/
.. _rsync: https://linux.die.net/man/1/rsync
.. _Siegfried: https://github.com/richardlehane/siegfried
.. _Sleuthkit: http://www.sleuthkit.org/
.. _Tesseract: http://code.google.com/p/tesseract-ocr/
.. _Ubuntu Linux: https://ubuntu.com/
.. _UUID: http://www.ossp.org/pkg/lib/uuid/
.. _unar: http://unarchiver.c3.cx/commandline
.. _Zip: http://manpages.ubuntu.com/manpages/hardy/man1/zip.1.html
