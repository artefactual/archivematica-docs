.. _admin-maintenance:

===========
Maintenance
===========

This page contains information relevant to maintaining your Archivematica
installation.

*On this page:*

* :ref:`Management commands <management-commands>`

* :ref:`Maintaining Elasticsearch <elasticsearch>`

  * :ref:`Rebuild Elasticsearch indexes <elasticsearch-indexes>`
  * :ref:`External Elasticsearch access <elasticsearch-external>`

* :ref:`Data backup <data-backup>`

* :ref:`FAQ <admin-faq>`

  * :ref:`How to clean up a full disk <disk-full>`
  * :ref:`How to restart services <restart-services>`
  * :ref:`Error stack trace <stack-trace>`
  * :ref:`Transfer won't start <transfer-wont-start>`
  * :ref:`How to clear user sessions <clear-user-sessions>`
  * :ref:`How to clear the application database <clear-app-db>`


.. _management-commands:

Management commands
-------------------

Archivematica implements multiple management commands using the command
interface provided by the Django web framework.

A full list of commands can be retrieved as follows:

.. code:: bash

   sudo -u archivematica bash -c " \
       set -a -e -x
       source /etc/default/archivematica-dashboard || \
           source /etc/sysconfig/archivematica-dashboard \
               || (echo 'Environment file not found'; exit 1)
       cd /usr/share/archivematica/dashboard
       /usr/share/archivematica/virtualenvs/archivematica/bin/python \
           manage.py help
   ";

If you want to see the help message of a specific command, try:

.. code:: bash

   sudo -u archivematica bash -c " \
       set -a -e -x
       source /etc/default/archivematica-dashboard || \
           source /etc/sysconfig/archivematica-dashboard \
               || (echo 'Environment file not found'; exit 1)
       cd /usr/share/archivematica/dashboard
       /usr/share/archivematica/virtualenvs/archivematica/bin/python \
           manage.py help purge_transient_processing_data
   ";

We've looked up ``purge_transient_processing_data`` in the example above. The
description should provide enough information and, in some cases, usage
examples.

Finally, we're showing an example on how to execute a command passing some
optional arguments:

.. code:: bash

   sudo -u archivematica bash -c " \
       set -a -e -x
       source /etc/default/archivematica-dashboard || \
           source /etc/sysconfig/archivematica-dashboard \
               || (echo 'Environment file not found'; exit 1)
       cd /usr/share/archivematica/dashboard
       /usr/share/archivematica/virtualenvs/archivematica/bin/python \
           manage.py purge_transient_processing_data --dry-run
   ";


.. _elasticsearch:

Maintaining Elasticsearch
-------------------------

Since version 0.9, Archivematica uses Elasticsearch as its search engine. Elasticsearch
stores information about AIPs and Transfers in backlog. This data can be
searched from the Archival Storage and the Backlog tabs on the Archivematica dashboard.

.. note::
   As of Archivematica 1.7, this feature can be :ref:`fully or partially
   disabled <install-elasticsearch>`.

.. seealso::

  `Elasticsearch troubleshooting`_ help from AtoM documentation.

.. _elasticsearch-indexes:

Rebuild the indexes
^^^^^^^^^^^^^^^^^^^

Archivematica includes three Django commands to regenerate the Elasticsearch
indexes.

.. _aip-indexes-filesystem:

**Rebuild AIP indexes using filesystem**

To recreate the AIP indexes from the filesystem you require access to the
location paths of the AIP and Transfer Backlog storage locations. These
usually are located in the following paths:

* :file:`/var/archivematica/sharedDirectory/www/AIPsStore`
* :file:`/var/archivematica/sharedDirectory/www/AIPsStore/transferBacklog`

You should confirm the paths of your installation in the Locations tab of the
Storage Service.

To recreate AIP indexes from the filesystem, run the following command, passing
the path of the AIP storage location you confirmed above.

.. note::
   Please note, the execution of this command may take a long time for big
   AIP storage locations, especially if the AIPs are stored compressed.

.. code:: bash

   sudo -u archivematica bash -c " \
       set -a -e -x
       source /etc/default/archivematica-dashboard || \
           source /etc/sysconfig/archivematica-dashboard \
               || (echo 'Environment file not found'; exit 1)
       cd /usr/share/archivematica/dashboard
       /usr/share/archivematica/virtualenvs/archivematica/bin/python \
           manage.py rebuild_elasticsearch_aip_index_from_files \
               /var/archivematica/sharedDirectory/www/AIPsStoree --delete-all
   ";

