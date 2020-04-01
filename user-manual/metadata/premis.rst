.. _premis-template:

================================
PREMIS metadata in Archivematica
================================

Archivematica supports `PREMIS`_ metadata and currently implements `version 3`_.
It captures extensive technical metadata about Objects and records actions
(known as Events) taken on Objects by Agents. It also supports the addition of
PREMIS Rights metadata. This page discusses how PREMIS is implemented in the AIP
METS file.

*On this page:*

* :ref:`PREMIS Events metadata <premis-events>`
* :ref:`PREMIS Events list <event-list>`
* :ref:`PREMIS Agent metadata <premis-agent>`
* :ref:`PREMIS Rights metadata <premis-rights>`

.. _premis-events:

PREMIS Events metadata
----------------------

PREMIS Events will be recorded in separate digiprovMD sections in the METS (see
:ref:`METS in Archivematica <METS_schema>` for more information). PREMIS Events
recorded in the METS will contain metadata for *most* of the following semantic
units and semantic components (only if applicable):

* eventIdentifier - eventIdentifierType
* eventIdentifier - eventIdentifierValue
* eventType
* eventDateTime
* eventDetail
* eventOutcomeInformation - eventOutcome
* eventOutcomeDetail - eventOutcomeDetailNote
* linkingAgentIdentifier - linkingAgentIdentifierType
* linkingAgentIdentifier - linkingAgentIdentifierValue

For more information on semantic units and semantic components in PREMIS, please
see the `Data Dictionary`_. Below is an example of a PREMIS Event for file
format identification.

.. literalinclude:: scripts/METS.xml
   :language: xml
   :lines: 2272-2302

Note that there will be three Agents per Event listed under the
``linkingAgentIdentifier`` semantic unit. This means there will also be three
``linkingAgentIdentifierType`` and three ``linkingAgentIdentifierValue``
semantic components. Each Agent applied to a PREMIS event will also have its own
digiprovMD section in the METS (see :ref:`PREMIS Agent Metadata
<premis-agent>`).


.. _event-list:

PREMIS Events list
------------------

There are PREMIS Events that apply to original files and some that apply to
normalized files. Both are listed below, followed by a list of Events that occur
when certain microservices run in Archivematica.

Skip to:

* :ref:`Default events for original files <event-default>`
* :ref:`Normalized files <event-normalize>`
* :ref:`Name cleanup <event-cleanup>`
* :ref:`Format identification <event-identification>`
* :ref:`Extract packages <event-extract>`
* :ref:`OCR transcription <event-ocr>`
* :ref:`AIP reingest <event-reingest>`
* :ref:`Sending transfers to backlog <event-backlog>`

.. _event-default:

Default events for original files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The following microservices are run for all *original* objects ingested into
Archivematica, including any submission documentation:

* ingestion
* message digest calculation
* virus check

If a bag or a transfer with checksum manifests is ingested, then each file will
include:

* fixity check

.. _event-normalize:

Normalized files
^^^^^^^^^^^^^^^^

The following microservices are run for all *normalized* files:

* creation
* message digest calculation
* validation (if there is a validation tool available for the identified format)

Note that for *original* files with a normalized derivative, a normalization
PREMIS Event will be added.

.. literalinclude:: scripts/PREMISevents.xml
   :language: xml
   :lines: 107-126

.. _event-cleanup:

Name cleanup
^^^^^^^^^^^^

If this microservice is run on a file, then it is entered as the following
PREMIS Event which also records the original filename:

* name cleanup

.. literalinclude:: scripts/PREMISevents.xml
   :language: xml
   :lines: 35-53

.. _event-identification:

Format identification
^^^^^^^^^^^^^^^^^^^^^

When this microservice is run, the following PREMIS Events may be recorded:

* format identification
* validation (if there is a validation tool available for the identified format)

.. _event-extract:

Extract packages
^^^^^^^^^^^^^^^^

This PREMIS Event will be recorded on all extracted files:

* unpacking

.. literalinclude:: scripts/PREMISevents.xml
   :language: xml
   :lines: 1-14

.. _event-ocr:

OCR transcription
^^^^^^^^^^^^^^^^^

If OCR is run over a file in the Ingest tab, then the file will include the
following PREMIS Event:

* transcription

.. _event-reingest:

AIP reingest
^^^^^^^^^^^^

If an AIP has been partially or fully reingested there will be a PREMIS Event
for all files in the **objects** directory:

