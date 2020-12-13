.. _am-api-overview:

=============
API overview
=============

Archivematica exposes services and resources with the following REST-style APIs that were built using Tastypie, a webservice API framework for Django:

    * :ref:`AM-API-intro`
    * :ref:`SS-API-intro`

The Archivematica and Storage service APIs are designed to help you create custom solutions or integrate with RESTful APIs. 

.. _AM-API-intro:
      
Archivematica API
==================

The Archivematica API enables the following:

 * Coverage of some basic workflow functionality (e.g. listing and approving workflow tasks awaiting decision).
 * Proxy support to the Storage Service.
 * Exposing unit status or processing configuration details.
   
See :ref:`am-api-reference.rst` for information on Archivematica API endpoints.

.. _SS-API-intro:

Storage Service API
====================

If your system configuration includes the Archivematica Storage Service, then you may find the Storage Service API helpful for retrieving information about the following resources:

    * Pipeline
    * Space
    * Location

Storage Service API endpoints require authentication with a username and API key. See :ref:`Authentication<api-overview-auth>` for additional information.

===============
Using the APIs
===============

All calls to the API endpoints require authentication with username and API key. These can be submitted as GET parameters (e.g. ``?username=demo&api_key=e6282adabed84e39ffe451f8bf6ff1a67c1fc9f2``) or in the  header (e.g. ``Authorization: ApiKey demo:e6282adabed84e39ffe451f8bf6ff1a67c1fc9f2``).

There are a number of API endpoints in the Archivematica Dashboard, some of which are proxies to the Storage Service. For resource and endpoint descriptions, consult the :ref:`am-api-reference.rst` section.

.. _api-overview-auth:

Authentication
===============

Archivematica's Dashboard provides a simple cookie-based user authentication system using the Django authentication framework. Only authenticated users have access to the data.

Both the Archivematica API and Storage Service API use GET parameters by default to give access to authenticated users.

When setting GET parameters, the format is::

    ?username=<username>&api_key=<api_key>

If you do not want to pass unencrypted user data via the request header, you can pass an API key value as part of the header with each request.

When passing an API key value as part of the header, the format is::

    ApiKey <username>:<api_key>

Generating an API key for a user
=================================

API keys are associated with user accounts, which you can manage in the Dashboard Administration tab. Archivematica users fall into two categories-- administrators and non-administrators. :ref:`admin-dashboard-users` who are administrators can create and edit user accounts. Administrators can also generate an API key for any user account in the database. 

To generate an API key for an existing user in Archivematica:

    1. Navigate to **Admin > Users**, and then you will be redirected to the Users page.

    2. Select the user for whom you would like to generate an API key, and click their username or the **Edit** button. Archivematica will load the user’s Profile page.

    3. Click to enable the **Regenerate API key** box.

    4. Then click **Save**.
   
    5. In the **Users** page, click the username again to return to that user's profile, and then you will see the regenerated API key.   

.. NOTE::
   In the Storage Service, an API key is automatically generated for each new user. If you change the password for a given user, then a new API key will be randomly generated for that user.

Using an API key in a request
==============================

An API key value must be passed with each request to the API endpoints, or no response will be returned. Below is an example of using `curl <https://curl.haxx.se/>`_ to submit the requests with the API key in the header.

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
