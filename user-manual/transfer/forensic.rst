.. _forensic:

====================
Forensic disk images
====================

Archivematica supports the preservation of forensic disk images. Selecting the
disk image :ref:`transfer type <transfer-types>` is not required to preserve
disk images - you can use the standard transfer types or the bag transfer
types, if your disk image is bagged. The disk image transfer type gives users
an extra disk image-specific metadata form where you can record information
about the imaging process.

*On this page*

* :ref:`Workflow configuration options <disk-image-configuration-options>`

* :ref:`Using the disk image transfer type <disk-image-workflow>`

  * :ref:`Compound disk images <compound-disk-images>`

.. _disk-image-configuration-options:

Workflow configuration options
------------------------------

If you are processing disk images, you may want to adjust Archivematica's
:ref:`processing configuration <dashboard-processing>` options in the
Administration tab of the dashboard.

For more information on the processing configuration fields, see
:ref:`Fields and options <processing-config-fields>`.

Extract packages
++++++++++++++++

Archivematica can be configured to extract the contents from a package, which
includes forensic image formats as well as compressed content like ZIP files.

However, extracting the contents of a forensic disk image can cause major
performance issues, since disk images often contain many thousands of system
files that need to be subsequently processed in Archivematica. This can result
in failures. We recommend not extracting forensic image formats. This can be set
in the processing configuration by setting the *Extract packages* job to "No".

If you would like to extract forensic image formats anyway, you can set the
*Extract packages* job to "Yes". We recommend testing this at scale to ensure
that it is a viable workflow for your deployment. For more information, see
:ref:`Preservation Action Rules <disable-fpr-rules>` on the Scalability page.

Delete packages after extraction
++++++++++++++++++++++++++++++++

If you have chosen to extract files, Archivematica can be configured to delete
the original package (the metadata and logs for the package are retained). This
can save space in the resulting AIP. The original package can also be retained.

To have Archivematica automatically delete forensic image formats once the files
have been extracted, set the *Delete packages after extraction* job to "Yes". If
you would prefer to retain the file after extraction, set the job to "No".

Examine contents
++++++++++++++++

The examine contents microservice runs `Bulk Extractor`_, a forensics tool that
can recognize credit card numbers, social security numbers, and other patterns
in data. Bulk Extractor creates logs that are stored in the AIP. The logs can be
inspected by sending the transfer to the backlog and using the Examine Contents
functionality on the :ref:`Analysis pane <analysis_pane>` in the Appraisal tab.

Examine contents is another microservice that can result in increased processing
time, especially if it is running on the contents of an extracted forensic disk
image. If you are not extracting contents, the disk image itself is not likely
to generate any results from Bulk Extractor.

We recommend setting the *Examine contents* job to "No", so that Bulk Extractor
does not run. If you would like to run Bulk Extractor on the extracted contents
of a forensic disk image, we strongly recommend testing this workflow at scale
to ensure that the Archivematica site is properly resourced to handle the
processing load.

.. _disk-image-workflow:

Using the disk image transfer type
----------------------------------

#. Select *Disk image* from the Transfer type drop-down menu on the Transfer tab
   of the dashboard. Give your transfer a name.

#. From the transfer browser, choose your forensic disk image and click **Add**.
   Note that it must be contained within a directory.

#. If you would like to add metadata about the imaging process, click on the
   metadata icon to the right of the filename. This will open the metadata form
   in a new tab. Adding metadata is optional.

   .. figure:: images/start-forensic-transfer.*
      :align: center
      :figwidth: 70%
      :width: 100%
      :alt: The transfer tab showing a disk image transfer setup, with the metadata icon circled in red.

      Click on the metadata icon to add metadata.

#. Enter your metadata and click **Save**, then close the tab.

   .. figure:: images/forensic-metadata-template.*
      :align: center
      :figwidth: 70%
      :width: 100%
      :alt: Forensic disk image metadata template

      Fill in the metadata template and click save.

   .. important::

      The metadata form opens in a new tab. After clicking save, you **must**
      close the new tab to go back to your in-progress transfer, rather than
      clicking on the Transfer tab from the metadata form.

#. If you are planning to start multiple transfers, you can repeat the above
   steps for adding metadata to additional transfers.

#. Once all images are loaded to the dashboard and all metadata is added, select
   **Start Transfer**.

#. Proceed through the normal :ref:`Transfer <transfer>` and
   :ref:`Ingest <ingest>` workflows.

.. note::

   Note that during the *Characterize and extract metadata* microservice,
   `fiwalk`_ will be used on forensic disk image files.

.. _compound-disk-images:

Compound disk images
++++++++++++++++++++

You can combine multiple parts of a compound disk image into a single AIP, if
desired, by using the backlog arrangement functionality in Archivematica.

#. Start each part of the compound disk image as a single transfer, as per the
   instructions above.

#. When you reach the *Create SIP* job, select "Send to backlog". Do this for
   each transfer.

#. In the :ref:`Appraisal tab <appraisal>`, use the
   :ref:`Arrangement <arrangement>` pane to combine your transfers into one SIP.

#. Once you're happy with the arrangement, start the SIP by selecting the parent
   directory and then clicking **Create SIP**.


:ref:`Back to the top <forensic>`


.. _Bulk Extractor: https://github.com/simsong/bulk_extractor/wiki
.. _fiwalk: https://forensicswiki.xyz/wiki/index.php?title=Fiwalk
