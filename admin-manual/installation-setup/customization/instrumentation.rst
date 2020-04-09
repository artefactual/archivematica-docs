.. _instrumentation:

===========================
Performance instrumentation
===========================

.. _instrumentation-overview:

Overview
--------

Archivematica includes features to collect metrics related to processing and
performance over time. When configured to do so, Archivematica and Archivematica
Storage Service will export metrics over HTTP, in a format that can be scraped
by tools like `Prometheus`_ for storage and analysis. This data can then be
visualized using a tool like `Grafana`_.

Instrumentation provides short term, near real time insight into how an
Archivematica pipeline is performing.

*On this page:*

* :ref:`Prometheus <instrumentation-prometheus>`
* :ref:`Grafana <instrumentation-grafana>`
* :ref:`Available metrics <instrumentation-available-metrics>`

  * :ref:`MCP Client metrics <mcp-client-metrics>`
  * :ref:`MCP Server metrics <mcp-server-metrics>`
  * :ref:`Dashboard metrics <dashboard-metrics>`
  * :ref:`Storage Service metrics <storage-service-metrics>`

* :ref:`Configuration <instrumentation-configuration>`

  * :ref:`Configure Prometheus <configure-prometheus>`
  * :ref:`Configure Grafana <configure-grafana>`

.. _instrumentation-prometheus:

Prometheus
----------

`Prometheus`_ is an open source tool for scraping, storing, and querying time
series data. Each metric has a name and a series of values over time.

One example of a metric commonly used for Archivematica is **AIPs Stored
Count**, or the number of AIPs stored over time. The value would be ``0`` when
the pipeline is first created, increasing to ``1`` after the first AIP is
stored.

There are a few things to be aware of when using Prometheus with Archivematica:

* The Prometheus web interface is not authenticated; by default it runs on port
  9090 and is open to anyone. Access should be restricted from the public
  internet via firewall. Likewise, the metrics endpoints on Archivematica are
  unauthenticated. If your Archivematica instance is publicly available over the
  internet, you should restrict access to ``/metrics`` URLs via firewall.

* Prometheus scrapes data from Archivematica at a configured interval, and
  doesn’t know when value changes have occurred between scrapes. If the scrape
  interval is set to 15 seconds, that will be the value you will see in the
  data, even if the previous scrape interval was 60 seconds.

* Prometheus is intended for short term data storage. By default it will store
  metrics for 15 days. To change this, pass a larger value (e.g. ``60d``) to
  ``--storage.tsdb.retention.time`` when starting Prometheus.

For more information about configuring Prometheus, please see the
`Prometheus documentation`_.

.. _instrumentation-grafana:

Grafana
-------

`Grafana`_ is an open source tool for visualising data. It is highly
configurable and provides many options to visualise the data stored in
Prometheus in useful ways. Grafana can be configured nearly any way you like;
experimenting with new dashboards can be done via the web interface and is
encouraged. The default Archivematica dashboard we provide is only intended as a
starting point.


.. _instrumentation-available-metrics:

Available metrics
-----------------

Archivematica makes use of various `Prometheus metric types`_. Counters are
numeric values that only ever increase. Gauges are numeric values that can
increase or decrease. Histograms and summaries provide both a count and a sum of
values, and can be broken out over quantiles (often thought of as percentiles,
so a 0.95 quantile is the 95th percentile).

.. _mcp-client-metrics:

MCP Client metrics
++++++++++++++++++

* ``mcpclient_job_total`` (Counter): number of jobs processed, labeled by
  script.
* ``mcpclient_job_success_timestamp`` (Gauge): timestamp of most recent job
  processed, labeled by script.
* ``mcpclient_job_error_total`` (Counter): number of failures processing jobs,
  labeled by script.
* ``mcpclient_job_error_timestamp`` (Gauge): timestamp of most recent job
  failure, labeled by script.
* ``mcpclient_task_execution_time_seconds`` (Histogram): histogram of worker
  task execution times in seconds, labeled by script.
