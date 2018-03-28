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
   your AtoM Elasticsearch index. Your AtoM site is more likely to be a public-
   facing IP and therefore this is an important step.

To further enhance your Elasticsearch index's security make the following
changes in your Elasticsearch ``/etc/elasticsearch/elasticsearch.yml`` file:

.. code:: bash

   discovery.zen.ping.multicast.enabled: false
   script.disable_dynamic:true

Then, ``/etc/init.d/elasticsearch restart``.

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
credentials by editing these two files:

* ``/etc/archivematica/archivematicaCommon/dbsettings`` (change the ``user`` and
  ``password`` settings)

* ``/usr/share/archivematica/dashboard/settings/common.py`` (change the ``USER``
  and ``PASSWORD`` settings in the ``DATABASES`` section)

Archivematica does not presently support secured MySQL communication so MySQL
should be run locally or on a secure, isolated network. See :issue:`1645`.

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

.. _user-security:

User security
-------------

We added support for two authentication backends in Archivematica 1.7: LDAP and
Shibboleth. Authentication backends provide an extensible system for when a
``username`` and ``password`` stored with the user model need to be
authenticated against a different service than the default.

This feature relies on the `authentication infrastructure <django-auth-infra_>`_
provided by the Django web framework. Check out their docs for more details!

.. important::

   Please note that this is a new feature as of Archivematica 1.7 that has been
   minimally tested outside of the development environment. If you experience
   any problems with the feature, please consider creating a
   `GitHub issue <am-gh-issues_>`_ or creating a post in the
   `Archivematica Google Group <am-google-groups_>`_. The configuration
   mechanism has some rough edges so it is recommended for advanced users only.

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
   ``SS_SHIBBOLETH_AUTHENTICATION``. You can find more details about this
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

.. _ca-root-certificates:

CA certificates
===============

Archivematica uses a HTTP library called `Requests <requests_>`_. There are
`two main approaches <requests-cas_>`_ for dealing with the updates of the root
CAs sets:

Upgrade the ``certifi`` package frequently
++++++++++++++++++++++++++++++++++++++++++

There are three virtual environments where Requests is used: MCPClient,
Dashboard and Storage Service. This is how you can update ``certifi`` across
the three environments:

.. code:: bash

   $ sudo /usr/share/archivematica/virtualenvs/archivematica-dashboard/bin/pip install -U certifi
   $ sudo /usr/share/archivematica/virtualenvs/archivematica-mcp-client/bin/pip install -U certifi
   $ sudo /usr/share/archivematica/virtualenvs/archivematica-storage-service/bin/pip install -U certifi

The services need to be restarted after the update, for example if you are
using systemd:

.. code:: bash

   $ sudo systemctl restart archivematica-dashboard
   $ sudo systemctl restart archivematica-mcp-client
   $ sudo systemctl restart archivematica-storage-service

Use the environment string REQUEST_CA_BUNDLE
++++++++++++++++++++++++++++++++++++++++++++

Requests honours the environment string ``REQUEST_CA_BUNDLE`` so the
administrator can indicate a custom bundle which could be the system's CA
bundle.

- The Ubuntu system's CA bundle file is
  :file:`/etc/ssl/certs/ca-certificates.crt`.
- The CentOS system's CA bundle file is
  :file:`/etc/pki/tls/certs/ca-bundle.crt`.

On Ubuntu, add the following line to the :file:`/etc/default/archivematica-*`
files to use the system's CA bundle:

.. code::

   REQUEST_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt

On CentOS, add the following line to the :file:`/etc/default/archivematica-*`
files to use the system's CA bundle:

.. code::

   REQUEST_CA_BUNDLE=/etc/pki/tls/certs/ca-bundle.crt

Trusting additional CAs
+++++++++++++++++++++++

If you are using ``REQUEST_CA_BUNDLE`` you may want to trust additional CAs.

On CentOS:

- Copy the ``.crt`` file to ``/etc/pki/ca-trust/source/anchors`` on your
  CentOS machine.
- Run the `update-ca-trust extract` command.

The :file:`/etc/pki/tls/certs/ca-bundle.crt` file is a symbolic link that
refers to the consolidated output created by the ``update-ca-trust`` command.

On Ubuntu:

- Copy the .crt file to :file:`/usr/local/share/ca-certificates` on your Ubuntu
  machine.
- Run the `update-ca-certificates` command.

This will create a new :file:`/etc/ssl/certs/ca-certificates.crt` file.


:ref:`Back to the top <security>`

.. _django-auth-infra: https://docs.djangoproject.com/en/2.0/topics/auth/customizing/#authentication-backends
.. _am-gh-issues: https://github.com/artefactual/archivematica/issues
.. _am-google-groups: https://groups.google.com/forum/#!forum/archivematica
.. _am-dashboard-config: https://github.com/artefactual/archivematica/blob/stable/1.7.x/src/dashboard/install/README.md
.. _am-ldap-auth-mod: https://github.com/artefactual/archivematica/blob/stable/1.7.x/src/dashboard/src/settings/components/ldap_auth.py
.. _am-shib-auth-mod: https://github.com/artefactual/archivematica/blob/stable/1.7.x/src/dashboard/src/settings/components/shibboleth_auth.py
.. _ldap: https://en.wikipedia.org/wiki/Lightweight_Directory_Access_Protocol
.. _shibboleth: https://www.shibboleth.net/
.. _requests: http://docs.python-requests.org/
.. _requests-cas: http://docs.python-requests.org/en/master/user/advanced/#ca-certificates