* reingestion

.. _event-backlog:

Sending transfers to backlog
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If a transfer was sent to backlog there will be an PREMIS Event:

* removal from backlog

.. literalinclude:: scripts/PREMISevents.xml
   :language: xml
   :lines: 71-81


.. _premis-agent:

PREMIS Agent metadata
----------------------

PREMIS Agents that are linked to a PREMIS Event will also be placed in its own
digiprovMD section. The default semantic units for each agent are:

* agentIdentifier
* agentName
* agentType

There are three types of Agents associated with every PREMIS Event. They will be
listed under ``agentType`` as the following three options (METS XML examples
included):

Software
^^^^^^^^^

.. literalinclude:: scripts/METS.xml
   :language: xml
   :lines: 2378-2388

Organization
^^^^^^^^^^^^^

.. literalinclude:: scripts/METS.xml
   :language: xml
   :lines: 2392-2402

Archivematica user
^^^^^^^^^^^^^^^^^^

.. literalinclude:: scripts/METS.xml
   :language: xml
   :lines: 2406-2416


One of each type of Agent will be included in each amdSec as its own digiprovMD
in the METS AIP file (See :ref:`METS in Archivematica <METS_schema>`).


.. _premis-rights:

PREMIS Rights metadata
----------------------

PREMIS rights metadata can be added during :ref:`transfer <transfer>` or
:ref:`ingest <ingest>`; it can be entered via the GUI interface to be applied to
the entirety of the SIP or transfer. Rights can also be entered at the object
level by describing them in a rights.csv file and using the :ref:`Import
metadata <import-metadata>` feature.

Below, the entry template is described as it appears for each rights basis,
followed by acts granted/restricted.

Skip to:

* :ref:`Basis: Copyight <basis-copyight>`
* :ref:`Basis: Statute <basis-statute>`
* :ref:`Basis: License <basis-license>`
* :ref:`Basis: Donor <basis-donor>`
* :ref:`Basis: Policy <basis-policy>`
* :ref:`Basis: Other <basis-other>`
* :ref:`Acts granted or restricted <acts-granted>`


.. _basis-copyight:

Basis: Copyright
^^^^^^^^^^^^^^^^

Below is a list of the template fields and the associated rule. The example also
includes the resulting block of METS XML.

PREMIS in METS XML: ``<premis:rightsBasis>Copyright</premis:rightsBasis>``

Copyright status
++++++++++++++++

**Rule** "A coded designation of the copyright status of the object at the time
the rights status is recorded; e.g. copyrighted, publicdomain, unknown."

.. code-block:: none

   <premis:rightsStatement>
       <premis:copyrightInformation>
          <premis:copyrightStatus>Under copyright</premis:copyrightStatus>


Copyright jurisdiction
++++++++++++++++++++++

**Rule** "The country whose copyright laws apply"

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
          <premis:copyrightJurisdiction>ca</premis:copyrightJurisdiction>

**Notes** Values should be taken from a controlled vocabulary. Recommended:
ISO 3166.


Copyright determination date
++++++++++++++++++++++++++++

**Rule** "The date that the copyright status recorded in copyrightStatus was
determined."

.. code-block:: none

   <premis:rightsStatement>
       <premis:copyrightInformation>
            <premis:copyrightStatusDeterminationDate>2011-09-16</premis:copyrightStatusDeterminationDate>

**Notes**  Uses ISO 8061.

Copyright start date
++++++++++++++++++++

**Rule** "Date when the particular copyright applies or is applied to the
content."

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
         <premis:copyrightApplicableDates>
            <premis:startDate>2015-01-01</premis:startDate>

**Notes** Uses ISO 8061.

Copyright end date
++++++++++++++++++

**Rule** "Date when the particular copyright no longer applies or is applied to
the content."

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
         <premis:copyrightApplicableDates>
            <premis:endDate>2065-01-01</premis:endDate>

**Notes** Uses ISO 8061. End date can be left open by clicking "Open End Date."

Copyright documentation identifier- Type
++++++++++++++++++++++++++++++++++++++++

**Rule** "A designation of the domain within which the copyright documentation
identifier is unique."

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
         <premis:copyrightDocumentationIdentifier>
            <premis:copyrightDocumentationIdentifierType> Donor form </premis:copyrightDocumentationIdentifierType>

Copyright documentation identifier- Value
+++++++++++++++++++++++++++++++++++++++++

