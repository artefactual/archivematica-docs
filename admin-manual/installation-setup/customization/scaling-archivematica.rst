.. _scaling-archivematica:

=====================
Scaling Archivematica
=====================

.. _scaling-overview:

Overview
--------

Archivematica includes a number of features and options to improve scalability
and performance. The default configuration options are geared towards "typical"
use cases and for many users won't require any modification. However, some
users will benefit from optimising configuration options to meet their
specific preservation needs and available computing resources.

This guide describes three broad approaches to scaling and optimization and the
specific techniques available to each approach.

This is not a detailed 'how to' guide or set of specific recommendations. The
goal here is to explain what broad strategies are available and enough of the
implementation details to allow skilled administrators to choose and implement
the right strategy for their institution.

*On this page:*

* :ref:`Scaling up: optimising on one machine <scaling-up>`
* :ref:`Scaling out: optimising across multiple machines <scaling-out>`
* :ref:`Process configuration strategies <config-strategies>`

.. _scaling-up:

Scaling up: optimising on one machine
-------------------------------------

Processing speed and capacity will generally increase in line with increases
in computing resources (CPU, memory and disk space). When a deployment uses a
machine with considerably more (or less) resources than the
:ref:`recommended minimum production requirements <requirements-production>`,
there are several different configuration options that may help further
optimise performance.

Optimising the number of packages processed at a time
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

MCPServer allows processing of up to a set number of packages concurrently.
The ``ARCHIVEMATICA_MCPSERVER_MCPSERVER_CONCURRENT_PACKAGES`` parameter defines
the maximum number of packages that MCPServer will process simultaneously.
The default value is 0.5 * <cpu count>, rounded up. This number could be
increased if you are constantly processing transfers, but not seeing full CPU
utilization. See `MCPServer`_ for more details.


Optimising the number of MCPServer threads
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

MCPServer has two settings for modifying the number of threads run:

* ``ARCHIVEMATICA_MCPSERVER_MCPSERVER_RPC_THREADS`` sets the number of
  "RPC Server" workers available to respond to status requests from other
  components (such as the Dashboard). The default value is 4. If you are seeing
  slow status updates in the Dashboard, increasing this value _may_ help.
* ``ARCHIVEMATICA_MCPSERVER_MCPSERVER_WORKER_THREADS`` sets the number of
  threads available to handle MCPServer processing tasks, such as submitting
  Gearman jobs for processing by MCPClient. The default value is
  <cpu count> + 1. Increasing this value _may_ help increase CPU utilization.


Deploy multiple MCPClients
^^^^^^^^^^^^^^^^^^^^^^^^^^

The `MCPClient`_ component is responsible for the most significant sources of
load in an Archivematica deployment. In Archivematica 1.8.x and higher, it can
in some cases make sense to deploy more than one MCPClient component on the
same machine, due to the introduction of batching.

.. note::

   Note: In Archivematica 1.7.x and earlier, the MCPClient does not use
   batching, and instead creates multiple Gearman workers (creating one worker
   per CPU available). In these earlier versions, there is no benefit to
   installing multiple instances of the MCPClient on the same machine. There
   will still be a benefit in installing multiple instances on different
   machines. See
   :ref:`Scaling out: optimising across multiple machines <scaling-out>`.

The MCPClient accepts batches of files to process at once. Batches are
processed using a single process by default, but some client scripts can run
multi-threaded or fork processes where possible (see `MCPClient concurrency`_
for more details). This approach is a trade-off that delivers significant
improvements in most circumstances.

However, there will be times when certain tasks are not run concurrently, and
CPU becomes underutilized. Deploying multiple instances of the MCPClient
component may improve overall performance, particularly where a machine has
many CPUs.

To deploy another instance of MCPClient on the same machine we recommend
creating an additional `systemd`_ unit. A second unit can be created by
creating another `unit file`_ for the MCPClient service. For example, in CentOS
the existing `MCPClient unit file`_ is located in
`/etc/systemd/system/archivematica-mcp-client.service`.
To add a unit, create a copy of that unit file with a different name, such as\
`/etc/systemd/system/archivematica-mcp-client-two.service`
and ask systemd to reload all unit files using `$ systemctl daemon-reload`.


