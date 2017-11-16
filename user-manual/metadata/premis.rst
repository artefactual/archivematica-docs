.. _premis-template:

================================
PREMIS metadata in Archivematica
================================

Archivematica supports the entry of `PREMIS <http://www.loc.gov/standards/premis/>`_
rights metadata during :ref:`transfer <transfer>` or :ref:`ingest <ingest>`.
Rights entered via the GUI interface apply to the entirety of the SIP or transfer.
Rights can also be entered at the object level by describing them in a rights.csv
file and using the :ref:`Import metadata <import-metadata>` feature.

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
================

PREMIS in METS XML: ``<premis:rightsBasis>Copyright</premis:rightsBasis>``

Copyright status
----------------

**Template field** Copyright status

**Rule** "A coded designation of the copyright status of the object at the time
the rights status is recorded; e.g. copyrighted, publicdomain, unknown."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
       <premis:copyrightInformation>
          <premis:copyrightStatus>Under copyright</premis:copyrightStatus>


Copyright jurisdiction
----------------------

**Template field** Copyright jurisdiction

**Rule** "The country whose copyright laws apply"

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
          <premis:copyrightJurisdiction>ca</premis:copyrightJurisdiction>

**Notes** Values should be taken from a controlled vocabulary. Recommended:
ISO 3166.


Copyright determination date
----------------------------

**Template field** Copyright determination date

**Rule** "The date that the copyright status recorded in copyrightStatus was
determined."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
       <premis:copyrightInformation>
            <premis:copyrightStatusDeterminationDate>2011-09-16</premis:copyrightStatusDeterminationDate>

**Notes**  Uses ISO 8061.

Copyright start date
--------------------

**Template field** Copyright start date

**Rule** "Date when the particular copyright applies or is applied to the content."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
         <premis:copyrightApplicableDates>
            <premis:startDate>2015-01-01</premis:startDate>

**Notes** Uses ISO 8061.


Copyright end date
------------------

**Template field** Copyright end date

**Rule** "Date when the particular copyright no longer applies or is applied to the content."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
         <premis:copyrightApplicableDates>
            <premis:endDate>2065-01-01</premis:endDate>

**Notes** Uses ISO 8061.

End date can be left open by clicking "Open End Date." Resulting METS XML:

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
         <premis:copyrightApplicableDates>
            <premis:endDate>OPEN</premis:endDate>


Copyright documentation identifier- Type
----------------------------------------

**Template field** Copyright documentation identifier- Type

**Rule** "A designation of the domain within which the copyright documentation
identifier is unique."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
         <premis:copyrightDocumentationIdentifier>
            <premis:copyrightDocumentationIdentifierType> Donor form </premis:copyrightDocumentationIdentifierType>


Copyright documentation identifier- Value
-----------------------------------------

**Template field** Copyright documentation identifier- Value

**Rule** "The value of the copyrightDocumentationIdentifier."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
         <premis:copyrightDocumentationIdentifier>
            <premis:copyrightDocumentationIdentifierValue>CCA-2009-67</premis:copyrightDocumentationIdentifierValue>


Copyright documentation identifier- Role
----------------------------------------

**Template field** Copyright documentation identifier- Role

**Rule** "A value indicating the purpose or expected use of the documentation
being identified."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
         <premis:copyrightDocumentationIdentifier>
            <premis:copyrightDocumentationIdentifierRole>Copyright holder statement</premis:copyrightDocumentationIdentifierRole>


Copyright note
--------------

**Template field** Copyright note

**Rule** "Additional information about the copyright status of the object".

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:copyrightInformation>
         <premis:copyrightNote>Copyright held by donor</premis:copyrightNote>


.. _basis-statute:

Basis: Statute
==============

PREMIS in METS XML: ``<premis:rightsBasis>Statute</premis:rightsBasis>``

Statute jurisdiction
--------------------

**Template field** Statute jurisdiction

**Rule** "The country or other political body enacting the statute."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteInformation>
         <premis:statuteJurisdiction>ca</premis:statuteJurisdiction>

**Notes** Values should be taken from a controlled vocabulary. Recommended: ISO
ISO 3166.


