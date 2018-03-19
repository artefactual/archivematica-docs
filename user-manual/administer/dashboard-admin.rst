.. _dashboard-admin:

============================
Dashboard administration tab
============================

This page describes dashboard user administration in Archivematica via the
dashboard. For higher level, technical administrative documentation, please
see :ref:`Administrator manual <home>`.

The Archivematica administration pages, under the Administration tab of the
dashboard, allows you to configure application components and manage users.

*On this page:*

* :ref:`Processing configuration <dashboard-processing>`

  * :ref:`Fields and options <processing-config-fields>`

* :ref:`General <dashboard-general>`

* :ref:`Failures <dashboard-failures>`

* :ref:`Transfer source locations <dashboard-transfer-source>`

* :ref:`AIP storage locations <dashboard-AIP-stor>`

* :ref:`Processing storage usage <dashboard-usage>`

* :ref:`AtoM DIP upload <dashboard-atom>`

* :ref:`ArchivesSpace DIP upload <dashboard-AS>`

* :ref:`Archivists Toolkit DIP upload <dashboard-AT>`

* :ref:`PREMIS agent <dashboard-premis>`

* :ref:`REST API <dashboard-rest>`

* :ref:`Users <dashboard-users>`

* :ref:`Handle server config <handle-server>`

* :ref:`Language <language-choice>`

* :ref:`Version <version>`


.. _dashboard-processing:

Processing configuration
------------------------

The processing configuration administration page of the dashboard allows users
to configure the job decision points presented by Archivematica during transfer and
ingest. This screen provides you with an easy form to configure the default
processingMCP.xml that governs these decisions. When you change the options using
the web interface the necessary XML will be written behind the scenes.

Starting in 1.7, Archivematica includes both a default and an automated
processing configuration. The automated processing configuration is used only if
a transfer source location has been set up to move content through Archivematica
with no human operator.

.. image:: images/ProcessingConfigOptions.*
   :align: center
   :width: 60%
   :alt: Processing configuration selection screen, showing three config options: automated, borndigital, and default

Multiple processing configurations can be created using the *Add* button on the
Processing Configuration screen. Often, users create multiple configurations for
different types of content - one for audio-visual material, one for images, one
for textual records, etc. To edit an existing processing configuration file, click
on the *Edit* button to the right of the processing configuration name.

Note that alternate processing configurations (i.e. anything other than default)
are used in two ways:

#. When you reingest an AIP, you are given the opportunity to select which
   processing configuration you'd like to use.
#. You can download a specific processingMCP.xml via the command line and
   include it with a transfer. Archivematica will then use this to
   automate your transfer selections, rather than the default configuration.

All other transfers will use the default processing configuration.

In order to edit any of the selections, select a choice from the drop-down menu
to the right of the job name. Once you've made all of your selections, save the
processing configuration. The fields are described in the next section.

.. image:: images/ProcessingConfig.*
   :align: center
   :width: 60%
   :alt: Processing configuration screen in the dashboard

.. _processing-config-fields:

Processing configuration fields
===============================

Many jobs in the Archivematica transfer and ingest tabs have configurable decision
points. Automating these decisions can make the transfer and ingest process substantially
quicker, especially if you find yourself selecting the same decisions over and over.
Below is a list of the processing configuration form fields with a short description
about how they work and the drop-down options for each.

Name
++++

The name of the processingMCP.xml that you are editing.

Assign UUIDs to directories
+++++++++++++++++++++++++++

Directories are given an entry in the fileSec and assigned a unique universal
identifier (UUID). Note that the digital objects in the transfer are always
assigned a UUID.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - UUIDs are assigned.
#. **No** - UUIDs are not assigned.

Send transfer to quarantine
+++++++++++++++++++++++++++

Transfers are sequestered until virus definitions can be updated.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - transfers are automatically quarantined.
#. **No** - transfers are not sent to quarantine.

Remove from quarantine after (days)
+++++++++++++++++++++++++++++++++++

Transfers are automatically removed from quarantine after a defined number of days
and made available for further processing.

**Data entry field:** Enter the number of days that transfers should remain in
quarantine (i.e. 5).

Generate transfer structure report
++++++++++++++++++++++++++++++++++

