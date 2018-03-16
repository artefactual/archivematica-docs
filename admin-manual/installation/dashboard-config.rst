.. _dashboard-config:

============================
Dashboard administration tab
============================

The Archivematica administration pages, under the Administration tab of the
dashboard, allow you to configure application components and manage users.

*On this page:*

* :ref:`Processing configuration <process-config>`

* :ref:`General <admin-dashboard-general>`

* :ref:`Failures <admin-dashboard-failures>`

* :ref:`Transfer source locations <admin-dashboard-transfer-source>`

* :ref:`AIP storage locations <admin-dashboard-AIP-stor>`

* :ref:`AtoM DIP upload <admin-dashboard-atom>`

* :ref:`ArchivesSpace DIP upload <admin-dashboard-AS>`

* :ref:`Archivists Toolkit DIP upload <admin-dashboard-AT>`

* :ref:`PREMIS agent <admin-dashboard-premis>`

* :ref:`REST API <admin-dashboard-rest>`

* :ref:`Users <admin-dashboard-users>`

.. _process-config:

Processing configuration
------------------------

When processing a SIP or transfer, you may want to automate some of the
workflow choices. Choices can be preconfigured by putting a
``processingMCP.xml`` file into the root directory of a SIP/transfer.

If a SIP or transfer is submitted with a ``processingMCP.xml`` file,
processing decisions will be made with the included file.

The XML file format is:

.. code:: bash

   <processingMCP>
    <preconfiguredChoices>
        <!-- Send to quarantine? -->
        <preconfiguredChoice>
            <appliesTo>755b4177-c587-41a7-8c52-015277568302</appliesTo>
            <goToChain>d4404ab1-dc7f-4e9e-b1f8-aa861e766b8e</goToChain>
        </preconfiguredChoice>
        <!-- Display metadata reminder -->
        <preconfiguredChoice>
            <appliesTo>eeb23509-57e2-4529-8857-9d62525db048</appliesTo>
            <goToChain>5727faac-88af-40e8-8c10-268644b0142d</goToChain>
        </preconfiguredChoice>
        <!-- Remove from quarantine -->
        <preconfiguredChoice>
            <appliesTo>19adb668-b19a-4fcb-8938-f49d7485eaf3</appliesTo>
            <goToChain>333643b7-122a-4019-8bef-996443f3ecc5</goToChain>
            <delay unitCtime="yes">2419200.0</delay>
        </preconfiguredChoice>
        <!-- Extract packages -->
        <preconfiguredChoice>
            <appliesTo>dec97e3c-5598-4b99-b26e-f87a435a6b7f</appliesTo>
            <goToChain>01d80b27-4ad1-4bd1-8f8d-f819f18bf685</goToChain>
        </preconfiguredChoice>
        <!-- Delete extracted packages -->
        <preconfiguredChoice>
            <appliesTo>f19926dd-8fb5-4c79-8ade-c83f61f55b40</appliesTo>
            <goToChain>85b1e45d-8f98-4cae-8336-72f40e12cbef</goToChain>
        </preconfiguredChoice>
        <!-- Select pre-normalize file format identification command -->
        <preconfiguredChoice>
            <appliesTo>7a024896-c4f7-4808-a240-44c87c762bc5</appliesTo>
            <goToChain>3c1faec7-7e1e-4cdd-b3bd-e2f05f4baa9b</goToChain>
        </preconfiguredChoice>
        <!-- Select compression algorithm -->
        <preconfiguredChoice>
            <appliesTo>01d64f58-8295-4b7b-9cab-8f1b153a504f</appliesTo>
            <goToChain>9475447c-9889-430c-9477-6287a9574c5b</goToChain>
        </preconfiguredChoice>
        <!-- Select compression level -->
        <preconfiguredChoice>
            <appliesTo>01c651cb-c174-4ba4-b985-1d87a44d6754</appliesTo>
            <goToChain>414da421-b83f-4648-895f-a34840e3c3f5</goToChain>
        </preconfiguredChoice>
      </preconfiguredChoices>
     </processingMCP>

