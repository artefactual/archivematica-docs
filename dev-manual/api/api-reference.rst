.. _am-api-reference.rst:

==========
Reference
==========

Quickly review all available resources for the Archivematica API and Storage 
Service API with this reference.

Archivematica API
==================

The Archivematica API provides:

    * Coverage of some basic workflow functionality.
    * Proxy support to the Storage Service.
    * Exposure to unit status or processing configuration details.
    
Archivematica API resources and endpoints
==========================================

Endpoints for the Archivematica API have been organized into the following 
resource categories:

    * :ref:`transfer-resource.rst`
    * :ref:`ingest-resource.rst`
    * :ref:`admin-resource.rst`
    * :ref:`unit-resource.rst`
    * :ref:`other-resource.rst`
    * :ref:`beta.rst`

.. _transfer-resource.rst:

Transfer
---------

Transfer refers to the process of moving any set of digital objects 
into Archivematica and turning the materials into a Submission Information 
Package (SIP). The Transfer tab prepares your content for preservation in 
Archivematica.

Start transfer
^^^^^^^^^^^^^^

========  ==================================  =================================
``POST``  **/api/transfer/start_transfer/**   *Initiates a transfer in Archive-
                                              matica.*
========  ==================================  =================================

Request body parameters:

.. tip:: The parameters in the following table can be submitted as a JSON
   object with key-value pairs in the request body.

=============  ================================================================

``name``           Name of transfer

``type``           Type of the new transfer (e.g. standard, unzipped bag,
                   zipped bag, dspace).

``accession``      Accession number of new transfer.

``paths[]``        List of base64-encoded
                   ``<location_uuid>:<relative_path>`` to be copied into the new
                   transfer. Location UUIDs should be associated with this pipe-
                   line, and relative path should be relative to the location.

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
                                                        unzipped bag, zipped 
                                                        bag, dspace.

                     ``directory``                      Directory the transfer 
                                                        is in currently.    

                     ``uuid``                           UUID of the transfer.      

==================   ================================   ========================

Example request:

.. literalinclude:: _code/list_transfer.curl

Example response:

.. literalinclude:: _code/list_transfer_response.curl

Approve transfer(s)
^^^^^^^^^^^^^^^^^^^^

========  ==========================  =========================================
``POST``  **/api/transfer/approve/**  *Approves a transfer awaiting initiation.*
========  ==========================  =========================================

Request body parameters:

=============  ================================================================

``type``           Type of the transfer (e.g. standard, unzipped bag,
                   zipped bag, dspace) to approve.

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
^^^^^^^

========  =================================   =================================
``GET``   **/api/transfer/status/<transfer    *Returns the status of a
          UUID>/**                            transfer.* 
========  =================================   =================================

Response definitions:

=================       ============================     ======================

``status``              One of FAILED, REJECTED,         string
                        USER_INPUT, COMPLETE or
                        PROCESSING                     

``name``                Name of the transfer,            string
                        e.g. "imgs"

``sip_uuid``            If status is COMPLETE,           string
                        this field will exist 
                        with either the UUID 
                        of the SIP or 'BACKLOG'

``microservice``        Name of the current              string  
                        microservice

``directory``           Name of the directory,           string      
                        e.g. "imgs-52dd0c01-e803-
                        423a-be5f-b592b5d5d61c"

``path``                Full path to the transfer,       string
                        e.g. "/var/archivematica/
                        sharedDirectory/watched
                        Directories/SIPCreation/
                        completedTransfers/imgs-
                        52dd0c01-e803-423a-
                        be5f-b592b5d5d61c/"

``message``             "Fetched status from             string
                        <transfer UUID>
                        successfully."      

``type``                "transfer"                       string

``uuid``                UUID of the transfer,            string
                        e.g. "52dd0c01-e803-423a-
                        be5f-b592b5d5d61c"

=================       ============================     ======================

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
^^^^^

===========  =================================   ==============================
``DELETE``   **/api/transfer/<transfer UUID>/    *Hides a transfer*
             delete/**                          
===========  =================================   ==============================

Example request:

.. literalinclude:: _code/hide_request.curl

Example response:

.. literalinclude:: _code/hide_response.curl


Completed
^^^^^^^^^^

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
^^^^^^^^^^^^^^^

..  note::

    The Start reingest endpoint complements the :ref:`ss-reingest-aip.rst`
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

.. _ingest-resource.rst:

Ingest
-------

Ingest refers to the process by which digital objects are packaged into SIPs and
run through microservices that enable normalization, packaging into an 
AIP, and generation of a DIP.

Status
^^^^^^^

===========  =================================   ==============================
``GET``      **/ingest/status/<unit_UUID>/**     *Returns status of the SIP.* 
===========  =================================   ==============================

Response definitions:

==================   ==========================================================
                    
``status``           One of FAILED, REJECTED, USER_INPUT, COMPLETE or PROCESSING.

``name``             Name of the SIP, e.g. "imgs".

``microservices``    Name of the current microservice

``directory``        Name of the directory, e.g. "imgs-52dd0c01-e803-423a-be5f
                     \ -b592b5d5d61c"

``path``             Full path to the transfer, e.g. "/var/archivematica/shared
                     Directory/currentlyProcessing/imgs-52dd0c01-e803-423a-be5f-
                     / b592b5d5d61c/".     

``message``          "Fetched status for <SIP UUID> successfully."

``type``             "SIP"

``uuid``             UUID of the SIP, e.g. "52dd0c01-e803-423a-be5f-b592b5d61c".

==================   ==========================================================

Example request:

.. literalinclude:: _code/status_request.curl

Example response (JSON):

.. literalinclude:: _code/status_response.curl

Hide
^^^^^

===========  =================================== ==============================
``DELETE``   **/api/ingest/<SIP UUID>/delete/**  *Hides a SIP.* 
===========  =================================== ==============================

Example request:

.. literalinclude:: _code/hide_request.curl

Example response:

.. literalinclude:: _code/hide_response.curl


List SIPS Waiting for User Input
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^

===========  ========================== ========================================
``GET``      **/api/ingest/completed/**  *Returns a list of completed SIPs.*
===========  ========================== ========================================

Example request:

.. literalinclude:: _code/completed_ingest_request.curl

Example response (JSON):

.. literalinclude:: _code/completed_ingest_response.curl

Reingest
^^^^^^^^^

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
^^^^^^^^^^^^^^

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
                    
``message``          "Approval successful."

``reingest_uuid``    UUID of the reingested transfer.

==================   ==========================================================


.. _admin-resource.rst:

Administration
--------------

Administration enables you to configure various parts of the application and 
manage integrations and users.


Levels of description
^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

.. _unit-resource.rst:


Unit
----

Unit refers to "a type of Package Description that is specialized to provide 
information about an Archival Information Unit for use by Access Aids." (OAIS, 
p.1-13, Section 1.7.2)

List jobs
^^^^^^^^^^

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
^^^^^

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

.. _other-resource.rst:

Other
------

Other is a generic resource category that includes path metadata associated 
with level of description, and it also includes name associated with any 
customized processing configuration.

Path metadata
^^^^^^^^^^^^^^

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

  curl --location --request GET 'http://test.machine.archivematica.net/api/processing-configuration/backlog' \
  --header 'Authorization: ApiKey analyst:zzhah5chashie8OwEih6udie4choo4la'


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

.. _beta.rst:

Beta
-----

API endpoints that are still in-flux and could potentially change.

Package
^^^^^^^^

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

``type``               Transfer name.

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

   curl -v POST \
       -H "Authorization: ApiKey test:test" \
       -H "Content-Type: application/json" \
       -d "{\
           \"path\": \"$(echo -n '/home/archivematica/archivematica-sampledata
           /SampleTransfers/DemoTransfer' | base64 -w 0)\", \
           \"name\": \"demo_transfer_absolute\", \
           \"processing_config\": \"automated\", \
           \"type\": \"standard\" \
           }" \
      "http://<archivematica-uri>/api/v2beta/package"

*Starting a transfer using an relative path with a transfer source UUID*::

  curl -v POST \
       -H "Authorization: ApiKey test:test" \
       -H "Content-Type: application/json" \
       -d "{\
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

======================= ========================================================
**/api/v2beta/package** *Available in Archivematica 1.10+. This endpoint can be 
                        used to validate CSVs against embedded sets of rules. 
                        Currently works with Avalon Media System Manifest files.*

                        *In the future, this endpoint can be extended to support 
                        validation for metadata.csv or rights.csv, or other 
                        institutionally-based rules.*   