* ``mcpclient_gearman_sleep_time_seconds`` (Counter): total worker sleep after
  gearman error times in seconds.
* ``mcpclient_transfer_started_total`` (Counter): number of Transfers started,
  by transfer type.
* ``mcpclient_transfer_started_timestamp`` (Gauge): timestamp of most recent
  transfer started, by transfer type.
* ``mcpclient_transfer_completed_total`` (Counter): number of Transfers
  completed, by transfer type.
* ``mcpclient_transfer_completed_timestamp`` (Gauge): timestamp of most recent
  transfer completed, by transfer type.
* ``mcpclient_transfer_error_total`` (Counter): number of transfer failures, by
  transfer type, error type.
* ``mcpclient_transfer_error_timestamp`` (Gauge): timestamp of most recent
  transfer failure, by transfer type, error type.
* ``mcpclient_transfer_files`` (Histogram): histogram of number of files
  included in transfers, by transfer type.
* ``mcpclient_transfer_size_bytes`` (Histogram): histogram of number of bytes in
  transfers, by transfer type.
* ``mcpclient_sip_started_total`` (Counter): number of SIPs started.
* ``mcpclient_sip_started_timestamp`` (Gauge): timestamp of most recent SIP
  started.
* ``mcpclient_sip_error_total`` (Counter): number of SIP failures, by error
  type.
* ``mcpclient_sip_error_timestamp`` (Gauge): timestamp of most recent SIP
  failure, by error type.
* ``mcpclient_aips_stored_total`` (Counter): number of AIPs stored.
* ``mcpclient_aips_stored_timestamp`` (Gauge): timestamp of most recent AIP
  stored.
* ``mcpclient_dips_stored_total`` (Counter): number of DIPs stored.
* ``mcpclient_dips_stored_timestamp`` (Gauge): timestamp of most recent DIP
  stored.
* ``mcpclient_aip_processing_seconds`` (Histogram): histogram of AIP processing
  time, from first file recorded in DB to storage in SS.
* ``mcpclient_dip_processing_seconds`` (Histogram): histogram of DIP processing
  time, from first file recorded in DB to storage in SS.
* ``mcpclient_aip_files_stored`` (Histogram): histogram of number of files
  stored in AIPs. Note, this includes metadata, derivatives, etc.
* ``mcpclient_dip_files_stored`` (Histogram): histogram of number of files
  stored in DIPs.
* ``mcpclient_aip_size_bytes`` (Histogram): histogram of number of bytes stored
  in AIPs. Note, this includes metadata, derivatives, etc.
* ``mcpclient_dip_size_bytes`` (Histogram): histogram of number of bytes stored
  in DIPs. Note, this includes metadata, derivatives, etc.
* ``mcpclient_aip_files_stored_by_file_group_and_format_total`` (Counter):
  number of original files stored in AIPs labeled by file group, format name.
  Note: format labels are `intentionally not zeroed`_, so be aware of that when
  querying.
* ``mcpclient_aip_original_file_timestamps`` (Histogram): histogram of
  modification times for files stored in AIPs, bucketed by year.
* ``archivematica_info`` (Info): Archivematica version information.
* ``environment_info`` (Info): environment variable (configuration) information.

.. _mcp-server-metrics:

MCP Server metrics
++++++++++++++++++

* ``mcpserver_gearman_active_jobs`` (Gauge): Number of gearman jobs currently
  being processed.
* ``mcpserver_gearman_pending_jobs`` (Gauge): Number of gearman jobs pending
  submission.
* ``mcpserver_task_total`` (Counter): Number of tasks processed, labeled by task
  group, task name.
* ``mcpserver_task_error_total`` (Counter): Number of failures processing tasks,
  labeled by task group, task name.
* ``mcpserver_task_success_timestamp`` (Gauge): Most recent successfully
  processed task, labeled by task group, task name.
* ``mcpserver_task_error_timestamp`` (Gauge): Most recent failure when
  processing a task, labeled by task group, task name.
* ``mcpserver_task_duration_seconds`` (Histogram): Histogram of task processing
  durations in seconds, labeled by task group, task name, script name.