Where ``appliesTo`` is the UUID associated with the micro-service job presented in
the dashboard, and ``goToChain`` is the UUID of the desired selection. The default
``processingMCP.xml`` file is located at ``/var/archivematica/sharedDirectory/share
dMicroServiceTasksConfigs/processingMCPConfigs/defaultProcessingMCP.xml``.

The processing configuration administration page of the dashboard provides you
with an easy form to configure the default ``processingMCP.xml`` that's added to
a SIP or transfer if it doesn't already contain one. When you change the
options using the web interface the necessary XML will be written behind the
scenes.

.. image:: images/dashboard-1.*
   :align: center
   :width: 80%
   :alt: Processing configuration dashboard part 1

.. image:: images/dashboard-2.*
   :align: center
   :width: 80%
   :alt: Processing configuration dashboard part 2


* For the approval (yes/no) steps, the user ticks the box on the left-hand side
  to make a choice. If the box is not ticked, the approval step will appear in
  the dashboard.

* For the other steps, if no actions are selected the choices appear in the
  dashboard

Specific processing configurations available on this page are:

#. Select whether or not to send transfers to quarantine (yes/no) and
   decide how long you'd like them to stay there (below).

#. Approve normalization, sending the AIP to storage, and uploading the
   DIP without interrupting the workflow in the dashboard.

#. Store the AIP without interrupting the workflow in the dashboard.

#. Select whether or not Archivematica should transcribe files.

#. Select whether or not Archivematica should generate a transfer structure
   report (see :ref:`Process the transfer <process-transfer>`)

#. Select if Archivematica should create one SIP from the transfer and
   continue processing or send the transfer to backlog.

#. Select whether to extract packages as well as whether to keep and/or
   delete the extracted objects and/or the package itself.

#. Select Normalization options (see :ref:`Normalize <normalize>`).

#. Select whether or not Archivematica should remind you to add metadata at the
   appropriate point during ingest.

#. Select whether or not to Examine contents.

#. Select which format identification tool and command to run in both/either
   transfer and/or ingest to base your normalization upon.

#. Select which format identification tool and command to run for Submission
   documentation and metadata.

#. Select whether packages should be deleted after extraction.

#. Select between 7z using lzma and 7zip using bzip or parallel bzip2 algorithms
   for AIP compression.

#. Select compression levels:

    * 1 - fastest mode

    * 3 - fast compression mode

    * 5 - normal compression mode

    * 7 - maximum compression

    * 9 - ultra compression

#. Select one archival storage location where you will consistently send your
   AIPs and DIPs (if you are storing DIPs rather than sending them immediately
   to an access system.)

.. _admin-dashboard-general:

General
-------

In the general configuration section, you can select interface options and set
Storage Service options for your Archivematica client.

.. figure:: images/Generalconfig.*
   :align: center
   :figwidth: 70%
   :width: 100%
   :alt: General configuration options in Administration tab of the dashboard

   General configuration options in Administration tab of the dashboard

**Interface options**

Here, you can hide parts of the interface that you don't need to use. In
particular, you can hide CONTENTdm DIP upload link, AtoM DIP upload link and
DSpace transfer type.

**Storage Service options**

This is where you'll find the complete URL for the Storage Service. See
:ref:`Storage Service <storageService:administrators>` for more information
about this feature.

.. _admin-dashboard-failures:

Failures
--------

This page displays packages that failed during processing.

.. figure:: images/FailuresAdmin.*
   :align: center
   :figwidth: 70%
   :width: 100%
   :alt: Failures report in the dashboard

   Failures report in the dashboard


Clicking the date, name or UUID will display a report of the failure:

.. image:: images/FailReport.*
   :align: center
   :width: 70%
   :alt: Failure report for a failed transfer

The Failure report can be removed from the Dashboard by clicking Delete.

.. _admin-dashboard-transfer-source:

Transfer source location
------------------------

Archivematica allows you to start transfers using the operating system's file
browser or via a web interface. Source files for transfers, however, cannot be
uploaded using the web interface; they must exist on volumes accessible to the
Archivematica MCP server and configured via the Storage Service.

