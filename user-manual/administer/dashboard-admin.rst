.. _dashboard-admin:

============================
Dashboard administration tab
============================

This page describes dashboard user administration in Archivematica via the
dashboard. For higher level, technical administrative documentation, please
see :ref:`Administrator manual <home>`.

The Archivematica administration pages, under the Administration tab of the
dashboard, allows you to configure various parts of the application and manage
integrations and users.

*On this page:*

* :ref:`Processing configuration <dashboard-processing>`

  * :ref:`Fields and options <processing-config-fields>`

* :ref:`General <dashboard-general>`
* :ref:`Failures <dashboard-failures>`
* :ref:`Transfer source locations <dashboard-transfer-source>`
* :ref:`AIP storage locations <dashboard-AIP-stor>`
* :ref:`Processing storage usage <dashboard-usage>`
* :ref:`DIP upload <dashboard-dip-upload>`

  * :ref:`AtoM/Binder DIP upload <dashboard-atom>`
  * :ref:`ArchivesSpace DIP upload <dashboard-AS>`

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
to configure the job decision points presented by Archivematica during transfer
and ingest. There are two processing configurations available on installation:

* ``Default``, which is used for any transfer started manually from the
  :ref:`Transfer tab <create-transfer>`, automatically via the
  `automation tools`_, or in any other context where no other processing
  configuration is specified.
* ``Automated``, which is used for transfers automatically started from Jisc
  RDSS environments (if you are not a Jisc user, feel free to delete this
  configuration).

.. image:: images/processing-config.*
   :align: center
   :width: 60%
   :alt: Processing configuration screen, showing two configurations: default and automated

To edit an existing processing configuration file, click on the **Edit** button
to the right of the processing configuration name.

Multiple processing configurations can be created using the **Add** button on
the Processing Configuration screen. Often, users create multiple configurations
for different types of content - one for audio-visual material, one for images,
one for textual records, etc.

You can also revert the default and automated processing configurations to their
pre-sets by clicking on **Reset**. Please note that the pre-sets for the default
processing configuration are noted in the :ref:`Processing configuration fields
<processing-config-fields>` section below.

Note that alternate processing configurations (i.e. anything other than default)
are used in two ways:

#. When you re-ingest an AIP, you are given the opportunity to select which
   processing configuration you'd like to use.
#. You can download the processingMCP.xml file by clicking **Download**. Then,
   rename the file ``processingMCP.xml`` and include it at the top level of your
   transfer. Archivematica will then use this to automate your transfer
   selections, rather than the default configuration. For more information on
   the processingMCP.xml file, see :ref:`Creating a custom config with
   processingMCP.xml <processingmcp-file>`.

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Many jobs in the Archivematica transfer and ingest tabs have configurable
decision points. Automating these decisions can make the transfer and ingest
process substantially quicker, especially if you find yourself selecting the
same decisions over and over. Below is a list of the processing configuration
form fields with a short description about how they work and the drop-down
options for each.

The option marked by an asterisk is the pre-set value for the default processing
configuration. If you change the default configuration, you can click on
**Reset** to revert all changes back to the installation pre-sets.

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
#. **No** - UUIDs are not assigned.*

Send transfer to quarantine
+++++++++++++++++++++++++++

Transfers are sequestered until virus definitions can be updated.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - transfers are automatically quarantined.
#. **No** - transfers are not sent to quarantine.*

Remove from quarantine after (days)
+++++++++++++++++++++++++++++++++++

Transfers are automatically removed from quarantine after a defined number of
days and made available for further processing.

Enter the number of days that transfers should remain in quarantine (i.e. 5).

The default value for this field is 28 days.

Generate transfer structure report
++++++++++++++++++++++++++++++++++

A text file is generated showing a directory tree of the original transfer
structure.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - structure report is created.*
#. **No** - structure report is not created.

Perform file identification (Transfer)
++++++++++++++++++++++++++++++++++++++