**Rule** "The value of the copyrightDocumentationIdentifier."

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
         <premis:copyrightDocumentationIdentifier>
            <premis:copyrightDocumentationIdentifierValue>CCA-2009-67</premis:copyrightDocumentationIdentifierValue>

Copyright documentation identifier- Role
++++++++++++++++++++++++++++++++++++++++

**Rule** "A value indicating the purpose or expected use of the documentation
being identified."

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
         <premis:copyrightDocumentationIdentifier>
            <premis:copyrightDocumentationIdentifierRole>Copyright holder statement</premis:copyrightDocumentationIdentifierRole>

Copyright note
++++++++++++++

**Rule** "Additional information about the copyright status of the object".

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
         <premis:copyrightNote>Copyright held by donor</premis:copyrightNote>


.. _basis-statute:

Basis: Statute
^^^^^^^^^^^^^^

PREMIS in METS XML: ``<premis:rightsBasis>Statute</premis:rightsBasis>``

Statute jurisdiction
++++++++++++++++++++

**Rule** "The country or other political body enacting the statute."

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteInformation>
         <premis:statuteJurisdiction>ca</premis:statuteJurisdiction>

**Notes** Values should be taken from a controlled vocabulary. Recommended: ISO
ISO 3166.


Statute citation
++++++++++++++++

**Rule** "An identifying designation for the statute."

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteInformation>
         <premis:statuteCitation>Freedom of Information and Protection of Privacy Act [RBSC 1996] Chapter 165</premis:statuteCitation>


Statute determination date
+++++++++++++++++++++++++++

**Rule** "The date that the determination was made the the statute authorized
the permission(s) noted."

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteInformation>
         <premis:statuteInformationDeterminationDate>2015-07-02</premis:statuteInformationDeterminationDate>

**Note** Uses ISO 8061


Statute start date
++++++++++++++++++

**Rule** "The date when the statute begins to apply or is applied to the
content."

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteApplicableDates>
         <premis:startDate>2015-01-01</premis:startDate>

**Note** Uses ISO 8061


Statute end date
++++++++++++++++

**Rule** "The date when the statute ceases to apply or is applied to the
content."

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteApplicableDates>
         <premis:endDate>2020-01-01</premis:endDate>

**Note** Uses ISO 8061. End date can be left open by clicking "Open End Date."


Statute documentation identifier- Type
++++++++++++++++++++++++++++++++++++++

**Rule** "A designation of the domain within which the statute documentation
identifier is unique."

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteDocumentationIdentifier>
         <premis:statuteDocumentationIdentifierType>Acts</premis:statuteDocumentationIdentifierType>



Statute documentation identifier- Value
+++++++++++++++++++++++++++++++++++++++

**Rule** "The value of the statuteDocumentationIdentifier."

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteDocumentationIdentifier>
         <premis:statuteDocumentationIdentifierValue>RBSC 1996</premis:statuteDocumentationIdentifierValue>


Statute documentation identifier- Role
++++++++++++++++++++++++++++++++++++++

**Rule** "A value indicating the purpose or expected use of the documentation
being identified."

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteDocumentationIdentifier>
         <premis:statuteDocumentationIdentifierRole>Law</premis:statuteDocumentationIdentifierRole>


Statute note
++++++++++++

**Rule** "Additional information about the statute."

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteInformation>
         <premis:statuteNote>Social insurance numbers, health information covered by personal privacy provisions</premis:statuteNote>


.. _basis-license:


Basis: License
^^^^^^^^^^^^^^

Below is a list of the template fields and the associated rule. The example also
includes the resulting block of METS XML.

PREMIS in METS XML: ``<premis:rightsBasis>License</premis:rightsBasis>``

License terms
+++++++++++++

**Rule** "Text describing the license or agreement by which permission was
granted."

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseTerms>This file is licensed under the Creative Commons Attribution-Share Alike 3.0 Unported license</premis:licenseTerms>


License start date
++++++++++++++++++

**Rule** "The date at which the license is first applies or is applied to the
content."

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseApplicableDates>
            <premis:startDate>2015-01-01</premis:startDate>

**Note** Uses ISO 8061.


License end date
++++++++++++++++

**Rule** "The date at which the license no longer applies or is applied to the
content."

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseApplicableDates>
            <premis:endDate>OPEN</premis:endDate>

**Note** Uses ISO 8061. End date can be left open by clicking "Open End Date" as
 shown above.