When starting a transfer you are required to select one or more directories of
files to add to the transfer.

.. _admin-dashboard-AIP-stor:

AIP storage locations
---------------------

AIP storage directories are directories in which completed AIPs are stored.
Storage directories can be specified in a manner similar to transfer source
directories using the Storage Service.

You can view your transfer source directories in the Administrative tab of the
dashboard under "AIP storage locations".

.. _admin-dashboard-atom:

AtoM DIP upload
---------------

Archivematica can upload DIPs directly to an AtoM website so the contents can
be accessed online.  DIP Upload to AtoM is usually a three step process:

#. If AtoM is installed on a remote server, Archivematica uses SSH and rsync to
   copy the DIP to a temporary directory on the AtoM server. If Archivematica 
   and AtoM share a common filesystem (e.g. a shared network directory) this 
   step is unnecessary.

#. Archivematica sends a REST request to AtoM to tell AtoM which archival
   description is the target of the DIP. The DIP target description is 
   identified by the description's "slug".  The actual upload of the DIP 
   contents to AtoM is done via a background job, and may take some time to
   process if a large DIP is uploaded.

#. An AtoM background worker uploads the DIP metadata (METS file) and digital
   objects from the temporary directory to AtoM, links them to the target
   description, then deletes the temporary files.

The AtoM DIP upload configuration page is where you specify the details of the
AtoM installation you'd like the DIPs uploaded to (and, if using Rsync to
transfer the DIP files, Rsync transfer details).

The parameters that you'll most likely want to set are url, email, and
password. These parameters, respectively, specify the destination AtoM
website's URL, the email address used to log in to the website, and the
password used to log in to the website.

AtoM DIP upload can also use Rsync as a transfer mechanism. Rsync is an open
source utility for efficiently transferring files. The rsync-target parameter
is used to specify an Rsync-style target host/directory pairing,
``foobar.com:~/dips/`` for example. The rsync-command parameter is used to
specify rsync connection options, ``ssh -p 22222 -l user`` for example. If you
are using the rsync option, please see AtoM server configuration below.

To set any parameters for AtoM DIP upload change the values, preserving the
existing format they're specified in, in the ``Command arguments`` field then
click "Save".

Note that in AtoM, the sword plugin (Admin --> Plugins --> qtSwordPlugin) must
be enabled in order for AtoM to receive uploaded DIPs. Enabling Job scheduling
(Admin --> Settings --> Job scheduling) is also recommended. From the AtoM
documentation, see :ref:`Settings <atom:settings>` and
:ref:`Plugins <atom:manage-plugins>`.