Optimise batch size for large files
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ``ARCHIVEMATICA_MCPSERVER_MCPSERVER_BATCH_SIZE`` parameter defines the
maximum number of files that will be included in any one batch. The default
value is 128, which is the threshold at which increasing batch size does not
deliver further performance gains.

When processing large files, smaller batch sizes may improve performance when
there is more than one instance of MCPClient available. For example, processing
large audio-visual files can take significant resources and time per file. A
transfer with 100 files in it will all get included in one batch assuming the
default batch size of 128. Reducing the batch size to 25 would result in 4
batches, which would all run concurrently if there were 4 instances of the
MCPClient available.

Currently we do not have detailed recommendations on for optimizations of this
type. We encourage testing and evaluation to find the best settings for your
circumstances.

To set the batch size parameter, see `MCPServer`_ Configuration.

Optimising the number of Dashboard workers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Dashboard process can runs multiple worker processes via Gunicorn.
The ``AM_GUNICORN_WORKERS`` value (default 1) sets the number of workers used.
Increasing this value _may_ help improve Dashboard responsiveness.
See `Dashboard`_ for more details.

Optimising the number of Storage Service workers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Storage Service process can run multiple worker processes via Gunicorn.
The ``SS_GUNICORN_WORKERS`` value (default 1) sets the number of workers used.
Increasing this value _may_ help improve Storage Service responsiveness.

Note that increasing this value may cause database errors if using SQLite.


.. _scaling-out:

Scaling out: optimising across multiple machines
------------------------------------------------

The second general strategy to improve processing speed and capacity is to
distribute some components in the system across more than one machine. This
section sets outs which components can be distributed to other machines and
describes the configuration options available for optimising performance across
those machines.

Distributing components on multiple machines
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Firewall configuration
++++++++++++++++++++++

When installing Archivematica on multiple machines, the various Archivematica
processes must be able to reach each other on the relevant ports. Your firewall
configuration must allow for this.

In particular, please ensure that the Archivematica dashboard can talk to the
Storage Service, and that the pipeline components (i.e., MCPServer, MCPClient)
can talk to Gearman.

In addition, please ensure that the Elasticsearch (``9200``) and MySQL
(``3306``) services are not exposed to the world.

The ports of the Archivematica components and related services are provided
below.

* Archivematica dashboard: ``80`` (``81`` for RPM-based installs)
* Archivematica Storage Service: ``8000`` (``8001`` for RPM-based installs)
* MySQL: ``3306``
* Gearman: ``4730``
* SSH: ``22``
* Elasticsearch: ``9200``
* NFS: ``2049``

Create multiple instances of MCPClient (on a separate machine)
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

As noted above, the MCPClient is responsible for the most significant sources
of load on a machine. Creating instances of the MCPClient on other machines is
the most obvious way to improve concurrent processing.

To create another instance of an MCPClient on another machine:

#. Install the MCPClient using your preferred installation method: manually
   using packages, or by modifying ansible scripts or docker-compose scripts
#. Ensure that the second machine has access to the following shared
   directories, defined in these parameters (see `MCPClient`_ Configuration
   for details):
   ``ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_SHAREDDIRECTORYMOUNTED``
   ``ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_PROCESSINGDIRECTORY``
   ``ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_REJECTEDDIRECTORY``
   ``ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_WATCHDIRECTORYPATH``
#. Ensure the additional MCPClient instance is configured to connect to the
   Gearman server (on the original machine) by setting the following parameter:
   ``ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_MCPARCHIVEMATICASERVER``

It is also possible to restrict an MCPClient to run certain types of tasks, by
editing the list of supported commands in the `archivematicaClientModules`_
file. This might be advantageous where certain commands tend to be run on
certain kinds of objects, allowing you to route particular types of work to
specific MCPClients or machines.

Distribute other components to another machine
++++++++++++++++++++++++++++++++++++++++++++++

It is possible to deploy the Elasticsearch, Gearman and MySQL components on
other machines.
For help, ask on the `Archivematica user forum`_ for more details.

Optimising settings across machines
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Optimize batch size for large files
+++++++++++++++++++++++++++++++++++

This technique will work just as well on multiple machines as it does on one
machine, as described above in :ref:`Scaling up: optimising on one machine <scaling-up>`.

Adjusting timeouts
++++++++++++++++++

