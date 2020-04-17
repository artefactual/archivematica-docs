.. _archival-storage:

================
Archival storage
================

The Archival Storage tab consists of a table showing all of the stored Archival
Information Packages (AIPs) for the Archivematica instance. There is a search
interface at the top of the page where you can construct simple or boolean
queries to find AIPs or individual items in storage. At the top of the table is
the total size of the stored AIPs and the number of indexed files. The table
lists the AIP's name, size, UUID, date that the AIP was stored, status, and
whether or not the AIP is encrypted. Use the up and down arrows in the column
headers to sort by AIP name, size, or date stored.

.. image:: images/archival-storage-tab.*
   :align: center
   :width: 60%
   :alt: The Archival Storage tab showing a table of five AIPs that have been stored.

From the Archival Storage tab, you can select an individual AIP and download it,
delete it, or initiate :ref:`AIP re-ingest <reingest>`.

Note that Dissemination Information Packages (DIPs) are not displayed on the
Archival Storage tab, even if they have been stored. For information on
accessing stored DIPs, see the :ref:`Storage Service <storageservice:index>`
documentation.

*On this page*

* :ref:`Searching the AIP store <search-aip>`

  * :ref:`Conducting a search <conducting-search>`
  * :ref:`Searching for AICs <search-for-aics>`

* :ref:`AIP information page <aip-information-page>`

  * :ref:`Downloading an AIP <download-aip>`
  * :ref:`Metadata-only DIP upload <metadata-only-dip-upload>`
  * :ref:`AIP reingest <reingest-aip>`
  * :ref:`Deleting an AIP <delete-aip>`

* :ref:`AIP encryption <aip-encryption>`
* :ref:`Stored AIP structure <stored-aip-structure>`

.. note::

   If you are running :ref:`Archivematica without Elasticsearch
   <install-elasticsearch>` or with limited Elasticsearch functionality, the
   Archival Storage tab may not appear in your dashboard.

.. _search-aip:

Searching the AIP store
-----------------------

The Archival Storage tab allows you to search for any AIP that appears in the
Archivematica instance's index. You can free search over all of the results or
limit your search using one or more of the search parameters:

* **File UUID**: the UUID of a specific file within an AIP.
* **File extension**: the format extension of a file within an AIP.
* **AIP UUID**: the UUID of the AIP.
* **AIP name**: the name of the AIP.
* **Identifiers**: the value of the ``<identifier>`` field in a MODS file
  included as submission documentation or in an Islandora transfer's METS file
  (using the :ref:`Islandora integration <islandora-integration>`).
* **Part of AIC**: an :ref:`AIC<aic>` number added to the AIP's descriptive
  metadata, formatted as ``AIC#`` followed by the value (i.e. ``AIC#GWQ498``).
  This searches for the individual AIPs that comprise an AIC.
* **AIC identifier**: the identifier of a created :ref:`AIC<aic>`, formatted as
  ``AIC#`` followed by the value (i.e. ``AIC#GWQ498``). This search returns AIC
  packages.
* **Transfer metadata**: metadata added using the special metadata form for the
  :ref:`disk image transfer type <disk-image-workflow>`.
* **Transfer metadata (other)**: the contents of the ``bag-info.txt`` of a bag
  transfer. Note that if you select this option, a second data entry box will
  pop up where youcan define a specific ``bag-info.txt`` field you would like
  to search against - for example, if ``bag-info.txt`` included the line
  ``Source-Organization: My Org``, you could enter ``Source-Organization`` into
  the second data entry box to limit searches to that field.

You can also define your search string as a keyword, phrase, or date range:

* **Keyword**: by default, the Keyword option treats the search string as a
  Boolean OR search - that is, every word is treated as a separate value connected by OR
  operators. For example, searching for ``2015-Annual-Report`` actually searches
  for "2015 OR Annual OR Report", so the results contain anything named with
  "2015" or "Annual" or "Report". To search for a specific strings, add quotation marks
  around the string - ``"2015-Annual-Report"``.