A text file is generated showing a directory tree of the original transfer structure.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - structure report is created.
#. **No** - structure report is not created.

Select file format identification command (Transfer)
++++++++++++++++++++++++++++++++++++++++++++++++++++

Choose a tool to identify the format of the files in your transfer.

Options:

#. **None** - the user is prompted for a decision.
#. **Identify using Fido** - use `fido <http://openpreservation.org/technology/products/fido/>`_
   to identify files by their file signature.
#. **Skip File Identification** - files will not be identified.
#. **Identify using Siegfried** - use `Siegfried <https://www.itforarchivists.com/siegfried>`_
   to identify files by their signature.
#. **Identify by File Extension** - identify files by their extension rather than
   signature.

Extract packages
++++++++++++++++

Packages (such as .zip files) are unzipped and extracted into a directory.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - the contents of the package are extracted.
#. **No** - package is left as-is.

Delete packages after extraction
++++++++++++++++++++++++++++++++

Packages that have been extracted in the previous step can be deleted after extraction.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - the package is deleted.
#. **No** - the package is preserved along with the extracted content.

Perform policy checks on originals
++++++++++++++++++++++++++++++++++

If you create policies using MediaConch, run the policies against the transfer
to assess conformation.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - the transfer is checked against any policies.
#. **No** - policies are ignored.

Examine contents
++++++++++++++++

Run Bulk Extractor, a forensics tool that can recognize credit card numbers,
social security numbers, and other patterns in data. For more information on
reviewing Bulk Extractor logs, see the :ref:`Analysis pane <analysis_pane>` on
the Appraisal tab.

**Options:**

#. **None** - the user is prompted for a decision.use
#. **Yes** - Bulk Extractor scans content and creates log outputs of recognized
   patterns for review.
#. **No** - Bulk Extractor does not run.

Create SIP(s)
+++++++++++++

Create a formal SIP out of the transfer or send it to the backlog.

Options:

#. **None** - the user is prompted for a decision.
#. **Send to backlog** - transfer is sent to a backlog storage space for temporary
   storage or appraisal.
#. **Create single SIP and continue processing** - transfer becomes a SIP and is made
   available for further processing on the ingest tab.

.. note::

   If you are running Archivematica in indexless mode (without Elasticsearch),
   the backlog will be unavailable and the **Send to backlog** option will not
   be present in this dropdown.

Select file format identification command (Ingest)
++++++++++++++++++++++++++++++++++++++++++++++++++

Choose a tool to identify the format of files in your SIP.

Options:

#. **None** - the user is prompted for a decision.
#. **Use existing data** - reuse file identification data from the transfer tab.
#. **Identify using Fido** - use `fido <http://openpreservation.org/technology/products/fido/>`_
   to identify files by their file signature.
#. **Identify using Siegfried** - use `Siegfried <https://www.itforarchivists.com/siegfried>`_
   to identify files by their signature.
#. **Identify by File Extension** - identify files by their extension rather than
   their signature.

Normalize
+++++++++

Convert ingested digital objects to preservation and/or access formats. See
:ref:`Normalize <normalize>` for more information.

Options:

#. **None** - the user is prompted for a decision.
#. **Normalize for preservation and access** - creates preservation copies of the
   objects plus access copies which will be used to generate the DIP.
#. **Normalize for preservation** - creates preservation copies only. No access
   copies are created and no DIP will be generated.
#. **Normalize manually** - see :ref:`Manual Normalization <manual-norm>` for
   more information.
#. **Do not normalize** - the AIP will contain originals only. No preservation or
   access copies are generated and no DIP will be generated.
#. **Normalize service files preservation** - see :ref:`Digitization <digitized>`
   for more information.
#. **Normalize for access** - the AIP will contain originals only. No preservation
   copies will be generated. Access copies will be created which will be used to
   generate the DIP.

Approve normalization
+++++++++++++++++++++

The dashboard allows users to review the normalization output and the normalization
report.

Options:

#. **None** - the user has a chance to review and approve normalization.
#. **Yes** - skip the review step and automatically continue processing.

Perform policy checks on preservation derivatives
+++++++++++++++++++++++++++++++++++++++++++++++++