* ``archivematica_info`` (Info): Archivematica version information.
* ``environment_info`` (Info): Environment variable (configuration) information.

.. _dashboard-metrics:

Dashboard metrics
+++++++++++++++++

The dashboard includes a large number of metrics provided by the
`django-prometheus`_ package. These break down the number of HTTP requests, as
well as request size, latency, errors, etc in a number of ways. They are
primarily useful for developers working on the dashboard, although a number
(e.g. ``django_http_requests_latency_including_middlewares_seconds`` for request
latency or ``django_http_responses_total_by_status`` for number of HTTP
responses) are useful for general reporting.

* ``django_http_responses_before_middlewares_total`` (Counter): Total count of requests before middlewares run
* ``django_http_requests_before_middlewares_total`` (Counter): Total count of responses before middlewares run
* ``django_http_requests_latency_including_middlewares_seconds`` (Histogram): Histogram of requests processing time (including middleware processing time)
* ``django_http_requests_unknown_latency_including_middlewares_total`` (Counter): Count of requests for which the latency was unknown (when computing * django_http_requests_latency_including_middlewares_seconds)
* ``django_http_requests_latency_seconds_by_view_method`` (Histogram): Histogram of request processing time labelled by view
* ``django_http_requests_unknown_latency_total`` (Counter): Count of requests for which the latency was unknown
* ``django_http_ajax_requests_total`` (Counter): Count of AJAX requests
* ``django_http_requests_total_by_method`` (Counter): Count of requests by method
* ``django_http_requests_total_by_transport`` (Counter): Count of requests by transport
* ``django_http_requests_total_by_view_transport_method`` (Counter): Count of requests by view, transport, method
* ``django_http_requests_body_total_bytes`` (Histogram): Histogram of requests by body size
* ``django_http_responses_total_by_templatename`` (Counter): Count of responses by template name
* ``django_http_responses_total_by_status`` (Counter): Count of responses by status
* ``django_http_responses_total_by_status_view_method`` (Counter): Count of responses by status, view, method
* ``django_http_responses_body_total_bytes`` (Histogram): Histogram of responses by body size
* ``django_http_responses_total_by_charset`` (Counter): Count of responses by charset
* ``django_http_responses_streaming_total`` (Counter): Count of streaming responses
* ``django_http_exceptions_total_by_type`` (Counter): Count of exceptions by object type
* ``django_http_exceptions_total_by_view`` (Counter): Count of exceptions by view
* ``django_model_save_total`` (Counter): Total model save calls labeled by model class
* ``django_model_delete_total`` (Counter): Total model save calls labeled by model class

The dashboard also includes additional metrics:
common_db_retry_time_seconds (Counter): Total time waiting to retry database transactions in seconds, labeled by operation description
common_ss_api_request_duration_seconds (Counter): Total time waiting on the Storage Service API in seconds, labeled by function

.. _storage-service-metrics:

Storage Service metrics
+++++++++++++++++++++++

The Storage Service includes all the same Django-based metrics as the Dashboard.

.. _instrumentation-configuration:

Configuration
-------------

The following environment variables will turn on metrics capturing and export in
Archivematica (provided with example values):

* ``ARCHIVEMATICA_MCPSERVER_MCPSERVER_PROMETHEUS_BIND_PORT=7998``
* ``ARCHIVEMATICA_MCPSERVER_MCPSERVER_PROMETHEUS_BIND_ADDRESS=0.0.0.0``
* ``ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_PROMETHEUS_BIND_PORT=7999``
* ``ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_PROMETHEUS_BIND_ADDRESS=0.0.0.0``
* ``ARCHIVEMATICA_DASHBOARD_DASHBOARD_PROMETHEUS_ENABLED=true``
* ``SS_PROMETHEUS_ENABLED=true``

For more documentation on these, see the README files for the `Dashboard`_,
`MCPClient`_, `MCPServer`_, and `Storage Service`_ (make sure to select the
correct branch from the branch dropdown menu if you are not using Archivematica
qa/1.x / Storage Service qa/0.x). Note that you don’t need to export metrics for
all services.

