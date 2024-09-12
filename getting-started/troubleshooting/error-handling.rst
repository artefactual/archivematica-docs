.. _error-handling:

==============
Error handling
==============

Archivematica anticipates that a number of different types of errors can occur
during processing. Some of them will result in processing being halted and the
transfer or SIP being moved to the failed directory in the file browser. For
others, processing can continue: for example, a normalization failure is
reported and the user is given the opportunity to continue processing the SIP.

If you don't find an answer here or elsewhere in the user manual, please try
searching the `Archivematica user forum`_. Someone may have had the same problem
before and been offered a solution. If you do not find the answer there, feel
free to ask us a question. The best questions to the list include as much
information as possible about the error. This means offering us information
about the system(s) you're using, the content of your transfer(s), and copying
the task information (click on the cog icon on the same line as the microservice
job where the error occurred) and show arguments data output. See task
information and show arguments data for the same error, below.

*On this page:*

* :ref:`Dashboard error reporting <error-dashboard>`
* :ref:`Failure reports in Administration tab <failure-reports>`
* :ref:`Email error report <email-failure>`
* :ref:`Normalization errors <normalization-errors>`
* :ref:`DIP upload error <dip-error>`
* :ref:`Errors that fail transfers <failure-errors>`
* :ref:`Common error behaviours <common-errors>`
* :ref:`Rejecting a transfer or SIP <rejecting>`
* :ref:`Removing a transfer or SIP from the dashboard <removing>`
* :ref:`Browser compatability <error-browser>`

.. _error-dashboard:

Dashboard error reporting
-------------------------

In certain cases, when a microservice fails or encounters an error, the workflow
will be halted and Archivematica will report a 'Failed transfer'. The
microservice drop-down can be expanded to show the specific task that failed.

.. figure:: images/PinkChecksumFail.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: The dashboard showing a transfer has failed

   The dashboard showing a transfer has failed at the Verify transfer checksums
   microservice

Note that the transfer has been moved to the failed directory and processing
has been halted.

.. figure:: images/PinkFailMSexpandJob.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Microservice expanded to show the failed job

   The expanded detail on 'Failed transfer'

Click the tasks icon (the gear icon on the right-hand side) to open up an
error report:

.. figure:: images/ErrorRptFailChecksum.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: An error report showing that a virus has been found in a file

   An error report showing that a file has failed checksum validation

These reports are generally standard and predictable for certain types of
errors and are useful for trouble-shooting. Note that the failed file(s) will
always appear at the top of the report.


.. _failure-reports:

Failure reports in Administration tab
-------------------------------------

You can view failure reports in the Administration tab of the dashboard.
See :ref:`Dashboard administration tab- Failures <dashboard-failures>` for
more information.


.. _email-failure:

Email error report
------------------

Archivematica will send email reports for two kinds of failures:

* Normalization reports are sent when the normalization process has resulted in
  at least one error.
* Failure reports are sent when the workflow fails unexpectedly.

.. figure:: images/EmailFail-10.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: An emailed failure report showing an error at Verify bag microservice

   An emailed failure report showing an error at Verify bag microservice

An e-mail is generated if the transfer or ingest cannot be completed, not if
an error occurs which does not halt processing. Please note that the server
must have mail delivery enabled in order to receive error emails without
additional configuration.

For more information about email reports, please see :ref:`Email notification
configuration <email-config>`

.. _normalization-errors:

Normalization errors
--------------------

The dashboard will report normalization errors when:

* Normalization is attempted but fails

* No normalization is attempted and the file is not in a recognized
  preservation or access format

When normalization fails, the SIP continues processing until it reaches the
normalization approval step. At this point, the user has two options:

**Option 1**

Click on the report icon next to the Actions drop-down menu to see a summary
report of the normalization:

.. figure:: images/NormReporterror-10.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Normalization report showing failed normalization attempts

   Normalization report showing failed normalization attempts

The report shows what has been normalized, what is already in an acceptable
preservation and access format, and what has failed normalization or is not in a
recognized preservation or access format. If normalization has failed, you can
click on "yes" to see a task report of the error in a new tab:

.. figure:: images/Normreporterrortask-10.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Task output for failed normalization job

   Task output for failed normalization job


**Option 2**

Click Review in parentheses next to the microservice to view the
normalization results in a directory structure in a new browser tab:

.. figure:: images/RvrNorm-10.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Review normalization results in a new tab

   Review normalization results in a new tab

The review allows the user to either open the objects in the browser when
there is an appropriate plug-in or download the objects and open them using a
local application.

The user may choose to continue processing the SIP despite any normalization
errors.

