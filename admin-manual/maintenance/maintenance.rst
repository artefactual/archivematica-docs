.. _admin-maintenance:

===========
Maintenance
===========

This page contains information relevant to maintaining your Archivematica
installation.

*On this page:*

* :ref:`Elasticsearch <elasticsearch>`

* :ref:`Programmatic access to indexed AIP data <elasticsearch-access>`

* :ref:`Delete Elasticsearch index <elasticsearch-delete>`

* :ref:`Rebuild AIP or transfer index <elasticsearch-rebuild>`

* :ref:`Data backup <data-backup>`

* :ref:`FAQ <admin-faq>`

.. _elasticsearch:

Maintaining Elasticsearch
-------------------------

Since version 0.9, Archivematica stores AIP file information, such as METS
data, using Elasticsearch. This data can be searched from the Archival Storage
area of the dashboard or can be interfaced with programmatically.

.. _elasticsearch-access:

Programmatic access to indexed AIP data
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To access indexed AIP data using a custom script or application, find an
Elasticsearch interface library for the programming language you've chosen to
use. In Archivematica we use Python with the `pyes`_ library. In our developer
documentation, we'll outline the use of pyes to access AIP data, but any
programming language/interface library, such as PHP and `Elastica`_, should
work.

**Connecting to Elasticsearch**

In this section we'll run through an example of interfacing with Elasticsearch
data using a Python script that leverages the pyes library.

The first step, when using pyes, is to require the module. The following code
imports pyes functionality on a system on which Archivematica is installed.

.. code:: bash

   import sys
   sys.path.append("/home/demo/archivematica/src/archivematicaCommon/lib/externals")
   from pyes import *

Next you'll want to create a connection to Elasticsearch.

.. code:: bash

   conn = ES('127.0.0.1:9200')

**Full text searching**

Once connected to Elasticsearch, you can perform searches. Below is the code
needed to do a "wildcard" search for all AIP files indexed by Elasticsearch
and retrieve the first 20 items. Instead of doing a "wildcard" search you
could also supply keywords, such as a certain AIP UUID.

.. code:: bash

   start_page     = 1
   items_per_page = 20

   q = StringQuery('*')

   try:
     results = conn.search_raw(
        query=q,
        indices='aips',
        type='aip',
        start=start_page - 1,
        size=items_per_page
     )
   except:
      print 'Query error.'

**Querying for specific data**

While the "StringQuery" query type is good for broad searches, you may want to
narrow a search down to a specific field of data to reduce false positives.
Below is an example of searching documents, using "TermQuery", matching
criteria within specific data. As, by default, Elasticsearch stores term
values in lowercase the term value searched for must also be lowercase.

.. code:: bash

   import sys
   sys.path.append("/usr/lib/archivematica/archivematicaCommon/externals")
   import pyes

   conn = pyes.ES('127.0.0.1:9200')

   q = pyes.TermQuery("METS.amdSec.ns0:amdSec_list.@ID", "amdsec_8")

   try:
       results = conn.search_raw(query=q, indices='aips')
   except:
     print 'Query failed.'


**Displaying search results**

Now that you've performed a couple of searches, you can display some results.
The below logic cycles through each hit in a results set, representing an AIP
file, and prints the UUID of the AIP the file belongs in, the Elasticsearch
document ID corresponding to the indexed file data, and the path of the file
within the AIP.

.. code:: python

   if results:
       document_ids = []
       for item in results.hits.hits:
           aip = item._source
           print 'AIP ID: ' + aip['AIPUUID'] + ' / Document ID: ' + item._id
           print 'Filepath: ' + aip['filePath']
           print
           document_ids.append(item._id)


**Fetching specific documents**

If you want to get Elasticsearch data for a specific AIP file, you can use the
Elasticsearch document ID. The above code populates the document_ids array and
the below code uses this data, retrieving individual documents and extracting
a specific item of data from each document.

.. code:: python

   for document_id in document_ids:
       data = conn.get(index_name, type_name, document_id)

       format = data['METS']['amdSec']['ns0:amdSec_list'][0]['ns0:techMD_list'][0]['ns0:mdWrap_list'][0]['ns0:xmlData_list'][0]['ns1:object_list'][0]['ns1:objectCharacteristics_list'][0]['ns1:format_list'][0]['ns1:formatDesignation_list'][0]['ns1:formatName']

       print 'Format for document ID ' + document_id + ' is ' + format