If you create policies using MediaConch, run the policies against the newly-created
preservation derivatives to ensure conformation.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - the normalized files are checked against any policies.
#. **No** - policies are ignored.

Perform policy checks on access derivatives
+++++++++++++++++++++++++++++++++++++++++++

If you create policies using MediaConch, run the policies against the newly-created
preservation derivatives to ensure conformation.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - the normalized files are checked against any policies.
#. **No** - policies are ignored.

Bind PIDs
+++++++++

Assign persistent identifiers and send the information to a Handle Server (must
be configured).

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - PIDs are created and a API call posts the PIDs to the Handle Server.
#. **No** - PIDs are not created.

Document empty directories
++++++++++++++++++++++++++

By default, Archivematica removes empty directories and does not document that they existed.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - an entry for the directory is created in the structmap.
#. **No** - the directory is not documented.

Reminder: add metadata if desired
+++++++++++++++++++++++++++++++++

Archivematica allows users to see :ref:`add metadata <add-metadata>` to the SIP using
the GUI. This reminder occurs at the last moment that it is possible to add
metadata; once the ingest proceeds past this point, it is no longer possible to
add metadata to the SIP.

Options:

#. **None** - the user has a chance to add metadata.
#. **Continue** - skip the reminder and automatically continue processing.

Transcribe files (OCR)
++++++++++++++++++++++

Users can elect to run Tesseract, an OCR tool that is included in Archivematica,
to produce text files containing file transcripts. For more information,
see (see :ref:`Transcribe SIP contents <transcribe-contents>`).

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - Tesseract runs on all OCR-able files.
#. **No** - Tesseract does not run.

Select file format identification command (Submission documentation & metadata)
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Choose a tool to identify the format of any submission documentation and/or metadata
files that were included in your transfer.

Options:

#. **None** - the user is prompted for a decision.
#. **Identify using Siegfried** - use `Siegfried <https://www.itforarchivists.com/siegfried>`_
   to identify files by their signature.
#. **Identify using Fido** - use `fido <http://openpreservation.org/technology/products/fido/>`_
   to identify files by their file signature.
#. **Identify by File Extension** - identify files by their extension rather than
   their signature.
#. **Skip File Identification** - file identification is not run on submission
   documentation or metadata files.

Select compression algorithm
++++++++++++++++++++++++++++

AIPs created by Archivematica can be stored as compressed packages or uncompressed,
depending on your storage requirements.

Options:

#. **None** - the user is prompted for a decision.
#. **7z using bzip2** - a 7Zip file is created using the tool `bzip2 <http://www.bzip.org/>`_.
#. **7z using LZMA** - a 7Zip file is created using the tool `LZMA <http://www.7-zip.org/sdk.html>`_.
#. **Uncompressed** - the AIP is not compressed.
#. **Parallel bzip2** - a 7Zip file is created using the tool `Parallel bzip2 (pbzip2) <http://compression.ca/pbzip2/>`_.

Select compression level
++++++++++++++++++++++++

If you selected a compression choice in the step above, you can determine how
compressed you would like your AIP to be. Selecting a higher compression level
means that the resulting AIP is smaller, but compression also takes longer. Lower
compression levels mean quicker compression, but a larger AIP.

Options:

#. **None** - the user is prompted for a decision.
#. **5 - normal compression mode** - the compression tool will strike a balance
   between speed and compression to make a moderately-sized, moderately-compressed
   AIP.
#. **7 - maximum compression** - a smaller AIP that takes longer to compress.
#. **9 - ultra compression** - the smallest possible AIP.
#. **3 - fast compression mode** - a larger AIP that will be compressed quickly.
#. **1 - fastest mode** - the AIP will be compressed as quickly as possible.

Store AIP
+++++++++

Once processing is complete, AIPs can be stored without interrupting the
workflow in the dashboard.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - the AIP is marked for storage automatically.

Store AIP location
++++++++++++++++++

If the previous step and this step are configured, all AIPs will be sent to the
selected storage location (unless you have included a custom processing
configuration with the transfer that defines another location).

Options:

#. **None** - the user is prompted for a decision.
#. **Default location** - the AIP is stored in the AIP storage location that has
   been defined as the default in the Storage Service.
