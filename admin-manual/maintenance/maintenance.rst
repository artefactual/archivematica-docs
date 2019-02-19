.. _admin-maintenance:

===========
Maintenance
===========

This page contains information relevant to maintaining your Archivematica
installation.

*On this page:*

* :ref:`Elasticsearch <elasticsearch>`

  * :ref:`Rebuild the indexes <elasticsearch-indexes>`
  * :ref:`External access <elasticsearch-external>`

* :ref:`Data backup <data-backup>`
* :ref:`FAQ <admin-faq>`

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

Archivematica includes two Django commands to regenerate the Elasticsearch
indexes. These commands require access in the local filesystem to the location
paths of the AIP and Transfer Backlog storage locations. These
usually are located in the following paths:

* :file:`/var/archivematica/sharedDirectory/www/AIPsStore`
* :file:`/var/archivematica/sharedDirectory/www/AIPsStore/transferBacklog`

You should confirm the paths of your installation in the Locations tab of the
Storage Service.

.. _aip-indexes:

**AIP indexes**

To recreate the AIP indexes from files run the following command, passing the
path of the AIP storage location you confirmed above.

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
       /usr/share/archivematica/virtualenvs/archivematica-dashboard/bin/python \
           manage.py rebuild_elasticsearch_aip_index_from_files \
               /var/archivematica/sharedDirectory/www/AIPsStoree --delete-all
   ";

The command accepts the following parameters:

* `[storage_location_path]` **[REQUIRED]**: Path where the AIP storage location
  is located in the local filesystem.
* `--delete-all`: Removes the entire indexes to regenerate the mapping and
  settings.
* `--delete`: Removes matching AIP documents to avoid duplicates but keeps the
  index mappings and settings.
* `--uuid` [aip_uuid]: Index a single AIP from the storage location.

It can be executed multiple times with different paths to index multiple AIP
storage locations.

.. _transfer-indexes:

**Transfer indexes**

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
       /usr/share/archivematica/virtualenvs/archivematica-dashboard/bin/python \
           manage.py rebuild_transfer_backlog
   ";

The command accepts the following parameters:

* `--transfer-backlog-dir [storage_location_path]`: Path where the Transfer
  Backlog storage location is located in the local filesystem. *Default:*
  `/var/archivematica/sharedDirectory/www/AIPsStore/transferBacklog`.
* `--no-prompt`: Do not ask for confirmation.

.. _elasticsearch-external:

External access
^^^^^^^^^^^^^^^

For further interactions with the Elasticsearch indexes, to browse the data or
to create visualizations, the following tools are recommended:

* `Kibana`_
* `Dejavu`_

The index names are: `aips`, `aipfiles`, `transfers` and `transferfiles`.

.. _data-backup:

Data back-up
------------

In Archivematica there are three types of data you'll likely want to back up:

* Filesystem (particularly your storage directories)

* MySQL

* Elasticsearch

MySQL is used to store short-term processing data. You can back up the MySQL
database by using the following command:

.. code:: bash

   mysqldump -u <your username> -p<your password> -c MCP > <filename of backup>

Elasticsearch is used to store long-term data. Instructions and scripts for
backing up and restoring Elasticsearch are available in the
`Elasticsearch documentation`_.

.. _admin-faq:

FAQ
---

.. _restart-services:

How to restart the Archivematica services
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Restart all services**

.. code:: bash

   am services

Note that the default action is to restart all services. To see other available
parameters, type:

.. code:: bash

   am services help

**Stopping**

.. code:: bash

   sudo stop archivematica-mcp-server
   sudo stop archivematica-mcp-client
   sudo /etc/init.d/apache2 stop
   sudo /etc/init.d/gearman-job-server stop
   sudo stop mysql
   sudo /etc/init.d/elasticsearch stop

**Starting**

.. code:: bash

   sudo /etc/init.d/elasticsearch start
   sudo start mysql
   sudo /etc/init.d/gearman-job-server start
   sudo /etc/init.d/apache2 start
   sudo start archivematica-mcp-server
   sudo start archivematica-mcp-client

.. _stack-trace:

Error stack trace
^^^^^^^^^^^^^^^^^

   "I am getting a white error page in the Dashboard. How can I find out what
   the error is?"

Seeing an full error stack trace for the Dashboard requires knowing how to
edit a configuration file from the command line.

1. SSH to the Archivematica server

2. With your preferred text editor, open the dashboard settings file (vim shown
   in example; Note that you must use sudo to edit this file):

   .. code:: bash

      sudo vim /usr/share/archivematica/dashboard/settings/common.py

3. Change the "DEBUG" flag from "False" to "True"

   .. code:: bash

      DEBUG = True

4. Save the fileservices

5. Restart Apache

   .. code:: bash

      sudo apache2ctl restart

6. Reload the dashboard page reporting the error in your browse

7. Debug or report error

8. Restore DEBUG to False and restart Apache to turn error reporting off again

Resolve hanging decisions
^^^^^^^^^^^^^^^^^^^^^^^^^

   "My Transfer or Ingest tab has a red circle indicating that a decision is
   awaiting user input, but there are no decisions to be made on the screen. How
   do I get rid of the red circle?"

.. image:: images/user-input.*
   :align: center
   :width: 80%
   :alt: A red bubble on the Transfer tab at the top of the Archivematica dashboard indicates that a decision is awaiting user input.

Any time a decision in the Transfer or Ingest tab is awaiting user input,
Archivematica visually indicates the need for user input by placing a red circle
on the tab. The numeral inside the circle indicates how many decisions are
awaiting user input on the tab.

It is possible to `remove transfers or SIPs`_ from the Transfer or Ingest tab
without resolving a decision, which results in the red circle remaining even if
there is no decision awaiting user input on the tab. While this isn't a critical
issue, it is annoying. To get rid of the red circle, you need to use a command
line tool to resolve the user input first and then either complete or reject the
transfer/SIP. In the Archivematica source code, there is a python module
containing an RPC client that can give you information about the transfers and
SIPs that you have in your dashboard. It also allows you to add user inputs, as
an alternative to using the dashboard.

.. IMPORTANT::

   The tool that is currently being used for this workflow, mcp-rpc-cli, may be
   deprecated or replaced in future releases. These instructions are accurate as
   of Archivematica 1.7.2.

.. note::

   These instructions work on Archivematica 1.7.x, deployed on either CentOS or
   Ubuntu via ansible or RPMs. If you are using this tool on a vagrant
   deployment, please note the specific instructions related to vagrant. For
   more information about installation methods, please see :ref:`installation`.

1. Clone the `archivematica-devtools`_ repository into your Archivematica source
   repository and follow the installation instructions found within the
   repository. On Ubuntu or CentOS, clone the repository to
   `/opt/archivematica`. On vagrant, clone the repository to `/vagrant/src/`.
   You should be able to access the devtools by running the `am` command.

2. Navigate to the Archivematica MCP Client directory and start the mcp-rpc-cli.

   Ubuntu or CentOS:

      .. code-block:: bash

         sudo -u archivematica bash -c " \
            set -a -e -x
              source /etc/default/archivematica-mcp-client || \
                  source /etc/sysconfig/archivematica-mcp-client \
                      || (echo 'Environment file not found'; exit 1)
              cd /opt/archivematica/archivematica-devtools/bin/
              ./am mcp-rpc-cli
          ";

   Vagrant:

      .. code-block:: bash

         sudo -u archivematica bash -c " \
            set -a -e -x
              source /etc/default/archivematica-mcp-client || \
                  source /etc/sysconfig/archivematica-mcp-client \
                      || (echo 'Environment file not found'; exit 1)
              cd /vagrant/src/archivematica-devtools/bin/
              ./am mcp-rpc-cli
          ";

