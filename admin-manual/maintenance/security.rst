.. _security:

========
Security
========

.. important::

  Once you've set up Archivematica it's a good practice, for the sake of security,
  to change the default passwords.

This page outlines various security settings and configurations in Archivematica.

.. _elasticsearch-security:

Elasticsearch access control
----------------------------

The only way to limit access to ElasticSearch, currently, is using your
server's firewall configuration. You'll likely want to configure your server's
firewall to limit access to ElasticSearch's TCP/IP port (9200). It is
recommended to only allow access by 127.0.0.1 (the server itself) and the IPs
of any other servers or workstations that should be able to access it.

.. important::

   If you are using AtoM as your access system, remember to perform this task on
   your AtoM Elasticsearch index. Your AtoM site is more likely to be a public-
   facing IP and therefore this is an important step.

To further enhance your Elasticsearch index's security make the following changes
in your Elasticsearch ``/etc/elasticsearch/elasticsearch.yml`` file:

.. code:: bash

   discovery.zen.ping.multicast.enabled: false
   script.disable_dynamic:true

Then, ``/etc/init.d/elasticsearch restart``.

.. _mysql-security:

MySQL
-----

You should create a new MySQL user or change the password of the default
"archivematica" MySQL user. The change the password of the default user, enter
the following into the command-line:

.. code:: bash

   $ mysql -u root -p<your MyQL root password> -D mysql \
      -e "SET PASSWORD FOR 'archivematica'@'localhost' = PASSWORD('<new password>'); \
      FLUSH PRIVILEGES;"

Once you've done this you can change Archivematica's MySQL database access
credentials by editing these two files:

* ``/etc/archivematica/archivematicaCommon/dbsettings`` (change the ``user`` and
   ``password`` settings)

*  ``/usr/share/archivematica/dashboard/settings/common.py`` (change the ``USER``
   and ``PASSWORD`` settings in the ``DATABASES`` section)

Archivematica does not presently support secured MySQL communication so MySQL
should be run locally or on a secure, isolated network. See issue
`1645 <https://projects.artefactual.com/issues/1645>`_.

.. _atom-security:

AtoM
----

In addition to changing the MySQL credentials, if you've also installed AtoM
you'll want to set the password for it as well. Note that after changing your
AtoM credentials you should update the credentials on the AtoM DIP upload
administration page as well.

.. _gearman-security:

Gearman
-------

Archivematica relies on the German server for queuing work that needs to be
done. Gearman currently doesn't support secured connections so Gearman should
be run locally or on a secure, isolated network. See issue
`1345 <https://projects.artefactual.com/issues/1345>`_.

:ref:`Back to the top <security>`