* **Phrase**: the Phrase option allows for more flexibility while searching. You
  can use the Phrase option to perform fuzzy searches, such as ``council*`` to
  find AIPs named ``council-minutes``, ``councilminutes``, and
  ``council-report``.
* **Date range**: this allows you to search for AIPs that were created by
  Archivematica between two dates. You can conduct date range searches by
  entering a date, a colon, and a second date, such as
  ``2015-01-02:2015-03-15``.

.. _conducting-search:

Conducting a search
^^^^^^^^^^^^^^^^^^^

#. On the Archival Storage tab, enter your search term into the text box at the
   top of the screen. If you want to limit your search results to a specific
   parameter (for example, the AIP name or a file UUID), use the first dropdown
   box to select the parameter. By default the parameter is set to **Any**,
   which will search across the whole storage index. Use the second dropdown
   menu to select whether to search by keyword, phrase, or date range.

#. If you would like to see individual files in the search results, rather than
   AIPs, select the **Show files?** checkbox.

#. To build a Boolean search, click on **Add New**. This will bring up a second
   text box and set of dropdown menus. You can select *Or*, *And*, or *Not* as
   your Boolean connectors.

.. image:: images/search-archival-storage.*
  :align: center
  :width: 80%
  :alt: The Archival Storage tab showing the results for a specific AIP UUID and the .png file extension. There is one result.

By clicking on **View raw** next to a search result, you can also view the raw
JSON stream that has been indexed for searching. The JSON contains the METS
data, the Archivematica version that generated the data, the AIP UUID, the time
indexing occurred, and the relative file path within the AIP.

.. _search-for-aics:

Searching for Archival Information Collections (AICs)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Archivematica includes the ability to break a single collection into multiple
AIPs that are connected together as an :ref:`Archival Information Collection
<aic>` (AIC). For more information on searching for AICs, see :ref:`Search for
AICs <search-aic>`.

.. _aip-information-page:

AIP information page
--------------------

Clicking on the name of an AIP will open the AIP information page. From this
page, it is possible to upload an associated DIP, re-ingest the AIP, or delete
the AIP as well as downloading the AIP or viewing the METS and pointer files.

.. image:: images/aip-information-page.*
   :align: center
   :width: 80%
   :alt: The information page for an AIP.

.. _download-aip:

Downloading an AIP
^^^^^^^^^^^^^^^^^^

To download an AIP, click **Download**. The download will begin in your web
browser. Note that for very large AIPs, it might take a few minutes for the
download to start. Downloading very large AIPs can result in hitting
Archivematica's default timeouts, resulting in an AIP that doesn't download -
please see the :ref:`Scaling up <scaling-up>` documentation for more information
on adjusting timeouts. If the AIP is too large, you may need to download it
directly from the storage location.

For more information about how AIPs are structured, please see :ref:`AIP
structure <aip-structure>`.

.. _download-mets:

Downloading the METS file
+++++++++++++++++++++++++

The AIP `METS file`_ lists all of the digital objects in the AIP (original
files, preservation masters, license files, OCR text files, submission
documentation, etc.), describes their relationships to each other, and links
digital objects to their descriptive, technical, provenance, and rights
metadata.

To look at the METS file without having to download the AIP, you can click on
**View** next to *METS file*. The METS file will either open in your browser or
it will automatically start downloading.

