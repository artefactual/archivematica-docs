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
searching the `public user forum <https://groups.google.com/forum/?fromgroups#!forum/archivematica>`_.
Someone may have had the same problem before and been offered a solution. If you
do not find the answer there, feel free to ask us a question. The best questions
to the list include as much information as possible about the error. This
means offering us information about the system(s) you're using, the content of
your transfer(s), and copying the task information (click on the cog icon on
the same line as the micro-service job where the error occurred) and show
arguments data output. See task information and show arguments data for the
same error, below.

*On this page:*

* :ref:`Dashboard error reporting <error-dashboard>`

* :ref:`Failure reports in Administration tab <failure-reports>`

* :ref:`Email error report <email-failure>`

* :ref:`Normalization errors <normalization-errors>`

* :ref:`DIP upload error <dip-error>`

* :ref:`Common error behaviours <common-errors>`

* :ref:`Rejecting a transfer or SIP <rejecting>`

* :ref:`Removing a transfer or SIP from the dashboard <removing>`

* :ref:`Browser compatability <error-browser>`

.. _error-dashboard:

Dashboard error reporting
-------------------------

When a micro-service fails or encounters an error, the micro-service
background turns from green to pink and a "failed" icon appears next to the
transfer or SIP name:

.. figure:: images/PinkChecksumFail.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: The dashboard showing a transfer has failed

   The dashboard showing a transfer has failed at the Verify transfer checksums
   micro-service and has been moved to the failed directory

Note that the transfer has been moved to the failed directory and processing
has been halted.

Clicking on the micro-service will expand to show the specific job that contains
an error:


.. figure:: images/PinkFailMSexpandJob.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Micro-service expanded to show the failed job

   The Verify transfer checksums micro-service expanded to sholw the failed job

Click the tasks icon (the gear icon on the right-hand side) to open up an
error report:

.. figure:: images/ErrorRptFailVirusScan-10.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: An error report showing that a virus has been found in a file

   An error report showing that a virus has been found in a file

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

If the user has an email address associated with their user account, the
dashboard can email a failure report:

.. figure:: images/EmailFail-10.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: An emailed failure report showing an error at Verify bag micro-service

   An emailed failure report showing an error at Verify bag micro-service

An e-mail is generated if the transfer or ingest cannot be completed, not if
an error occurs which does not halt processing. Please note that the server
must have mail delivery enabled in order to receive error emails without
additional configuration.

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

The report shows what has been normalized, what is already in an
acceptable preservation and access format, and what has failed normalization
or is not in a recognized preservation or access format. If normalization has
failed, you can click on "yes" to see a task report of the error in a new tab:

.. figure:: images/Normreporterrortask-10.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Task output for failed normalization job

   Task output for failed normalization job


**Option 2**

Click Review in parentheses next to the micro-service to view the
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
the user chose to normalize based on FITS-JHOVE results and experienced
failures, the user may wish to redo normalization and choose to normalize
based on FITS-DROID results instead.

.. figure:: images/Normdropdown-10.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Redo normalization option in drop-down menu of Approve normalization job

   Redo normalization option in drop-down menu of Approve normalization job

Archivematica will send an email when normalization errors occur. Information given
in the email report:

* UUID of the pipeline
* Name and UUID of the SIP
* File name and file UUID, and whether Preservation or Access normalization failed
* Exit code

Exit code 1 indicates that a normalization rule and command exists but failed
to execute properly (due to a problem in the command, a problem with the file, etc).
Exit code 2 indicates that a normalization rule/command does not exist for that
format.

.. figure:: images/NormEmailReport.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Normalization error report sent by email

   Emailed normalization error report

.. _dip-error:

Dip upload error
----------------

Archivematica will allow the user to continue to attempt to upload the DIP if
a mistake was made entering the permalink:


.. figure:: images/DIPUploadTryAgain-10.*
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Warning that permalink was incorrect, allows user to retry upload DIP

   Warning that permalink was incorrect, allows user to retry upload DIP


.. _common-errors:

Other common error behaviours
-----------------------------

#. Verify metadata directory checksums: if the checksums in the metadata
   directory cannot be verified (i.e. if a file is missing or corrupted) the
   micro-service will fail and the transfer will be moved in the failed
   directory.

#. Scan for viruses: if a virus is found the micro-service will fail and the
   transfer will be moved in the failed directory.

#. Characterize and extract metadata: if FITS processing fails, the micro-
   service will fail and the transfer will continue processing. Similarly, if
   a tool within FITS fails, like JHOVE, you will see the pink error bar but
   be able to continue processing.

#. Remove thumbs.db file: if Archivematica is unable to remove a thumbs.db
   file, the micro-service will fail and the SIP will continue processing.

#. Normalize submission documentation to preservation format: if normalization
   fails, the micro-service will fail and the SIP will continue processing.

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

   Click on the red Remove icon to remove a transfer or SIP from the dashboard, then click Confirm.

It is recommended that you clear your dashboard of transfers and SIPs periodically
to improve browser performance.

.. _error-browser:

Browser compatability
---------------------

Archivematica has been tested most extensively with Firefox and Chrome. There are
known issues with Internet Explorer 11 which result in an inability to start
transfers in the dashboard (`Issue 7246 <https://projects.artefactual.com/issues/7246>`_).  Minimal, but successful,
testing has been done with Microsoft Edge.

:ref:`Back to the top <error-handling>`
