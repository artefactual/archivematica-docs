.. _backlog:

=======
Backlog
=======

At the end of the :ref:`Transfer tab microservices
<transfer-tab-microservices>`, users are given the option to place a transfer
into a backlog storage space. Users may choose to use the backlog in order to do
more analysis on the materials at a later date, either outside of Archivematica
or by using the :ref:`Appraisal tab <appraisal>` features, before placing the
materials in long-term storage.

Transfers placed in the backlog have undergone basic digital preservation
microservices - for example, all files have been given UUIDs, checksums have
been generated, the files have been scanned for viruses, and identification and
validation information has been captured. The transfer has also been converted
into `bag`_.

By navigating to the Backlog tab, users can view, search for, and request
deletion of transfers that have been sent to backlog.

.. note::

   If you are running :ref:`Archivematica without Elasticsearch
   <install-elasticsearch>` or with limited Elasticsearch functionality, the
   Backlog tab may not appear in your dashboard.

*On this page:*

* :ref:`Searching for transfers and files <backlog-transfer-search>`
* :ref:`Downloading transfers or files <backlog-download>`
* :ref:`Deleting transfers from the backlog <backlog-delete>`
* :ref:`Retrieving transfers from the backlog <backlog-retrieve>`

.. _backlog-transfer-search:

Searching for transfers and files
---------------------------------

#. The backlog tab shows a paginated list of all the transfers that have been
   sent to the backlog.

   .. figure:: images/backlog-tab.*
      :align: center
      :width: 80%
      :alt: Archivematica backlog tab showing all transfers in the backlog

#. To change the columns that are visible in the tabular list of backlogged
   transfers, click on the **Select columns** icon at the bottom of the table.
   This will present a list of the columns that are available for viewing in the
   table. The blue row indicates that a column is currently visible. A white row
   indicates that the column is currently not visible.

   .. figure:: images/backlog-select-columns.*
      :align: center
      :width: 80%
      :alt: Archivematica backlog tab showing select columns options

#. Click on a blue or white row to toggle this value for each column. In the
   example below, all the available columns are selected. Note that your column
   selection choices will persist between your user sessions and apply to other
   users of the same Archivematica instance.

   .. figure:: images/backlog-all-columns.*
      :align: center
      :width: 80%
      :alt: Archivematica backlog tab showing all columns selected

#. You can click on the column headers to sort in ascending or descending order.
   An up or down caret (arrow point) will appear. (e.g. see File count below)

   .. figure:: images/backlog-sort-columns.*
      :align: center
      :width: 80%
      :alt: Archivematica backlog tab sorted on File count column

#. Note that the same column selection ability applies when you enable the
   “Show files?” option.

   .. figure:: images/backlog-show-files.*
      :align: center
      :width: 80%
      :alt: Archivematica backlog tab with Show Files option

#. The search fields at the top of the page can be used to search the backlog.
   You can limit your search to the file name, file extension, accession number,
   Ingest date or Transfer UUID. Leaving the search parameter set to "Any"
   will also display search results from the transfer name. Click on **Add new**
   to add a second boolean string to your search query.

   .. figure:: images/backlog-search.*
      :align: center
      :width: 80%
      :alt: Archivematica backlog tab showing a search for transfers.

      Search results for transfers with transfer names that include "backlog"
      and a dash AND transfers that include a file with the exact phrase
      "pepperbox-poppy" in the file name.

#. To view individual files in your search results, click the checkbox next to
   **Show files?**

   .. figure:: images/backlog-search-show-files.*
      :align: center
      :width: 80%
      :alt: Archivematica backlog tab showing a search for transfers.

      The same search results as above, with **Show files?** selected.

.. _backlog-download:

Downloading transfers or files
------------------------------

Whole transfers or individual files can be downloaded by selecting the
**Download** button in the Actions column.

Transfers are downloaded as tar packages. Individual files are downloaded
unpackaged.

.. _backlog-delete:

Deleting transfers
------------------

Similar to :ref:`deleting a stored AIP <delete-aip>`, deleting a backlogged
transfer is a two-step process. Front-end users can request that a transfer in
backlog be deleted, but an administrator must log in to the Archivematica
Storage Service to confirm the deletion.

#. To request that a transfer is deleted, click on the red remove icon in the
   Actions column.

#. You will be prompted to provide a reason for deleting the transfer. Enter
   the reason and select **Delete**.

   .. figure:: images/backlog-delete.*
      :align: center
      :width: 80%
      :alt: Screen prompting user to provide a reason for deleting a transfer. The user has written "This is a test" in the textbox.

#. Until the deletion is confirmed by a Storage Service administrator, the
   transfer will remain visible in the backlog tab and will still be available
   for download.

.. _backlog-retrieve:

Retrieving transfers from the backlog
-------------------------------------

Materials in backlog can be analysed, appraised, and arranged by using the
functionality on the :ref:`Appraisal tab <appraisal>`. Once you are ready to
move a transfer out of the backlog and process it for long-term storage, follow
the instructions in the see :ref:`Arranging a SIP through drag-and-drop
<arrangement-drag-drop>` section of the Appraisal tab documentation.

:ref:`Back to the top <backlog>`

.. _bag: https://tools.ietf.org/html/rfc8493
