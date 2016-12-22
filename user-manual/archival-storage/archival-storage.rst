.. _archival-storage:

================
Archival storage
================

During archival storage, the AIP is moved into its storage repository.

Should you run into an error during archival storage, please see
:ref:`Error handling <error-handling>`.

*On this page*

* :ref:`Storing an AIP <storing-aip>`
* :ref:`Searching the AIP store <search-aip>`
* :ref:`Deleting an AIP <delete-aip>`

.. _storing-aip:

Storing an AIP
--------------

#. Once ingest is complete, selecting a location to "Store AIP" in the Actions
   drop-down menu compresses and zips the AIP and moves it into Archival storage.

#. In the demo version of Archivematica the AIP storage directory is
   ``/sharedDirectoryStructure/www/AIPsStore/``. In other environments it can be a
   remote network mounted directory. If multiple AIP storage locations have been
   created in the Storage Service, each will appear in the Store AIP location
   dropdown, including LOCKSS locations.

#. The AIP directories are broken down into UUID quad directories for efficient
   storage and retrieval.

   .. note::

      Archivematica uses a directory tree structure to store AIPs.
      The tree is based on AIP UUIDs, which are 16-digit alphanumeric unique universal
      identifiers. Each UUID is broken down into a manageable 4-character chunk, or
      "UUID quad". Each quad represents a directory. The first four characters (the
      first UUID quad) of the AIP UUID will compose a subdirectory
      of the AIP storage. The second UUID quad will be the name of a sub directory
      of the first, and so on. The last four characters (the last UUID quad) are
      used to create the leaf of the AIP store directory tree, and the AIP with
      that UUID resides in that leaf.

4. The Archival storage tab in the Archivematica dashboard consists of a table with information about the stored AIPs. Use the up and down arrows in the column headers to sort by AIP name, size, UUID, date stored or status. Note that at the top of the table is the total size of the stored AIPs and the number of indexed files.

.. image:: images/ArchStorTab1.*
   :align: center
   :width: 80%
   :alt: Archival storage tab showing stored AIPs

5. To open a copy of the AIP, click on the AIP name. You can then open or download the zipped AIP.

6. The AIP pointer file can be accessed by clicking on the Pointer file link. The pointer file provides information on the AIP and its relationships to the Archivematica, DIPs, and other AIPs as appropriate.

.. seealso::

   * :ref:`AIP structure <aip-structure>`
   * `Archivematica METS file (wiki) <https://www.archivematica.org/wiki/METS>`_


.. _search-aip:

Searching the AIP store
-----------------------

To search the AIP index, use the search bar at the top of the screen.

* Use the first dropdown menu to select whether to search for the File UUID, File
  path, File extension, AIP UUID, or AIP name.

* Use the second dropdown menu to select whether to search by keyword, phrase, or date range.

* Select *Show files?* to display discrete files in your results.

* Select *Show AICs?* to display Archival Information Collections (aggregates of
  of multiple AIPs) in your results.

.. image:: images/SearchArchStor.*
   :align: center
   :width: 80%
   :alt: AIP storage search results

The search index includes AIP names and METS contents. All METS metadata is indexed
and searchable.

Clicking on the name of an AIP will open the AIP information screen. From this screen,
it's possible to upload an associated DIP, re-ingest the AIP, or delete the AIP
as well as downloading the AIP or viewing the pointer file. Clicking on the name of an image will open the image in the browser.

By clicking on "View raw" next to a search result, you can also view the raw
JSON data that contains the METS data, the Archivematica version that
generated the data, the AIP UUID, the time indexing occurred, and the
relative file path within the AIP.

.. _delete-aip:

Deleting an AIP
---------------

1. To request AIP deletion, click on the red delete icon next the AIP in the Archival storage tab table.

.. image:: images/DeleteButton.*
   :align: center
   :width: 80%
   :alt:  Dashboard request to delete AIP


2. Archivematica will ask for a reason for deletion.

.. image:: images/ReasonDelete.*
   :align: center
   :width: 80%
   :alt: Give a reason for deletion

Choosing to delete an AIP will send a request to your Archival Storage Service administrator. If the administrator approves the request, your AIP will be deleted from your Archival Storage and your index will be updated. If the administrator denies the request, the AIP will remain in storage and your administrator should contact you.

.. important::

   Note that Archivematica tracks the location and existence
   of AIPs in 2 ways, within the Storage Service and in the Elastic Search index
   which you can search via the dashboard. Deleting AIP's directly from the file
   system rather than through the Storage Service will cause inconsistencies in
   both applications and is not recommended in a production environment.

.. seealso::

   :ref:`Access <access>`


:ref:`Back to the top <archival-storage>`
