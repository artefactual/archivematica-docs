.. _atom-setup:

=================================
Using AtoM 2.x with Archivematica
=================================

Archivematica |version| has been tested with and is recommended for use with the
latest version of AtoM. AtoM version 2.2 or higher is required if you wish to
use the :ref:`hierarchical DIP functionality <hierarchical-dip>`.

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

.. _config-dip-upload:

Configure DIP upload
--------------------

Once you have a working AtoM installation, enter the appropriate credentials and
information on the Administration tab. See :ref:`AtoM/Binder DIP upload
<admin-dashboard-atom>` for more information.

Once this is complete, there are

#. Confirm atom-worker is configured on the AtoM server (copy the ``atom-
   worker.conf`` file from AtoM source to ``/etc/init/``).
#. Enable the :ref:`SWORD plugin <atom:manage-plugins>` from the AtoM Plugins
   menu.
#. Enable `job scheduling`_ in the AtoM settings page (AtoM version 2.1 or lower
   only).
#. Confirm gearman is installed on the AtoM server.
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
