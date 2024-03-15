.. _api-reference-archivematica:

=================
Archivematica API
=================

The Archivematica API provides:

* Coverage of some basic workflow functionality.
* Proxy support to the Storage Service.
* Exposure to unit status or processing configuration details.

Resources and endpoints
=======================

Endpoints for the Archivematica API have been organized into the following
resource categories:

* :ref:`transfer-resource`
* :ref:`ingest-resource`
* :ref:`admin-resource`
* :ref:`unit-resource`
* :ref:`other-resource`
* :ref:`beta`

.. _transfer-resource:

Transfer
---------

Transfer refers to the process of moving any set of digital objects
into Archivematica and turning the materials into a Submission Information
Package (SIP). The Transfer tab prepares your content for preservation in
Archivematica.

Start transfer
^^^^^^^^^^^^^^

========  ==================================  =================================
``POST``  **/api/transfer/start_transfer/**   *Initiates a transfer in Archive
                                              matica.*
========  ==================================  =================================

Request body parameters:

.. tip:: The parameters in the following table can be submitted as a JSON
   object with key-value pairs in the request body.

=============  ================================================================

``name``           Name of transfer

``type``           Type of the new transfer. Valid values are: standard,
                   zipfile, unzipped bag, zipped bag, dspace, maildir, TRIM,
                   dataverse. Default: standard.

``accession``      Accession number of new transfer.

``paths[]``        List of base64-encoded
                   ``<location_uuid>:<relative_path>`` to be copied into the new
                   transfer. Location UUIDs should be associated with this
                   pipeline, and relative path should be relative to the
                   location.

``row_ids[]``      ID of the associated TransferMetadataSet for disk image
                   ingest. Can be provided as ``[""]``.

=============  ================================================================

Example request:

.. literalinclude:: _code/start_transfer.curl

Example response:

.. literalinclude:: _code/start_transfer_response.curl

List unapproved transfer(s)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

========  ==============================  ======================================

``GET``   **/api/transfer/unapproved/**    *Returns a list of transfers awaiting
                                           approval*

========  ==============================  ======================================

Response definitions:

==================   ================================   ========================

``message``          "Fetched unapproved transfers
                     successfully."

``results``          List of dicts with the following
                     keys:

                     ``type``                           Transfer type.

                                                        One of: standard,
                                                        zipfile, unzipped bag,
                                                        zipped bag, dspace,
                                                        maildir, TRIM,
                                                        dataverse

                     ``directory``                      Directory the transfer
                                                        is in currently.

                     ``uuid``                           UUID of the transfer.

==================   ================================   ========================

Example request:

.. literalinclude:: _code/list_transfer.curl

Example response:

.. literalinclude:: _code/list_transfer_response.curl

Approve transfer(s)
^^^^^^^^^^^^^^^^^^^

========  ==========================  =========================================
``POST``  **/api/transfer/approve/**  *Approves a transfer awaiting initiation.*
========  ==========================  =========================================

Request body parameters:

=============  ================================================================

``type``           Type of the transfer. Valid values are: standard,
                   zipfile, unzipped bag, zipped bag, dspace, maildir, TRIM,
                   dataverse. Default: standard.

``directory``      Directory the transfer is in currently.

=============  ================================================================

Example request:

.. literalinclude:: _code/approve_transfer.curl

Response definitions:

==================   ==========================================================

``message``          "Approval successful."

``uuid``             UUID of the approved transfer

==================   ==========================================================

Example response:

.. literalinclude:: _code/approve_transfer_response.curl

Status
^^^^^^

========  =================================   =================================
``GET``   **/api/transfer/status/<transfer    *Returns the status of a
          UUID>/**                            transfer.*
========  =================================   =================================

Response definitions:

.. list-table::

    * - ``status``
      - One of FAILED, REJECTED, USER_INPUT, COMPLETE or PROCESSING
      - string
    * - ``name``
      - Name of the transfer, e.g. "imgs"
      - string
    * - ``sip_uuid``
      - If status is COMPLETE, this field will exist with either the UUID
        of the SIP or 'BACKLOG'
      - string
    * - ``microservice``
      - Name of the current microservice
      - string
    * - ``directory``
      - Name of the direcotry, e.g.
        "imgs-52dd0c01-e803-423a-be5f-b592b5d5d61c"
      - string
    * - ``path``
      - Full path to the transfer, e.g.
        "/var/archivematica/sharedDirectory/watchedDirectories/SIPCreation/
        completedTransfers/imgs-52dd0c01-e803-423a-be5f-b592b5d5d61c"
      - string
    * - ``message``
      - "Fetched status from <transfer UUID> successfully."
      - string
    * - ``type``
      - "transfer"
      - string
    * - ``uuid``
      - UUID of the transfer, e.g. "52dd0c01-e803-423a-be5f-b592b5d5d61c"
      - string

..  note::

    For consumers of this endpoint, it is possible for Archivematica to return a
    status of COMPLETE without a sip_uuid. Consumers looking to use the UUID
    of the AIP that will be created following Ingest should therefore test
    for both a status of COMPLETE and the existence of sip_uuid that does not
    also equal BACKLOG to ensure that they retrieve it. This might mean an
    additional call to the status endpoint while this data becomes available.

Example request:

.. literalinclude:: _code/status_request.curl

Example response:

.. literalinclude:: _code/status_response.curl

Hide
^^^^

===========  =================================   ==============================
``DELETE``   **/api/transfer/<transfer UUID>/    *Hides a transfer*
             delete/**
===========  =================================   ==============================

Request body parameters:

=================   ================================================================

``transfer_uuid``   UUID of the transfer.

=================   ================================================================

Response definitions:

==================   ==========================================================

``removed``          Boolean true or false.

==================   ==========================================================

Example request:

.. literalinclude:: _code/hide_request_transfer.curl

Example response:

.. literalinclude:: _code/hide_response.curl


Completed
^^^^^^^^^

===========  =================================   ==============================
``GET``      **/api/transfer/completed/**        *Returns list of Transfers that
                                                 are completed.*
===========  =================================   ==============================

Response definitions:

==================   ==========================================================

``message``          "Fetched completed transfers successfully."

``results``          List of UUIDs of completed Transfers.

==================   ==========================================================

Example request:

.. literalinclude:: _code/completed_request.curl

Example response:

.. literalinclude:: _code/completed_response.curl

Start reingest
^^^^^^^^^^^^^^

..  note::

    The Start reingest endpoint complements the :ref:`ss-reingest-aip`
    endpoint on the Storage Service's end. When a reingest has been initiated,
    Archivematica fetches the AIP from storage, extracts and runs fixity on it
    to verify its integrity. Then Archivematica will set up the environment
    as per the reingest type before the Storage Service endpoint calls the
    Archivematica Start reingest endpoint.


===========  =================================   ==============================
``POST``      **/api/transfer/reingest**         *Starts a full reingest.*
===========  =================================   ==============================