3. You should see an output that looks like the snippet here:

   .. code-block:: xml

      0
      <choicesAvailableForUnit>
       <UUID>a62cf1bc-caf4-4656-94bb-da6713bea572</UUID>
       <unit>
         <type>SIP</type>
         <unitXML>
           <UUID>8bcd6bd8-3f8b-4673-b309-bb98d84b43bb</UUID>
           <currentPath>%sharedPath%watchedDirectories/storeAIP/diptest4-8bcd6bd8-3f8b-4673-b309-bb98d84b43bb/</currentPath>
         </unitXML>
       </unit>
       <choices>
         <choice>
           <chainAvailable>433f4e6b-1ef4-49f8-b1e4-49693791a806</chainAvailable>
           <description>Reject AIP</description>
         </choice>
         <choice>
           <chainAvailable>9efab23c-31dc-4cbd-a39d-bb1665460cbe</chainAvailable>
           <description>Store AIP</description>
         </choice>
       </choices>
      </choicesAvailableForUnit>
      1
      <choicesAvailableForUnit>
       <UUID>b4b8aed1-13be-4174-a3a4-806bc993c861</UUID>
       <unit>
         <type>SIP</type>
         <unitXML>
           <UUID>04c62e5e-0d00-4bf8-9298-18eeb2df0df8</UUID>
           <currentPath>%sharedPath%watchedDirectories/storeAIP/diptest4-8bcd6bd8-3f8b-4673-b309-bb98d84b43bb/</currentPath>
         </unitXML>
       </unit>
       <choices>
         <choice>
           <chainAvailable>c5488a27-fef8-4338-9355-bbdde821c957</chainAvailable>
           <description>Reject AIP</description>
         </choice>
         <choice>
           <chainAvailable>97866125-ddd1-4811-8e9d-ebae48fd11d0</chainAvailable>
           <description>Store AIP</description>
         </choice>
       </choices>
      </choicesAvailableForUnit>

      q to quit
      u to update List
      number to approve Job
      Please enter a value:

   The above is showing two SIPs that were cleared from the Ingest tab while
   waiting for user input at the Store AIP decision point. Each SIP is given an
   entry number, beginning with 0. Note that transfers that were cleared from
   the Transfer tab while waiting for user input would also appear in this list.

   Below the entry number, we get some basic information about the SIP within
   the <unit> element (the type, UUID, and the current location). Following
   that, we have the <choices> element, which presents the currently-available
   choices for the SIP. The Store AIP decision point gives the user two choices:
   Reject AIP or Store AIP.

4. Select the transfer or SIP that you would like to work with by entering the
   entry number.

   .. code-block:: console

      Please enter a value: 0

   You should now see a list of the available choices for the transfer or SIP.
   Each choice is preceded by an entry number.

   .. code-block:: xml

      0
      <choice>
       <chainAvailable>433f4e6b-1ef4-49f8-b1e4-49693791a806</chainAvailable>
       <description>Reject AIP</description>
      </choice>
      1
      <choice>
       <chainAvailable>9efab23c-31dc-4cbd-a39d-bb1665460cbe</chainAvailable>
       <description>Store AIP</description>
      </choice>

      q to quit
      u to update List
      number to approve Job
      Please enter a value:

5. Make the decision by entering the choice's entry number.

   .. code-block:: console

      Please enter a value: 1

   In this example, we have chosen to store the AIP by selecting the Store AIP
   choice. We could now confirm that this action worked by checking the
   Archivematica instance's Storage tab to confirm that the AIP was stored.

6. To update the list and continue, enter `u` when prompted to enter a value.
   Repeat the steps above until there are no more choices left to make.


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
  ``archivematica-mcp-server``, ``archivematica-mcp-client``,
  and ``archivematica-dashboard``.

  Note that on some installations, ``gearmand`` may be called
  ``gearman-job-server``.

:ref:`Back to the top <maintenance>`

.. _`Elasticsearch documentation`: https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-snapshots.html
.. _`Elasticsearch troubleshooting`: https://www.accesstomemory.org/docs/latest/admin-manual/maintenance/elasticsearch/#maintenance-elasticsearch
.. _`Kibana`: https://www.elastic.co/products/kibana
.. _`Dejavu`: https://github.com/appbaseio/dejavu
.. _`remove transfers or SIPs`: https://www.archivematica.org/en/docs/archivematica-1.7/user-manual/transfer/transfer/#cleaning-up-the-transfer-dashboard
.. _`archivematica-devtools`: https://github.com/artefactual/archivematica-devtools