**Augmenting documents**

To add additional data to an Elasticsearch document, you'll need the document
ID. The following code shows an Elasticsearch query being used to find a
document and update it with additional data. Note that the name of the data
field being added, "__public", is prefixed with two underscores. This practice
prevents the accidental overwriting of system or Archivematica-specific data.
System data is prefixed with a single underscore.

.. code:: python

   import sys
   sys.path.append("/usr/lib/archivematica/archivematicaCommon/externals")
   import pyes

   conn = pyes.ES('127.0.0.1:9200')

   q = pyes.TermQuery("METS.amdSec.ns0:amdSec_list.@ID", "amdsec_8")

   results = conn.search_raw(query=q, indices='aips')

   try:
     if results:
       for item in results.hits.hits:
           print 'Updating ID: ' + item['_id']

           document = item['_source']
           document['__public'] = 'yes'
           conn.index(document, 'aips', 'aip', item['_id'])
   except:
     print 'Query failed.'

.. _elasticsearch-delete:

Delete the Elasticsearch index through the GUI
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To help with Elasticsearch development, Archivematica comes with a plugin for
Elasticsearch, called `Elasticsearch Head`_, that provides a web application
for browsing and administering Elasticsearch data. It can be accessed
at http://your.host.name:9200/_plugin/head/.

Elasticsearch Head will allow you to delete an index, if need be.


.. image:: images/Elasticsearch_head_delete.png
   :align: center
   :width: 80%
   :alt: Deleting an Elasticsearch index from Elasticsearch Head.

Delete Elasticsearch index programmatically
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If, for whatever reason, you need to delete an Elasticsearch index
programmatically, this can be done with pyes using the following code.

.. code:: bash

   import sys
   sys.path.append("/home/demo/archivematica/src/archivematicaCommon/lib/externals")
   from pyes import *
   conn = ES('127.0.0.1:9200')

   try:
       conn.delete_index('aips')
   except:
       print "Error deleting index or index already deleted."

.. _elasticsearch-rebuild:

Rebuilding the AIP index
^^^^^^^^^^^^^^^^^^^^^^^^

To rebuild the Elasticsearch AIP index enter the following to find the
location of the rebuilding script:

.. code:: bash

   locate rebuild-elasticsearch-aip-index-from-files

Copy the location of the script then enter the following to perform the
rebuild (substituting "/your/script/location/rebuild-elasticsearch-aip-index-
from-files" with the location of the script):

.. code:: bash

   /your/script/location/rebuild-elasticsearch-aip-index-from-files <location of your AIP store>

Rebuilding the transfer index
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Similarly, to rebuild the Elasticsearch transfer data index enter the
following to find the location of the rebuilding script:

.. code:: bash

   locate rebuild-elasticsearch-transfer-index-from-files

Copy the location of the script then enter the following to perform the
rebuild (substituting "/your/script/location/rebuild-elasticsearch-transfer-
index-from-files" with the location of the script):

.. code:: bash

   /your/script/location/rebuild-elasticsearch-transfer-index-from-files <location of your AIP store>

.. seealso::

   `Elasticsearch troubleshooting`_ help from AtoM documentation.

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

:ref:`Back to the top <maintenance>`

.. _`pyes`: https://github.com/aparo/pyes/
.. _`Elastica`: https://github.com/ruflin/Elastica/
.. _`Elasticsearch documentation`: https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-snapshots.html
.. _`Elasticsearch troubleshooting`: https://www.accesstomemory.org/docs/latest/admin-manual/maintenance/elasticsearch/#maintenance-elasticsearch
.. _`Elasticsearch Head`: http://mobz.github.com/elasticsearch-head/
.. _`remove transfers or SIPs`: https://www.archivematica.org/en/docs/archivematica-1.7/user-manual/transfer/transfer/#cleaning-up-the-transfer-dashboard
.. _`archivematica-devtools`: https://github.com/artefactual/archivematica-devtools