======================= ========================================================

Usage example (assuming that avalon.csv exists)::

  curl http://127.0.0.1:62080/api/v2beta/validate/avalon \
  --data-binary "@avalon.csv" \
  --header "Authorization: ApiKey test:test" \
  --header "Content-Type: text/csv; charset=utf-8"

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

Storage Service API
====================

The Storage Service API enables access to storage areas to which the Storage 
Service has access.

Storage Service API resources and endpoints
============================================

Endpoints for the Storage Service API have been organized into the following 
resource categories:

    * :ref:`ss-pipeline.rst`
    * :ref:`ss-space.rst`
    * :ref:`ss-location.rst`
    * :ref:`ss-package.rst`

.. _ss-pipeline.rst:

Pipeline
---------

A pipeline is a representation of an Archivematica installation that is assigned
a unique universal identifier (UUID) when it is registered with the Storage 
Service. The UUID provides information about your server and all associated 
clients. 

..  note::

  For each Storage Service API resource, you can display a detailed schema by 
  adding "schema" to the get all URL like in the following example: ::

    $ curl -X GET -H"Authorization: ApiKey 
    test:95141fc645ed97a95893f1f865d24687f89a27ad" 'http://localhost:8000/api/v2
    /location/schema/?format=json

    {
       "allowed_detail_http_methods": [
           "get",
           "post"
       ],
       "allowed_list_http_methods": [
           "get"
       ],
       "default_format": "application/json",
       "default_limit": 20,
       "fields": {
           "description": {
               "blank": false,
               "default": "No default provided.",
               "help_text": "Unicode string data. Ex: \"Hello World\"",
               "nullable": false,
               "primary_key": false,
               "readonly": true,
               "type": "string",
               "unique": false,
               "verbose_name": "description"
           },
           "enabled": {
               "blank": true,
               "default": true,
               "help_text": "True if space can be accessed.",
               "nullable": false,
               "primary_key": false,
               "readonly": false,
               "type": "boolean",
               "unique": false,
               "verbose_name": "Enabled"
           },
           "path": {
               "blank": false,
               "default": "No default provided.",
               "help_text": "Unicode string data. Ex: \"Hello World\"",
               "nullable": false,
               "primary_key": false,
               "readonly": true,
               "type": "string",
               "unique": false,
               "verbose_name": "path"
           },
           "pipeline": {
               "blank": false,
               "default": "No default provided.",
               "help_text": "Many related resources. Can be either a list of URIs
               or list of individually nested resource data.",
               "nullable": false,
               "primary_key": false,
               "readonly": false,
               "related_schema": "/api/v2/pipeline/schema/",
               "related_type": "to_many",
               "type": "related",
               "unique": false,
               "verbose_name": "pipeline"
           },
           "purpose": {
               "blank": false,
               "default": "No default provided.",
               "help_text": "Purpose of the space.  Eg. AIP storage, Transfer 
               source",
               "nullable": false,
               "primary_key": false,
               "readonly": false,
               "type": "string",
               "unique": false,
               "verbose_name": "Purpose"
           },
           "quota": {
               "blank": false,
               "default": null,
               "help_text": "Size, in bytes (optional)",
               "nullable": true,
               "primary_key": false,
               "readonly": false,
               "type": "string",
               "unique": false,
               "verbose_name": "Quota"
           },
           "relative_path": {
               "blank": false,
               "default": "",
               "help_text": "Path to location, relative to the storage space's 
               path.",
               "nullable": false,
               "primary_key": false,
               "readonly": false,
               "type": "string",
               "unique": false,
               "verbose_name": "Relative Path"
           },
           "resource_uri": {
               "blank": false,
               "default": "No default provided.",
               "help_text": "Unicode string data. Ex: \"Hello World\"",
               "nullable": false,
               "primary_key": false,
               "readonly": true,
               "type": "string",
               "unique": false,
               "verbose_name": "resource uri"
           },
           "space": {
               "blank": false,
               "default": "No default provided.",
               "help_text": "A single related resource. Can be either a URI or 
               set of nested resource data.",
               "nullable": false,
               "primary_key": false,
               "readonly": false,
               "related_schema": "/api/v2/space/schema/",
               "related_type": "to_one",
               "type": "related",
               "unique": false,
               "verbose_name": "space"
           },
           "used": {
               "blank": false,
               "default": 0,
               "help_text": "Amount used, in bytes.",
               "nullable": false,
               "primary_key": false,
               "readonly": false,
               "type": "string",
               "unique": false,
               "verbose_name": "Used"
           },
           "uuid": {
               "blank": true,
               "default": "",
               "help_text": "Unique identifier",
               "nullable": false,
               "primary_key": false,
               "readonly": false,
               "type": "string",
               "unique": true,
               "verbose_name": "uuid"
           }
       },
       "filtering": {
           "pipeline": 2,
           "purpose": 1,
           "quota": 1,
           "relative_path": 1,
           "space": 2,
           "used": 1,
           "uuid": 1
       }
    }


  This schema, among other things, describes the fields in the resource 
  (including the schema URI of related resource fields) and the fields that allow 
  filtering. Valid filtering values are: Django ORM filters (e.g. startswith, 
  exact, lte, etc.) or 1 or 2. If a filtering field is set to 2 it can be filtered 
  over the related resource fields. For example, the locations could be filtered
  by their pipeline UUID setting it in a request parameter formatted with two 
  underscore chars: /api/v2/location/?pipeline__uuid=<uuid>

  For more info on how to interact with the API see:

  `<http://django-tastypie.readthedocs.io/en/v0.13.1/interacting.html>`__

Get all pipelines
^^^^^^^^^^^^^^^^^

