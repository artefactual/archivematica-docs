.. _task-output-capturing-admin:

===================================
Task output capturing configuration
===================================

Archivematica allows users to configure their MCP client(s) in order to control
whether or not output streams (stdout and stderr) from the client scripts are
captured and then passed from the task workers to the task manager (the MCP
server).

In the default configuration, these output streams *are* captured. In this
state, when a user clicks on the gear icon of a microservice in order to view
the tasks that have run, each task representation will contain a section
entitled ``Standard streams`` which will contain a sub-section entitled
``Standard output (stdout)`` containing the stdout from the client script and
another entitled ``Standard error (stderr)`` containing the stderr.

However, in some cases, serializing these output streams and moving them around
(*capturing* them) can have a non-trivial performance cost. (We have measured a
6% reduction in processing time for some transfers when output capturing is
disabled.) Archivematica can be configured to avoid paying this cost by
disabling the capturing of these output streams. The trade-off for doing this
is that the stdout and stderr that documents the running of a preservation task
will no longer be stored in the database and it will no longer be displayed in
the tasks interface.

In order to configure Archivematica to stop capturing output streams, one must
set the ``ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_CAPTURE_CLIENT_SCRIPT_OUTPUT``
environment variable to ``false`` before starting (or re-starting) the MCP
client process. The way that Archivematica environment variables are set
depends on the deployment method used. Please consult the relevant
documentation for your deployment method if you are interested in disabling
output capturing.

- :ref:`Environment variable configuration for CentOS package-based installations <install-pkg-centos>`
- :ref:`Environment variable configuration for Ubuntu package-based installations <install-pkg-ubuntu>`
- :ref:`Environment variable configuration for Ubuntu Ansible-based installations <install-ansible>`
- `Environment variable configuration for Docker Compose installations <https://github.com/artefactual-labs/am/tree/master/compose>`_

Note that when output capturing is disabled the stdout will *never* be captured
while the *stderr* will only be captured when the preservation task returns a
non-zero exit code (i.e., when it fails). This allows the user to get the
performance benefits while still having useful debugging information in the
case where a task fails.

.. tip::

   It is also possible to tweak the configuration of your database server in
   order to push the existing limits further. This can be a good solution for
   users familiar with the MySQL storage engine. In particular we have had some
   success increasing the InnoDB log file size (``innodb_log_file_size``). See
   `Should MySQL update the default innodb_log_file_size?`_ for more. In the
   long term, we expect to find better ways to store task results - if you are
   interested, please see `issue #314`_.

:ref:`Back to the top <task-output-capturing-admin>`

.. _`Should MySQL update the default innodb_log_file_size?`: https://www.percona.com/blog/2011/11/21/should-mysql-update-the-default-innodb_log_file_size/
.. _`issue #314`: https://github.com/archivematica/Issues/issues/314