Choose whether or not to identify the format of the files in your transfer.

Options:

#. **None** - the user is prompted for a decision.*
#. **Yes** - use the enabled file identification command. See
   :ref:`Identification <identification>` for more information.
#. **No** - files will not be identified.

Extract packages
++++++++++++++++

Packages (such as .zip files) are unzipped and extracted into a directory.

Options:

#. **None** - the user is prompted for a decision.*
#. **Yes** - the contents of the package are extracted.
#. **No** - package is left as-is.

Delete packages after extraction
++++++++++++++++++++++++++++++++

Packages that have been extracted in the previous step can be deleted after
extraction.

Options:

#. **None** - the user is prompted for a decision.*
#. **Yes** - the package is deleted.
#. **No** - the package is preserved along with the extracted content.

.. note::

   If you are processing a :ref:`Dataverse <dataverse>` transfer, you must
   select "No". The Dataverse transfer will fail if packages are deleted.

Perform policy checks on originals
++++++++++++++++++++++++++++++++++

If you have created policies using :ref:`MediaConch <fpr-mediaconch>`, Archivematica
runs the original transfer materials against the policies to assess
conformance.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - the transfer is checked against any policies.
#. **No** - policies are ignored.*

Examine contents
++++++++++++++++

Run `Bulk Extractor`_, a forensics tool that can recognize credit card numbers,
social security numbers, and other patterns in data. For more information on
reviewing Bulk Extractor logs, see the :ref:`Analysis pane <analysis_pane>` on
the Appraisal tab.

**Options:**

#. **None** - the user is prompted for a decision.*
#. **Skip examine contents** - Bulk Extractor does not run.
#. **Yes** - Bulk Extractor scans content and creates log outputs of recognized
   patterns for review.

Create SIP(s)
+++++++++++++

Create a formal SIP out of the transfer or send it to the backlog.

Options:

#. **None** - the user is prompted for a decision.*
#. **Send to backlog** - transfer is sent to a backlog storage space for
   temporary storage or appraisal.
#. **Create single SIP and continue processing** - transfer becomes a SIP and is
   made available for further processing on the ingest tab.

.. note::

   If you are running Archivematica in indexless mode (without Elasticsearch),
   the backlog will be unavailable and the **Send to backlog** option will not
   be present in this dropdown.

Select file format identification command (Ingest)
++++++++++++++++++++++++++++++++++++++++++++++++++

Choose to identify the format of files in your SIP.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - use the enabled file identification command. See
   :ref:`Identification <identification>` for more information.
#. **No, use existing data** - re-uses file identification data from the
   transfer tab.*

Normalize
+++++++++

Convert ingested digital objects to preservation and/or access formats. See
:ref:`Normalize <normalize>` for more information.

Options:

#. **None** - the user is prompted for a decision.*
#. **Normalize for preservation and access** - creates preservation copies of
   the objects plus access copies which will be used to generate the DIP.
#. **Normalize for preservation** - creates preservation copies only. No access
   copies are created and no DIP will be generated.
#. **Normalize manually** - see :ref:`Manual Normalization <manual-norm>` for
   more information.
#. **Do not normalize** - the AIP will contain originals only. No preservation
   or access copies are generated and no DIP will be generated.