The command accepts the following parameters:

* ``[storage_location_path]`` **[REQUIRED]**: Path where the AIP storage location
  is located in the local filesystem.
* ``--delete-all``: Removes the entire indexes to regenerate the mapping and
  settings.
* ``--delete``: Removes matching AIP documents to avoid duplicates but keeps the
  index mappings and settings.
* ``--uuid`` [aip_uuid]: Index a single AIP from the storage location.

It can be executed multiple times with different paths to index multiple AIP
storage locations.

.. _aip-indexes-api:

**Rebuild AIP indexes using Storage Service API**

This command uses the Storage Service API to determine which stored AIPs and
AICs need to be reindexed (based on status and origin pipeline), and then
reindexes those AIPs and AICs from temporarily downloaded copies of their
METS files. This approach enables reindexing of AIPs/AICs stored in encrypted
and some remote storage locations. However, this command must be run on the
same system that Archivematica is installed on, since it uses code from the
Archivematica codebase.

By default, the script will reindex every AIP and AIC in the Storage Service
that has an origin pipeline that matches where the script is run from, and a
status other than "DELETED".

.. code:: bash

    sudo -u archivematica bash -c " \
        set -a -e -x
        source /etc/default/archivematica-dashboard || \
            source /etc/sysconfig/archivematica-dashboard \
                || (echo 'Environment file not found'; exit 1)
        cd /usr/share/archivematica/dashboard
        /usr/share/archivematica/virtualenvs/archivematica/bin/python \
            manage.py rebuild_aip_index_from_storage_service --delete-all
    ";

The command accepts the following parameters:

* ``--pipeline`` may be passed optionally to reindex packages from a different
  pipeline than the current dashboard.
* ``-u`` or ``--uuid`` may be passed optionally to only reindex the AIP that has
  the matching UUID.
* ``--delete`` will delete any data found in Elasticsearch with a matching
  UUID before re-indexing. This is useful if only some AIPs are missing from
  the index, since AIPs that already exist will not have their information
  duplicated.
* ``--delete-all`` will delete the entire AIP Elasticsearch index before
  starting. This is useful if there are AIPs indexed that have been deleted,
  or if you would like to delete the 'aips' and 'aipfiles' indices entirely
  and recreate them using the most recent version of the Elasticsearch
  mappings.

.. _transfer-indexes:

**Rebuild Transfer indexes**

To regenerate the Transfers indexes, apart from access to the storage location,
the command checks the transfer and transfer files existence in the Dashboard
database. The indexes will be fully recreated with the current settings and
mappings and populated with the Transfers from the location. Execution example:

.. note::
   Please note, the execution of this command may take a long time for big
   Transfer Backlog storage locations.

.. code:: bash

   sudo -u archivematica bash -c " \
       set -a -e -x
       source /etc/default/archivematica-dashboard || \
           source /etc/sysconfig/archivematica-dashboard \
               || (echo 'Environment file not found'; exit 1)
       cd /usr/share/archivematica/dashboard
       /usr/share/archivematica/virtualenvs/archivematica/bin/python \
           manage.py rebuild_transfer_backlog
   ";

The command accepts the following parameters:

* ``--transfer-backlog-dir`` [storage_location_path]: Path where the Transfer
  Backlog storage location is located in the local filesystem. *Default:*
  `/var/archivematica/sharedDirectory/www/AIPsStore/transferBacklog`.
* ``--no-prompt``: Do not ask for confirmation.
* ``--from-storage-service``: Uses the Storage Service API to determine which
  stored transfers need to be re-indexed. Temporarily downloads a copy of each
  transfer via the API for indexing. This enables reindexing of packages stored
  in encrypted locations as well as some remote locations.

.. _elasticsearch-external:

External access
^^^^^^^^^^^^^^^

For further interactions with the Elasticsearch indexes, to browse the data or
to create visualizations, the following tools are recommended:

* `Kibana`_
* `Dejavu`_

The index names are: `aips`, `aipfiles`, `transfers` and `transferfiles`.

.. _data-backup:

Data backup
-----------

By default, there are three types of data that should be backed up:

* Filesystem (particularly your storage directories)

* MySQL and SQLite

* Elasticsearch

In addition to the filesystem, below are some detailed instructions of what to
back up, where it exists, and how to do it.

Data to back up from an Archivematica instance:

#. MCP database (see below for details)
#. SS database (see below for details)
#. Elasticsearch indexes (see below for details)
#. Pointer files (in the Storage Service internal processing location; the
   default location is ``/var/archivematica/storage_service``)
#. AM config in ``/etc/archivematica``
#. Processing configurations (in
   ``/var/archivematica/sharedDirectory/sharedMicroServiceTasksConfigs/processingMCPConfigs``)


If doing an update or migration of Archivematica to a new server, the following
may also be important to back up:

#. Archivematica source code (``/opt/archivematica``) (to know which version of
   the software was installed, if there were custom changes, etc.)
#. Archivematica shared directory (``/var/archivematica/sharedDirectory/``)

If your instance uses automation-tools, that should also be backed up:

#. Source code (``/opt/archivematica/automation-tools``)
#. Scripts (normally in ``/etc/archivematica/automation-tools``)
#. Crontab entries for automation-tools
#. Automation database (normally in ``/var/archivematica/automation-tools/``)
#. Any other helper scripts source and databases


Archivematica Database backup and restore
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

MySQL is used to store short-term processing data. You can back up the MySQL
database by using the following command:

.. code:: bash

   mysqldump -u <your username> -p<your password> -c MCP > <filename of backup>


To restore from ``mysqldump`` file:

.. code:: bash

   mysql -u <your username> -p<your password> MCP < MCP_backup.sql

Storage Service Database backup and restore
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To backup the SQLite database and pointer files created by the storage service run:

.. code:: bash

  rsync -av /var/archivematica/storage_service /backup/location/storage_service
  rsync -av /var/archivematica/storage-service/storage.db /backup/location/storage.db

.. note::

  The Storage Service must not be actively in use. Make sure the
  Storage Service is not running by stopping the ``nginx`` or ``storage-service``
  services or by making the backup at a time that it is not in use.

To restore Storage Service from backup:

.. code:: bash

  service archivematica-storage-service stop
  rsync -av /backup/location/storage.db /var/archivematica/storage-service/storage.db
  rsync -av /backup/location/storage_service /var/archivematica/storage_service
  service archivematica-storage-service start

Elasticsearch
^^^^^^^^^^^^^

Elasticsearch is used to store long-term data. Instructions and scripts for
backing up and restoring Elasticsearch are available in the
`Elasticsearch documentation`_.

**Preconfiguration**

The path.repo and snapshot repository have to be configured. For example, using
``/var/lib/elasticsearch/backup-repo`` as the repo path:

.. code:: bash

  mkdir /var/lib/elasticsearch/backup-repo
  chmod 0755 /var/lib/elasticsearch/backup-repo
  chown elasticsearch:elasticsearch /var/lib/elasticsearch/backup-repo

Add this line to the ``/etc/elasticsearch/elasticsearch.yml`` file:

.. code:: bash

  path.repo: /var/lib/elasticsearch/backup-repo

Restart elasticsearch:

.. code:: bash

  service elasticsearch restart

To use a new directory as snapshot repository, create and adjust permissions for one, like so:

.. code:: bash

  mkdir /var/lib/elasticsearch/backup-repo/es_backup_YOUR-NAME
  chmod 0755 /var/lib/elasticsearch/backup-repo/es_backup_YOUR-NAME
  chown elasticsearch:elasticsearch /var/lib/elasticsearch/backup-repo/es_backup_YOUR-NAME

Before any snapshot or restore operation can be performed, a snapshot repository
should be registered in Elasticsearch. The repository settings are
repository-type specific:

.. code:: bash

  curl -XPUT -H 'Content-Type: application/json' 'http://localhost:9200/_snapshot/es_backup_YOUR-NAME' -d '{
      "type": "fs",
      "settings": {
          "compress" : true,
          "location": "/var/lib/elasticsearch/backup-repo/es_backup_YOUR-NAME"
      }
  }'

**Backing up Elasticsearch indexes**

To make a backup (snapshot) for the ``aips``, ``aipfiles``, ``transfer`` and
``transferfiles`` indexes, a different name has to be used every time a snapshot
is taken. For example, using the date inside the filename:

.. code:: bash

  curl -XPUT -H 'Content-Type: application/json' 'http://localhost:9200/_snapshot/es_backup_YOUR-NAME/%3Csnapshot-am-%7Bnow%2Fd%7D%3E?wait_for_completion=true' -d'
  {
    "indices": "aips,aipfiles,transfers,transferfiles",
    "ignore_unavailable": true,
    "include_global_state": false
  }'