============= ============================= =================================
``GET``       **/api/v2/pipeline/**         *Retrieves information about all 
                                            pipelines in the system.*  
============= ============================= =================================

Query string parameters:

==================  ============================================================

``description``     Description of the pipeline.

``uuid``            UUID associated with the pipeline.

==================  ============================================================

Response definitions (JSON):

Returns information about all the pipelines in the system. Can be filtered by 
the description or uuid. Disabled pipelines are not returned.

==================  ============================================================

``meta``            Metadata on the response: number of hits, pagination 
                    information.

``objects``         List of pipelines. See :ref:`ss_pipeline_details` for format.

==================  ============================================================

Example request::

  $ curl -X GET -H"Authorization: ApiKey test:95141fc645ed97a95893f1f865d24687f89a27ad"
   'http://localhost:8000/api/v2/pipeline/?description__startswith=Archivematica'
    | python -m json.tool

Example response::

  {
      "meta": {
          "limit": 20,
          "next": null,
          "offset": 0,
          "previous": null,
          "total_count": 1
      },
      "objects": [
          {
              "description": "Archivematica on alouette",
              "remote_name": "127.0.0.1",
              "resource_uri": "/api/v2/pipeline/dd354557-9e6e-4918-9fe3-a65b00ecb1af/",
              "uuid": "dd354557-9e6e-4918-9fe3-a65b00ecb1af"
          }
      ]
  }

Create new pipeline
^^^^^^^^^^^^^^^^^^^

============= ============================= =================================
``POST``       **/api/v2/pipeline/**        *Creates a new pipeline.*  
============= ============================= =================================

Request body parameters (accepts JSON strings as parameter values):

============================   =================================================

``uuid``                       UUID of the new pipeline.

``description``                Pipeline description.

``api_key``                    API key associated with user for authorization.

``api_username``               Username of admin authorized to write to the
                               storage location.

``create_default_locations``   If True, will associated default Locations 
                               with the newly created pipeline.

``shared_path``                If default locations are created, create the 
                               processing location at this path in the local 
                               filesystem.

``remote_name``                URI of the pipeline.
                               
                               Note: Before v0.11.0: If create_default_locations
                               is set, SS will try to guess the value using the 
                               REMOTE_ADDR header.

                               In v0.11.0 or newer: If not provided, SS will try
                               to guess the value using the REMOTE_ADDR header.

============================   =================================================

Example request::

  $ curl -X POST \
   -H"Authorization: ApiKey test:95141fc645ed97a95893f1f865d24687f89a27ad" \
   -H"Content-Type: application/json" \
   -d'{"uuid": "99354557-9e6e-4918-9fe3-a65b00ecb199", \
       "description": "Test pipeline", "create_default_locations": true, \
       "api_username": "demo", \
       "api_key": "03ecb307f5b8012f4771d245d534830378a87259"}' \
    'http://192.168.1.42:8000/api/v2/pipeline/'

Example response::

  {
     "create_default_locations": true,
     "description": "Test pipeline",
     "remote_name": "192.168.1.42",
     "resource_uri": "/api/v2/pipeline/99354557-9e6e-4918-9fe3-a65b00ecb199/",
     "uuid": "99354557-9e6e-4918-9fe3-a65b00ecb199"
  }

.. _ss_pipeline_details:

Get pipeline details
^^^^^^^^^^^^^^^^^^^^

============= ============================= =================================
``GET``       **/api/v2/pipeline/<uuid>**   *Retrieves information about all 
                                            pipelines in the system.*  
============= ============================= =================================

Response definitions (JSON):

==================  ============================================================

``description``     General statement about the pipeline.

``remote_name``     IP or hostname of the pipeline for use in API calls.

``resource_uri``    URI for this pipeline in the API.

``uuid``            UUID of the pipeline.

==================  ============================================================

Example request:

.. literalinclude:: _code/ss_get_pipeline_details_request.curl

Example response (JSON body):

.. literalinclude:: _code//ss_get_pipeline_details_response.curl

.. _ss-space.rst:

Space
-----

A storage space contains all the information necessary to connect to the 
physical storage. It is where the files are stored. Protocol-specific 
information, like an NFS export path and hostname, or the username of a system 
accessible only via SSH, is stored here. All locations must be contained in 
a space.


Get all spaces
^^^^^^^^^^^^^^^

============= =================== ==============================================
``GET``       **/api/v2/space/**  *Retrieves information about all the spaces 
                                  in the system. Can be filtered by several 
                                  fields: access protocol, path, size, amount 
                                  used, UUID and verified status. Disabled spaces
                                  are not returned.* 
============= =================== ==============================================

Query string parameters:

============================   =================================================

``access_protocol``            Protocol that the space uses; must be searched 
                               based on the database code.

``path``                       Space's path.

``size``                       Maximum size in bytes. Can use greater than 
                               (size__gt=1024), less than (size__lt=1024), and 
                               other Django field lookups.

``used``                       Bytes stored in this space. Can use greater than 
                               (size__gt=1024), less than (size__lt=1024), and 
                               other Django field lookups.

``uuid``                       UUID of the space.                               

============================   =================================================

Response definitions (JSON):

==================  ============================================================

``meta``            Metadata on the response: number of hits, pagination 
                    information.

``objects``         List of spaces.

==================  ============================================================

Example request:

.. literalinclude:: _code/ss_get_all_spaces_request.curl

Example response (JSON):

.. literalinclude:: _code/ss_get_all_spaces_response.curl


Get space details
^^^^^^^^^^^^^^^^^

============= ========================= ========================================

``GET``       **/api/v2/space/<UUID>/** *Returns space-specific details.*

============= ========================= ========================================

Response definitions (JSON):

===================   ==========================================================

``access_protocol``    Database code for the access protocol.  

``last verified``      Date of last verification; this is a stub feature.

``path``               Space's path.

``resource_uri``       URI to the resource in the API.

``size``               Maximum size of the space in bytes.

``used``               Bytes stored in this space.

``uuid``               UUID of the space.

``verified``           If the space is verified, this is a stub feature.

===================   ==========================================================

Example request:

.. literalinclude:: _code/ss_get_space_details_request.curl

Example response (JSON):

.. literalinclude:: _code/ss_get_space_details_response.curl


Browse space path
^^^^^^^^^^^^^^^^^

============= ================================   ===============================
``GET``       **/api/v2/space/<UUID>/browse/**   *Gets details about the space
                                                 path and directory structure.*  
============= ================================   ===============================

Query string parameters:

============================   =================================================

``path``                       Path inside the Space to look.

============================   =================================================

Response definitions (JSON):

===================   ==========================================================

``entries``           List of entries at path, files or directories.  

``directories``       List of directories in path. Subset of entries.

===================   ==========================================================

Example request:

.. literalinclude:: _code/ss_browse_space_path_request.curl

Example response (JSON):

.. literalinclude:: _code/ss_browse_space_path_response.curl


Create space
^^^^^^^^^^^^

..  note::

    For background, see `Issue 36 
    <https://github.com/archivematica/Issues/issues/36>`_

============= ==========================  ======================================

``POST``      **/api/v2/pipeline/space**  *Creates a new space.*

============= ==========================  ======================================

Request body parameters:

Parameters should contain fields for a new space: See the 
`Storage Service \
<https://www.archivematica.org/en/docs/storage-service-0.16/administrators/#>`_
documentation or `Space <https://wiki.archivematica.org/Storage_Service#Space>`_
for fields relevant to each type of space. Basic fields for a local file system 
space are listed below.

===================   ==========================================================

``access_protocol``   This defines the type of space.

``path``              Absolute path to the space on the local filesystem.

``size``              (Optional) Maximum size allowed for this space. Set to 0 
                      or leave blank for unlimited.

===================   ==========================================================

Example (to create an S3 space):

.. code::

  $ curl \
      -X POST \
      -d @payload.json \
      -H "Content-Type: application/json" \
      -H "Authorization: ApiKey test:test" \
          http://127.0.0.1:62081/api/v2/space/

  Where payload.json contains
  {
      "access_protocol": "S3",
      "path": "",
      "staging_path": "/",
      "endpoint_url": "http://127.0.0.1:12345",
      "access_key_id": "_Cah4cae1_",
      "secret_access_key": "_Thu6Ahqu_",
      "region": "us-west-2"
  }

..  note::

    Endpoint returns all paths base64 encoded.


.. _ss-location.rst:

Location
--------

A location is a subdivision of a space. Each location is assigned a specific 
purpose, such as AIP storage, DIP storage, transfer source or transfer backlog, 
in order to provide an organized way to structure content within a space.

Get all locations
^^^^^^^^^^^^^^^^^

============= ========================= ========================================

