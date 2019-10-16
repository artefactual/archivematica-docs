.. _archival-storage:

================
Archival storage
================

The Archival Storage tab in the Archivematica dashboard consists of a table
listing all of the stored AIPs. At the top of the table is the total size of the
stored AIPs and the number of indexed files. The table lists the AIP name, the
size, the UUID, the date that the AIP was stored, its status, and whether or not
the AIP is encrypted. Use the up and down arrows in the column headers to sort
by AIP name, size, UUID, or date stored.

From the Archival Storage tab, you can download the AIP, delete it, or initiate
:ref:`AIP re-ingest <reingest>`.

.. note::

   If you are running :ref:`Archivematica without Elasticsearch
   <install-elasticsearch>` or with limited Elasticsearch functionality, the
   Archival Storage tab may not appear in your dashboard.

.. image:: images/ArchStorTab1.*
   :align: center
   :width: 80%
   :alt: Archival storage tab showing stored AIPs

*On this page*

* :ref:`Searching the AIP store <search-aip>`
* :ref:`AIP information page <aip-information-page>`

  * :ref:`Downloading an AIP <download-aip>`
  * :ref:`Metadata-only DIP upload <metadata-only-dip-upload>`
  * :ref:`AIP reingest <reingest-aip>`
  * :ref:`Deleting an AIP <delete-aip>`

* :ref:`AIP encryption <aip-encryption>`
* :ref:`AIP structure <aip-structure>`

.. seealso::

   * :ref:`AIP structure <aip-structure>`
   * `Archivematica METS file (wiki)`_

.. _search-aip:

Searching the AIP store
-----------------------

Once AIPs have been stored, they can be searched for, downloaded, or deleted
from the Archival Storage tab.

* File UUID
* File extension
* AIP UUID
* AIP name
* Identifiers
* Part of AIC
* AIC identifier
* Transfer metadata
* Transfer metadata (other)

To search the AIP index, use the search bar at the top of the screen on the
Archival Storage tab.

#. Use the first dropdown menu to select whether to search for the File UUID,
   File path, File extension, AIP UUID, or AIP name.

#. Use the second dropdown menu to select whether to search by keyword, phrase,
   or date range.

#. Select **Show files?** to display individual files in the search results. By
   default, the search result displays the AIP.

#. Select **Show AICs?** to display :ref:`Archival Information Collections
   <aic>` in your results.

  .. image:: images/SearchArchStor.*
     :align: center
     :width: 80%
     :alt: AIP storage search results

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

.. _aip-structure:

AIP structure
-------------

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

.. _`Archivematica METS file (wiki)`: https://wiki.archivematica.org/METS
