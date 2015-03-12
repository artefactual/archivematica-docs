.. _duracloud-setup:

Archivematica-Duracloud Quick Start Guide
=========================================

Introduction
------------

`ArchivesDirect <http://www.archivesdirect.org/>`_ is an Archivematica in
DuraCloud hosting plan offered by Artefactual Systems and DuraSpace. This
guide can be used by those who wish to install Archivematica and/or DuraCloud
locally and run the systems themselves and may also be helpful for those using
the hosted service. This guide assumes that you have already installed
Archivematica and DuraCloud, or have arranged for a hosted instance through
Artefactual Systems/DuraSpace. Hosted clients will have steps 1 and 2
completed for them.

For installation instructions please see:

* :ref:`Archivematica installation <installation>`

* `DuraCloud documentation <https://wiki.duraspace.org/display/DURACLOUD/DuraCloud>`_

Step 1: Configure DuraCloud
---------------------------

If you plan to use DuraCloud for transfer source, processing and AIP/DIP storage,
it is recommended that your DuraCloud instance should be configured to have the
following spaces:

* aip-store : This is the space where completed AIPs will be stored

* dip-store : Space where completed DIPs are stored

* transfer-source : Space to sync digital objects for transfer into
  Archivematica. You may also create multiple spaces with other names for this
  purpose.

* transfer-backlog : Space used by Archivematica for material sent to
  :ref:`backlog <manage-backlog>`.

Note that you can pick and choose what spaces are needed in DuraCloud; for
example, you may choose to use a local server for transfer source but send
your AIPs and DIPs for storage in DuraCloud. You need only create the relevant
spaces in DuraCloud for your particular configuration.

Two DuraCloud users should be created:

* An Client user, who has **read/write** permissions for transfer-source, and
  **read** permissions for aip-store and dip-store.

* An Archivematica user, who has **read/write** permissions for aip-store,
  dip-store and transfer-backlog, and **read** permission for transfer-source.

Step 2: Configure Archivematica Storage Service
-----------------------------------------------

The :ref:`Archivematica Storage Service <storageservice:index>` was installed
when you installed Archivematica.

1. Set up a Storage Service space for each of transfer-source, transfer-backlog,
   aip-store and dip-store. Use the following parameters:

Access protocol: DuraCloud

Size: optional

Path: leave blank

Staging path: for example, ``/var/archivematica/storage_service/``

Host: Hostname of the DuraCloud instance, e.g. trial.duracloud.org

Username and Password: Enter Archivematica username and password that you
created for DuraCloud in step 1.

Duraspace: the name of the space in DuraCloud you are creating this Storage
Service space for (e.g. transfer-source, aip-store, etc).

As noted in step one, other possible configurations are possible if you are not
using DuraCloud for all Archivematica spaces.

2. Create one location in each space for aip-store, dip-store and
transfer-backlog, choosing the appropriate purpose and relative path for each.

.. tip::

   Be sure to click on the pipeline to enable the location you are creating.

3. If using DuraCloud for transfer-source, locations can be configured after
   content is synced- see below.


Step 3: Download and configure sync tool
----------------------------------------

Content can be added to DuraCloud spaces via the sync tool, which can be
installed from DuraSpace
`here <https://wiki.duraspace.org/display/DURACLOUD/DuraCloud+Downloads>`_.
The DuraCloud sync tool can be run through a GUI or the command line; these
instructions will proceed using the GUI.



Step 4: Syncing content to DuraCloud
------------------------------------

These instructions pertain to users who use a DuraCloud space for transfer-
source. DuraCloud offers its own `documentation <https://wiki.duraspace.org/display/DURACLOUDDOC/DuraCloud+Sync+Tool>`_
about syncing and configuring the DuraCloud Sync Tool. The following instructions
are configuration requirements specific to users who have Archivematica
transfer source locations in DuraCloud.

It is necessary to have a directory structure with a minimum depth of two
levels inside the synced folder, in order for Archivematica to correctly
interpret the files in DuraCloud as a potential transfer source. Deciding how
to sync directories to DuraCloud is an important step for a number of reasons:

* It will help prevent unnecessarily large transfers to Archivematica

* It can create a more efficient workflow for you later in Archivematica
  processing

Note that one transfer to Archivematica can either become one SIP (and
therefore, one AIP and one DIP) or, a transfer can be sent to backlog where it
can be separated and/or combined with other transfers to create one or more
SIP(s). Two scenarios are outlined below:

**Create a new directory to sync:**

1. Create a top level directory on your local machine or server to sync to
   DuraCloud.

2. Create at least 2 levels of directories within that directory before any
    digital objects.

Example 1:

.. code:: bash

   /syncFolder
      /Transfers
         /Project1
             Digital objects
         /Project2
             Digital objects

In this example, the directory called Transfers will be available in the
Archivematica dashboard to support the choice of a transfer source. Project1
and Project2 would each be available as a transfer source. The transfers would
each contain all of the digital objects in the directory in their respective
transfers.

Example 2:

.. code:: bash

   /syncFolder
       /Transfers
            /Project1
                 /Photographs
                      Digital objects
                 /Videos
                      Digital objects
            /Project2
                 /Text files
                      Digital objects
                 /Word files
                      Digital objects

In this example, the archivist will have more flexibility when deciding which
directory becomes a transfer in Archivematica. Either Project1 and Project2
could be transfers, as in the examples above, or the subdirectories within
could become their own transfers (Photographs, Videos, etc).

**Sync an existing directory**

1. If there are existing directories that you wish to sync but do not wish to
   reorganize into a directory structure deep enough to work with Archivematica,
   you can instead use the Sync Tool's prefix option:

i. Ensure your sync tool is stopped in the Status tab. Then click on the
   configuration tab.

ii. Under "Other options," create a prefix for your sync folder to create a
    directory structure at least two levels deep. The prefix must end in a
    slash (/).

2. Note that the prefix will replace the directory name of the sync folder in
   DuraCloud.

Example 1:

.. code:: bash

   /syncFolder
      Digital objects

If the sync directory selected in the sync tool is ``syncFolder``, you could add
a prefix such as: ``transfers/Project1/``. Archivematica would then recognize
``transfers`` as a transfer source, and ``Project1`` would be available as a
transfer. That transfer would contain all of the digital objects in ``syncFolder``.

3. It is also possible to use the prefix option with a sync folder which has
   subfolders.

Example 2:

.. code:: bash

   /syncFolder
        /Photographs
             Digital objects
        /Videos
             Digital objects

If the sync directory selected in the sync tool is ``syncFolder``, you could add
a prefix such as: ``transfers/Project1``. In this example, ``transfers`` will
still be interpreted by Archivematica as a transfer source, but either
``Project1``, ``Photographs`` or ``Video`` could be chosen in the dashboard as
the transfer.

Step 5: Configure transfer sources
----------------------------------

Assuming that you have configured transfer-source spaces in DuraCloud,
return to the Archivematica Storage Serice at this point to configure transfer
sources locations.

Navigate to the transfer-source Storage Service space and create locations for
each top level directory inside the directory or directories you have synced.

.. tip::

   If you consistently use the same named top-level directory when syncing
   (e.g. "transfers") you will only need to configure the transfer source
   once.

   If you browse for a path and do not see the expected directory listed, this
   may be caused by a UI bug. You can type the path in instead.

:ref:`Back to the top <duracloud-setup>`