``GET``       **/api/v2/location/**     *Returns space-specific details.*

============= ========================= ========================================

Example request::

  $ curl -X GET -H"Authorization: ApiKey 
  test:95141fc645ed97a95893f1f865d24687f89a27ad" 'http://localhost:8000/api/v2
  /location/schema/?format=json'

Example response::

  {
      "meta": {
          "limit": 20,
          "next": null,
          "offset": 0,
          "previous": null,
          "total_count": 7
      },
      "objects": [
          {
              "description": "",
              "enabled": true,
              "path": "/home",
              "pipeline": [
                  "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/"
              ],
              "purpose": "TS",
              "quota": null,
              "relative_path": "home",
              "resource_uri": "/api/v2/location/a48e2a56-bae7-4b63-824e-b886bbadd77d/",
              "space": "/api/v2/space/218caeb7-fd59-4b7b-99b1-f5771a2dd34f/",
              "used": "0",
              "uuid": "a48e2a56-bae7-4b63-824e-b886bbadd77d"
          },
          {
              "description": "Store AIP in standard Archivematica Directory",
              "enabled": true,
              "path": "/var/archivematica/sharedDirectory/www/AIPsStore",
              "pipeline": [
                  "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/"
              ],
              "purpose": "AS",
              "quota": null,
              "relative_path": "var/archivematica/sharedDirectory/www/AIPsStore",
              "resource_uri": "/api/v2/location/6286affb-6a2b-4ac7-b81e-192d84ede4c6/",
              "space": "/api/v2/space/218caeb7-fd59-4b7b-99b1-f5771a2dd34f/",
              "used": "179586607",
              "uuid": "6286affb-6a2b-4ac7-b81e-192d84ede4c6"
          },
          {
              "description": "Store DIP in standard Archivematica Directory",
              "enabled": true,
              "path": "/var/archivematica/sharedDirectory/www/DIPsStore",
              "pipeline": [
                  "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/"
              ],
              "purpose": "DS",
              "quota": null,
              "relative_path": "var/archivematica/sharedDirectory/www/DIPsStore",
              "resource_uri": "/api/v2/location/8b70e21b-57a3-46f1-baee-c8c48fb6383c/",
              "space": "/api/v2/space/218caeb7-fd59-4b7b-99b1-f5771a2dd34f/",
              "used": "6773558",
              "uuid": "8b70e21b-57a3-46f1-baee-c8c48fb6383c"
          },
          {
              "description": "Default transfer backlog",
              "enabled": true,
              "path": "/var/archivematica/sharedDirectory/www/AIPsStore/transferBacklog",
              "pipeline": [
                  "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/"
              ],
              "purpose": "BL",
              "quota": null,
              "relative_path": "var/archivematica/sharedDirectory/www/AIPsStore/\
              transferBacklog",
              "resource_uri": "/api/v2/location/0da78c11-4ea7-4c52-8114-d39980e5\
              ad2b/",
              "space": "/api/v2/space/218caeb7-fd59-4b7b-99b1-f5771a2dd34f/",
              "used": "189008",
              "uuid": "0da78c11-4ea7-4c52-8114-d39980e5ad2b"
          },
          {
              "description": "For storage service internal usage.",
              "enabled": true,
              "path": "/var/archivematica/storage_service",
              "pipeline": [],
              "purpose": "SS",
              "quota": null,
              "relative_path": "var/archivematica/storage_service",
              "resource_uri": "/api/v2/location/5bf813d0-5663-4025-aac3-956ed1403790/",
              "space": "/api/v2/space/218caeb7-fd59-4b7b-99b1-f5771a2dd34f/",
              "used": "0",
              "uuid": "5bf813d0-5663-4025-aac3-956ed1403790"
          },
          {
              "description": "Default AIP recovery",
              "enabled": true,
              "path": "/var/archivematica/storage_service/recover",
              "pipeline": [
                  "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/"
              ],
              "purpose": "AR",
              "quota": null,
              "relative_path": "var/archivematica/storage_service/recover",
              "resource_uri": "/api/v2/location/e26a003e-361c-45ad-b82e-185faabc\
              7a2d/",
              "space": "/api/v2/space/218caeb7-fd59-4b7b-99b1-f5771a2dd34f/",
              "used": "0",
              "uuid": "e26a003e-361c-45ad-b82e-185faabc7a2d"
          },
          {
              "description": null,
              "enabled": true,
              "path": "/var/archivematica/sharedDirectory",
              "pipeline": [
                  "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/"
              ],
              "purpose": "CP",
              "quota": null,
              "relative_path": "var/archivematica/sharedDirectory/",
              "resource_uri": "/api/v2/location/6f99d6c7-65ff-4966-993d-92a40df4\
              a072/",
              "space": "/api/v2/space/218caeb7-fd59-4b7b-99b1-f5771a2dd34f/",
              "used": "0",
              "uuid": "6f99d6c7-65ff-4966-993d-92a40df4a072"
          }
      ]
  }


Create new location
^^^^^^^^^^^^^^^^^^^

============= =====================  ===========================================

``POST``      **/api/v2/location/**  *Added in v0.12 - see issue 
                                     `367 <https://github.com/artefactual/archivematica-storage-service/issues/367>`_ 
                                     and issue `37 <https://github.com/archivematica/Issues/issues/37>`_.*

                                     *This endpoint creates a location in the 
                                     storage service, but it doesn't actually 
                                     create the directory to which the location 
                                     points.*

============= =====================  ===========================================

Request body parameters:

===================   ==========================================================

``description``       Information about the space.

``pipeline``          URI of the pipeline.

``space``             URI of the space.

``default``           If 'true' this location will be the default for it's 
                      purpose.

``purpose``           Accepts the following possible values:

                      AR (AIP_RECOVERY)

                      AS (AIP_STORAGE)

                      CP (CURRENTLY_PROCESSING)

                      DS (DIP_STORAGE)

                      SD (SWORD_DEPOSIT)

                      SS (STORAGE_SERVICE_INTERNAL)

                      BL (BACKLOG)

                      TS (TRANSFER_SOURCE)

                      RP (REPLICATOR)

``relative_path``     Relative to the space's path.                      

===================   ==========================================================


Example::

  curl -s -d '{
      "pipeline": ["/api/v2/pipeline/90707555-244f-47af-8271-66496a6a965b/"],
      "purpose": "TS",
      "relative_path": "foo/bar",
      "description": "foobar",
      "space": "/api/v2/space/141593ff-2a27-44a1-9de1-917573fa0f4a/"
  }' \
      -X POST \
      -H "Authorization: ApiKey test:test" \
      -H "Content-Type: application/json" \
          "http://127.0.0.1:62081/api/v2/location/"


Get location details
^^^^^^^^^^^^^^^^^^^^

============= ============================  ====================================

``GET``       **/api/v2/location/<UUID>/**  *Returns space-specific details.*

============= ============================  ====================================


Example request::

  curl --location --request GET 'http://test.archivematica.net:8000/api/v2/location/e26a003e-361c-45ad-b82e-185faabc7a4d' \
  --header 'Authorization: ApiKey test_user:ow7ioGh2reephua8uPaiWee3EiHeev6u'

Example response::

  {
      "description": "Default AIP recovery",
      "enabled": true,
      "path": "/var/archivematica/storage_service/recover",
      "pipeline": [
          "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/"
      ],
      "purpose": "AR",
      "quota": null,
      "relative_path": "var/archivematica/storage_service/recover",
      "resource_uri": "/api/v2/location/e26a003e-361c-45ad-b82e-185faabc7a4d/",
      "space": "/api/v2/space/218caeb7-fd59-4b7b-99b1-f5771a2dd34f/",
      "used": "0",
      "uuid": "e26a003e-361c-45ad-b82e-185faabc7a2d"
  }

Move files to this location
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

===========  =================================   ===============================

``POST``     **/api/v2/location/<UUID>/**        *Move files to specified pipe-
                                                 line location.*

===========  =================================   ===============================

Request body parameters:

======================  ========================================================

``origin_location``     UUID of the pipeline on which to reingest AIP.
               
``pipeline``            URI of the pipeline. Both Locations must be associated 
                        with this pipeline.

``files``               List of dicts containing source and destination. The 
                        `source` and `destination` are paths relative to their 
                        Location of the files to be moved.                          

======================  ========================================================

..  note::

    Intended for use with creating Transfers, SIPs, etc and other cases where 
    files need to be moved but not tracked by the storage service.

..     To include if available
       Example request:
       Example response:

Browse location path 
^^^^^^^^^^^^^^^^^^^^

===========  ===================================   =============================

``GET``      **/api/v2/location/<UUID>/browse/**   *Returns location paths that
                                                   are base64 encoded.*

===========  ===================================   =============================

Query string parameters:

======================  ========================================================

``entries``             List of entries in `path`, files or directories.
               
``directories``         List of directories in `path`. Subset of `entries`.

======================  ========================================================

SWORD collection
^^^^^^^^^^^^^^^^

=============  ==============================  =================================

``GET, POST``  **/api/v2/location/<UUID>/** \  *Part of the Archivematica storage
               **sword/collection**            service REST API. The Storage Service
                                               also talks to the Archivematica 
                                               dashboard, however, to notify it that
                                               a transfer created from a SWORD deposit
                                               has been approved for processing.*
                                                     
                 

=============  ==============================  =================================

The Archivematica Sword API enables 3rd party applications to automate the 
process of creating Transfers.

  1. Create Transfer - set the name and other metadata about a Transfer
  Populate Transfer - add/edit/update digital objects in a Transfer, 
  and associated metadata.

  2. Finalize Transfer - indicates that the Transfer is ready to start processing.
  After content has been deposited, if users have access to the deposit directory 
  they can also manually manipulate the deposit directory aside from any 
  manipulation using the API.

  3. Once a Transfer has been created, populated and finalized, Archivematica 
  will begin processing that Transfer.

Example request::

  curl --location --request GET 'http://test.archivematica.net:8000/api/v2/location/6286affb-6a2b-4ac7-b81e-192d84ede7c6/browse/'

Example response::

  {
      "directories": [
          "MTk5OA==",
          "MjdkOQ==",
          "MmM0Yg==",
          "MmNkMA==",
          "OTE0NA==",
          "YjdlZg==",
          "ZTA1Mg==",
          "dHJhbnNmZXJCYWNrbG9n"
      ],
      "entries": [
          "MTk5OA==",
          "MjdkOQ==",
          "MmM0Yg==",
          "MmNkMA==",
          "OTE0NA==",
          "YjdlZg==",
          "ZTA1Mg==",
          "dHJhbnNmZXJCYWNrbG9n"
      ],
      "properties": {
          "MTk5OA==": {
              "object count": 1
          },
          "MjdkOQ==": {
              "object count": 1
          },
          "MmM0Yg==": {
              "object count": 1
          },
          "MmNkMA==": {
              "object count": 1
          },
          "OTE0NA==": {
              "object count": 1
          },
          "YjdlZg==": {
              "object count": 1
          },
          "ZTA1Mg==": {
              "object count": 1
          },
          "dHJhbnNmZXJCYWNrbG9n": {
              "object count": 34
          }
      }
  }

.. _ss-package.rst:

Package
-------

A package is a bundle of one or more files transferred from an external service;
for example, a package may be an AIP, a backlogged transfer, or a DIP. Each 
package is stored in a location.


Get all packages
^^^^^^^^^^^^^^^^

===========  ==================   ==============================================

``GET``      **/api/v2/file/**    *Retrieves information about all packages
                                  for all available storage locations.*

===========  ==================   ==============================================

Example request::

  curl --location --request GET 'http://test.archivematica.net:8000/api/v2/file/' \
  --header 'Authorization: ApiKey test_user:ow7ioGh2reephua8uPaiWee3EiHeev6u' 

Example response::

  {
      "meta": {
          "limit": 20,
          "next": null,
          "offset": 0,
          "previous": null,
          "total_count": 11
      },
      "objects": [
          {
              "current_full_path": "/var/archivematica/sharedDirectory/www/AIPsStore/27d9/8723/a8f2/490b/9116/88c5/a555/9ca2/img-2-27d98723-a8f2-490b-9116-88c5a5559ca2.7z",
              "current_location": "/api/v2/location/6286affb-6a2b-4ac7-b81e-192d84ede4c6/",
              "current_path": "27d9/8723/a8f2/490b/9116/88c5/a555/9ca2/img-2-27d98723-a8f2-490b-9116-88c5a5559ca2.7z",
              "encrypted": false,
              "misc_attributes": {
                  "reingest_pipeline": null
              },
              "origin_pipeline": "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/",
              "package_type": "AIP",
              "related_packages": [],
              "replicas": [],
              "replicated_package": null,
              "resource_uri": "/api/v2/file/27d98723-a8f2-490b-9116-88c5a5559ca2/",
              "size": 11444115,
              "status": "UPLOADED",
              "uuid": "27d98723-a8f2-490b-9116-88c5a5559ca2"
          },
          {
              "current_full_path": "/var/archivematica/sharedDirectory/www/AIPsStore/b7ef/c3ad/81dc/4581/b630/f7ed/5ca8/01ce/images-b7efc3ad-81dc-4581-b630-f7ed5ca801ce.7z",
              "current_location": "/api/v2/location/6286affb-6a2b-4ac7-b81e-192d84ede4c6/",
              "current_path": "b7ef/c3ad/81dc/4581/b630/f7ed/5ca8/01ce/images-b7efc3ad-81dc-4581-b630-f7ed5ca801ce.7z",
              "encrypted": false,
              "misc_attributes": {
                  "reingest_pipeline": null
              },
              "origin_pipeline": "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/",
              "package_type": "AIP",
              "related_packages": [],
              "replicas": [],
              "replicated_package": null,
              "resource_uri": "/api/v2/file/b7efc3ad-81dc-4581-b630-f7ed5ca801ce/",
              "size": 11447220,
              "status": "UPLOADED",
              "uuid": "b7efc3ad-81dc-4581-b630-f7ed5ca801ce"
          },
          {
              "current_full_path": "/var/archivematica/sharedDirectory/www/AIPsStore/9144/66c1/d89d/4232/b583/7dcd/631f/d08a/test-914466c1-d89d-4232-b583-7dcd631fd08a.7z",
              "current_location": "/api/v2/location/6286affb-6a2b-4ac7-b81e-192d84ede4c6/",
              "current_path": "9144/66c1/d89d/4232/b583/7dcd/631f/d08a/test-914466c1-d89d-4232-b583-7dcd631fd08a.7z",
              "encrypted": false,
              "misc_attributes": {},
              "origin_pipeline": "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/",
              "package_type": "AIP",
              "related_packages": [],
              "replicas": [],
              "replicated_package": null,
              "resource_uri": "/api/v2/file/914466c1-d89d-4232-b583-7dcd631fd08a/",
              "size": 43609598,
              "status": "UPLOADED",
              "uuid": "914466c1-d89d-4232-b583-7dcd631fd08a"
          },
          {
              "current_full_path": "/var/archivematica/sharedDirectory/www/AIPsStore/1998/acb4/c6d8/439f/8e74/7285/ba15/012d/i2-1998acb4-c6d8-439f-8e74-7285ba15012d.7z",
              "current_location": "/api/v2/location/6286affb-6a2b-4ac7-b81e-192d84ede4c6/",
              "current_path": "1998/acb4/c6d8/439f/8e74/7285/ba15/012d/i2-1998acb4-c6d8-439f-8e74-7285ba15012d.7z",
              "encrypted": false,
              "misc_attributes": {
                  "reingest_pipeline": null
              },
              "origin_pipeline": "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/",
              "package_type": "AIP",
              "related_packages": [],
              "replicas": [],
              "replicated_package": null,
              "resource_uri": "/api/v2/file/1998acb4-c6d8-439f-8e74-7285ba15012d/",
              "size": 11408327,
              "status": "UPLOADED",
              "uuid": "1998acb4-c6d8-439f-8e74-7285ba15012d"
          },
          {
              "current_full_path": "/var/archivematica/sharedDirectory/www/AIPsStore/2cd0/575f/5e0b/4d2f/bd00/7e0b/254e/0802/mc-test-2cd0575f-5e0b-4d2f-bd00-7e0b254e0802.7z",
              "current_location": "/api/v2/location/6286affb-6a2b-4ac7-b81e-192d84ede4c6/",
              "current_path": "2cd0/575f/5e0b/4d2f/bd00/7e0b/254e/0802/mc-test-2cd0575f-5e0b-4d2f-bd00-7e0b254e0802.7z",
              "encrypted": false,
              "misc_attributes": {},
              "origin_pipeline": "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/",
              "package_type": "AIP",
              "related_packages": [
                  "/api/v2/file/855e14e9-2921-4b51-be77-0afdbdc16aeb/"
              ],
              "replicas": [],
              "replicated_package": null,
              "resource_uri": "/api/v2/file/2cd0575f-5e0b-4d2f-bd00-7e0b254e0802/",
              "size": 11416388,
              "status": "UPLOADED",
              "uuid": "2cd0575f-5e0b-4d2f-bd00-7e0b254e0802"
          },
          {
              "current_full_path": "/var/archivematica/sharedDirectory/www/DIPsStore/855e/14e9/2921/4b51/be77/0afd/bdc1/6aeb/mc-test-2cd0575f-5e0b-4d2f-bd00-7e0b254e0802",
              "current_location": "/api/v2/location/8b70e21b-57a3-46f1-baee-c8c48fb6383c/",
              "current_path": "855e/14e9/2921/4b51/be77/0afd/bdc1/6aeb/mc-test-2cd0575f-5e0b-4d2f-bd00-7e0b254e0802",
              "encrypted": false,
              "misc_attributes": {},
              "origin_pipeline": "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/",
              "package_type": "DIP",
              "related_packages": [
                  "/api/v2/file/2cd0575f-5e0b-4d2f-bd00-7e0b254e0802/"
              ],
              "replicas": [],
              "replicated_package": null,
              "resource_uri": "/api/v2/file/855e14e9-2921-4b51-be77-0afdbdc16aeb/",
              "size": 3386601,
              "status": "UPLOADED",
              "uuid": "855e14e9-2921-4b51-be77-0afdbdc16aeb"
          },
          {
              "current_full_path": "/var/archivematica/sharedDirectory/www/AIPsStore/transferBacklog/originals/test_bag-cdc18f4b-e859-4244-9c42-c575b69e92fe",
              "current_location": "/api/v2/location/0da78c11-4ea7-4c52-8114-d39980e5ad2b/",
              "current_path": "originals/test_bag-cdc18f4b-e859-4244-9c42-c575b69e92fe",
              "encrypted": false,
              "misc_attributes": {},
              "origin_pipeline": "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/",
              "package_type": "transfer",
              "related_packages": [],
              "replicas": [],
              "replicated_package": null,
              "resource_uri": "/api/v2/file/cdc18f4b-e859-4244-9c42-c575b69e92fe/",
              "size": 189008,
              "status": "UPLOADED",
              "uuid": "cdc18f4b-e859-4244-9c42-c575b69e92fe"
          },
          {
              "current_full_path": "/var/archivematica/sharedDirectory/www/AIPsStore/e052/5606/c710/4380/9c98/fdb4/3e77/c0ba/demo_images-e0525606-c710-4380-9c98-fdb43e77c0ba.7z",
              "current_location": "/api/v2/location/6286affb-6a2b-4ac7-b81e-192d84ede4c6/",
              "current_path": "e052/5606/c710/4380/9c98/fdb4/3e77/c0ba/demo_images-e0525606-c710-4380-9c98-fdb43e77c0ba.7z",
              "encrypted": false,
              "misc_attributes": {},
              "origin_pipeline": "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/",
              "package_type": "AIP",
              "related_packages": [
                  "/api/v2/file/578fec0b-4d6e-4725-8649-e03be6ab7425/"
              ],
              "replicas": [],
              "replicated_package": null,
              "resource_uri": "/api/v2/file/e0525606-c710-4380-9c98-fdb43e77c0ba/",
              "size": 11414225,
              "status": "UPLOADED",
              "uuid": "e0525606-c710-4380-9c98-fdb43e77c0ba"
          },
          {
              "current_full_path": "/var/archivematica/sharedDirectory/www/DIPsStore/578f/ec0b/4d6e/4725/8649/e03b/e6ab/7425/demo_images-e0525606-c710-4380-9c98-fdb43e77c0ba",
              "current_location": "/api/v2/location/8b70e21b-57a3-46f1-baee-c8c48fb6383c/",
              "current_path": "578f/ec0b/4d6e/4725/8649/e03b/e6ab/7425/demo_images-e0525606-c710-4380-9c98-fdb43e77c0ba",
              "encrypted": false,
              "misc_attributes": {},
              "origin_pipeline": "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/",
              "package_type": "DIP",
              "related_packages": [
                  "/api/v2/file/e0525606-c710-4380-9c98-fdb43e77c0ba/"
              ],
              "replicas": [],
              "replicated_package": null,
              "resource_uri": "/api/v2/file/578fec0b-4d6e-4725-8649-e03be6ab7425/",
              "size": 3386957,
              "status": "UPLOADED",
              "uuid": "578fec0b-4d6e-4725-8649-e03be6ab7425"
          },
          {
              "current_full_path": "/var/archivematica/sharedDirectory/www/AIPsStore/2c4b/a224/5889/4a07/a6ca/8323/5ad1/82e0/metadata-2c4ba224-5889-4a07-a6ca-83235ad182e0.7z",
              "current_location": "/api/v2/location/6286affb-6a2b-4ac7-b81e-192d84ede4c6/",
              "current_path": "2c4b/a224/5889/4a07/a6ca/8323/5ad1/82e0/metadata-2c4ba224-5889-4a07-a6ca-83235ad182e0.7z",
              "encrypted": false,
              "misc_attributes": {},
              "origin_pipeline": "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/",
              "package_type": "AIP",
              "related_packages": [],
              "replicas": [],
              "replicated_package": null,
              "resource_uri": "/api/v2/file/2c4ba224-5889-4a07-a6ca-83235ad182e0/",
              "size": 78948258,
              "status": "UPLOADED",
              "uuid": "2c4ba224-5889-4a07-a6ca-83235ad182e0"
          },
          {
              "current_full_path": "/var/archivematica/sharedDirectory/www/AIPsStore/9390/594f/84c2/457d/bd6a/618f/21f7/c954/cf-1-9390594f-84c2-457d-bd6a-618f21f7c954.7z",
              "current_location": "/api/v2/location/6286affb-6a2b-4ac7-b81e-192d84ede4c6/",
              "current_path": "9390/594f/84c2/457d/bd6a/618f/21f7/c954/cf-1-9390594f-84c2-457d-bd6a-618f21f7c954.7z",
              "encrypted": false,
              "misc_attributes": {},
              "origin_pipeline": "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/",
              "package_type": "AIP",
              "related_packages": [],
              "replicas": [],
              "replicated_package": null,
              "resource_uri": "/api/v2/file/9390594f-84c2-457d-bd6a-618f21f7c954/",
              "size": 11417385,
              "status": "UPLOADED",
              "uuid": "9390594f-84c2-457d-bd6a-618f21f7c954"
          }
      ]
  }

Create new package
^^^^^^^^^^^^^^^^^^

===========  ==================  ===============================================
``POST``     **/api/v2/file/**   *Creates a database entry tracking the package 
                                 (AIP, transfer, etc). If the package is an AIP,
                                 DIP or AIC and the current_location is an AIP 
                                 or DIP storage location it also moves the files
                                 from the source to destination location. If the
                                 package is a Transfer and the current_location 
                                 is transfer backlog, it is also moved.*

                                 *This is handled through the modified* 
                                 ``obj_create`` *function, which calls* 
                                 ``Package.store_aip`` *or* ``Package.backlog_transfer``.
===========  ==================  ===============================================

Query string parameters:

========================  ======================================================

``uuid``                  UUID of the new package.
               
``origin_location``       URI of the Location where the package is currently.

``origin_path``           Path to the package, relative to the origin_location.

``current_location``      URI of the Location where the package should be stored.

``current_path``          Path where the package should be stored, relative
                          to the current_location.

``package_type``          Type of package this is. One of: `AIP`, `AIC`, `DIP`, 
                          `transfer`, `SIP`, `file`, `deposit`.

``size``                  Size of the package.

``origin_pipeline``       URI of the pipeline the package is from.

``related_package_uuid``  UUID of a package that is related to this one.
                          E.g. UUID of a DIP when storing an AIP               

========================  ======================================================

Get package details
^^^^^^^^^^^^^^^^^^^^

=========   =======================  ===========================================

``GET``     **/api/v2/file/<UUID>**  *Retrieves information about a package.*