License documentation identifier- Type
++++++++++++++++++++++++++++++++++++++

**Rule** "A designation of the domain within which the license documentation
identifier is unique."

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseDocumentationIdentifier>
            <premis:licenseDocumentationIdentifierType>Accession form number</premis:licenceDocumentationIdentifierType>


License documentation identifier- Value
+++++++++++++++++++++++++++++++++++++++

**Rule** "The value of the licenseDocumentationIdentifier."

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseDocumentationIdentifier>
            <premis:licenseDocumentationIdentifierValue>CCA-2011-29</premis:licenseDocumentationIdentifierValue>


License documentation identifier- Role
++++++++++++++++++++++++++++++++++++++

**Rule** "A value indicating the purpose or expected use of the documentation
being identified."

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseDocumentationIdentifier>
            <premis:licenseDocumentationRole>Accession form license area</premis:licenseDocumentationRole>


License note
++++++++++++

**Rule** "Additional information about the license."

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseNote>Donors are prompted to choose a Creative Commons license on accession form</premis:licenseNote>

.. _basis-donor:

Basis: Donor
^^^^^^^^^^^^

Below is a list of the template fields and the associated rule. The example also
includes the resulting block of METS XML.

.. note::

   Archivematica provides a template for donor rights, which are translated in
   PREMIS as "other".  In the METS file, you will find Donor rights in a rightsMD
   ``<premis:rightsBasis>Other</premisrightsBasis>``.

Donor agreement start date
++++++++++++++++++++++++++

**Rule** "Date when the other right applies or is applied to the content."

.. code-block:: none

   <premis:rightsStatment>
      <premis:otherRightsInformation>
        <premis:otherRightsApplicableDates>
           <premis:startDate>2015-01-01</premis:startDate>

**Note** Uses ISO 8061.

Donor agreement end date
++++++++++++++++++++++++

**Rule** "Date when the other right no longer applies or is applied to the
content."

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
        <premis:otherRightsApplicableDates>
           <premis:endDate>2025-01-01</premis:endDate>

**Note** Uses ISO 8061. End date can be left open by clicking "Open End Date."

Donor documentation identifier- Type
++++++++++++++++++++++++++++++++++++

**Rule** "A designation of the domain within which the rights statement
documentation identifier is unique."

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierType>Donor form number</premis:otherRightsDocumentationIdentifierType>

Donor documentation identifier- Value
+++++++++++++++++++++++++++++++++++++

**Rule** "The value of the otherRightsDocumentationIdentifier."

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierValue>CCA-2011-89</premis:otherRightsDocumentationIdentifierValue>


Donor documentation identifier- Role
++++++++++++++++++++++++++++++++++++

**Rule** "The value indicating the purpose or expected use of the documentation
being identified."

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierRole>Agreement</premis:otherRightsDocumentationIdentifierRole>

Donor agreement note
+++++++++++++++++++++

**Rule** "Additional information about the rights of the object".

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsNote>Ten-year restriction on access by donor request</premis:otherRightsNote>



.. _basis-policy:

Basis: Policy
^^^^^^^^^^^^^

Below is a list of the template fields and the associated rule. The example also
includes the resulting block of METS XML.

.. note::

   Archivematica provides a template for policy rights, which are translated in
   PREMIS as "other".  In the METS file, you will find Policy rights in a
   rightsMD ``<premis:rightsBasis>Other</premisrightsBasis>``.

Policy start date
+++++++++++++++++

**Rule** "Date when the other right applies or is applied to the content."

.. code-block:: none

   <premis:rightsStatment>
      <premis:otherRightsInformation>
        <premis:otherRightsApplicableDates>
           <premis:startDate>2015-01-01</premis:startDate>

**Note** Uses ISO 8061.

Policy end date
++++++++++++++++

**Rule** "Date when the other right no longer applies or is applied to the
content."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
        <premis:otherRightsApplicableDates>
           <premis:endDate>2025-01-01</premis:endDate>

**Note** Uses ISO 8061. End date can be left open by clicking "Open End Date."

Policy documentation identifier- Type
+++++++++++++++++++++++++++++++++++++

**Rule** "A designation of the domain within which the rights statement
documentation identifier is unique."

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierType>RFA policy number</premis:otherRightsDocumentationIdentifierType>

Policy documentation identifier- Value
++++++++++++++++++++++++++++++++++++++