#. **Normalize service files for access** - see :ref:`Transferring material
   with service (mezzanine) files <transfer-service-files>` for more
   information.
#. **Normalize for access** - the AIP will contain originals only. No
   preservation copies will be generated. Access copies will be created which
   will be used to generate the DIP.

Approve normalization
+++++++++++++++++++++

The dashboard allows users to review the normalization output and the
normalization report.

Options:

#. **None** - the user has a chance to review and approve normalization.*
#. **Yes** - skip the review step and automatically continue processing.

Generate thumbnails
+++++++++++++++++++

This gives the option of generating thumbnails for use in the AIP and DIP.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes, without default** - thumbnails will be produced for any format which
   has a :ref:`normalize for thumbnails <normalization>` rule in the FPR.
   Formats which do not have a rule will not have a thumbnail generated.
#. **No** - thumbnails will not be generated.
#. **Yes** - thumbnails will be generated according to the format rules in the
   FPR. Formats which do not have a rule will have a default thumbnail
   generated (grey document icon).*

Perform policy checks on preservation derivatives
+++++++++++++++++++++++++++++++++++++++++++++++++

If you create policies using MediaConch, run the policies against the
newly-created preservation derivatives to ensure conformation.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - the normalized files are checked against any policies.
#. **No** - policies are ignored.*

Perform policy checks on access derivatives
+++++++++++++++++++++++++++++++++++++++++++

If you create policies using MediaConch, run the policies against the
newly-created preservation derivatives to ensure conformation.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - the normalized files are checked against any policies.
#. **No** - policies are ignored.*

Bind PIDs
+++++++++

Assign persistent identifiers and send the information to a Handle.Net server.
See :ref:`Bind PIDs <bind-pids>` for more information.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - PIDs are created and a API call posts the PIDs to the Handle
   Server.
#. **No** - PIDs are not created.*

Document empty directories
++++++++++++++++++++++++++

By default, Archivematica removes empty directories and does not document that
they existed.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - an entry for the directory is created in the structmap.
#. **No** - the directory is not documented.*

Reminder: add metadata if desired
+++++++++++++++++++++++++++++++++

Archivematica allows users to see :ref:`add metadata <add-metadata>` to a SIP
through the user interface. This reminder occurs at the last moment that it is
possible to add metadata; once the ingest proceeds past this point, it is no
longer possible to add metadata to the SIP.

Options:

#. **None** - the user has a chance to add metadata.*
#. **Continue** - skip the reminder and automatically continue processing.

Transcribe files (OCR)
++++++++++++++++++++++

Users can elect to run Tesseract, an OCR tool that is included in Archivematica,
to produce text files containing file transcripts. For more information,
see (see :ref:`Transcribe SIP contents <transcribe-contents>`).

Options:

#. **None** - the user is prompted for a decision.*
#. **Yes** - Tesseract runs on all OCR-able files.
#. **No** - Tesseract does not run.

Select file format identification command (Submission documentation & metadata)
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Choose a tool to identify the format of any submission documentation and/or
metadata files that were included in your transfer.

Options:

#. **None** - the user is prompted for a decision.
#. **Yes** - use the enabled file identification command. See
   :ref:`Identification <identification>` for more information.*
#. **No** - files will not be identified.

Select compression algorithm
++++++++++++++++++++++++++++

AIPs created by Archivematica can be stored as compressed packages or
uncompressed, depending on your storage requirements.

Options:

#. **None** - the user is prompted for a decision.
#. **7z using bzip2** - a 7Zip file is created using the `bzip2`_ algorithm.*
#. **7z using LZMA** - a 7Zip file is created using the `LZMA`_ algorithm.
#. **7z without compression** - a 7Zip file is created but the contents are not
   compressed.
#. **Gzipped tar** - the AIP is created using the `gzip`_ algorithm.
#. **Parallel bzip2** - a 7Zip file is created using the
   `Parallel bzip2 (pbzip2)`_ algorithm.
#. **Uncompressed** - the AIP is not compressed.

Select compression level
++++++++++++++++++++++++

If you selected a compression choice in the step above, you can determine how
compressed you would like your AIP to be. Selecting a higher compression level
means that the resulting AIP is smaller, but compression also takes longer.
Lower compression levels mean quicker compression, but a larger AIP.

Options:

#. **None** - the user is prompted for a decision.
#. **5 - normal compression mode** - the compression tool will strike a balance
   between speed and compression to make a moderately-sized, moderately-
   compressed AIP.*
#. **7 - maximum compression** - a smaller AIP that takes longer to compress.
#. **9 - ultra compression** - the smallest possible AIP.
#. **3 - fast compression mode** - a larger AIP that will be compressed quickly.
#. **1 - fastest mode** - the AIP will be compressed as quickly as possible.

.. note::

   If you chose `Uncompressed` or `7z without compression` in the previous step,
   the compression level will have no effect on your package.

Store AIP
+++++++++

Pausing at the Store AIP microservice allows users to review the AIP contents
prior to storage. If you do not want to manually review AIPs prior to storage,
this can be set to bypass that review step.

Options:

#. **None** - the user is prompted for a decision.*
#. **Yes** - the AIP is marked for storage automatically.

Store AIP location
++++++++++++++++++

Once the previous step is approved, the AIP can be automatically sent to a
specified storage location by setting the preferred location.

Options:

#. **None** - the user is prompted for a decision.*
#. **Default location** - the AIP is stored in the AIP storage location that has
   been defined as the default in the Storage Service.
#. **[Other storage locations]** - any other AIP storage locations that are
   available will also appear on this list.

Upload DIP
++++++++++

If a DIP was created, it can be automatically sent to an access system for which
there is an Archivematica integration.

Options:

#. **None** - the user is prompted for a decision.*
#. **Upload DIP to CONTENTdm** - see :ref:`CONTENTdm <contentdm>` DIP upload
   documentation.
#. **Upload DIP to AtoM** - see :ref:`AtoM <upload-atom>` DIP upload
   documentation.
#. **Do not upload** - the DIP will not be uploaded to an access system.
#. **Upload DIP to ArchivesSpace** - see :ref:`ArchivesSpace <upload-as>` DIP
   upload documentation.

Store DIP
+++++++++

If a DIP was created, it can be stored without interrupting the workflow in the
dashboard. Note that DIP storage is not required, and that DIPs can be created
on demand by :ref:`re-ingesting the AIP <reingest>`.

Options:

#. **None** - the user is prompted for a decision.*
#. **Yes** - the DIP is marked for storage automatically.

Store DIP location
++++++++++++++++++

If the previous step and this step are configured, all DIPs will be sent to the
selected storage location (unless you have included a custom processing
configuration with the transfer that defines another location).

Options:

#. **None** - the user is prompted for a decision.*
#. **Default location** - the DIP is stored in the DIP storage location that has
   been defined as the default in the Storage Service.
#. **[Other storage locations]** - any other DIP storage locations that are
   available will also appear on this list.

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
^^^^^^^^^^^^^^^^^^^^^^^

This is where you'll find the complete URL for the Storage Service, along with a
username and API key. See the Storage Service documentation for more information
about this feature.

Checksum algorithm
^^^^^^^^^^^^^^^^^^

You can select which checksum algorithm Archivematica will use during the
*Assign UUIDs and checksums* microservice in Transfer. Choose between MD5,
SHA-1, SHA-256 and SHA-512.

Elasticsearch indexing
^^^^^^^^^^^^^^^^^^^^^^

As of Archivematica 1.7, Elasticsearch is optional. Installing Archivematica
without Elasticsearch or with limited Elasticsearch functionality means reduced
consumption of compute resources and lower operational complexity. Fully or
partially disabling Elasticsearch means that the Backlog, Appraisal, and
Archival Storage tabs may not appear and their functionality is not available.

This section in the General configuration shows the Elasticsearch configuration.

.. _dashboard-failures:

Failures
--------

This page displays packages that failed during processing.

.. figure:: images/failuresAdmin.*
   :align: center
   :figwidth: 70%
   :width: 100%
   :alt: Failures report in the dashboard

   Failures report in the dashboard


Clicking the date, name or UUID will display a report of the failure:

.. image:: images/failReport.*
   :align: center
   :width: 70%
   :alt: Failure report for a failed transfer

The failure report can be removed from the Dashboard by clicking Delete.

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

.. _dashboard-dip-upload:

DIP upload
----------

Archivematica has access integrations with three access platforms: AtoM, Binder,
and ArchivesSpace. For more information on Archivematica
integrations, please see the :ref:`Integrations <integrations>` page.

.. _dashboard-atom:

AtoM/Binder DIP upload
^^^^^^^^^^^^^^^^^^^^^^

Archivematica can upload DIPs directly to an `AtoM`_ website so that the
contents can be accessed online. Using the same configuration screen, you can
also configure Archivematica to upload DIPs to `Binder`_, which is built off the
AtoM framework.

For more information on configuring the AtoM/Binder DIP upload parameters and
the servers, please see the :ref:`AtoM/Binder DIP upload <admin-dashboard-atom>`
configuration instructions.

**Levels of description**

You can fetch levels of description from AtoM so that they can be used for
:ref:`SIP arrangement <arrangement>`. Click on Levels of Description, then
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

   You may need an administrator to configure AtoM for DIP uploads from
   Archivematica. For administrator instructions, see :ref:`AtoM DIP upload
   <admin-dashboard-atom>` in the Administrator manual

.. _dashboard-AS:

ArchivesSpace DIP upload
^^^^^^^^^^^^^^^^^^^^^^^^

Before ingesting digital objects destined for ArchivesSpace, ensure that
the ArchivesSpace DIP upload settings in the administration tab of the
dashboard have been set.

For more information on configuring the ArchivesSpace DIP upload parameters,
please see the Admin Manual :ref:`ArchivesSpace DIP upload <admin-dashboard-AS>`
configuration instructions.

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
the `Django authentication framework`_. Access to the dashboard is limited only
to logged-in users and a login page will be shown when the user is not
recognized. If the application can't find any user in the database, the user
creation page will be shown instead, allowing the creation of an administrator
account.

Users can be also created, modified and deleted from the Administration tab.
Only users who are administrators can create and edit user accounts.

You can add a new user to the system by clicking the "Add new" button on the
user administration page. By adding a user you provide a way to access
Archivematica using a username/password combination. Should you need to change
a user's username or password, you can do so by clicking the "Edit" button,
corresponding to the user, on the administration page. Should you need to
revoke a user's access, you can click the corresponding "Delete" button.

For more information about user creation, deletion, and security, please see
the :ref:`Users <admin-dashboard-users>` section in the Admin Manual.

.. _handle-server:

Handle Server config
--------------------
Archivematica can to be configured to make requests to a Handle System HTTP API
so that files, directories and entire AIPs can be assigned persistent
identifiers (PIDS) and derived persistent URLs (PURLs).

.. _language-choice:

Language
--------

The language menu allows you to choose from select languages.

Archivematica is translated by volunteers through `Transifex`_. The completeness
of a language is dependent on how many strings have been translated in
Transifex. For information about contributing translations to the Archivematica
project, see :ref:`Translations <translations>`.

.. _version:

Version
-------
This tab displays the version of Archivematica you're using.

:ref:`Back to the top <dashboard-admin>`

.. _AtoM: https://www.accesstomemory.org
.. _Django authentication framework: https://docs.djangoproject.com/en/1.8/topics/auth/
.. _automation tools: https://github.com/artefactual/automation-tools
.. _Fido: http://openpreservation.org/technology/products/fido/
.. _Siegfried: https://www.itforarchivists.com/siegfried
.. _bzip2: http://www.bzip.org/
.. _LZMA: https://www.7-zip.org/sdk.html
.. _Parallel bzip2 (pbzip2): https://launchpad.net/pbzip2/
.. _gzip: https://launchpad.net/gzip
.. _`Binder`: https://binder.readthedocs.io/en/latest/contents.html
.. _`Transifex`: https://www.transifex.com/artefactual/archivematica/
.. _`Bulk Extractor`: https://www.forensicswiki.org/wiki/Bulk_extractor