Request body parameters:

=============  ================================================================

``name``       Name of the AIP. The AIP should also be found
               at ``%sharedDirectory%/tmp/<name>``.

``uuid``       UUID of the AIP to reingest.

=============  ================================================================

Response definitions:

==================   ==========================================================

``message``          "Approval successful."

``reingest_uuid``    UUID of the reingested transfer.

==================   ==========================================================

.. _ingest-resource:

Ingest
------

Ingest refers to the process by which digital objects are packaged into SIPs and
run through microservices that enable normalization, packaging into an
AIP, and generation of a DIP.

Status
^^^^^^

===========  =================================   ==============================
``GET``      **/ingest/status/<unit_UUID>/**     *Returns status of the SIP.*
===========  =================================   ==============================

Response definitions:

.. list-table::

    * - ``status``
      - One of FAILED, REJECTED, USER_INPUT, COMPLETE or PROCESSING.
    * - ``name``
      - Name of the SIP, e.g. "imgs".
    * - ``microservices``
      - Name of the current microservice
    * - ``directory``
      - Name of the directory,
        e.g. "imgs-52dd0c01-e803-423a-be5f-b592b5d5d61c"
    * - ``path``
      - Full path to the transfer, e.g.
        "/var/archivematica/sharedDirectory/
        currentlyProcessing/imgs-52dd0c01-e803-423a-be5f/b592b5d5d61c/".
    * - ``message``
      - "Fetched status for <SIP UUID> successfully."
    * - ``type``
      - "SIP"
    * - ``uuid``
      - UUID of the SIP, e.g. "52dd0c01-e803-423a-be5f-b592b5d61c".

Example request:

.. literalinclude:: _code/status_request.curl

Example response (JSON):

.. literalinclude:: _code/status_response.curl

Hide
^^^^

===========  =================================== ==============================
``DELETE``   **/api/ingest/<SIP UUID>/delete/**  *Hides a SIP.*
===========  =================================== ==============================

Request body parameters:

=============  ================================================================

``sip_uuid``   UUID OF THE SIP.

=============  ================================================================

Response definitions:

==================   ==========================================================

``removed``          Boolean true or false.

==================   ==========================================================

Example request:

.. literalinclude:: _code/hide_request_ingest.curl

Example response:

.. literalinclude:: _code/hide_response.curl


List SIPS Waiting for User Input
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

=========  ========================  ===========================================
``GET``    **/api/ingest/waiting**   *Returns a list of SIPs waiting for user
                                     input.*
