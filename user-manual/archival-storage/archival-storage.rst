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

.. note::

   If you are running :ref:`Archivematica without Elasticsearch
   <install-elasticsearch>` or with limited Elasticsearch functionality, the
   Archival Storage tab may not appear in your dashboard.

*On this page*

* :ref:`Searching the AIP store <search-aip>`

  * :ref:`Conducting a search <conducting-search>`
  * :ref:`Searching for AICs <search-aics>`

* :ref:`AIP information page <aip-information-page>`

  * :ref:`Downloading an AIP <download-aip>`
  * :ref:`Metadata-only DIP upload <metadata-only-dip-upload>`
  * :ref:`AIP reingest <reingest-aip>`
  * :ref:`Deleting an AIP <delete-aip>`

* :ref:`AIP encryption <aip-encryption>`
* :ref:`Stored AIP structure <stored-aip-structure>`

.. seealso::

   * :ref:`AIP structure <aip-structure>`
   * `Archivematica METS file`_

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
* **Transfer metadata (other)**: the contents of the ``bag.info.txt`` of a bag
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

#. Enter your search term in the freetext box.

#. If you want to limit your search results to a specific parameter (for
   example, the AIP name or a file UUID), select the parameter from the dropdown
   menu. By default the parameter is set to **Any**, which will search across
   the whole storage index.

#. Use the second dropdown menu to select whether to search by keyword, phrase,
   or date range.

#. If you would like to see individual files in the search results, rather than
   AIPs, select **Show files?**.

#. To build a 



.. image:: images/SearchArchStor.*
  :align: center
  :width: 80%
  :alt: AIP storage search results


.. _search-aics:

Searching for Archival Information Collections
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


#. If you would like to see :ref:`Archival Information Collections <aic>` in
   the search results, select **Show AICs?**. By default, AICs are



The search index includes AIP names and METS contents. All METS metadata is
indexed and searchable.

By clicking on **View raw** next to a search result, you can also view the raw
JSON stream that has been indexed for searching. The JSON contains the METS
data, the Archivematica version that generated the data, the AIP UUID, the time
indexing occurred, and the relative file path within the AIP.

.. _aip-information-page:

AIP information page
--------------------

Clicking on the name of an AIP will open the AIP information page. From this
page, it is possible to upload an associated DIP, re-ingest the AIP, or delete
the AIP as well as downloading the AIP or viewing the pointer file. Clicking on
the name of an image will open the image in the browser.

.. _download-aip:

Downloading an AIP
^^^^^^^^^^^^^^^^^^

.. _metadata-only-dip-upload:

Metadata-only upload to AtoM
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. _reingest-aip:

Re-ingest AIP
^^^^^^^^^^^^^


.. _delete-aip:

Deleting an AIP
^^^^^^^^^^^^^^^

#. On the AIP information page, naviagate to the **Delete** action tab at the
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

Choosing to delete an AIP will send a request to the Storage Service
administrator. If the administrator approves the request, the AIP will be
deleted from your Archival Storage and the index will be updated. If the
administrator denies the request, the AIP will remain in storage.

.. important::

   Note that Archivematica tracks the location and existence of AIPs in 2 ways:
   within the Storage Service and in the Elastic Search index which you can
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

You can tell if your AIP is encrypted on the Archival Storage tab. Encrypted
AIPs appear as True in the Encrypted column.

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


In the storage platform, the AIP is broken down into a directory tree structure
based on the AIP's UUID, which is the 32-digit alphanumeric unique universal
identifier assigned to each AIP. Each UUID is broken down into a manageable
4-character chunk, or "UUID quad", which helps with efficient storage and
retrieval.

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

:ref:`Back to the top <archival-storage>`

.. _`Archivematica METS file`: https://wiki.archivematica.org/METS
