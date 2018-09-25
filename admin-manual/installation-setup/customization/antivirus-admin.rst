.. _antivirus-admin:

========================
Antivirus administration
========================

Archivematica provides Antivirus capabilities through the
`ClamAV <clam-av-home_>`_ antivirus engine.

Antivirus settings are configured to capture the largest possible number of
viruses across the largest breadth of file types and sizes possible.

If configuration of ClamAV is required then you can do this through various
environment variables inside the operating system.

Clamdscan or Clamscan
---------------------

Clamscan is a standalone application. Clamdscan is a server based
implementation of the same tool.

Depending on your method of deployment, the Archivematica MCP Client will need
to have the environment variable ``CLAMAV_CLIENT_BACKEND`` set to one of two
case-insensitive values:

* ``clamdscanner`` for Clamdscan
* ``clamscanner`` for Clamscan

Archivematica will look for one of these values. If a value is not recognised
then it will default to Clamdscan.

.. note::

	It is recommended that you employ Clamdscan for virus checking.

	Clamscan is slower than Clamdscan because the process has to be started
	and the virus database reloaded for each file that is passed to it.

	Clamdscan's utility is due in part to the antivirus definition database
	only being loaded once when the service is started. Files are passed to the
	service by stream or by filesystem reference.

	To illustrate the difference in performance, a MB image file can be scanned
	by Clamdscan in an average of 2 seconds. Using Clamscan the average for the
	same file will be 1 minute 20 seconds.

Antivirus Settings and their Impacts
------------------------------------

Antivirus in Archivematica is configured using Environment Variables. These are
documented in detail on the Archivematica GitHub pages for the
`MCP Client Environment Variables <mcp-client-vars_>`_.

There are three values for antivirus that can impact whether a file is scanned
or not. If either of these are exceeded then Archivematica cannot guarantee
that a file has been scanned in its entirety for viruses.

Given that Archivematica cannot guarantee in such cases that all instances of
any virus have been detected a :ref:`PREMIS <premis-template>` event will not
be recorded.

From the ClamAV `manual pages <clamav-manual-pages_>`_:

::

	MaxFileSize SIZE
		Files  larger than this limit won't be scanned. Affects the input file
		itself as well as files contained inside it (when the input file is an
		archive, a document or some other kind of container).

	MaxScanSize SIZE
		Sets the maximum amount of data to be scanned for each input file.
		Archives and other containers are recursively extracted  and  scanned
		up to this value. The size of an archive plus the sum of the sizes of
		all files within archive count toward the scan size. For example, a
		1M uncompressed archive containing a single 1M inner file counts as
		2M toward the max scan size.

	StreamMaxLength** SIZE
		Close the STREAM session when the data size limit is exceeded.
		**Clamdscan Only

	Notes:
		All options expressing a size are limited to max 2GB. Values in
		excess will be reset to the maximum.

Configuration of ClamAV values
------------------------------

Defaults in Archivematica are set to:

::

	MaxFileSize=2000M
	MaxScanSize=2000M
	StreamMaxLength=2000M

	Where M is the unit Megabytes

.. note::

	Clamscan defaults cannot be set above 2GB (2000M) as per this link to
	ClamAV `Bug 11958 <https://bugzilla.clamav.net/show_bug.cgi?id=11958>`_
	(login required).

Configuration is done via environment variable, or deploy script, e.g. Ansible
playbook.

Docker-compose
^^^^^^^^^^^^^^

Before a container is built, the Compose ``.env`` file can be modified to
reflect new values, e.g. `here <docker-compose-env_>`_.

The container can then be recreated:

::

	docker-compose up -d --force-recreate --no-deps archivematica-mcp-client

Ansible
^^^^^^^

The defaults for the ClamAV Ansible role can be configured in the defaults
`configuration file <ansible-default-config_>`_
before following the Ansible installation process.

Impact of various configuration settings
----------------------------------------

Where defaults are **increased**, processing times of transfers will be
**slower** for transfers with larger digital files. **More** digital files will
be completely scanned.

Where defaults are **decreased**, processing times of transfers will be
**faster** for all digital files. **Fewer** digital files will be completely
scanned.

Virus definition updates
------------------------

An update service called ``freshclam`` is run regularly to update virus
definitions in Archivematica. To see when the virus database was last updated
you can review the log at the following location:

::

/var/log/clamav/freshclam.log

Troubleshooting
---------------

If the Scan for Viruses microservice is reporting that a file is too big but the
defaults you have set look accruate, then there is a chance the MCP Client
configuration needs updating. The microservice will look at the environment
variables:

* ``ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_CLAMAV_CLIENT_MAX_FILE_SIZE``
* ``ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_CLAMAV_CLIENT_MAX_SCAN_SIZE``

To determine whether to pass the file to the virus scanner. These values are
configured in `Ansible <ansible-envars_>`_ or inside the operating system
environment itself.

:ref:`Back to the top <antivirus-admin>`

.. _clam-av-home: https://www.clamav.net/
.. _mcp-client-vars: https://github.com/artefactual/archivematica/blob/stable/1.7.x/src/MCPClient/install/README.md#environment-variables
.. _clamav-manual-pages: https://manpages.debian.org/jessie/clamav-daemon/clamd.conf.5.en.html
.. _docker-compose-env: https://github.com/artefactual-labs/am/blob/stable/1.7.x/compose/.env
.. _ansible-default-config: https://github.com/artefactual-labs/ansible-clamav/blob/master/defaults/main.yml
.. _ansible-envars: https://github.com/artefactual-labs/ansible-archivematica-src#environment-variables
