.. _security:

========
Security
========

.. important::

   Once you've set up Archivematica it's a good practice, for the sake of
   security, to change the default passwords.

This page outlines various security settings and configurations in
Archivematica.

.. _elasticsearch-security:

Elasticsearch access control
----------------------------

The only way to limit access to Elasticsearch, currently, is using your
server's firewall configuration. You'll likely want to configure your server's
firewall to limit access to Elasticsearch's TCP/IP port (9200). It is
recommended to only allow access by 127.0.0.1 (the server itself) and the IPs
of any other servers or workstations that should be able to access it.

.. important::

   If you are using AtoM as your access system, remember to perform this task on
   your AtoM Elasticsearch index. Your AtoM site is more likely to be a
   public-facing IP and therefore this is an important step.

For more advanced Elasticsearch installations follow `their security
documentation <elasticsearch-security-external_>`_. The
``archivematica_src_elasticsearch_host`` configuration attribute accepts
RFC-1738 formatted URLs (e.g.: ``https://user:secret@host:443``).

.. _mysql-security:

MySQL
-----

You should create a new MySQL user or change the password of the default
``archivematica`` MySQL user. The change the password of the default user, enter
the following into the command-line:

.. code:: bash

   $ mysql -u root -p<your MyQL root password> -D mysql \
      -e "SET PASSWORD FOR 'archivematica'@'localhost' = PASSWORD('<new password>'); \
      FLUSH PRIVILEGES;"

Once you've done this you can change Archivematica's MySQL database access
credentials by editing your system files and changing the following values for
each of the following components.

The components can be found in different locations depending on the Operating
System.

For Ubuntu systems:

* /etc/default/archivematica-dashboard
* /etc/default/archivematica-mcp-client
* /etc/default/archivematica-mcp-server
* /etc/default/archivematica-storage-service

For Rocky Linux/Red Hat systems:

* /etc/sysconfig/archivematica-dashboard
* /etc/sysconfig/archivematica-mcp-client
* /etc/sysconfig/archivematica-mcp-server
* /etc/sysconfig/archivematica-storage-service

The variables are different depending on the component. These are the following
variables to change per component:

**Dashboard:**

* ARCHIVEMATICA_DASHBOARD_CLIENT_DATABASE
* ARCHIVEMATICA_DASHBOARD_CLIENT_HOST
* ARCHIVEMATICA_DASHBOARD_CLIENT_PASSWORD
* ARCHIVEMATICA_DASHBOARD_CLIENT_USER

**MCPClient:**

* ARCHIVEMATICA_MCPCLIENT_CLIENT_DATABASE
* ARCHIVEMATICA_MCPCLIENT_CLIENT_HOST
* ARCHIVEMATICA_MCPCLIENT_CLIENT_PASSWORD
* ARCHIVEMATICA_MCPCLIENT_CLIENT_USER

**MCPServer:**

* ARCHIVEMATICA_MCPSERVER_CLIENT_DATABASE
* ARCHIVEMATICA_MCPSERVER_CLIENT_HOST
* ARCHIVEMATICA_MCPSERVER_CLIENT_PASSWORD
* ARCHIVEMATICA_MCPSERVER_CLIENT_USER

**Storage Service when using sqlite3:**

* SS_DB_NAME
* SS_DB_HOST
* SS_DB_PASSWORD
* SS_DB_USER

**Storage Service when using MySQL:**

* SS_DB_URL

For Storage Service MySQL database see:
`Storage Service application-specific-environment-variables <ss-config_>`_.

.. _atom-security:

AtoM
----

In addition to changing the MySQL credentials, if you've also installed AtoM
you'll want to set the password for it as well. Note that after changing your
AtoM credentials you should update the credentials on the
:ref:`AtoM DIP upload administration page <admin-dashboard-atom>` as well.

.. _gearman-security:

Gearman
-------

Archivematica relies on the German server for queuing work that needs to be
done. Gearman currently doesn't support secured connections so Gearman should
be run locally or on a secure, isolated network. See :issue:`1345`.

.. _authentication-security:

Authentication backends
-----------------------

Archivematica supports multiple authentication backends: LDAP, Shibboleth, OIDC
and CAS. Authentication backends provide an extensible system for when a
``username`` and ``password`` stored with the user model need to be
authenticated against a different service than the default.

This feature relies on the `authentication infrastructure <django-auth-infra_>`_
provided by the Django web framework. Check out their docs for more details!

.. _ldap-setup:

LDAP setup
==========

`LDAP <ldap_>`_ is a directory service protocol used for, among other things,
authentication and authorization. This feature allows administrators to deploy
the Archivematica Dashboard Django application with LDAP authentication.

This functionality has not been made available yet in the Storage Service.

LDAP backend configuration
++++++++++++++++++++++++++

#. Enable the authentication backend using the environment variable
   ``ARCHIVEMATICA_DASHBOARD_DASHBOARD_LDAP_AUTHENTICATION``. You can find more
   details about this environment string in the
   `configuration document <am-dashboard-config_>`_.

#. Customize the ``ldap_auth.py`` settings module as needed. Open the file to
   find what are the existing environment variable lookups. You can inject the
   configuration via the environment string or changing the settings mode
   manually.

#. Restart the Archivematica Dashboard.

.. _shibboleth-setup:

Shibboleth setup
================

`Shibboleth <shibboleth_>`_ is a federated identity solution that provides
Single Sign-On authentication and authorization. This feature allows
administrators to deploy both the Archivematica Dashboard and Storage Service
Django applications with Shibboleth authentication.

Shibboleth backend configuration in Archivematica Dashboard
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#. Enable the authentication backend using the environment variable
   ``ARCHIVEMATICA_DASHBOARD_DASHBOARD_SHIBBOLETH_AUTHENTICATION``. You can find more details about this
   environment string in the `configuration document <am-dashboard-config_>`_.

#. Customize the ``shibboleth_auth.py`` settings module as needed.

#. Restart the Archivematica Dashboard.

Shibboleth backend configuration in Storage Service
+++++++++++++++++++++++++++++++++++++++++++++++++++

#. Enable the authentication backend using the environment variable
   ``SS_SHIBBOLETH_AUTHENTICATION``. Assign a string value ``true`` to enable
   it.

#. Customize the ``base.py`` settings module as needed.

#. Restart the Storage Service.

.. _oidc-setup:

OIDC setup
==========

`OIDC <oidc_>`_ (OpenID Connect) is an identity layer on top of OAuth 2.0, providing
identity verification, authentication and basic information about the end user. This
feature allows administrators to deploy both the Archivematica Dashboard and Storage
Service Django applications with OIDC authentication.

It is based on `mozilla-django-oidc <mozilla-django-oidc-docs_>`_. In addition
to the instructions below, please refer to their documentation for more
details.

.. important::

   The OIDC backend is an experimental feature that you can turn on to test
   (see instructions below). Please share your feedback!

OIDC backend configuration in Archivematica Dashboard
+++++++++++++++++++++++++++++++++++++++++++++++++++++

#. Enable the authentication backend using the environment variable
   ``ARCHIVEMATICA_DASHBOARD_DASHBOARD_OIDC_AUTHENTICATION``. You can find more
   details about this environment string in the
   `configuration document <am-dashboard-config_>`_.

#. Customize the ``oidc_auth.py`` settings module as needed.

#. Restart the Archivematica Dashboard.

OIDC backend configuration in Storage Service
+++++++++++++++++++++++++++++++++++++++++++++

#. Enable the authentication backend using the environment variable
   ``SS_OIDC_AUTHENTICATION``. Assign a string value ``true`` to enable
   it.

#. Customize the ``base.py`` settings module as needed.

#. Restart the Storage Service.

.. _cas-setup:

CAS setup
=========

`CAS <cas_>`_ (Central Authentication Service) is an enterprise multilingual
single sign-on solution to authentication for web applications. This feature
allows administrators to deploy both the Archivematica Dashboard and Storage
Service Django applications with CAS authentication.

CAS backend configuration in Archivematica Dashboard
++++++++++++++++++++++++++++++++++++++++++++++++++++

#. Enable the authentication backend using the environment variable
   `ARCHIVEMATICA_DASHBOARD_DASHBOARD_CAS_AUTHENTICATION`. You can find more
   details about this environment string in the
   `configuration document <am-dashboard-config_>`_.

#. Customize the ``cas_auth.py`` settings module as needed.

#. Restart the Archivematica Dashboard.

#. Apply the database migrations with:

   .. code:: bash

    sudo -u archivematica bash -c " \
        set -a -e -x
        source /etc/default/archivematica-dashboard || \
            source /etc/sysconfig/archivematica-dashboard \
                || (echo 'Environment file not found'; exit 1)
        cd /usr/share/archivematica/dashboard
        /usr/share/archivematica/virtualenvs/archivematica/bin/python \
            manage.py migrate \
    ";


CAS backend configuration in Storage Service
++++++++++++++++++++++++++++++++++++++++++++

#. Enable the authentication backend using the environment variable
   ``SS_CAS_AUTHENTICATION``. Assign a string value ``true`` to enable
   it.

#. Customize the ``base.py`` settings module as needed.

#. Restart the Storage Service.

#. Apply the database migrations with:

   .. code:: bash

    sudo -u archivematica bash -c " \
        set -a -e -x
        source /etc/default/archivematica-storage-service || \
            source /etc/sysconfig/archivematica-storage-service \
                || (echo 'Environment file not found'; exit 1)
        cd /usr/lib/archivematica/storage-service
        /usr/share/archivematica/virtualenvs/archivematica-storage-service/bin/python \
            manage.py migrate
    ";

.. _password-validation:

Password validation
-------------------

A strong password policy can be introduced by enabling the password validation
layer, which is available in both `Archivematica <am-dashboard-config_>`_ and
`Storage Service <ss-config_>`_.

Please follow the links above to know more about the different options
available. E.g. the minimum lenght of your user passwords can be adjusted with
``ARCHIVEMATICA_DASHBOARD_PASSWORD_MINIMUM_LENGTH`` and
``SS_AUTH_PASSWORD_MINIMUM_LENGTH`` depending on the component.

.. _cookie-session-security:

Cookie and session security
---------------------------

When using HTTPS, it is recommended to enable "secure" cookies as well as other
Django settings that provide additional security. See the `SSL/HTTPS
<django-https-settings_>`_ section on the Django documentation site for further
details.

Additionally, it is possible to adjust some Django settings related to `session
management <django-session-settings_>`_, such as their length or some other
attributes related to the session cookie, e.g. ``SESSION_COOKIE_SECURE`` marks
the session cookie as "secure".

.. important::

   The final Django settings module targeting production environments is
   ``production.py``. In our repositories, they can be found
   `here <am-prod-settings_>`_ and `here <ss-prod-settings_>`_. There is not
   current support for additional settings modules but it may be added in the
   future.

.. _csp-security:

Content Security Policy (CSP)
-----------------------------

`CSP <csp_>`_ (Content Security Policy) is an added layer of security
that helps to detect and mitigate certain types of attacks, including
Cross Site Scripting (XSS) and data injection attacks. This feature
allows administrators to deploy both the Archivematica Dashboard and
Storage Service Django applications with CSP headers.

It is based on the `django-csp <django-csp-docs_>`_ package. In
addition to the instructions below, please refer to their
documentation for more details.

.. important::

   The CSP support is an experimental feature that you can turn on to
   test (see instructions below). Please share your feedback!

CSP configuration in Archivematica Dashboard
============================================

#. Enable CSP support using the environment variable
   ``ARCHIVEMATICA_DASHBOARD_DASHBOARD_CSP_ENABLED``. You can find
   more details about this environment string in the `configuration
   document <am-dashboard-config_>`_.

#. A small set of header policies are loaded from the
   ``settings.components.csp`` module, but you can provide your own
   overrides through a Python module and set its path in the
   ``CSP_SETTINGS_FILE`` Django setting.

#. Restart the Archivematica Dashboard.

CSP backend configuration in Storage Service
============================================

#. Enable CSP support using the environment variable
   ``SS_CSP_ENABLED``. Assign a string value ``true`` to enable it.

#. A small set of header policies are loaded from the
   ``settings.components.csp`` module, but you can provide your own
   overrides through a Python module and set its path in the
   ``CSP_SETTINGS_FILE`` Django setting.

#. Restart the Storage Service.

.. _ca-root-certificates:

CA certificates
---------------

Archivematica uses a HTTP library called `Requests <requests_>`_. There are
`two main approaches <requests-cas_>`_ for dealing with the updates of the root
CAs sets:

Upgrade the ``certifi`` package frequently
==========================================

This is how you can update ``certifi`` inside the virtual environment:

.. code:: bash

   $ sudo /usr/share/archivematica/virtualenvs/archivematica/bin/pip install -U certifi

The services need to be restarted after the update, for example if you are
using systemd:

.. code:: bash

   $ sudo systemctl restart archivematica-dashboard
   $ sudo systemctl restart archivematica-mcp-client
   $ sudo systemctl restart archivematica-storage-service

Use the environment string REQUESTS_CA_BUNDLE
=============================================

Requests honours the environment string ``REQUESTS_CA_BUNDLE`` so the
administrator can indicate a custom bundle which could be the system's CA
bundle.

- The Ubuntu system's CA bundle file is
  :file:`/etc/ssl/certs/ca-certificates.crt`.
- The Rocky Linux system's CA bundle file is
  :file:`/etc/pki/tls/certs/ca-bundle.crt`.

On Ubuntu, add the following line to the :file:`/etc/default/archivematica-*`
files to use the system's CA bundle:

.. code:: bash

   REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

On Rocky Linux, add the following line to the :file:`/etc/default/archivematica-*`
files to use the system's CA bundle:

.. code:: bash

   REQUESTS_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt

Trusting additional CAs
+++++++++++++++++++++++

If you are using ``REQUESTS_CA_BUNDLE`` you may want to trust additional CAs.

On Rocky Linux:

- Copy the ``.crt`` file to ``/etc/pki/ca-trust/source/anchors`` on your
  Rocky Linux machine.
- Run the `update-ca-trust extract` command.

The :file:`/etc/pki/tls/certs/ca-bundle.crt` file is a symbolic link that
refers to the consolidated output created by the ``update-ca-trust`` command.

On Ubuntu:

- Copy the .crt file to :file:`/usr/local/share/ca-certificates` on your Ubuntu
  machine.
- Run the `update-ca-certificates` command.

This will create a new :file:`/etc/ssl/certs/ca-certificates.crt` file.


:ref:`Back to the top <security>`

.. _django-auth-infra: https://docs.djangoproject.com/en/3.2/topics/auth/customizing/#authentication-backends
.. _am-gh-issues: https://github.com/artefactual/archivematica/issues
.. _am-google-groups: https://groups.google.com/forum/#!forum/archivematica
.. _am-dashboard-config: https://github.com/artefactual/archivematica/blob/stable/1.16.x/src/dashboard/install/README.md
.. _am-ldap-auth-mod: https://github.com/artefactual/archivematica/blob/stable/1.16.x/src/dashboard/src/settings/components/ldap_auth.py
.. _am-shib-auth-mod: https://github.com/artefactual/archivematica/blob/stable/1.16.x/src/dashboard/src/settings/components/shibboleth_auth.py
.. _ldap: https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol
.. _shibboleth: https://www.shibboleth.net/
.. _oidc: https://openid.net/connect/
.. _cas: https://www.apereo.org/projects/cas
.. _csp: https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP
.. _requests: https://requests.readthedocs.io/en/master/
.. _requests-cas: https://requests.readthedocs.io/en/master/user/advanced/#ca-certificates
.. _elasticsearch-security-external: https://www.elastic.co/guide/en/x-pack/current/elasticsearch-security.html
.. _ss-config: https://github.com/artefactual/archivematica-storage-service/blob/stable/0.22.x/install/README.md
.. _mozilla-django-oidc-docs: https://mozilla-django-oidc.readthedocs.io/en/stable/
.. _django-csp-docs: https://django-csp.readthedocs.io/en/latest/
.. _django-https-settings: https://docs.djangoproject.com/en/3.2/topics/security/#ssl-https
.. _django-session-settings: https://docs.djangoproject.com/en/3.2/topics/http/sessions/#settings
.. _am-prod-settings: https://github.com/artefactual/archivematica/blob/stable/1.16.x/src/dashboard/src/settings/production.py
.. _ss-prod-settings: https://github.com/artefactual/archivematica-storage-service/blob/stable/0.22.x/storage_service/storage_service/settings/production.py