=========  ========================  ===========================================

Response definitions:

==================   ==========================================================

``message``          "Fetched units successfully."

``results:``         List of dicts with keys:

                     ``sip_directory``: Directory the SIP is in currently.

                     ``sip_uuid``: UUID OF THE SIP.

                     ``sip_name``: Name of the SIP.

                     ``microservice``: Name of the current microservice.

==================   ==========================================================

.. note::

   Despite the URL, this currently returns both SIPs & transfers that
   are waiting for user input. In the future, a separate **/api/transfer/
   waiting** should be added for transfers.

Example request:

.. literalinclude:: _code/sips-waiting_request.curl

Example response (JSON):

.. literalinclude:: _code/sips-waiting_response.curl

Completed
^^^^^^^^^

===========  ========================== ========================================
``GET``      **/api/ingest/completed/**  *Returns a list of completed SIPs.*
===========  ========================== ========================================

Example request:

.. literalinclude:: _code/completed_ingest_request.curl

Example response (JSON):

.. literalinclude:: _code/completed_ingest_response.curl

Reingest
^^^^^^^^

=========== ========================= ==========================================
``POST``    **/api/ingest/reingest**  *Starts a partial or metadata-only reingest.*
=========== ========================= ==========================================

Request body parameters:

=============  ================================================================

``name``       Name of the AIP. The AIP should also be found
               at ``%sharedDirectory%/tmp/<name>``.

``uuid``       UUID of the AIP to reingest.

=============  ================================================================

Response definitions:

==================   ==========================================================

``message``          "Approval successful."

``reingest_uuid``    UUID of the reingested transfer.

==================   ==========================================================

Example request:

.. literalinclude:: _code/am-ss_reingest_aip.curl

Example response (JSON):

.. literalinclude:: _code/reingest_aip_response.curl

Copy metadata
^^^^^^^^^^^^^