=========   =======================  ===========================================

Example request::

  curl --location --request \
  GET 'http://test.archivematica.net:8000/api/v2/file/9390594f-84c2-457d-bd6a-618f21f7c954/' \
  --header 'Authorization: ApiKey test:ow7ioGh2reephua8uPaiWee4EiHeav7u'


Example response::

  {
      "current_full_path": "/var/archivematica/sharedDirectory/www/AIPsStore/9390/594f/84c2/457d/bd6a/618f/21f7/c954/cf-1-9390594f-84c2-457d-bd6a-618f21f7c954.7z",
      "current_location": "/api/v2/location/6286affb-6a2b-4ac7-b81e-192d84ede4c6/",
      "current_path": "9390/594f/84c2/457d/bd6a/618f/21f7/c954/cf-1-9390594f-84c2-457d-bd6a-618f21f7c954.7z",
      "encrypted": false,
      "misc_attributes": {},
      "origin_pipeline": "/api/v2/pipeline/a64e061a-5688-49b5-95c1-0b6885c40c04/",
      "package_type": "AIP",
      "related_packages": [],
      "replicas": [],
      "replicated_package": null,
      "resource_uri": "/api/v2/file/9390594f-84c2-457d-bd6a-618f21f7c954/",
      "size": 11417385,
      "status": "UPLOADED",
      "uuid": "9390594f-84c2-457d-bd6a-618f21f7c954"
  }


