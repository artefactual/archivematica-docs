.. _atom-setup:

=================================
Using AtoM 2.x with Archivematica
=================================

Archivematica |version| has been tested with and is recommended for use with the
latest version of AtoM. AtoM version 2.2 or higher is required if you wish to
use the hierarchical DIP functionality.

*On this page*

* :ref:`Install AtoM <install-atom>`
* :ref:`Configure DIP upload <config-dip-upload>`
* :ref:`User instructions <user-instructions-atom>`

.. _install-atom:

Install AtoM
------------

Installation instructions for AtoM 2 are available in the
:ref:`accesstomemory.org documentation <atom:home>`. When following those
instructions, it is best to download AtoM from the git repository (rather than
use one of the supplied tarballs).

You must enable the SWORD plugin (``qtSwordPlugin``) and the REST API
(``arRestApiPlugin``) from the :ref:`AtoM plugins menu <atom:manage-plugins>`.

.. _config-dip-upload:

Configure DIP upload
--------------------

Once you have a working AtoM installation, enter the appropriate credentials and
information on Archivematica's Administration tab. See :ref:`AtoM/Binder DIP
upload <admin-dashboard-atom>` for more information about the fields and their
values.

Next, configure the connection between the two systems:

#. Confirm atom-worker is configured on the AtoM server by copying the
   ``atom-worker.conf`` file from AtoM source to ``/etc/init/``.
#. Make sure that the SWORD plugin and AtoM REST API are enabled on the
   :ref:`AtoM plugins menu <atom:manage-plugins>`.

   a. If you are running AtoM 2.1 or lower, enable `job scheduling`_ in the AtoM
      settings page. In later versions of AtoM, this is enabled by default.

#. Confirm that gearman is installed on the AtoM server, as per the :ref:`AtoM
   installation documentation <atom:installation>`.
#. Configure SSH keys to allow rsync to work for the Archivematica user, from
   the Archivematica server to the AtoM server.
#. Restart gearman on the AtoM server.
#. Restart the AtoM worker on the AtoM server.

.. _user-instructions-atom:

User instructions
-----------------

Instructions on how to upload a DIP to AtoM can be found in the User Manual
section :ref:`Upload a DIP to AtoM <upload-atom>`.

:ref:`Back to the top <atom-setup>`


.. _job scheduling: https://www.accesstomemory.org/en/docs/2.1/user-manual/administer/settings/#job-scheduling