.. NOTE::

   If you are planning to use the *metadata-only DIP upload to AtoM*
   functionality don't forget to enable the :ref:`the API plugin in AtoM
   <atom:api-intro>`, generate a API key and update the ``REST API key`` field
   accordingly. Metadata-only upload is only available since AtoM 2.4.

AtoM server configuration
^^^^^^^^^^^^^^^^^^^^^^^^^

This server configuration step is necessary to allow Archivematica to log in
to the AtoM server without passwords, and only when the user is deploying the
rsync option described above in the AtoM DIP upload section.

To enable sending DIPs from Archivematica to the AtoM server:

Generate SSH keys for the Archivematica user. Leave the passphrase field
blank.

.. code:: bash

   $ sudo -u archivematica ssh-keygen


Copy the contents of ``/var/lib/archivematica/.ssh/id_rsa.pub`` somewhere
handy, you will need it later.

Now, it's time to configure the AtoM server so Archivematica can send the DIPs
using SSH/rsync. For that purpose, you will create a user called ``archivematica``
and we are going to assign that user a restricted shell with access only to
rsync:

.. code:: bash

   $ sudo apt-get install rssh
   $ sudo useradd -d /home/archivematica -m -s /usr/bin/rssh archivematica
   $ sudo passwd -l archivematica
   $ sudo vim /etc/rssh.conf // Make sure that allowrsync is uncommented!

Add the SSH key that we generated before:

.. code:: bash

   $ sudo mkdir /home/archivematica/.ssh
   $ chmod 700 /home/archivematica/.ssh/
   $ sudo vim /home/archivematica/.ssh/authorized_keys // Paste here the contents of id_dsa.pub
   $ chown -R archivematica:archivematica /home/archivematica

In Archivematica, make sure that you update the ``--rsync-target`` accordingly.
These are the parameters that we are passing to the upload-qubit microservice.
Go to the Administration > Upload DIP page in the dashboard.

Generic parameters:

.. code:: bash

   --url="http://atom-hostname/index.php" \
   --email="demo@example.com" \
   --password="demo" \
   --uuid="%SIPUUID%" \
   --rsync-target="archivematica@atom-hostname:/tmp" \
   --debug

.. _admin-dashboard-AS:

ArchivesSpace DIP upload
-----------------------------

Before ingesting digital objects destined for ArchivesSpace, ensure that
the Achivists' Toolkit DIP upload settings in the administration tab of the
dashboard have been set.

* These settings should be created and saved before digital objects destined
  for upload to ArchivesSpace are processed. Note that these can be set
  once and used for processing any number of transfers (i.e. they do not need
  to be re-set for each transfer).

* Include the IP address of the host database (ArchivesSpace host), the database
  port (ArchivesSpace backend port), an ArchivesSpace administrative
  username, and the ArchivesSpace administrative user password.

* Restrictions Apply: Selecting *Yes* will apply a blanket access restriction to all content
  uploaded from Archivematica to ArchivesSpace. Selecting *No* will send all content to
  ArchivesSpace without restrictions. Should you wish to enable the PREMIS-based restrictions functionality,
  choose "base on PREMIS" under "Restrictions Apply". To add PREMIS rights,
  please see :ref:`Add PREMIS rights and restrictions <at-premis>`.

* ArchivesSpace repository number: Insert the identifier for the ArchivesSpace repository
  to which you would like to upload DIPs here. Note that the default identifier for a
  single-repository ArchivesSpace instance is **2**.

.. NOTE::
  In order to save changes to the ArchivesSpace DIP upload configuration, you must
  enter the password before clicking save. Note that Archivematica will *not* show you
  an error if the password is not entered.

.. _admin-dashboard-AT:

Archivists Toolkit DIP upload
-----------------------------

Before ingesting digital objects destined for Archivists' Toolkit, ensure that
the Achivists' Toolkit DIP upload settings in the administration tab of the
dashboard have been set.

* These settings should be created and saved before digital objects destined
  for upload to Archivists Toolkit are processed. Note that these can be set
  once and used for processing any number of transfers (i.e. they do not need
  to be re-set for each transfer). The screenshots below show the template in
  the dashboard.

* Include the IP address of the host database (db host), the database port (db
  port), the database name (db name), the database user (db user), and the
  Archivists' Toolkit user name (at username).

* Should you wish to enable the PREMIS-based restrictions functionality,
  choose "base on PREMIS" under "Restrictions Apply". To add PREMIS rights,
  please see :ref:`Add PREMIS rights and restrictions <at-premis>`.

.. _admin-dashboard-premis:

PREMIS agent
------------

The PREMIS agent name and code can be set here via the administration interface.

.. _admin-dashboard-rest:

Rest API
--------

In addition to automation using the ``processingMCP.xml`` file, Archivematica
includes a REST API for automating transfer approval. Using this API, you can
create a custom script that copies a transfer to the appropriate directory
then uses the curl command, or some other means, to let Archivematica know
that the copy is complete.

API keys
^^^^^^^^

Use of the REST API requires the use of API keys. An API key is associated
with a specific user. To generate an API key for a user:

* Browse to /administration/accounts/list/

* Click the "Edit" button for the user you'd like to generate an API key for

* Click the "Regenerate API key" checkbox

* Click "Save"

After generating an API key, you can click the "Edit" button for the user and
you should see the API key.

IP whitelist
^^^^^^^^^^^^

The API key is always required but in some cases the administrator may want to
add an additional security measurement. IP whitelisting allows you to create a
list of trusted IP addresses from which you can access to the API.

The IP whitelist can be edited in the administration interface at
``/administration/api/``. If the whitelist is empty all requests will be
allowed.

Approving a transfer
^^^^^^^^^^^^^^^^^^^^

The REST API can be used to approve a transfer. The transfer must first be
copied into the appropriate watch directory. To determine the location of the
appropriate watch directory, first figure out where the shared directory is
from the watchDirectoryPath value of
``/etc/archivematica/MCPServer/serverConfig.conf``. Within that directory is a
subdirectory activeTransfers. In this subdirectory are watch directories for
the various transfer types.

When using the REST API to approve a transfer, if a transfer type isn't
specified, the transfer will be deemed a standard transfer.

**HTTP Method**: POST

**URL**: /api/transfer/approve

**Parameters**:

``directory``: directory name of the transfer

``type`` (optional): transfer type [standard|dspace|unzipped bag|zipped bag]

``api_key``: an API key

``username``: the username associated with the API key

Example curl command:

.. code:: bash

   curl --data "username=rick&api_key=f12d6b323872b3cef0b71be64eddd52f87b851a6&type=standard&directory=MyTransfer" http://127.0.0.1/api/transfer/approve

Example result:

.. code:: bash

   {"message": "Approval successful."}

Listing unapproved transfers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The REST API can be used to get a list of unapproved transfers. Each
transfer's directory name and type is returned.

**Method**: ``GET``

**URL**: ``/api/transfer/unapproved``

**Parameters**:

``api_key``: an API key

``username``: the username associated with the API key

Example curl command:

.. code:: bash

   curl "http://127.0.0.1/api/transfer/unapproved?username=rick&api_key=f12d6b323872b3cef0b71be64eddd52f87b851a6"

Example result:

.. code:: bash

   {
       "message": "Fetched unapproved transfers successfully.",
       "results": [{
               "directory": "MyTransfer",
              "type": "standard"
           }
       ]
   }

.. _admin-dashboard-users:

Users
-----

The dashboard provides a simple cookie-based user authentication system using
the `Django authentication framework <https://docs.djangoproject.com/en/1.4/topics/auth/>`_.
Access to the dashboard is limited only to logged-in users and a login page
will be shown when the user is not recognized. If the application can't find
any user in the database, the user creation page will be shown instead,
allowing the creation of an administrator account.