Statute citation
----------------

**Template field** Statute citation

**Rule** "An identifying designation for the statute."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteInformation>
         <premis:statuteCitation>Freedom of Information and Protection of Privacy Act [RBSC 1996] Chapter 165</premis:statuteCitation>


Statute information determination date
--------------------------------------

**Template field** Statute determination date

**Rule** "The date that the determination was made the the statute authorized
the permission(s) noted."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteInformation>
         <premis:statuteInformationDeterminationDate>2015-07-02</premis:statuteInformationDeterminationDate>

**Note** Uses ISO 8061


Statute start date
------------------

**Template field** Statute start date

**Rule** "The date when the statute begins to apply or is applied to the content."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteApplicableDates>
         <premis:startDate>2015-01-01</premis:startDate>

**Note** Uses ISO 8061


Statute end date
----------------

**Template field** Statute end date

**Rule** "The date when the statute ceases to apply or is applied to the content."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteApplicableDates>
         <premis:endDate>2020-01-01</premis:endDate>

**Note** Uses ISO 8061

End date can be left open by clicking "Open End Date." Resulting METS XML:

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteApplicableDates>
         <premis:endDate>OPEN</premis:endDate>


Statute documentation identifier- Type
--------------------------------------

**Template field** Statute documentation identifier- Type

**Rule** "A designation of the domain within which the statute documentation
identifier is unique."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteDocumentationIdentifier>
         <premis:statuteDocumentationIdentifierType>Acts</premis:statuteDocumentationIdentifierType>



Statute documentation identifier- Value
---------------------------------------

**Template field** Statute documentation identifier- Value

**Rule** "The value of the statuteDocumentationIdentifier."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteDocumentationIdentifier>
         <premis:statuteDocumentationIdentifierValue>RBSC 1996</premis:statuteDocumentationIdentifierValue>


Statute documentation identifier- Role
--------------------------------------

**Template field** Statute documentation identifier- Role

**Rule** "A value indicating the purpose or expected use of the documentation
being identified."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteDocumentationIdentifier>
         <premis:statuteDocumentationIdentifierRole>Law</premis:statuteDocumentationIdentifierRole>



Statute note
------------

**Template field** Statute note

**Rule** "Additional information about the statute."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:statuteInformation>
         <premis:statuteNote>Social insurance numbers, health information covered by personal privacy provisions</premis:statuteNote>


.. _basis-license:


Basis: License
==============

PREMIS in METS XML: ``<premis:rightsBasis>License</premis:rightsBasis>``

License terms
-------------

**Template field** License terms

**Rule** "Text describing the license or agreement by which permission was granted."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseTerms>This file is licensed under the Creative Commons Attribution-Share Alike 3.0 Unported license</premis:licenseTerms>


License start date
------------------

**Template field** License start date

**Rule** "The date at which the license is first applies or is applied to the content."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseApplicableDates>
            <premis:startDate>2015-01-01</premis:startDate>

**Note** Uses ISO 8061.


License end date
----------------

**Template field** License end date

**Rule** "The date at which the license no longer applies or is applied to the content."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseApplicableDates>
            <premis:endDate>2020-01-01</premis:endDate>

**Note** Uses ISO 8061.

End date can be left open by clicking "Open End Date." Resulting METS XML:

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseApplicableDates>
            <premis:endDate>OPEN</premis:endDate>


License documentation identifier- Type
--------------------------------------

**Template field** License documentation identifier- Type

**Rule** "A designation of the domain within which the license documentation
identifier is unique."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseDocumentationIdentifier>
            <premis:licenseDocumentationIdentifierType>Accession form number</premis:licenceDocumentationIdentifierType>


License documentation identifier- Value
---------------------------------------

**Template field** License documentation identifier- Value

**Rule** "The value of the licenseDocumentationIdentifier."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseDocumentationIdentifier>
            <premis:licenseDocumentationIdentifierValue>CCA-2011-29</premis:licenseDocumentationIdentifierValue>


License documentation identifier- Role
--------------------------------------

**Template field** License documentation identifier- Role