Update package contents
^^^^^^^^^^^^^^^^^^^^^^^

=========   =======================  ===========================================

``PUT``     **/api/v2/file/<UUID>**  *Updates the contents of a package during
                                     reingest. If the package is an AIP or AIC, 
                                     currently stored in an AIP storage location,
                                     and the 'reingest' parameter is set, it will
                                     call* ``Package.finish_reingest`` *and merge 
                                     the new AIP with the existing one.*

                                     *This is implemented using a modified* 
                                     ``obj_update`` *which calls* ``obj_update_hook.``

=========   =======================  ===========================================

Request body parameters:

========================  ======================================================

``reingest``              *Flag to mark that this is reingest. Reduces chance
                          to accidentally modify an AIP.*

``uuid``                  *UUID of the existing package.*

``origin_location``       *URI of the Location where the package is currently.*

``origin_path``           *Path to the package, relative to the origin_location.*   

``current_location``      *URI of the Location where the package should be stored*

``package_type``          *Type of package this is. One of:* ``AIP``, ``AIC``.   

``size``                   *Size of the package.*

``origin_pipeline``        *URI of the pipeline the package is from. This must 
                           be the same pipeline reingest was started on (tracked
                           through* ``Package.misc_attributes.reingest_pipeline)``.

========================  ======================================================


