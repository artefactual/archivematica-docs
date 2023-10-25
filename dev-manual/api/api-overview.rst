.. _api-overview:

=============
API overview
=============

Archivematica exposes services and resources with the following REST-style APIs:

* :ref:`archivematica-api-intro`
* :ref:`storage-service-api-intro`

The Archivematica and Storage service APIs are designed to help you create
custom solutions.

.. _archivematica-api-intro:

Archivematica API
-----------------

The Archivematica API enables the following:

* Coverage of some basic workflow functionality (e.g. listing and approving
  workflow tasks awaiting decision).
* Proxy support to the Storage Service.
* Exposing unit status or processing configuration details.

Archivematica API endpoints require authentication. See
:ref:`Authentication <api-overview-auth>` for additional information.

See :ref:`api-reference-archivematica` for information on Archivematica API
endpoints.

.. _storage-service-api-intro:

Storage Service API
-------------------

If your system configuration includes the Archivematica Storage Service, then
you may find the Storage Service API helpful for retrieving information about
the following resources:

* Pipeline
* Space
* Location

Storage Service API endpoints require authentication. See
:ref:`Authentication <api-overview-auth>` for additional information.

See :ref:`api-reference-storage-service` for information on Storage Service API
endpoints.

.. _api-overview-auth:

Authentication
^^^^^^^^^^^^^^

All calls to the API endpoints require authentication with username and API key.

Archivematica's Dashboard provides a simple cookie-based user authentication
system using the Django authentication framework. Only authenticated users have
access to the data.

Both the Archivematica API and Storage Service API use GET parameters by default
to give access to authenticated users.

When setting GET parameters, the format is::

    ?username=<username>&api_key=<api_key>

When passing an API key value as part of the header, the format is::

    Authorization: ApiKey <username>:<api_key>

The Transport Layer Security (TLS) protocol should be enabled in the web server
(typically Nginx) to ensure that all data transmitted between clients and the
server is encrypted with secure algorithms and not viewable by third parties.

Generating an API key for a user
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

API keys are associated with user accounts, which you can manage in the
Dashboard Administration tab. Archivematica users fall into two categories:
administrators and non-administrators. :ref:`admin-dashboard-users` who are
administrators can create and edit user accounts. Administrators can also
generate an API key for any user account in the database.

To generate an API key for an existing user in Archivematica:

1. Navigate to **Admin > Users** to access the Users page.
2. Select the username of the user for whom you want to generate an API key.
3. Click on the **Regenerate API key** box.
4. Click **Save**.
5. Access the new API key on the user's profile by clicking on their username.

.. note::
   In the Storage Service, an API key is automatically generated for each new
   user. If you change the password for a given user, then a new API key will be
   randomly generated for that user.

Using an API key in a request
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

An API key value must be passed with each request to the API endpoints, or no
response will be returned. Below is an example of using
`cURL <https://curl.haxx.se/>`_ to submit the requests with the API key in the
header.

*Example request* (using curl)::

    curl -X GET \
    https://sandbox.archivematica.org/api/transfer/completed/ \
    -H 'Authorization: ApiKey admin:90e458ded261c7a5'

*Example request header*::

    GET /api/transfer/completed/? HTTP/1.1
    Host: sandbox.archivematica.org
    Authorization: ApiKey admin:90e458ded261c7a5

*Example response header*::

    HTTP/1.1 200
    status: 200
    Server: nginx
    Date: Fri, 19 Jul 2019 02:26:54 GMT
    Content-Type: application/json
    Transfer-Encoding: chunked
    Connection: keep-alive
    Vary: Accept-Language, Cookie
    Content-Language: en