Users can be also created, modified and deleted from the Administration tab.
Only users who are administrators can create and edit user accounts.

You can add a new user to the system by clicking the "Add new" button on the
user administration page. By adding a user you provide a way to access
Archivematica using a username/password combination. Should you need to change
a user's username or password, you can do so by clicking the "Edit" button,
corresponding to the user, on the administration page. Should you need to
revoke a user's access, you can click the corresponding "Delete" button.

CLI creation of administrative users
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you need an additional administrator user one can be created via the
command-line, issue the following commands:

.. code:: bash

   cd /usr/share/archivematica/dashboard
   export PATH=$PATH:/usr/share/archivematica/dashboard
   export DJANGO_SETTINGS_MODULE=settings.common
   python manage.py createsuperuser

CLI password resetting
^^^^^^^^^^^^^^^^^^^^^^

If you've forgotten the password for your administrator user, or any other
user, you can change it via the command-line:

.. code:: bash

   cd /usr/share/archivematica/dashboard
   export PATH=$PATH:/usr/share/archivematica/dashboard
   export DJANGO_SETTINGS_MODULE=settings.common
   python manage.py changepassword <username>

Security
^^^^^^^^

Archivematica uses `PBKDF2 <http://en.wikipedia.org/wiki/PBKDF2>`_ as the default
algorithm to store passwords. This should be sufficient for most users: it's
quite secure, requiring massive amounts of computing time to break. However,
other algorithms could be used as the following document explains:
`How Django stores passwords <https://docs.djangoproject.com/en/1.4/topics/auth/#how-django-stores-passwords>`_ .

Our plan is to extend this functionality in the future adding groups and
granular permissions support.


:ref:`Back to the top <dashboard-config>`