Update package metadata
^^^^^^^^^^^^^^^^^^^^^^^

=========   ========================   ==========================================

``PATCH``   **/api/v2/file/<UUID>**    *Updates the metadata stored in the 
                                       database for the package. Currently, this
                                       is used to update the reingest status.*

=========   ========================   ==========================================

.. note::

    Currently, this always sets ``Package.misc_attributes.reingest`` to ``None``, 
    regardless of what value was actually passed in.

This is implemented using a ``modified obj_update`` which calls ``obj_update_hook``.
``update_in_place`` also helps.


Delete package request
^^^^^^^^^^^^^^^^^^^^^^

===========  ====================================  =============================

``POST``     **/api/v2/file/<UUID>/delete_aip/**   *Requests package deletion.*

===========  ====================================  =============================

Request body parameters (mandatory):

========================  ======================================================

``event_reason``          *Rationale for deleting the AIP.*

``pipeline``              *UUID of the pipeline the delete request is from.*

``user_id``               *User ID requesting the deletion. This is the ID
                          of the user on the pipeline, and must be an integer
                          greater than 0.*

``user_email``            *Email of the user requesting the deletion.*                          

========================  ======================================================


Example request::

  curl --location --request POST 'http://test.archivematica.net:8000/api/v2/file/2cd0575f-5e0b-4d2f-bd00-7e0b254e0802/delete_aip/' \
  --header 'Authorization: ApiKey test:ow7ioGh2reephua8uPaiWee4EiHeev2z' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "event_reason": "testing purposes",
      "pipeline": "a64e061a-5688-49b5-95c1-0b6885c40c04",
      "user_id": "1",
      "user_email": "demo@example.com"
  }'


Example response::

  {
      "message": "Delete request created successfully.",
      "id": 3
  }


Recover AIP request
^^^^^^^^^^^^^^^^^^^

===========  ====================================  =============================

``POST``     **/api/v2/file/<UUID>/recover_aip/**  *Requests package recovery.*

===========  ====================================  =============================

Request body parameters (mandatory):

========================  =====================================================

``event_reason``          *Rationale for recovering the AIP.*

``pipeline``              *URI of the pipeline the recovery request is from.*

``user_id``               *User ID requesting the recovery. This is the ID of
                          the user on the pipeline, and must be an integer
                          greater than 0.*

``user_email``            *Email of the user requesting the recovery.*

========================  =====================================================

Example request::

  curl --location --request POST 'http://test.archivematica.net:8000/api/v2/file/2cd0575f-5e0b-4d2f-bd00-7e0b254e0802/recover_aip/' \
  --header 'Authorization: ApiKey test:ow7ioGh2reephua8uPaiWee4EiHeev2z' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "event_reason": "testing purposes",
      "pipeline": "a64e061a-5688-49b5-95c1-0b6885c40c04",
      "user_id": "1",
      "user_email": "demo@example.com"
  }'


Example response::

  {
      "message": "Recover request created successfully.",
      "id": 4
  }

Download single file
^^^^^^^^^^^^^^^^^^^^

=============  =====================================  ==========================

``GET, HEAD``  **/api/v2/file/<UUID>/extract_file/**  *Checks if a package is
                                                      locally available and
                                                      returns a single file
                                                      from the package.*

=============  =====================================  ==========================

..  note::

    (Future improvement) HEAD and GET should not perform the same functions. 
    HEAD should be updated to not return the file, and to only check for existence.
    Currently, the storage service has no way to check if a file exists except 
    by downloading and extracting this AIP.

Response:

Returns a single file from the Package. If the package is compressed, it 
downloads the whole AIP and extracts it.

This responds to HEAD because AtoM uses HEAD to check for the existence of a file.

If the package is in Arkivum, the package may not actually be available. This 
endpoint checks if the package is locally available. If it is, it is returned as
normal. If not, it returns ``202`` and emails the administrator about the 
attempted access.


Download package
^^^^^^^^^^^^^^^^

=============  =================================  ==============================

``GET, HEAD``  **/api/v2/file/<UUID>/download/**  *Checks if a package is 
                                                  available and returns the 
                                                  entire package as a single 
                                                  file.*




               **/api/v2/file/<UUID>/download/
               <chunk number>/
               (for LOCKSS harvesting)** 

