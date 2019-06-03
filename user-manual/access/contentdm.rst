.. _contentdm:

==========
CONTENTdm
==========

Archivematica can prepare DIPS for upload to CONTENTdm. As of Archivematica
version 1.4, no configuration with your CONTENTdm installation is necessary.
Rather, Archivematica will prepare the DIP and allow you to download via the
Dashboard or by SFTP to the server Archivematica is installed on.

In Archivematica version 1.4, direct upload to CONTENTdm is no longer
available. The process described below assumes the user will use
`CONTENTdm Project Client`_ to upload DIPs to CONTENTdm.

Should you run into an error during this process, please see
:ref:`Error handling <error-handling>`.

*On this page*

* :ref:`Preparing a transfer for CONTENTdm <transfer-contentdm>`

* :ref:`Controlling the file order <contentdm-order>`

* :ref:`Create DIP for CONTENTdm <dip-contentdm>`

.. _transfer-contentdm:

Preparing a transfer for CONTENTdm
----------------------------------

.. seealso::

   :ref:`Manual normalization <manual-norm>`

   :ref:`Import metadata <import-metadata>`

Note that it is possible to follow these instructions for either a single simple
or compound object, or multiple simple or compound objects.

**Preparing the transfer**

For a transfer of simple objects:

1. Inside the directory you wish to use as a transfer, create two
   subdirectories: ``metadata``, and ``objects``.

2. Inside ``objects``, place the digital objects you wish to transfer.

3. Inside ``metadata``, place a file called ``metadata.csv``. See preparation
   instructions below.

Example:

.. code:: bash

   /transferName
       /objects
           file1.tif
           file2.tif
           etc
       /metadata
           metadata.csv


For a transfer of compound objects:

1. Inside the directory you wish to use as a transfer, create two
   subdirectories: ``metadata``, and ``objects``.

2. Inside ``objects``, create or place directories, one corrsponding to each
   compound object. Place the digital objects inside those directories.

3. Inside metadata, place a file called ``metadata.csv``. See preparation
   instructions below.

Example:

.. code:: bash

   /transferName
       /objects
           /directoryOne
                file1.tif
                file2.tif
                etc
           /directoryTwo
                file3.tif
                file4.tif
                etc
       /metadata
           metadata.csv


**Preparing the metadata.csv**

The first column in the metadata.csv must be called filename. The contents will
be the path to the object and/or the directory. For a simple transfer:

``objects/filename.tif``

For a compound transfer:

``objects/directoryName``

Or, for a compound transfer with object-level metadata

``objects/directoryName/filename.tif``

If there are both Dublin Core and non-Dublin Core fields in metadata.csv,
Archivematica will look for "custom" (non-Dublin Core) field names in the
metadata.csv file file and create a tab delimited file based on those fields.
This allows the operator to use the field names as they appear exactly as they
do in the CONTENTdm collection, which eases the field matching in Project
Client. It is also recommended that you enter the non-Dublin Core fields in
the same order as in your CONTENTdm collection. However, if metadata.csv
contains *only* Dublin Core namespaced fields, Archivematica will create the tab
delimited file using those fieldnames, stripping out the dc namespace. For
example,``dc.title`` will become ``title``.

For more information regarding the creation and transfer of a metadata.csv file,
see :ref:`Import metadata <import-metadata>`.

.. _contentdm-order:

Controlling the file order
--------------------------

Currently, the only method of controlling the order of files and directories as
listed in the tab delimited file is to ensure they are in alphabetical order.
The sort method is based on `ASCII`_ characters (e.g. numbers, capital letters,
underscores, small case letters).

Other methods of controlling file order could be implemented in future releases.
Please see `Issue 8448`_.

.. _dip-contentdm:

Create DIP for CONTENTdm
------------------------

.. important::

   Ensure that your CONTENTdm target collection has a field called "AIP UUID
   and a field called "File UUID". The tab file produced by Archivematica
   will populate these two fields.

1. In the Archivematica dashboard at “Upload DIP”, choose the action “Upload DIP
   to CONTENTdm” from the drop-down menu.

2. Archivematica will create a DIP consisting of normalized or :ref:`manually
   normalized <manual-norm>` access objects and a tab delimited file for use in
   Project Client.

To review the DIP in the dashboard and download individual DIP objects and/or
the tab file, click "review":

.. image:: images/ReviewDIP.*
   :align: center
   :width: 80%
   :alt: Click "review" in Upload DIP microservice to access DIP objects and tab file

The next screen will display the uploadedDIPs directory, which operators can
navigate to locate the required DIP objects. The CONTENTdm tab file will be
in the same directory as the DIP objects.

.. image:: images/cdmDIP.*
   :align: center
   :width: 80%
   :alt: Download DIP screen showing CONTENTdm tab file in objects directory


By default, the DIP will be stored in
``/var/archivematica/sharedDirectory/watchedDirectories/uploadedDIPs/``. It can
be retrieved from this location via SFTP client, or individual objects
downloaded through the web browser.

.. tip::

   Once your work in CONTENTdm Project Client is complete, and your digital
   objects are uploaded, you may wish to "clean up" your uploadedDIPs directory
   to save space on your service and keep the Download DIP page manageable. This
   can be done through the
   :ref:`Administration tab, Processing storage usage <dashboard-usage>`.


:ref:`Back to the top <contentdm>`

.. _`CONTENTdm project client`: https://help.oclc.org/Metadata_Services/CONTENTdm/Project_Client
.. _`ASCII`: https://en.wikipedia.org/wiki/ASCII
.. _`Issue 8448`: https://projects.artefactual.com/issues/8448
