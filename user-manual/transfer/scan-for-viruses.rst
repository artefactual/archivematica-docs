.. _scan-for-viruses:

================
Scan for viruses
================

The scan for viruses microservice runs at multiple points in the transfer and
ingest workflows inside Archivematica. Archivematica uses the ClamAV antivirus
engine and its configuration is discussed :ref:`here <antivirus-admin>`. The
configuration of this service can effect whether PREMIS events are recorded for
files or not.

.. figure:: images/VirusPREMISPass.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: The event log for a successful virus check

   The event log for a successful virus check

We look at the impact of various settings below.

Exploring ClamAV settings
-------------------------

``MaxFileSize`` If a file is passed to the scanner that is larger than this
then it will not be scanned. No event will be recorded.

``MaxScanSize`` limits the number of bytes that will be scanned. This might be
used in a standard operating environment where one might be confident a virus
or malware will only appear within that range. In Archivematica, because of the
possibility of a virus still existing outside of that range, a PREMIS event
cannot be recorded confidently.

``MaxStreamLength`` is a setting used in Clamdscan only. The maximum number of
bytes that can be sent to the ClamAV daemon. Files that are larger than this
limit cannot be sent in their entirety to the server and so a PREMIS event that
states the existence or non-existence of malware in the file cannot be recorded
confidently.

We can observe the impact of different combinations of configuration options in
the following two tables.

Clamscan
^^^^^^^^
+-----------+-------------+-------------+----------+--------------+
| FileSize  | MaxFileSize | MaxScanSize | Scanned? | Premis Event |
+===========+=============+=============+==========+==============+
| 42M       | 42M         | 42M         | Yes      | Yes          |
+-----------+-------------+-------------+----------+--------------+
| 42M       | 42M         | 42M         | No       | No           |
+-----------+-------------+-------------+----------+--------------+
| 84M       | 84M         | 42M         | No       | No           |
+-----------+-------------+-------------+----------+--------------+
| 84M       | 42M         | 84M         | No       | No           |
+-----------+-------------+-------------+----------+--------------+

Clamdscan
^^^^^^^^^
+-----------+-------------+-------------+-----------------+----------+--------------+
| FileSize  | MaxFileSize | MaxScanSize | StreamMaxLength | Scanned? | Premis Event |
+===========+=============+=============+=================+==========+==============+
| 42M       | 42M         | 42M         | 100M            | Yes      | Yes          |
+-----------+-------------+-------------+-----------------+----------+--------------+
| 42M       | 42M         | 42M         | 21M             | No       | No           |
+-----------+-------------+-------------+-----------------+----------+--------------+
| 84M       | 84M         | 42M         | 100M            | No       | No           |
+-----------+-------------+-------------+-----------------+----------+--------------+
| 84M       | 42M         | 84M         | 100M            | No       | No           |
+-----------+-------------+-------------+-----------------+----------+--------------+

In both tables you can see that if for any reason a file is not scanned,
or *'not-completely-scanned'*, a PREMIS event will not be recorded. A PREMIS
event in either instance of `PASS` or `FAIL` would be a false-positive.

:ref:`Back to the top <scan-for-viruses>`