The snapshot will be saved to the
``/var/lib/elasticsearch/backup-repo/es_backup_YOUR-NAME`` directory. This
directory can be backed up, for example, using rsync:

.. code:: bash

  rsync -av /var/lib/elasticsearch/backup-repo/es_backup_YOUR-NAME /backup/location/elasticsearch

To list all the snapshots:

.. code:: bash

  curl -XGET 'http://localhost:9200/_snapshot/es_backup_YOUR-NAME/_all?pretty=true'

To delete a snapshot:

.. code:: bash

  curl -XDELETE 'http://localhost:9200/_snapshot/es_backup_YOUR-NAME/snapshot-am-YYYY.MM.DD'

**Restoring Elasticsearch**

Before restoring, the snapshot repo has to be registered in elasticsearch (see
preconfiguration). It can be restored in a different server, configuring the
repo.path, registering the snapshot repo (different paths and repo names can be
used) and copying the files inside the ``/backup/location/elasticsearch``
directory.

The index will have to be closed before restoration can occur. To close the
index, post to the following _close endpoints, like so:

.. code:: bash

  curl -XPOST -H 'Content-Type: application/json' 'http://localhost:9200/aips,aipfiles,transfers,transferfiles/_close' -d'
  {
    "ignore_unavailable": true
  }'

To restore ElasticSearch:

.. code:: bash

  curl -XPOST 'http://localhost:9200/_snapshot/es_backup_YOUR-NAME/snapshot-am-YYYY.MM.DD/_restore'


.. _admin-faq:

FAQ
---

.. _disk-full:

How to clean up a full disk
^^^^^^^^^^^^^^^^^^^^^^^^^^^
    "My Archivematica disk filled up and now Archivematica won't work. How can I
    fix this?"

Archivematica servers have as much storage as they have been commissioned. If
processing lots of very large files, particularly if working with normalization,
this will cause the disk to fill up and cause the system to malfunction.

When the disk on an Archivematica instance is full, a number of steps need to be
taken to recover.

**Recovery protocol**

#. Clean up the disk by removing failed or rejected transfers, any excessive
   ``/tmp`` data, or anything else causing the disk to have filled up.
#. Reset MySQL (or MariaDB, on CentOS) database.
#. Reset Archivematica components in appropriate order (see `restart-services`_
   for details).
#. Set Elasticsearch back into write mode. The easiest way to do this is to run
   the following command:

.. code:: bash

    curl -XPUT -H 'Content-Type: application/json' 'http://localhost:9200/_all/_settings' -d '{"index.blocks.read_only_allow_delete":null}'


.. _restart-services:

How to restart services
^^^^^^^^^^^^^^^^^^^^^^^
    "Something is not working right, or I need to stop a hanging transfer. What
    can I do?"

Archivematica is made up of these four core components:

.. code:: bash

    archivematica-mcp-server
    archivematica-mcp-client
    archivematica-dashboard
    archivematica-storage-service

Other services that Archivematica depends on are:
  * ClamAV
  * ElasticSearch
  * Gearman
  * MySQL (Ubuntu) or MariaDB (CentOS)
  * Nailgun
  * Nginx

Each service can be started/stopped/restarted with:

.. code:: bash

    service <name> start|stop|status|restart

To restart all services, restart the Gearman service and each Archivematica
component, in this order:

.. code:: bash

    service gearmand restart
    service archivematica-mcp-server restart
    service archivematica-mcp-client restart
    service archivematica-dashboard restart
    service archivematica-storage-service restart

.. note::

  Depending on your installation, gearmand might be called gearman-job-server.


.. _stack-trace:

Error stack trace
^^^^^^^^^^^^^^^^^

   "I am getting a white error page in the Dashboard. How can I find out what
   the error is?"

All Archivematica services, including the Dashboard, have set up loggers that
capture relevant events including warnings or errors.

Archivematica logs are stored in ``/var/log/archivematica/`` but the final
location may change depending on the environment or the logging configuration.


.. _transfer-wont-start:

Transfer won't start
^^^^^^^^^^^^^^^^^^^^
    "I try to create a new transfer, but nothing happens. What can I do?"

Sometimes a user may attempt to start a transfer and it will never seem to
initiate the Archivematica processes. There are a few issues to look out for
and investigate if this happens.

1. File permissions

   First, the issue may be related to file permissions in the transfer source
   directory. Check the permissions in the directory and on the files to ensure
   that all files can be read by Archivematica.