#. **[Other storage locations]** - any other AIP storage locations that are available
   will also appear on this list.

Upload DIP
++++++++++

If a DIP was created, it can be automatically sent to an access system for which
there is an Archivematica integration.

Options:

#. **None** - the user is prompted for a decision.
#. **Upload DIP to CONTENTdm** - see :ref:`CONTENTdm <contentdm>` DIP upload
   documentation.
#. **Upload DIP to Archivists Toolkit** - see :ref:`Archivists Toolkit <archivists-toolkit>`
   DIP upload documentation.
#. **Upload DIP to AtoM** - see :ref:`AtoM <upload-atom>` DIP upload documentation.
#. **Do not upload** - the DIP will not be uploaded to an access system.
#. **Upload DIP to ArchivesSpace** - see :ref:`ArchivesSpace <upload-as>` DIP
   upload documentation.

Store DIP
+++++++++

If a DIP was created, it can be stored without interrupting the workflow in the
dashboard. Note that DIP storage is not required, and that DIPs can be created
on demand by :ref:`reingesting the AIP <reingest>`.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - the DIP is marked for storage automatically.

Store DIP location
++++++++++++++++++

If the previous step and this step are configured, all DIPs will be sent to the
selected storage location (unless you have included a custom processing
configuration with the transfer that defines another location).

Options:

#. **None** - the user is prompted for a decision.
#. **Default location** - the DIP is stored in the DIP storage location that has
   been defined as the default in the Storage Service.
#. **[Other storage locations]** - any other DIP storage locations that are available
   will also appear on this list.

.. _dashboard-general:

General
-------

In this section, you can configure the following for your Archivematica client:

* Storage Service options
* Checksum algorithm
* Elasticsearch indexing

.. figure:: images/generalConfig.*
   :align: center
   :figwidth: 70%
   :width: 100%
   :alt: General configuration options in Administration tab of the dashboard

   General configuration options in Administration tab of the dashboard

Storage Service options
=======================

This is where you'll find the complete URL for the Storage Service, along with a
username and API key. See the Storage Service documentation for more information
about this feature.

Checksum algorithm
==================

You can select which checksum algorithm Archivematica will use during the
*Assign UUIDs and checksums* micro-service in Transfer. Choose between MD5,
SHA-1, SHA-256 and SHA-512.

Elasticsearch indexing
======================

As of Archivematica 1.7, Elasticsearch is optional. Installing Archivematica
without Elasticsearch means reduced consumption of compute resources and lower
operational complexity. Disabling Elasticsearch means that the Backlog,
Appraisal, and Archival Storage tabs do not appear and their functionality is
not available.

This section in the General configuration shows if Elasticsearch is enabled or
disabled.

.. _dashboard-failures:

Failures
--------

This page displays packages that failed during processing.

.. figure:: images/FailuresAdmin.*
   :align: center
   :figwidth: 70%
   :width: 100%
   :alt: Failures report in the dashboard

   Failures report in the dashboard


Clicking the date, name or UUID will display a report of the failure:

.. image:: images/FailReport.*
   :align: center
   :width: 70%
   :alt: Failure report for a failed transfer

The Failure report can be removed from the Dashboard by clicking Delete.


.. _dashboard-transfer-source:

Transfer source location
------------------------

Archivematica allows you to start transfers using the operating system's file
browser or via a web interface. Source files for transfers, however, cannot be
uploaded using the web interface; they must exist on volumes accessible to the
Archivematica MCP server and configured via the Storage Service.

When starting a transfer you are required to select one or more directories of
files to add to the transfer.


.. _dashboard-AIP-stor:

AIP storage locations
---------------------

AIP storage directories are directories in which completed AIPs are stored.
Storage directories can be specified in a manner similar to transfer source
directories using the Storage Service.

You can view your transfer source directories in the Administrative tab of the
dashboard under "AIP storage locations".

.. _dashboard-usage:

Processing storage usage
------------------------

This section of the Administration page displays various processing locations
with their current usage of available space.

.. image:: images/ProcessingUsage.*
   :align: center
   :width: 80%
   :alt: Processing storage usage area of Administration page