=========== ==================================== ==============================
``POST``    **/api/ingest/copy_metadata_files/** *Adds metadata files to a SIP.*
=========== ==================================== ==============================

.. TBD
   Example request:
   literalinclude:: _code/filename

Request body parameters:

==================  ============================================================

``sip_uuid``        UUID of the SIP to put files in.

``source_paths[]``  List of files to be copied, base64 encoded, in the format
                    'source_location_uuid:full_path'

==================  ============================================================


.. TBD
   Example response (JSON):
   literalinclude:: _code/filename


Response definitions:

==================   ==========================================================

``error``            Boolean true or false.

``message``          Success message or reason for the error.

==================   ==========================================================


Usage example::

  curl -X POST \
      http://my_archivematica_instance.archivematica.org/api/ingest/copy_metadata_files/ \
      -H 'Authorization: ApiKey [_your_username_]:[_your_ApiKey_]' \
      -H 'Content-Type: application/x-www-form-urlencoded' \
      -d 'sip_uuid=a7f1f36c-55c1-4fb7-a898-76d102e847dc&source_paths%5B%5D= \
      'NmRjYTgxNDAtMDg2NC00MzE5LTg2ZDctNTg0ZjZiZTY4N2EzOi9ob21lL2FyY2hpdmVtYXRpY2EvYXJjaGl2ZW1hdGljYS1zYW1wbGVkYXRhL2lzc3VlX3RlbXBsYXRlLm1k''


Response examples

201 Created::

    {
      "error": false,
      "message": "Metadata files added successfully."
    }

400 Bad Request::

    {
      "error": true,
      "message": "sip_uuid and source_paths[] both required."
    }

500 Internal Server Error::

    {
      "error": true,
      "message": "Location 6dca8140-0864-4319-86d7-584f6be687a3 is not associated with this pipeline"
    }

.. _admin-resource:

Administration
--------------

Administration enables you to configure various parts of the application and
manage integrations and users.


Levels of description
^^^^^^^^^^^^^^^^^^^^^

======= ===========================================  ===========================

``GET`` **/api/administration/dips/atom /levels/**   *Returns a JSON-encoded set
                                                     of the configured levels
                                                     of description.*

======= ===========================================  ===========================


Example request:

.. literalinclude:: _code/admin_levels_of_desc_req.curl

Example response (JSON):

The following response includes a list of AtoM Levels of description with key
'UUID' and value 'name of level of description'.

.. literalinclude:: _code/admin_levels_of_desc_response.curl


Fetch levels of description
^^^^^^^^^^^^^^^^^^^^^^^^^^^

======= =============================================== ========================

``GET`` **/api/administration/dips/atom/fetch_levels/**  *Fetches all levels of
                                                         description from an
                                                         AtoM database,
                                                         replacing any previously
                                                         existing.*

======= =============================================== ========================

Example request:

.. literalinclude:: _code/fetch_levels.curl

Example response (JSON):

The following response includes an updated list of AtoM Levels of description
with key 'UUID' and value 'name of level of description'.

.. literalinclude:: _code/fetch_levels_response.curl

.. _unit-resource:


Unit
----

Unit refers to "a type of Package Description that is specialized to provide
information about an Archival Information Unit for use by Access Aids." (OAIS,
p.1-13, Section 1.7.2)

List jobs
^^^^^^^^^

=============  =================================== =============================
``GET``         **/api/v2beta/jobs/<unit UUID>/**  *Returns a list of jobs for the
                                                   passed unit (transfer or
                                                   ingest).*
=============  =================================== =============================

Query string parameters (optional):

================     ===========================================================

``microservice``     Name of the microservice the jobs belong to.

``link_uuid``        UUID of the job chain link.

``name``             Name of the job.

================     ===========================================================

Response definitions (from list of dicts):

==================   ==========================================================

``uuid``             UUID of the job.

``name``             Name of the job.

``status``           One of USER_INPUT, PROCESSING, COMPLETE, FAILED or UNKNOWN.

``microservice``     Microservice to which the job belongs.

``link_uuid``        UUID of the job chain link.

``tasks``            List of dicts with information about the microservice's
                     tasks.

``uuid``             UUID of the task.

``exit_code``        Exit code of the task.

==================   ==========================================================

Example request:

.. literalinclude:: _code/list_transfer_unit_request.curl

Example response (JSON body):

.. literalinclude:: _code/list_transfer_unit_response.curl

Task
^^^^

=========  =================================== =================================
``GET``    **/api/v2beta/task/<task UUID>/**   *Returns information about a task.*
=========  =================================== =================================

Response definitions:

================   =============================================================

``uuid``           UUID of the task.

``exit_code``      List of dicts with keys:

``file_uuid``      Exit code of the task.

``file_name``      UUID of the file used for the task.

``time_created``   File used for the task.

``time_started``   String (YYYY-MM-DD HH:MM:SS) representing when the task
                   was created.

``duration``       Task duration in seconds (integer). If the duration is less
                   than a second, this will be a < 1 string.

================   =============================================================

Example request:

.. literalinclude:: _code/task_request.curl

Example response (JSON):

.. literalinclude:: _code/task_response.curl

.. _other-resource:

Other
-----

Other is a generic resource category that includes path metadata associated
with level of description, and it also includes name associated with any
customized processing configuration.

Path metadata
^^^^^^^^^^^^^

============= ============================= =================================
``GET, POST`` **/api/filesystem/metadata/** *Fetches (GET) or update (POST)
                                            metadata for a path (currently
                                            only level of description).*
============= ============================= =================================


Query string parameters or request body parameters:

.. tip:: The following parameter can be submitted as query string parameter
         with GET or as a JSON object with a key-value pair in the request body
         with POST.

================     ===========================================================

``path``             Arranged path on which to get metadata.

================     ===========================================================

Response: the processing config file as a stream

Content type: text/xml

Example request:

.. literalinclude:: _code/task_request.curl

Example response (JSON):

.. literalinclude:: _code/task_response.curl


Processing configuration
^^^^^^^^^^^^^^^^^^^^^^^^

=======  ======================================== ==============================

``GET``  **/api/processing-configuration/<name>** *Returns processing
                                                  onfiguration with <name>*

=======  ======================================== ==============================

Example request::

    curl \
        --location \
        --request GET \
        --header 'Authorization: ApiKey analyst:zzhah5chashie8OwEih6udie4choo4la' \
            'http://test.machine.archivematica.net/api/processing-configuration/backlog'


Example response::

    <processingMCP>
        <preconfiguredChoices>
            <!-- Create SIP(s) -->
            <preconfiguredChoice>
                <appliesTo>bb194013-597c-4e4a-8493-b36d190f8717</appliesTo>
                <goToChain>7065d256-2f47-4b7d-baec-2c4699626121</goToChain>
            </preconfiguredChoice>
            <!-- Assign UUIDs to directories -->
            <preconfiguredChoice>
                <appliesTo>bd899573-694e-4d33-8c9b-df0af802437d</appliesTo>
                <goToChain>2dc3f487-e4b0-4e07-a4b3-6216ed24ca14</goToChain>
            </preconfiguredChoice>
            <!-- Send transfer to quarantine -->
            <preconfiguredChoice>
                <appliesTo>755b4177-c587-41a7-8c52-015277568302</appliesTo>
                <goToChain>d4404ab1-dc7f-4e9e-b1f8-aa861e766b8e</goToChain>
            </preconfiguredChoice>
        </preconfiguredChoices>
    </processingMCP>