For more information about Archivematica's METS implementation, see :ref:`METS
in Archivematica <METS_schema>`.

.. _download-pointer:

Downloading the pointer file
++++++++++++++++++++++++++++

The AIP pointer file provides information about how the AIP was packaged for
storage, its fixity, and where the AIP is stored. The pointer file is used by
Archivematica primarily to retrieve the AIP.

To download the pointer file, click on **View** next to *Pointer file*. The
pointer file will either open in your browser or it will automatically start
downloading.

.. _metadata-only-dip-upload:

Metadata-only upload to AtoM
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

From the AIP information page, it is possible to send a metadata-only upload to
a connected :ref:`AtoM <atom:home>` site. See :ref:`Metadata-only upload to AtoM
<upload-metadata-atom>` for more information.

.. _reingest-aip:

Re-ingest AIP
^^^^^^^^^^^^^

From the AIP information page, it is possible to reingest an AIP in order to add
or update metadata, create a DIP on demand, or re-run all microservices. See
:ref:`Re-ingest AIP <reingest>` for more information.

.. _delete-aip:

Delete AIP
^^^^^^^^^^

Deleting an AIP in Archivematica is a two-step process. First, the user must
request that the AIP be deleted. Then, a Storage Service administrator must
approve the deletion from the Storage Service interface. If the administrator
approves the request, the AIP will be deleted from your Archival Storage and
the index will be updated. If the administrator denies the request, the AIP
will remain in storage.

#. On the AIP information page, navigate to the **Delete** action tab at the
   bottom of the page.

   .. image:: images/DeleteButton.*
      :align: center
      :width: 80%
      :alt:  Dashboard request to delete AIP

#. Enter the AIP UUID and a reason for deletion.

   .. image:: images/ReasonDelete.*
      :align: center
      :width: 80%
      :alt: Give a reason for deletion

#. Click delete. When you refresh the Archival Storage tab, the status of your
   AIP should now read *Deletion requested*.

.. important::

   Note that Archivematica tracks the location and existence of AIPs in 2 ways:
   within the Storage Service and in the Elasticsearch index which you can
   search via the dashboard. Deleting AIPs directly from the file system rather
   than through the Storage Service will cause inconsistencies in both
   applications and is not recommended in a production environment.

.. _aip-encryption:

AIP encryption
--------------

Beginning in the 1.7 version of Archivematica, institutions are able to encrypt
their AIPs for secure storage. This feature is particularly useful when an
institution stores its AIPs off-site.

To create an encrypted AIP, Archivematica needs an encrypted space and location
set up in the Storage Service. Please see :ref:`Encryption <storageservice:gpg>`
for more information.

#. Run your transfer through the regular microservices.

#. At the Store AIP location job on the Ingest tab, choose your encrypted AIP
   location. You now have an encrypted AIP!

You can tell if your AIP is encrypted by looking at the Encrypted column of the
table on the Archival Storage tab. Encrypted AIPs are marked as *True*.

.. image:: images/ArchiStorEncryptedColumn.*
   :align: center
   :width: 80%
   :alt: Archival storage tab showing encrypted AIP

The AIP pointer file contains a `PREMIS:EVENT` element for the encryption event.

The AIP itself can be downloaded in unencrypted form from the Archival Storage
tab.

.. _stored-aip-structure:

AIP storage structure
---------------------

For efficient storage and retrieval, Archivematica's Storage Service uses a
directory tree structure based on the AIP's UUID, which is the 32-digit
alphanumeric unique universal identifier assigned to each AIP. Each UUID is
broken down into a manageable 4-character chunk, or "UUID quad".

.. image:: images/AIP-quad-directories.*
   :align: center
   :width: 80%
   :alt: Screenshot of a file browser showing the AIP quad directories, with the lowest-level directory open to show the AIP package.

Each quad represents a directory. The first four characters (the first UUID
quad) of the AIP UUID are used as the name of the main subdirectory in the AIP
storage. The second UUID quad will be used as the name of a subdirectory of the
first, and so on. The last four characters (the last UUID quad) are used to
create the leaf of the AIP store directory tree, and the AIP with that UUID
resides in that leaf.

This folder structure is the same for both compressed and uncompressed AIPs.
AIPs that have been compressed for storage will be in ``.7z`` format.
Uncompressed AIPs will be stored as a directory, rather than a zipfile.

The quad directory structure is used for storage only. When you download the
AIP, you will only get the AIP itself, not the quad directories.

For more information about how AIPs are structured, please see :ref:`AIP
structure <aip-structure>`.

:ref:`Back to the top <archival-storage>`

.. _METS file: http://www.loc.gov/standards/mets/