Administrators can use the "clear" buttons to delete the contents of these
processing locations to make more room on their server.

.. _dashboard-atom:

AtoM DIP upload
---------------

Archivematica can upload DIPs directly to an
`AtoM <www.accesstomemory.org>`_ website so that the contents can
be accessed online. The AtoM DIP upload configuration page is where you
specify the AtoM installation where you'd like to upload DIPs
(and, if you are using Rsync to transfer the DIP files, the Rsync transfer details).

.. figure:: images/AtoMDIPConfig.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: AtoM DIP upload configuration in Dashboard.

   AtoM DIP upload configuration in Dashboard.

The required parameters are:

* **Upload URL** : the URL of the destination AtoM website.

* **Login email** : the email address used to log in to AtoM.

* **Login password** : the password used to log in to AtoM.

* **AtoM version** : the version of the destination AtoM website (find in Admin -> Settings -> Global).

.. note::

   Archivematica 1.5 has been tested with and is recommended for use with AtoM 2.2
   and AtoM 2.3.

If you are using Rsync to send the DIP to AtoM, enter Rsync details:

* **Rsync target** : Destination value for rsync, e.g. ``foobar.com:/dips``

* **Rsync command** : Used to specify the remote shell manually, e.g. ``ssh -p 22222 -l user``

If you are not using Rsync, leave these fields blank.

If you would like to have additional details in failure reports, also enable debug mode by choosing
"Yes".

**AtoM user interface**

In the AtoM user interface, please take note of the following:

* The sword plugin (Admin --> Plugins --> qtSwordPlugin) must be enabled in order for AtoM to receive uploaded DIPs.

* Enabling Job scheduling (Admin --> Settings --> Job scheduling) in version 2.1 or lower is also recommended.

**Levels of description**

You can fetch levels of description from AtoM so that they can be used in
:ref:`SIP arrange <arrange-sip>`. Click on Levels of Description, then
Fetch from AtoM to get an updated list from the AtoM levels of description
taxonomy.

.. image:: images/AtoM_lod.*
   :align: center
   :width: 80%
   :alt: Levels of description from AtoM shown in Archivematica administration screen

If there are levels of description in the AtoM taxonomy that you prefer not to
use in Archivematica SIP arrange, you can remove them using the red delete
button. You can change the order that they appear in SIP arrange by using the
up/down arrows in this screen.

.. note::

   You may need an administrator to configure AtoM for DIP uploads from Archivematica.
   For administrator instructions, see :ref:`AtoM configuration <admin-dashboard-atom>` in the
   Administrator manual

   .. _dashboard-AS:

ArchivesSpace DIP upload
-----------------------------

.. image:: images/ASDIPConfig.*
   :align: right
   :width: 45%
   :alt: ArchivesSpace configuration settings

Before ingesting digital objects destined for ArchivesSpace, ensure that
the ArchivesSpace DIP upload settings in the administration tab of the
dashboard have been set.

* These settings should be created and saved before digital objects destined
  for upload to ArchivesSpace are processed. Note that these can be set
  once and used for processing any number of transfers (i.e. they do not need
  to be re-set for each transfer).

* Include the IP address of the host database (ArchivesSpace host), the database
  port (ArchivesSpace backend port), an ArchivesSpace administrative
  username, the ArchivesSpace administrative user password, and the Use Statement (see note below).

* Restrictions Apply: Selecting *Yes* will apply a blanket access restriction to all content
  uploaded from Archivematica to ArchivesSpace. Selecting *No* will send all content to
  ArchivesSpace without restrictions. Should you wish to enable the PREMIS-based restrictions functionality,
  choose "base on PREMIS" under "Restrictions Apply". To add PREMIS rights,
  please see :ref:`Add PREMIS rights and restrictions <at-premis>`.

* ArchivesSpace repository number: Insert the identifier for the ArchivesSpace repository
  to which you would like to upload DIPs here. Note that the default identifier for a
  single-repository ArchivesSpace instance is 2.

.. NOTE::

   The *Use statement* field is required. To populate this fields, you **must**
   refer to ArchivesSpace's Controlled Value Lists.

   The Use statement field in Archivematica is mapped to the Use Statement list in
   ArchivesSpace. If the uploaded materials are original master images, for example,
   you could enter ``image-master`` in the Use statement field to apply the label
   image-master to all of the uploads.