Content type: text/xml

.. _beta:

Beta
-----

API endpoints that are still in-flux and could potentially change.

Package
^^^^^^^

============= ============================= =================================
``POST``      **/api/v2beta/package**       *Starts a new transfer type.*
============= ============================= =================================

Request body parameters (mandatory):

================     ===========================================================

``name``             Transfer name.

``path``             Path relative, or absolute to a storage service transfer
                     source.

================     ===========================================================

Request body parameters (optional):

=====================  =========================================================

``type``               Transfer type. Valid values are: standard, zipfile,
                       unzipped bag, zipped bag, dspace, maildir, TRIM,
                       dataverse. Default: standard.

``processing_config``  Processing configuration, e.g. default, automated,
                       default: default

``accession``          Accession ID.

``access_system_id``   Access system ID (see `Docs <https://bit.ly/3c4yWt6>`_).

``metadata_set_id``    Used to link to metadata sets added via the user
                       interface. It's safe to ignore this for now since
                       metadata can't be associated to transfer via the API
                       at the moment.

``auto_approve``       Boolean true or false to set the transfer to auto-approve,
                       default: true.

=====================  =========================================================

Response definitions:

==================   ==========================================================

``id``                Transfer UUID (Note: as the package endpoint allows the
                      caller to interact with Archivematica asynchronously it
                      does not guarantee a transfer has started. The caller must
                      use the UUID in the response to verify it has begun or any
                      errors that were encountered initiating one.)

==================   ==========================================================

Examples:

Only a subset of these options might be needed for most use-cases. A fundamental
difference between the package endpoint and others from which a transfer can be
initiated is that a storage service transfer location UUID isnt always required.
In some cases that might still be ideal.

*Starting a transfer using an absolute path*::

    curl \
        --request POST \
        --header "Authorization: ApiKey test:test" \
        --header "Content-Type: application/json" \
        --data "{\
           \"path\": \"$(echo -n '/home/archivematica/archivematica-sampledata
           /SampleTransfers/DemoTransfer' | base64 -w 0)\", \
           \"name\": \"demo_transfer_absolute\", \
           \"processing_config\": \"automated\", \
           \"type\": \"standard\" \
          }" \
            "http://<archivematica-uri>/api/v2beta/package"

*Starting a transfer using an relative path with a transfer source UUID*::

    curl \
        --request POST \
        --header "Authorization: ApiKey test:test" \
        --header "Content-Type: application/json" \
        --data "{\
           \"path\": \"$(echo -n 'd1184f7f-d755-4c8d-831a-a3793b88f760:
           /archivematica/archivematica-sampledata/SampleTransfers/DemoTransfer'
           | base64 -w 0)\", \
           \"name\": \"demo_transfer_relative\", \
           \"processing_config\": \"automated\", \
           \"type\": \"standard\" \
          }" \
            "http://<archivematica-uri>/api/v2beta/package"

Validate
^^^^^^^^

==================================== ========================================================
**/api/v2beta/validate/<validator>** *Available in Archivematica 1.10+. This endpoint can be
                                     used to validate CSVs against embedded sets of rules.
                                     Currently works with Avalon Media System Manifest
                                     (``avalon``) and rights.csv (``rights``) files.*

                                     *In the future, this endpoint can be extended to support
                                     validation for metadata.csv or archivesspaceids.csv, or
                                     other institutionally-based rules.*
==================================== ========================================================

Response definitions:

==================   ==========================================================

``valid``            Boolean true or false.

``reason``           Includes validation error.

==================   ==========================================================

Usage example (assuming that avalon.csv exists)::

  curl \
    --data-binary "@avalon.csv" \
    --header "Authorization: ApiKey test:test" \
    --header "Content-Type: text/csv; charset=utf-8" \
      http://127.0.0.1:62080/api/v2beta/validate/avalon

Response examples

200 OK::

    {
      "valid": true
    }

400 Bad Request (expect reason to include different validation errors)::

    {
      "valid": false,
      "reason": "Administrative data must include reference name and author."
    }

404 Not Found::

    {
      "error": true,
      "message": "Unknown validator. Accepted values: avalon"
    }
