.. _change-filenames:

================
Filename changes
================

The change filenames microservice runs twice during processing - once on the
Transfer tab and once on the Ingest tab. The purpose of this microservice is to
ensure that Archivematica's tools and processes do not fail because of
characters that appear in object and directory names.

Archivematica groups a wide variety of tools, such as :ref:`preservation
planning tools <preservation-planning-tools>`, together to create preservation
workflows. Some of the tools that Archivematica uses have a narrowly-defined
scope in terms of what the tool considers to be a valid character for a file or
directory name. Encountering a character that the tool considers to be invalid
can cause the tool to fail, which can halt processing and prevent the normal
operation of Archivematica.

To prevent these kinds of failures from happening, Archivematica implements
a script that changes file and directory names to conform to the requirements of
more restrictive tools. Valid characters are defined as the following:

``-_.()abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789``

The script tries to replace any character that is not included in the above list
with its nearest equivalent - for example, the character ``Č`` is replaced by
``C``. Where the script cannot find a close equivalent, the character is
replaced by an underscore. The change is documented in the METS file.

.. csv-table::
   :file: _csv/file-name-edits.csv
   :header-rows: 1

Additional information can be found in the complete PREMIS event:

.. code:: xml

   <mets:mdWrap MDTYPE="PREMIS:EVENT">
     <mets:xmlData>
       <premis:event xmlns:premis="info:lc/xmlns/premis-v2" xsi:schemaLocation="info:lc/xmlns/premis-v2 http://www.loc.gov/standards/premis/v2/premis-v2-2.xsd" version="2.2">
         <premis:eventIdentifier>
           <premis:eventIdentifierType>UUID</premis:eventIdentifierType>
           <premis:eventIdentifierValue>ef7ef8b8-c363-4dfe-9b67-4100d1bfa7f2</premis:eventIdentifierValue>
         </premis:eventIdentifier>
         <premis:eventType>filename change</premis:eventType>
         <premis:eventDateTime>2019-01-17T22:07:17+00:00</premis:eventDateTime>
         <premis:eventDetail>prohibited characters removed:program="sanitize_names"; version="1.10.d0ccb7d7661cf35c769dcc0846d8f087998af713"</premis:eventDetail>
         <premis:eventOutcomeInformation>
           <premis:eventOutcome></premis:eventOutcome>
           <premis:eventOutcomeDetail>
             <premis:eventOutcomeDetailNote>Original name="%transferDirectory%objects/Росси́я.png"; new name="%transferDirectory%objects/Rossiia.png"</premis:eventOutcomeDetailNote>
           </premis:eventOutcomeDetail>
         </premis:eventOutcomeInformation>
         <premis:linkingAgentIdentifier>
           <premis:linkingAgentIdentifierType>preservation system</premis:linkingAgentIdentifierType>
           <premis:linkingAgentIdentifierValue>Archivematica-1.7</premis:linkingAgentIdentifierValue>
         </premis:linkingAgentIdentifier>
         <premis:linkingAgentIdentifier>
           <premis:linkingAgentIdentifierType>repository code</premis:linkingAgentIdentifierType>
           <premis:linkingAgentIdentifierValue></premis:linkingAgentIdentifierValue>
         </premis:linkingAgentIdentifier>
       </premis:event>
     </mets:xmlData>
   </mets:mdWrap>

This strategy for addressing character limitations within the tools bundled by
Archivematica can result in significant changes to file and directory names. In
order to provide easy access to a record of the changes, the Archivematica AIP
contains log files that show the original name alongside the changed name. There
are two log files:

* The log file for name changes that happen during Transfer is located in the
  AIP at ``data/logs/transfers/my-transfer-name/logs/filenameChanges.log``
* The log file for name changes that happen during Ingest is located in the AIP
  at ``data/logs/filenameChanges.log``

These logs contain a plaintext rendering of the information embedded within the
PREMIS event.

.. code::

   Sanitized name: %transferDirectory%objects/Росси́я.png  ->  %transferDirectory%objects/Rossiia.png
   Sanitized name: %transferDirectory%objects/Éireann.png  ->  %transferDirectory%objects/Eireann.png
   Sanitized name: %transferDirectory%objects/f & ile.png  ->  %transferDirectory%objects/f___ile.png
   Sanitized name: %transferDirectory%objects/Česká republika.ong  ->  %transferDirectory%objects/Ceska_republika.ong
   Sanitized name: %transferDirectory%objects/Ísland.png  ->  %transferDirectory%objects/Island.png
   Sanitized name: %transferDirectory%objects/España.png  ->  %transferDirectory%objects/Espana.png

:ref:`Back to the top <change-filenames>`
