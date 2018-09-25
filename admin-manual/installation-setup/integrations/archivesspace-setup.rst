.. _archivesspace-setup:

======================================
Using ArchivesSpace with Archivematica
======================================

Archivematica |version| has been tested with and is recommended for use with the
latest version of ArchivesSpace.

For more information about ArchivesSpace, see the `ArchivesSpace`_ website.

*On this page*

* :ref:`Connecting Archivematica and ArchivesSpace <config_archivesspace>`
* :ref:`Sending material to ArchivesSpace <using-archivesspace>`

.. _config_archivesspace:

Connecting Archivematica and ArchivesSpace
------------------------------------------

Before users begin uploading data to ArchivesSpace from Archivematica, you must
fill in the ArchivesSpace DIP upload settings in the administration tab.

See :ref:`ArchivesSpace DIP upload <admin-dashboard-AS>` for more information.

.. _using-archivesspace:

Sending material to ArchivesSpace
---------------------------------

There are two primary methods of using ArchivesSpace and Archivematica together:
using the matching GUI on the Appraisal tab or using the DIP upload option on
the Ingest tab.

Matching objects to ArchivesSpace resources on the Appraisal tab
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ArchivesSpace pane in the Appraisal tab allows users to retrieve a list of
resources that have been created in an ArchivesSpace repository and match them
to digital objects in Archivematica. This information is then sent to
ArchivesSpace when you upload a DIP to ArchivesSpace.

See :ref:`ArchivesSpace resources <archivesspace_pane>` for more information.

Uploading to ArchivesSpace using DIP upload
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

DIP objects can be uploaded to ArchivesSpace without making use of the Appraisal
tab matching GUI, described above. Instead, users can select **Upload DIP to
ArchivesSpace** during the Upload DIP job in the Ingest tab.

See :ref:`Upload DIP to ArchivesSpace <upload-as>` for more information.

:ref:`Back to the top <atom-setup>`

.. _`ArchivesSpace`: http://archivesspace.org/