.. NOTE::

   The *Object type* field can be left blank. To populate this fields, you **must**
   refer to ArchivesSpace's Controlled Value Lists.

   The Object type field in Archivematica is mapped to the Digital Object Type list in
   ArchivesSpace. If the uploaded materials are sound recordings, you could enter ``sound_recording``
   in the Object type field to apply the label sound_recording to all of the uploads. For mixed
   media uploads, it is best to leave this field blank.

.. IMPORTANT::

   In order to save changes to the ArchivesSpace DIP upload configuration, you must
   enter the password before clicking save. Note that Archivematica will *not* show you
   an error if the password is not entered.


.. _dashboard-AT:

Archivists Toolkit DIP upload
-----------------------------

.. image:: images/ATDIPConfig.*
   :align: right
   :width: 45%
   :alt: Archivists Toolkit configuration settings

Before ingesting digital objects destined for Archivists' Toolkit, ensure that
the Achivists' Toolkit DIP upload settings in the administration tab of the
dashboard have been set.

* These settings should be created and saved before digital objects destined
  for upload to Archivists Toolkit are processed. Note that these can be set
  once and used for processing any number of transfers (i.e. they do not need
  to be re-set for each transfer). The screenshots below show the template in
  the dashboard.

* Include the IP address of the host database (db host), the database port (db
  port), the database name (db name), the database user (db user), and the
  Archivists' Toolkit user name (at username).

* Should you wish to enable the PREMIS-based restrictions functionality,
  choose "base on PREMIS" under "Restrictions Apply". To add PREMIS rights,
  please see :ref:`Add PREMIS rights and restrictions <at-premis>`.


.. seealso::

   * :ref:`Archivists Toolkit <archivists-toolkit>`
   * :ref:`Administrators manual- Archivists Toolkit DIP upload <admin-dashboard-AT>`


.. _dashboard-premis:

PREMIS agent
------------

The PREMIS agent name and code can be set via the administration interface.

.. image:: images/PREMISAdmin.*
   :align: center
   :width: 80%
   :alt: PREMIS agent settings in Administration tab

The PREMIS agent information is used in the METS files created by Archivematica
to identify the agency performing the digital preservation events.

.. seealso::

   * :ref:`Administrators manual - PREMIS <admin-dashboard-premis>`

.. _dashboard-rest:

REST API
--------

Archivematica includes a REST API for automating transfer approval.
Artefactual recommends that a technical administrator configure the options
for this feature.

To configure Archivematica to use the REST API for automation, see
:ref:`Administrator manual - REST API <admin-dashboard-rest>`.

.. _dashboard-users:

Users
-----

The dashboard provides a simple cookie-based user authentication system using
the `Django authentication framework <https://docs.djangoproject.com/en/1.4/topics/auth/>`_.
Access to the dashboard is limited only to logged-in users and a login page
will be shown when the user is not recognized. If the application can't find
any user in the database, the user creation page will be shown instead,
allowing the creation of an administrator account.

Users can be also created, modified and deleted from the Administration tab.
Only users who are administrators can create and edit user accounts.

You can add a new user to the system by clicking the "Add new" button on the
user administration page. By adding a user you provide a way to access
Archivematica using a username/password combination. Should you need to change
a user's username or password, you can do so by clicking the "Edit" button,
corresponding to the user, on the administration page. Should you need to
revoke a user's access, you can click the corresponding "Delete" button.


.. _handle-server:

Handle server config
--------------------
Archivematica can to be configured to make requests to a Handle System HTTP API
so that files, directories and entire AIPs can be assigned persistent identifiers
(PIDS) and derived persistent URLs (PURLs).

.. _language-choice:

Language
--------
The Archivematica dashboard is in the process of being translated. For more information go to `Translations <https://www.archivematica.org/en/docs/archivematica-1.7/user-manual/translations/translations/>`_.

.. _version:

Version
-------
This tab is where you can discover the version of Archivematica you're using.


:ref:`Back to the top <dashboard-admin>`