=============  =================================  ==============================

If the package is in Arkivum, the package may not actually be available. This 
endpoint checks if the package is locally available. If it is, it is returned as
normal. If not, it returns ``202`` and emails the administrator about the 
attempted access.


Get pointer file
^^^^^^^^^^^^^^^^

===========  =====================================  ============================

``GET``      **/api/v2/file/<UUID>/pointer_file/**  *Checks if a pointer file is
                                                    available and returns the
                                                    contents of the pointer file.*

===========  =====================================  ============================


Check fixity
^^^^^^^^^^^^

=======  ======================================  ===============================

``GET``  **//api/v2/file/<UUID>/check_fixity/**  *Performs a bag check and
                                                 updates the Storage Service 
                                                 database with the results 
                                                 of that check.*

=======  ======================================  ===============================


Query string parameters:

========================  ======================================================

``force_local``           *If true, download and run fixity on the AIP locally, 
                          instead of using the Space-provided fixity
                          if available.*

========================  ======================================================

Response definitions (JSON):

========================  ======================================================

``success``               `True` if the verification succeeded, `False` if the 
                          verification failed, `None` if the scan could not start.

``message``               Human-readable string explaining the report; it
                          will be empty for successful scans.

``failures``              List of 0 or more errors.

``timestamp``             ISO-formated string with the datetime of the last 
                          fixity check. If the check was performed by an 
                          external system, this will be provided by that system.
                          If not provided,or on error, it will be None.

========================  ======================================================

AIP storage callback request
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

=======  =================================================  ====================

``GET``  **/api/v2/file/<UUID>/send_callback/post_store/**  *Gets callbacks 
                                                            configured to run 
                                                            post-storage 
                                                            for given AIP.*

=======  =================================================  ====================

..  tip::

    In the Archivematica Storage Service versions 0.15 and above, this endpoint 
    has been extended to support callbacks for AIP, AIC and DIP stored events.

    * **Event:**  Post-store AIP, AIC, or DIP
    * **URI:**    https://scope.com/api/v1/dip/<package_uuid>/stored
    * **Method:** POST
    * **Headers:**
              * Authorization -> Token <token>
              * Origin -> https://ss.com
    * **Expected Status:**  202

..  note::

    When using this endpoint, AIPs must be locally stored for the API call
    to work properly currently.


Get file information for package
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

=======   =================================    =================================

``GET``   **/api/v2/file/<UUID>/contents/**    *Retrieves metadata on every file
                                               within a package.*

=======   =================================    =================================

Response definitions (JSON):

========================  ======================================================

``success``               True.

``package``               UUID of the package.

``files``                 List of dictionaries with file information.
                          Each dictionary has:

                          * source_id - UUID of the file to index.
                          * name - relative path of the file inside the package.
                          * source_package - UUID of the SIP this file is from.
                          * checksum - checksum of the file, or an empty string.
                          * accessionid - Accession number, or an empty string.
                          * origin - UUID of the Archivematica dashboard
                            this is from.

========================  ======================================================


Update file information for package
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

=======   =================================    ===================================

``PUT``   **/api/v2/file/<UUID>/contents/**    *Adds a set of files to a package.*

=======   =================================    ===================================

Response definitions (JSON):

========================  ======================================================

``relative_path``         Relative path of the file inside the package.

``fileuuid``              UUID of the file to index.

``accessionid``           Accession number, or an empty string.

``sipuuid``               UUID of the SIP this file is from.

``origin``                UUID of the Archivematica dashboard this is from.

========================  ======================================================


Delete file information for package
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

==========   =================================    ==============================

``DELETE``   **/api/v2/file/<UUID>/contents/**    *Removes all file records
                                                  associated with this package.*

==========   =================================    ==============================


Query file information on packages
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

=============   ==========================    ==================================

``GET, POST``   **/api/v2/file/metadata/**    *Access or write file information
                                              about the files.*

=============   ==========================    ==================================


Response definitions (JSON):

========================  ======================================================

``file``                  List of dictionaries with information about files that
                          match the query:

                          * accessionid - accession number, or an empty string.
                          * file_extension - file extension.
                          * filename - name of the file, sans path.
                          * relative_path -  relative path of the file inside 
                            the package.
                          * fileuuid - UUID of the file to index.
                          * sipuuid - UUID of the SIP this file is from.
                          * origin - UUID of the Archivematica dashboard this is
                            from.

========================  ======================================================


.. _ss-reingest-aip.rst:

Reingest AIP
^^^^^^^^^^^^

===========  =================================   ===============================

``POST``     **/api/v2/file/<UUID>/reingest/**   *Initiates an AIP reingest.*

===========  =================================   ===============================

Example request:

.. literalinclude:: _code/am-ss_reingest_aip.curl

Request body parameters (JSON):

======================  ========================================================

``pipeline``            UUID of the pipeline on which to reingest AIP.
               
``reingest_type``       One of `METADATA_ONLY` (metadata-only reingest), 
                        `OBJECTS` (partial reingest), `FULL` (full reingest).

``processing_config``   Optional. Name of the processing configuration to use
                        on full reingest.

======================  ========================================================

Example response:

.. literalinclude:: _code/reingest_aip_response.curl


Move package
^^^^^^^^^^^^

..  note::

    This endpoint was introduced in the Storage Service version 0.14.


===========     =============================    ===============================

``POST``        **/api/v2/file/<UUID>/move/**    *Relocates a package.*

===========     =============================    ===============================


Request body parameters (JSON):

======================  ========================================================

``location_uuid``       UUID of the location to send the package. The location 
                        must have the same Purpose as the package's current 
                        location (e.g. AIP Storage, DIP Storage).

======================  ========================================================

Example request::

  $ curl -d 'location_uuid=7c5c48d4-50db-4018-b4b1-7ed29d1ef9d3 ' -H"Authorization: ApiKey test:4525fd5272275caeac04a28447698c51" 'http://mysite.archivematica.org:8000/api/v2/file/8b8aa1a2-79c9-490e-b630-28f90bb7e654/move/'


SWORD endpoints
^^^^^^^^^^^^^^^

* URL:  ``/api/v2/file/<UUID>/sword/``
* URL:  ``/api/v2/file/<UUID>/sword/media/``
* URL:  ``/api/v2/file/<UUID>/sword/state/``
  
