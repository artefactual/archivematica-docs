.. _manage-backlog:

==================
Managing a backlog
==================

Users may wish to send their transfers to a backlog for storage until they are
ready to be retrieved and processed at a later date. Sending transfers through
the micro-services in the transfer tab of the dashboard allows the repository
a minimum amount of control over their digital objects. The transfer contents
and METS file are indexed to facilitate retrieval.

This workflow assumes that users have sent transfers to backlog from the end
of the transfer workflow in the dashboard, in the Micro-service: Create SIP
from Transfer, Job: Create SIP(s) dropdown menu. (Option 2 in Step 7 in
:ref:`Process the transfer <process-transfer>`).

Retrieve from backlog
---------------------

1. Use the Transfer backlog search bars at the top of the Ingest tab to find the
transfer(s) and/or object(s) you'd like to ingest, or browse the entire
backlog by clicking Search transfer backlog with a blank search. This will
populate the Originals pane of the Ingest dashboard.

.. note::

   Multi-item select is not yet included in this feature, though entire
   folders/directories can be moved.

To hide directories from the Originals pane, click on the directory and click
Hide.

.. figure:: images/Ingest-panes.png
   :align: center
   :figwidth: 80%
   :width: 100%
   :alt: Transfer backlog search results populate Originals pane

   Transfer backlog search results populate Originals pane


2. Drag and drop the transfer directory(ies) and/or object(s) you wish to
arrange and ingest as a SIP from the Originals panel to the Arrange panel, or
create an arrangement structure for your SIP.

3. If you wish to create one or more SIP(s) from one or more transfer(s), see
:ref:`Arrange SIP(s) <arrange-sip>`.

4. Click on the directory in the Arrange pane to select, and then click Create
SIP. Archivematica will confirm that you wish to create a SIP, and then
continue through the ingest process.

5. In the Ingest tab, your SIP will be waiting for a user decision. Select
"SIP creation complete" from the dropdown menu.

6. Continue processing using the ingest workflow. See :ref:`Ingest <ingest>`.

7. Once you've created an AIP and uploaded it to archival storage, your
transfer will be removed from the backlog and the index will be updated.


:ref:`Back to the top <manage-backlog>`
