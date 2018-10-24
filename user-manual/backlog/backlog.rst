.. _backlog:

=======
Backlog
=======

The backlog tab is used to view, search and request deletion of transfers which
have been sent to backlog.

At this time, transfers stored using Archivematica's backlog functionality can
only be accessed by using the same pipeline that the transfer was created in. If
you decommission your pipeline, you will be unable to reindex and repopulate the
backlogged material in a new Archivematica pipeline.

.. note::

   If you are running :ref:`Archivematica without Elasticsearch
   <install-elasticsearch>` or with limited Elasticsearch functionality, the
   Backlog tab will not appear in your dashboard.

*On this page:*

* :ref:`Searching for transfers <backlog-transfer-search>`
* :ref:`Searching for files <backlog-file-search>`
* :ref:`Downloading transfers or files <backlog-download>`
* :ref:`Deletion of transfers <backlog-delete>`


.. _backlog-transfer-search:

Searching for transfers
-----------------------

#. Navigate to the backlog page, where you should see a paginated list of all
   backlogged transfers.

   .. image:: images/backlog_tab.*
      :align: center
      :width: 80%
      :alt: Archivematica backlog tab showing backlogged transfers

#. Perform your search using the fields at the top of the screen, adding new
   boolean operators as desired. Searches can be performed on file name, file
   extension, accession number, Ingest date or SIP (Transfer) UUID. To search on
   the name of the transfer, leave the field as "Any". Wildcards (*) are allowed.

   .. hint::

      If you're not finding anything in your search results, try switching from "keyword" to "phrase."

   .. image:: images/backlog_transfer_search.*
      :align: center
      :width: 80%
      :alt: Archivematica backlog tab showing a search for transfers.

.. _backlog-file-search:

Searching for files
-------------------

File searches can be performed using the same instructions as Searching for transfers, above, by additionally clicking "Show files?". You can also browse all files in backlog by leaving the search blank and clicking "Show files?".

File searches/browses will show all files in the transfer, including logs created during transfer.

.. image:: images/backlog_file_search.*
   :align: center
   :width: 80%
   :alt: Archivematica backlog tab showing a search for transfers.


.. _backlog-download:

Downloading transfers or files
------------------------------

Either files or transfers can be downloaded by using the download button on the right-hand side. Transfers when downloaded will be packaged as a tar file.

.. note::

   In testing, we have had success in downloading transfers/files of up to 1 GB; further development may be required to scale this feature to larger transfers/files.


.. _backlog-delete:

Deletion of transfers
---------------------

#. Transfers can be requested for deletion by clicking the red remove icon
   beside the transfer.

#. The user will be prompted to provide a reason for deleting the transfer.

   .. image:: images/backlog_delete.*
      :align: center
      :width: 80%
      :alt: Screen prompting user to provide a reason for deleting a transfer.

#. To complete the deletion, an administrator must login to the Storage Service
   and approve the deletion.

#. Until the deletion is approved, the transfer will remain visible in the backlog
   tab and will be available for download from the backlog tab as well.

:ref:`Back to the top <backlog>`