2. System timeouts

   If it is a large transfer, it may just be taking a long time to copy the files
   and initially load them into the system, and the user can wait a bit longer
   and see if the processes begin after a bit of time. It is also possible that
   it is taking a long time because some of the system timeouts are being
   exceeded and the transfer has failed. This can be verified by checking the
   Storage Service logs and by checking where the transfer exists on the
   filesystem.

   For inadequate timeouts, check the Storage Service configuration and adjust
   if necessary.

3. Communication between Dashboard and Gearman

   If the transfer has successfully moved to the shared Directory (i.e. it can be
   found in ``sharedDirectory/watchedDirectories/activeTransfer/`` folders), but
   is still not showing up in the dashboard, there could have been a problem with
   the communication between the dashboard and Gearman. Restarting all of the
   services can resolve this problem and the transfer will appear.

   Restart services in the follow order: ``gearmand``,
   ``archivematica-mcp-server``, ``archivematica-mcp-client``, and
   ``archivematica-dashboard``.

   Note that on some installations, ``gearmand`` may be called
   ``gearman-job-server``.

.. _clear-user-sessions:

How to clear user sessions
^^^^^^^^^^^^^^^^^^^^^^^^^^

Administrators should use the Django ``clearsessions`` command to purge expired
sessions perodically, e.g. via a cron job. This is how it is executed:

.. code:: bash

   sudo -u archivematica bash -c " \
       set -a -e -x
       source /etc/default/archivematica-dashboard || \
           source /etc/sysconfig/archivematica-dashboard \
               || (echo 'Environment file not found'; exit 1)
       cd /usr/share/archivematica/dashboard
       /usr/share/archivematica/virtualenvs/archivematica/bin/python \
           manage.py clearsessions \
   ";

When using CAS authentication, it is additionally recommended to clear expired
CAS sessions with ``./manage.py django_cas_ng_clean_sessions`` immediately
after running ``clearsessions``. This is how it is executed:

.. code:: bash

   sudo -u archivematica bash -c " \
       set -a -e -x
       source /etc/default/archivematica-dashboard || \
           source /etc/sysconfig/archivematica-dashboard \
               || (echo 'Environment file not found'; exit 1)
       cd /usr/share/archivematica/dashboard
       /usr/share/archivematica/virtualenvs/archivematica/bin/python \
           manage.py django_cas_ng_clean_sessions \
   ";

You can also clear active sessions by emptying the ``django_session`` table in
the Archivematica database, e.g.::

    mysql -hHOSTNAME -uUSERNAME -e "DELETE FROM MCP.django_session"

Clearing up active sessions forcibly logs out all users.


.. _clear-app-db:

How to clear the application database
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Archivematica 1.13 introduces a new management command for this specific
purpose. It takes into account active packages and can be used to target
packages of a certain age only. Please read the help message of the command for
more details.

.. code:: bash

   sudo -u archivematica bash -c " \
       set -a -e -x
       source /etc/default/archivematica-dashboard || \
           source /etc/sysconfig/archivematica-dashboard \
               || (echo 'Environment file not found'; exit 1)
       cd /usr/share/archivematica/dashboard
       /usr/share/archivematica/virtualenvs/archivematica/bin/python \
           manage.py help purge_transient_processing_data
   ";

The example below will destroy all records from the database as well as the
search documents related to packages that completed more than six hours ago:

.. code:: bash

   sudo -u archivematica bash -c " \
       set -a -e -x
       source /etc/default/archivematica-dashboard || \
           source /etc/sysconfig/archivematica-dashboard \
               || (echo 'Environment file not found'; exit 1)
       cd /usr/share/archivematica/dashboard
       /usr/share/archivematica/virtualenvs/archivematica/bin/python \
           manage.py purge_transient_processing_data --age='0 00:06:00'
   ";


:ref:`Back to the top <maintenance>`

.. _`Elasticsearch documentation`: https://www.elastic.co/guide/en/elasticsearch/reference/6.8/modules-snapshots.html
.. _`Elasticsearch troubleshooting`: https://www.accesstomemory.org/docs/latest/admin-manual/maintenance/elasticsearch/#maintenance-elasticsearch
.. _`Kibana`: https://www.elastic.co/kibana
.. _`Dejavu`: https://github.com/appbaseio/dejavu
.. _`remove transfers or SIPs`: https://www.archivematica.org/en/docs/latest/user-manual/transfer/transfer/#cleaning-up-the-transfer-dashboard
.. _`archivematica-devtools`: https://github.com/artefactual/archivematica-devtools