If you are running multiple MCPClients, each of them must have a different port
set.

Once the environment variables have been set, restart the Archivematica
services and confirm that you can access the ``/metrics`` path on each of the
ports given (e.g. ``http://<am-hostname>:62080/metrics``). It should return a
block of text that looks like this:

.. code:: bash

   # HELP django_http_requests_latency_seconds_by_view_method Histogram of request processing time labelled by view.
   # TYPE django_http_requests_latency_seconds_by_view_method histogram
   django_http_requests_latency_seconds_by_view_method_bucket{le="0.005",method="POST",view="components.api.views.wrapper"} 0.0
   django_http_requests_latency_seconds_by_view_method_bucket{le="0.01",method="POST",view="components.api.views.wrapper"} 0.0

.. _configure-prometheus:

Configure Prometheus
++++++++++++++++++++

Once Archivematica is configured to export variables, you can set up Prometheus
to scrape data from it.

First, `download and install Prometheus`_.

Create a Prometheus configuration file (in this example, it's a YAML file called
``prometheus.yml``). If you are running all Archivematica components on a single
host, a good starting point is:

.. code:: yaml

   scrape_configs:
   - job_name: archivematica
     scrape_interval: 5s
     static_configs:
     - targets:
	     - localhost:7998
	     - localhost:7999
	     - localhost:62080
	     - localhost:62081

Start Prometheus, passing in the path to the config file: ``./prometheus
--config.file=prometheus.yml``.

You should be able to view the Prometheus web interface at
``http://<hostname>:9090``. Under Status -> Targets in the menu bar, you’ll be
able to see the status of the various Archivematica services.

.. _configure-grafana:

Configure Grafana
+++++++++++++++++

Once you have Prometheus storing metrics, Grafana can be set up so that you can
view them.

First, `download and install Grafana`_.

After following the installation guide for your platform, you can login to the
web interface (``http://<hostname>:3000/``, username: admin, password: admin). Note
that the Grafana web interface can be exposed to the internet (after changing
the default password), although you may wish to limit access.

Once you have logged into the Grafana interface, `add Prometheus as a data
source`_. After clicking **Save & Test**, you should see a “Data source is
working” message.

Now you need to import a dashboard. There is a basic Archivematica dashboard
available in Archivematica's `Docker compose environment`_, or you can `download
the dashboard JSON file`_ directly from GitHub. In Grafana, under Dashboards ->
Manage, choose **Import**, then either paste the JSON into the text box or save
the dashboard as a file and upload it.

.. _Prometheus: https://prometheus.io/
.. _Prometheus documentation: https://prometheus.io/docs/introduction/overview/
.. _Grafana: https://grafana.com/
.. _Prometheus metric types: https://prometheus.io/docs/concepts/metric_types/
.. _intentionally not zeroed: https://www.robustperception.io/existential-issues-with-metrics
.. _django-prometheus: https://github.com/korfuri/django-prometheus
.. _Dashboard: https://github.com/artefactual/archivematica/blob/qa/1.x/src/dashboard/install/README.md
.. _MCPClient: https://github.com/artefactual/archivematica/blob/qa/1.x/src/MCPClient/install/README.md
.. _MCPServer: https://github.com/artefactual/archivematica/blob/qa/1.x/src/MCPServer/install/README.md
.. _Storage Service: https://github.com/artefactual/archivematica-storage-service/blob/qa/0.x/install/README.md
.. _download and install Prometheus: https://prometheus.io/docs/prometheus/latest/installation/
.. _download and install Grafana: https://grafana.com/grafana/download
.. _add Prometheus as a data source: https://grafana.com/docs/grafana/latest/features/datasources/prometheus/#adding-the-data-source-to-grafana
.. _Docker compose environment: https://github.com/artefactual-labs/am/tree/master/compose
.. _download the dashboard JSON file: https://github.com/artefactual-labs/am/blob/master/compose/etc/grafana/provisioning/dashboards/Archivematica.json