**Rule** The value of the otherRightsDocumentationIdentifier

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierValue>RFA-P-1992/040</premis:otherRightsDocumentationIdentifierValue>

Policy documentation identifier- Role
+++++++++++++++++++++++++++++++++++++

**Rule** "The value indicating the purpose or expected use of the documentation
being identified."

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierRole>Policy</premis:otherRightsDocumentationIdentifierRole>

Policy note
++++++++++++

**Rule** "Additional information about the rights of the object".

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsNote>Thirty-year closure rule: Executive Office records available only to Richards Foundation staff and BoD</premis:otherRightsNote>


.. _basis-other:

Basis: Other
^^^^^^^^^^^^

Below is a list of the template fields and the associated rule. The example also
includes the resulting block of METS XML.

PREMIS in METS XML: ``<premis:rightsBasis>Other</premisrightsBasis>``

Other rights basis
++++++++++++++++++

**Rule** "Designation of the basis for the other right or permission described
in the rightsStatementIdentifier."

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsBasis>Agreements</premis:otherRightsBasis>


Other start date
++++++++++++++++

.. code-block:: none

   <premis:rightsStatment>
      <premis:otherRightsInformation>
        <premis:otherRightsApplicableDates>
           <premis:startDate>2015-01-01</premis:startDate>

**Note** Uses ISO 8061.

Other end date
++++++++++++++

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
        <premis:otherRightsApplicableDates>
           <premis:endDate>2025-01-01</premis:endDate>

**Note** Uses ISO 8061. End date can be left open by clicking "Open End Date."

Other documentation identifier- Type
+++++++++++++++++++++++++++++++++++++

**Rule** "A designation of the domain within which the rights statement
documentation identifier is unique."

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierType>MOU number</premis:otherRightsDocumentationIdentifierType>

Other documentation identifier- Value
+++++++++++++++++++++++++++++++++++++

**Rule** "The value of the otherRightsDocumentationIdentifier."

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierValue>MOU-F-89</premis:otherRightsDocumentationIdentifierValue>

Other documentation identifier- Role
++++++++++++++++++++++++++++++++++++

**Rule** "The value indicating the purpose or expected use of the documentation
being identified."

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierRole>Agreement number</premis:otherRightsDocumentationIdentifierRole>

Note
+++++

**Rule** "Additional information about the rights of the object".

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsNote>Terms of MOU with depositor include 10-year embargo for access</premis:otherRightsNote>


.. _acts-granted:

Acts granted or restricted
^^^^^^^^^^^^^^^^^^^^^^^^^^

Below is a list of the template fields and the associated rule. The example also
includes the resulting block of METS XML.

Act
++++

**Rule** "The action the preservation repository is allowed to take; e.g.
replicate, migrate, modify, use, disseminate, delete."

.. code-block:: none

   <premis:rightsStatement>
      <premis:rightsGranted>
         <premis:act>Delete</premis:act>

Grant/restriction
++++++++++++++++++

**Rule** Drop-down field: choose between Allow, Disallow, Conditional

.. code-block:: none

   <premis:rightsStatement>
      <premis:rightsGranted>
         <premis:restriction>Disallow</premis:restriction>

Start
++++++

**Rule** "Beginning date of the rights or restrictions granted."

.. code-block:: none

   <premis:rightsStatement>
      <premis:rightsGranted>
         <premis:termOfRestriction>
            <premis:startDate>2015-01-01</premis:startDate>

**Note** Uses ISO 8061.

End
+++

**Rule** "Ending date of the rights or restrictions granted."

.. code-block:: none

   <premis:rightsStatement>
      <premis:rightsGranted:
         <premis:termofRestriction>
            <premis:endDate>2025-01-01</premis:endDate>

**Note** Uses ISO 8061. End date can be left open by clicking "Open End Date."

Grant/restriction note
++++++++++++++++++++++

**Rule** "Additional information about the rights granted."

.. code-block:: none

   <premis:rightsStatement>
      <premis:rightsGranted>
         <premis:rightsGrantedNote>Publication restricted until copyright expires.</premis:rightsGrantedNote>


:ref:`Back to the top <premis-template>`

.. _PREMIS: http://www.loc.gov/standards/premis/
.. _version 3: https://www.loc.gov/standards/premis/v3/index.html
.. _Data Dictionary: https://www.loc.gov/standards/premis/v3/premis-3-0-final.pdf