Timeout settings are an important tool to mitigate failure scenarios created
when one component can't connect to another. The challenge is to set timeouts
so that they are long enough to allow particular processes to complete, but
not so long that system resources are left idle (or user's time is wasted),
waiting for a response from another component that has failed or can't be
reached due to network connectivity issues.

The standard timeout parameters for each component are used for long-running
(generally asynchronous) processes. "Quick" timeout values are for processes
that are synchronous and short (for instance, when an API is called to return
information to the UI for a waiting user).

The default value for the "Quick" timeouts is optimal for components that are
located on the same machine, and will be adequate in many cases for components
that are distributed to machines that are co-located.

There may be times when timeout values should be increased for distributed
components that are not co-located, or are slower due to the nature of the
communication protocol used.

See `Dashboard`_ Configuration, `MCPClient`_ Configuration, and `MCPServer`_
Configuration for a list of all timeout parameters, their default settings and
instructions for modifying them.

Optimising storage locations
++++++++++++++++++++++++++++

The Storage Service Administrator manual describes the different types of
:ref:`storage locations <storageService:locations>` that Archivematica uses.

In many cases it may be necessary to use different machines for different types
of storage locations. In general, we recommend having the most frequently used
locations (e.g. the "currently processing" location) on a local machine.
Locations that are used less frequently, such as AIP or DIP storage, will have
less impact on performance when distributed to remote storage locations.

.. _config-strategies:

Process configuration strategies
--------------------------------

Optimising what and how preservation actions get executed
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The final strategy for improving the performance and capacity of your
Archivematica deployment is to ensure that Archivematica is only carrying out
the work you deem important and necessary. Archivematica provides a wide
range of preservation actions and the default settings tend to make use of the
majority of them. There are several techniques for limiting which actions are
taken, that can have a significant impact on the overall time and compute
required to process a particular Transfer or SIP.

Environment configuration options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Disable Elasticsearch indexing
++++++++++++++++++++++++++++++

Archivematica uses Elasticsearch to create an index of every Archival
Information Package (AIP) it creates. It also creates an index of any Transfer
that is sent to the backlog. Indexes enable the search functionality from the
Archival Storage tab of the Dashboard (in the case of AIPs) or the Backlog and
Appraisal tabs (in the case of Transfers that were sent to the Backlog).
Indexes contain information on every object in a Transfer or AIP.

If a user chooses (whether in the dashboard or by configuration) to send
Transfers to the Backlog, the "Index Transfer Contents" job is run as part of
the "Create SIP From Transfer Microservice". At the end of the Ingest process
(in all cases) an Index is created as part of the "Store AIP" Microservice.

The larger a Transfer or AIP is, the longer it will take to create the Index.
Some users have found that Indexing can fail on very large Transfers or AIPS
(e.g. with many thousands of files).

Use of Elasticsearch is optional. Installing `Archivematica without
Elasticsearch <install-elasticsearch>` or with limited Elasticsearch
functionality means reduced consumption of compute resources and lower
operational complexity. Fully or partially disabling Elasticsearch means that
the Backlog, Appraisal, and Archival Storage tabs may not appear and their
functionality is not available.

See :ref:`Upgrade in indexless mode <upgrade-indexless>` for more details.

Allow indexing to fail
++++++++++++++++++++++

Indexing very large datasets can be so resource-intensive that indexing will
fail. By default, Archivematica will abort processing and invoked the
"Failed SIP" microservice.

The ``ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_INDEX_AIP_CONTINUE_ON_ERROR`` parameter
can be set to allow indexing to fail. When this is set and indexing fails,
the AIP will carry on with processing and be stored. It can't be found using
the normal search features in the Appraisal and Archival Storage tabs.

This feature doesn't optimize performance so much as mitigate performance
limitations. See `MCPClient`_ Configuration for details.

Disabling task output
+++++++++++++++++++++

Archivematica allows users to configure their MCPClient(s) in order to control
whether or not output streams (stdout and stderr) from the client scripts are
captured and then passed from the task workers to the task manager
(the MCPServer). Disabling task output will provide performance improvements.

See :ref:`Task output capturing configuration <task-output-capturing-admin>`.

Processing configuration options
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The :ref:`Processing configuration <dashboard-processing>` screen provides many
options for controlling what actions Archivematica performs. The following
settings can improve performance.

**Select file format identification command (Transfer):** Using Siegfried for
file identification has been shown to be faster than Fido in this
`benchmarking`_ study. See :ref:`Identification <identification>` for more information.

**Select file format identification command (Ingest):** If you are using the
Archivematica backlog and have accumulated items in the backlog for a long
period of time, e.g. months or even years, then you might want Archivematica to
refresh its file format identification at the Ingest stage of the workflow. If
Ingest is happening shortly after Transfer, selecting `Use existing data`
should be adequate and will save processing time.

**Generate thumbnails:** If you are generating thumbnails, selecting `yes
without defaults` will only generate thumbnail images for formats that have a
specific thumbnail rule defined. The default thumbnail rule only produces a
grey icon and for many formats has little value, but in transfers with many
files, can take significant processing time. It is also possible to disable
generation of thumbnails entirely by selecting  `no`.

**Select compression algorithm:** AIP compression causes an AIP to be put into
a container (e.g. a 7Zip container).  Using containers makes AIP storage and
transfer easier because the AIP is easier to move around as a single file. The
AIP file size also has the potential to be reduced, which saves storage space
and speeds up transfers to external AIP stores. The disadvantage is that
compression can take significant processing time and resources. AIP compression
introduces three extra steps in the workflow: compression to create the
container, then decompression to allow for a final checksum validation step. In
transfers with very large numbers of files (thousands) we have seen significant
performance improvements by not compressing the AIP.

**Select compression level:** Selecting a higher compression level means that
the resulting AIP is smaller, but compression also takes longer. Lower
compression levels mean quicker compression, but a larger AIP.

.. _disable-fpr-rules:

Preservation action rules
^^^^^^^^^^^^^^^^^^^^^^^^^

Some of the default preservation action rules can take considerable processing
time and resources. We have found the following rules useful to change in some
cases.

**Turn off default characterization rule:** `FITS`_ is used to characterise files
that don't have a recognised file format. Executing this rule takes processing
time and adds raw output to the METS file that can be low value for some
formats. For example, in scientific datasets with large numbers of generic text
files, or binary files created by instruments in scientific experiments, the
output can be verbose without being useful.

**Reduce number of image characterization rules:** Archivematica has rules
defined for all image and audio-visual formats to use ExifTool, Mediainfo and
ffprobe for characterisation. Using multiple tools ensures as much
characterization output as possible, but also introduces some level of
duplication. Only using one of the three tools for certain formats may provide
an adequate level of characterization with the benefit of reducing processing
time and the size of the final AIP.

See :ref:`Characterization <characterization>` and
:ref:`Altering commands and rules <altering-commands-rules>` for more details.

General Configuration Settings
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**Checksum Algorithm:** In the :ref:`General settings <dashboard-general>`
screen you can select which checksum algorithm Archivematica will use during
the Assign UUIDs and checksums microservice. For the purposes of fixity
checking, the MD5 algorithm may be adequate and takes less processing time
to create (and check) than the alternatives (e.g. SHA-256).

:ref:`Back to the top <scaling-archivematica>`

.. _MCPServer: https://github.com/artefactual/archivematica/tree/6ead2083f7bdd8b10ca76d41a7bff9c5aee23eb3/src/MCPServer/install
.. _MCPClient: https://github.com/artefactual/archivematica/tree/6ead2083f7bdd8b10ca76d41a7bff9c5aee23eb3/src/MCPClient
.. _MCPClient concurrency: https://github.com/artefactual/archivematica/tree/6ead2083f7bdd8b10ca76d41a7bff9c5aee23eb3/src/MCPClient#concurrency
.. _systemd: https://en.wikipedia.org/wiki/Systemd
.. _unit file: https://www.freedesktop.org/software/systemd/man/systemd.unit.html
.. _MCPClient unit file: https://raw.githubusercontent.com/artefactual-labs/am-packbuild/qa/1.x/rpm/archivematica/etc/archivematica-mcp-client.service
.. _archivematicaClientModules: https://github.com/artefactual/archivematica/blob/84661775836cf8037ad3b48feb8e02bb80335f0f/src/MCPClient/lib/archivematicaClientModules
.. _Archivematica user forum: https://groups.google.com/forum/#!forum/archivematica
.. _Dashboard: https://github.com/artefactual/archivematica/tree/6ead2083f7bdd8b10ca76d41a7bff9c5aee23eb3/src/dashboard/install
.. _benchmarking: https://www.itforarchivists.com/siegfried/benchmarks
.. _FITS: https://projects.iq.harvard.edu/fits/home