The user may choose to redo normalization, as well. For instance, if
the user chose to normalize based on one tool's results and experienced
failures, the user may wish to redo normalization and choose to normalize
based on another tool's results instead.

.. figure:: images/Normdropdown-10.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Redo normalization option in drop-down menu of Approve normalization job

   Redo normalization option in drop-down menu of Approve normalization job

Archivematica will send an :ref:`email <email-failure>` when normalization
errors occur. Information given in the email report:

* UUID of the pipeline Name and UUID of the SIP File name and file UUID, and
* whether Preservation or Access normalization failed Exit code

Exit code 1 indicates that a normalization rule and command exists but failed to
execute properly (due to a problem in the command, a problem with the file,
etc). Exit code 2 indicates that a normalization rule/command does not exist for
that format.

.. figure:: images/NormEmailReport.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Normalization error report sent by email

   Emailed normalization error report

.. _dip-error:

DIP upload error
----------------

Archivematica will allow the user to continue to attempt to upload the DIP if
a mistake was made entering the permalink:


.. figure:: images/DIPUploadTryAgain-10.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Warning that permalink was incorrect, allows user to retry upload DIP

   Warning that permalink was incorrect, allows user to retry upload DIP

.. _failure-errors:

Errors that fail transfers
-----------------------------

There are a number of microservice errors that will halt the workflow and cause
Archivematica to report a 'Failed transfer'. It is important to note that not
all microservice errors will lead to a failed transfer. Below is a list of
common errors that will result in the 'Failed transfer' microservice to run and
the transfer to be moved to the failed directory.

#. Scan for viruses: if a virus is found in the transfer then the microservice
   will fail and the transfer will be moved to the failed directory.

#. Generate METS.xml document: if this microservice fails to generate a portion
   of the METS file when run in either the Transfer Tab or the Ingest Tab, it
   will fail the transfer or SIP. Either the transfer or SIP will be moved to
   the failed directory. The error logs will give details about the issue so
   you can investigate further.

#. Verify transfer checksums: if the checksums in the metadata
   directory cannot be verified (i.e. if a file is missing or corrupted) this
   microservice will fail and the transfer will be moved to the failed
   directory.

#. Approve Transfer (zipped and unzipped bags): When running a zipped or
   unzipped bag transfer, the first microservice is 'Approve transfer.' If the
   'verify bag, and restructure for complaince' job fails within this
   microservice, the transfer will fail and be moved to the failed directory.
   This will happen when the bag does not conform to the `BagIt`_ specification
   or when one of the components is incorrect.

#. Verify transfer compliance: if a job fails within this microservice, the
   transfer will also fail and will be moved to the fail directory.

.. _common-errors:

Other common error behaviours
-----------------------------

Below is a list of common errors that, like normalization, will produce an
error report but will not fail the transfer.

#. Characterize and extract metadata: if the characterization tool fails, the
   micro-service will fail and the transfer will continue processing.
   You will see the pink error bar but be able to continue processing.

#. Remove thumbs.db file: if Archivematica is unable to remove a thumbs.db
   file, the microservice will fail and the SIP will continue processing.

#. Normalize submission documentation to preservation format: if normalization
   fails, the microservice will fail and the SIP will continue processing.

.. _rejecting:

Rejecting a transfer or SIP
---------------------------

At any of the workflow approval points the user can choose to reject a
transfer, SIP, AIP or DIP (depending on where the information object is in the
workflow). This will move the transfer or SIP to the Rejected directory
(accessible from the file browser) and will stop all processing on it. The
transfer or SIP will still be listed in the dashboard, however. See
:ref:`Removing a transfer or SIP from the dashboard <removing>`, below, to
remove it from the dashboard.

.. _removing:

Removing a transfer or SIP from the dashboard
---------------------------------------------

To remove a transfer or SIP from the dashboard, click on the red "Remove" icon
in the dashboard:

.. figure:: images/RemoveSIPDash-10.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Click on the red Remove icon to remove a transfer or SIP from the dashboard

   Click on the red Remove icon to remove a transfer or SIP from the dashboard,
   then click Confirm.

It is recommended that you clear your dashboard of transfers and SIPs
periodically to improve browser performance.

.. _error-browser:

Browser compatability
---------------------

Archivematica has been tested most extensively with Firefox and Chrome. There
are known issues with Internet Explorer 11 which result in an inability to start
transfers in the dashboard (:issue:`7246`).  Minimal, but successful, testing
has been done with Microsoft Edge.

:ref:`Back to the top <error-handling>`

.. _`Archivematica user forum`: https://groups.google.com/forum/#!forum/archivematica
.. _`BagIt`: https://tools.ietf.org/html/rfc8493
