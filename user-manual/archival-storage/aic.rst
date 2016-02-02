.. _aic:

===
AIC
===

Because datasets and digital object collections can be large and
heterogeneous, one dataset or collection of digital objects may be broken into
multiple AIPs. In such cases, the multiple AIPs can be intellectually combined
into one AIC, or Archival Information Collection, defined by the OAIS
reference model as "[a]n Archival Information Package whose Content
Information is an aggregation of other Archival Information Packages." (OAIS
1-9).

A basic AIC in Archivematica consists of:

* any number of related AIPs and

* a METS file containing a fileSec and a logical structMap listing all the
  related AIPs.

In storage, a pointer.xml file gives storage and compression information for
each AIC METS file and each AIP.

This part of the user guide is for creating and updating AICs.


Creating AICs
-------------

**Step 1: Create AIPs**

1. Ingest a standard transfer consisting of metadata and data files, or create a
SIP from backlog using the :ref:`SIP arrange pane <arrange-sip>`.

2. At the Normalize micro-service, click on the metadata button:

.. image:: images/AIC-Normalize.*
   :align: center
   :width: 80%
   :alt: Click on metadata button at Normalize step

3.  Under Metadata, select Add:

.. image:: images/AIC-AddMD.*
   :align: center
   :width: 80%
   :alt: Click on Add under Metadata

<<<<<<< HEAD
4. Enter Dublin Core metadata. Recommended minimum is Title and Part of AIC.
However, if desired, use the metadata entry template to create a more detailed
description of the AIP contents:
=======
4. Enter Dublin Core metadata. At a minimum, the AIC identifier (Part of AIC field) is required. However, if desired, use the metadata entry template to create a more detailed description of the AIP contents:
>>>>>>> 2e1c749... Clarified AIC identifier requirements

.. image:: images/AIC_metadata.*
   :align: center
   :width: 80%
   :alt: In the metadata screen add Title and Part of AIC

.. tip::

   The AIC can be represented by any combination of letters and numbers.


5. At bottom of screen, click the Create button.

6. Return to the ingest tab, finish processing and place the AIP in archival
storage.

7. Repeat steps 1 through 6 to create as many AIPs as desired. In step
1.4, be sure to enter the same value in Part of AIC if all of the AIPs are
destined to be added to the same AIC.

8. Once all the AIPs have been placed in storage, open the archival storage tab.

**Step 2: Create AIC**

1. To retrieve all AIPs with the same value in Part of AIC, enter AIC#[number]
in the search box and select Part of AIC as the search field. On the right
hand side, select "Show AICs?". Then click the Search archival storage button:

.. image:: images/AIC_search.*
   :align: center
   :width: 80%
   :alt: Search for AIPs in Archival storage

2. To create an AIC comprising all of the AIPs listed in the search results,
click the Create an AIC button:

.. image:: images/AIC_Create_button.*
   :align: center
   :width: 80%
   :alt: Click the Create an AIC button

3. Archivematica will produce a metadata entry template for the AIC. In the
template, at a minimum enter values into Title and Identifier fields.

.. note::

   The Identifier value must be structured as AIC#[number].

If desired, use the metadata entry template to create a more detailed
description of the AIC contents:

.. image:: images/AIC_New_metadata.*
   :align: center
   :width: 80%
   :alt: Enter metadata about the AIC.


4. Click the Create button at the bottom of the metadata entry template.
Return to the ingest tab. When the AIC appears in the dashboard, approve the
AIC:

.. image:: images/AIC_approve.*
   :align: center
   :width: 80%
   :alt: Approve the AIC in Ingest tab

5. Continue processing the AIC and place it in archival storage.


Retrieve and update AICs
------------------------

**Retrieve an AIC and related AIPs**

Open the Archival storage tab. To view a list of an AIC and its constituent
AIPs, search for the AIPs as described in Create AIC, above. Click Add new to
add a second search query using the OR boolean operator. In the second query
line, enter AIC#[number] in the search box and select AIC Identifier as the
search field. Click the Search archival storage button.

In the results list, the AIC is distinguishable by the entry in the AIC #
column, as shown in the screenshot (the constituent AIPs are shown with Part
of AIC#[number]) in that field.

.. image:: images/AIC_search_existing.*
   :align: center
   :width: 80%
   :alt: Search for AIC number in Archival storage

.. note::

   The Files column lists the number of AIPs in the AIC. This should match the
   number of AIPs shown in the search results. A bug is preventing the correct
   AIC file count in version 1.2 (see
   `Bug #7155 <https://projects.artefactual.com/issues/7155>`_ .


**Update an AIC**

If you would like to add more AIPs to an existing AIC, the original AIC should
be deleted via the archival storage tab. An AIC is deleted in the same way an
AIP is deleted: see :ref:`Delete an AIP <delete-aip>`.

Add as many new AIPs as desired as shown Creating AIPs above, and create
a new AIC as shown in Creating AICs.

:ref:`Back to the top <aic>`