**Rule** "A value indicating the purpose or expected use of the documentation
being identified."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseDocumentationIdentifier>
            <premis:licenseDocumentationRole>Accession form license area</premis:licenseDocumentationRole>


License note
------------

**Template field** License note

**Rule** "Additional information about the license."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:licenseInformation>
         <premis:licenseNote>Donors are prompted to choose a Creative Commons license on accession form</premis:licenseNote>

.. _basis-donor:

Basis: Donor
============

.. note::

   Archivematica provides a template for donor rights, which are translated in
   PREMIS as "other".  In the METS file, you will find Donor rights in a rightsMD
   ``<premis:rightsBasis>Other</premisrightsBasis>``.

Donor agreement start date
--------------------------

**Template field** Donor agreement start date

**Rule** "Date when the other right applies or is applied to the content."

**METS XML**

.. code-block:: none

   <premis:rightsStatment>
      <premis:otherRightsInformation>
        <premis:otherRightsApplicableDates>
           <premis:startDate>2015-01-01</premis:startDate>

**Note** Uses ISO 8061.

Donor agreement end date
------------------------

**Template field** Donor agreement end date

**Rule** "Date when the other right no longer applies or is applied to the content."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
        <premis:otherRightsApplicableDates>
           <premis:endDate>2025-01-01</premis:endDate>

**Note** Uses ISO 8061.

End date can be left open by clicking "Open End Date." Resulting METS XML:

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsApplicableDates>
            <premis:endDate>OPEN</premis:endDate>


Donor documentation identifier- Type
-------------------------------------

**Template field** Donor documentation identifier- Type

**Rule** "A designation of the domain within which the rights statement documentation
identifier is unique."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierType>Donor form number</premis:otherRightsDocumentationIdentifierType>

Donor documentation identifier- Value
-------------------------------------

**Template field** Donor documentation identifier- Value

**Rule** "The value of the otherRightsDocumentationIdentifier."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierValue>CCA-2011-89</premis:otherRightsDocumentationIdentifierValue>


Donor documentation identifier- Role
------------------------------------

**Template field** Donor documentation identifier- Role

**Rule** "The value indicating the purpose or expected use of the documentation
being identified."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierRole>Agreement</premis:otherRightsDocumentationIdentifierRole>

Donor agreement note
--------------------

**Template field** Donor agreement note

**Rule** "Additional information about the rights of the object".

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsNote>Ten-year restriction on access by donor request</premis:otherRightsNote>



.. _basis-policy:

Basis: Policy
=============

.. note::

   Archivematica provides a template for policy rights, which are translated in
   PREMIS as "other".  In the METS file, you will find Policy rights in a rightsMD
   ``<premis:rightsBasis>Other</premisrightsBasis>``.

Policy start date
-----------------

**Template field** Policy start date

**Rule** "Date when the other right applies or is applied to the content."

**METS XML**

.. code-block:: none

   <premis:rightsStatment>
      <premis:otherRightsInformation>
        <premis:otherRightsApplicableDates>
           <premis:startDate>2015-01-01</premis:startDate>

**Note** Uses ISO 8061.

Policy end date
---------------

**Template field** Policy end date

**Rule** "Date when the other right no longer applies or is applied to the content."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
        <premis:otherRightsApplicableDates>
           <premis:endDate>2025-01-01</premis:endDate>

**Note** Uses ISO 8061.

End date can be left open by clicking "Open End Date." Resulting METS XML:

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsApplicableDates>
            <premis:endDate>OPEN</premis:endDate>

Policy documentation identifier- Type
-------------------------------------

**Template field** Policy documentation identifier- Type

**Rule** "A designation of the domain within which the rights statement documentation
identifier is unique."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierType>RFA policy number</premis:otherRightsDocumentationIdentifierType>

Policy documentation identifier- Value
--------------------------------------

**Template field** Policy documentation identifier- Value

**Rule** The value of the otherRightsDocumentationIdentifier

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierValue>RFA-P-1992/040</premis:otherRightsDocumentationIdentifierValue>

Policy documentation identifier- Role
-------------------------------------

**Template field** Policy documentation identifier- Role

**Rule** "The value indicating the purpose or expected use of the documentation
being identified."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierRole>Policy</premis:otherRightsDocumentationIdentifierRole>

Policy note
-----------

**Template field** Policy note

**Rule** "Additional information about the rights of the object".

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsNote>Thirty-year closure rule: Executive Office records available only to Richards Foundation staff and BoD</premis:otherRightsNote>


.. _basis-other:

Basis: Other
============

PREMIS in METS XML: ``<premis:rightsBasis>Other</premisrightsBasis>``

Other rights basis
------------------

**Template field** Other rights basis

**Rule** "Designation of the basis for the other right or permission described
in the rightsStatementIdentifier."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsBasis>Agreements</premis:otherRightsBasis>


Other start date
----------------

**Template field** Other start date

**METS XML**

.. code-block:: none

   <premis:rightsStatment>
      <premis:otherRightsInformation>
        <premis:otherRightsApplicableDates>
           <premis:startDate>2015-01-01</premis:startDate>

**Note** Uses ISO 8061.

Other end date
--------------

**Template field** Other end date

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
        <premis:otherRightsApplicableDates>
           <premis:endDate>2025-01-01</premis:endDate>

**Note** Uses ISO 8061.

End date can be left open by clicking "Open End Date." Resulting METS XML:

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsApplicableDates>
            <premis:endDate>OPEN</premis:endDate>


Other documentation identifier- Type
------------------------------------

**Template field** Other documentation identifier- Type

**Rule** "A designation of the domain within which the rights statement documentation
identifier is unique."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierType>MOU number</premis:otherRightsDocumentationIdentifierType>

Other documentation identifier- Value
-------------------------------------

**Template field** Other documentation identifier- Value

**Rule** "The value of the otherRightsDocumentationIdentifier."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierValue>MOU-F-89</premis:otherRightsDocumentationIdentifierValue>

Other documentation identifier- Role
------------------------------------

**Template field** Other documentation identifier- Role

**Rule** "The value indicating the purpose or expected use of the documentation
being identified."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsDocumentationIdentifier>
            <premis:otherRightsDocumentationIdentifierRole>Agreement number</premis:otherRightsDocumentationIdentifierRole>

Note
----

**Template field** Note

**Rule** "Additional information about the rights of the object".

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:otherRightsInformation>
         <premis:otherRightsNote>Terms of MOU with depositor include 10-year embargo for access</premis:otherRightsNote>


.. _acts-granted:

Acts granted or restricted
==========================

Act
---

**Template field** Act

**Rule** "The action the preservation repository is allowed to take; e.g. replicate,
migrate, modify, use, disseminate, delete."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:rightsGranted>
         <premis:act>Delete</premis:act>

Grant/restriction
-----------------

**Template field** Grant/restriction

**Rule** Drop-down field: choose between Allow, Disallow, Conditional

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:rightsGranted>
         <premis:restriction>Disallow</premis:restriction>

Start
-----

**Template field** Start

**Rule** "Beginning date of the rights or restrictions granted."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:rightsGranted>
         <premis:termOfRestriction>
            <premis:startDate>2015-01-01</premis:startDate>

**Note** Uses ISO 8061.

End
---

**Template field** End

**Rule** "Ending date of the rights or restrictions granted."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:rightsGranted:
         <premis:termofRestriction>
            <premis:endDate>2025-01-01</premis:endDate>

**Note** Uses ISO 8061

End date can be left open by clicking "Open End Date." Resulting METS XML:

.. code-block:: none

   <premis:rightsStatement>
      <premis:rightsGranted:
         <premis:termofRestriction>
            <premis:endDate>OPEN</premis:endDate>

Grant/restriction note
----------------------

**Template field** Grant/restriction note

**Rule** "Additional information about the rights granted."

**METS XML**

.. code-block:: none

   <premis:rightsStatement>
      <premis:rightsGranted>
         <premis:rightsGrantedNote>Publication restricted until copyright expires.</premis:rightsGrantedNote>


:ref:`Back to the top <premis-template>`
