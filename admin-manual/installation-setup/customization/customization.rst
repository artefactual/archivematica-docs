.. _customization:

============================
Customization and automation
============================

*On this page*

* :ref:`Administration tab <config-admin-tab>`
* :ref:`Automating microservice decisions using the dashboard <config-using-dashboard>`
* :ref:`Preservation planning configuration <config-using-fpr>`
* :ref:`Antivirus configuration <antivirus-config>`
* :ref:`Resources for development configuration <development-config>`
* :ref:`Task output capturing configuration <task-config>`
* :ref:`Customizing for scalability and performance <customize-scalability>`

.. _config-admin-tab:

Administration tab
------------------

Archivematica's Administration tab is where users and administrators can create
users, change the language of the interface, review storage locations, and set
configuration details like DIP upload integrations and PREMIS agent information.
For more information about the Administration tab, see :ref:`Dashboard
Administration tab <dashboard-config>`.

.. _config-using-dashboard:

Automating microservice decisions using the dashboard
-----------------------------------------------------

It is possible for administrators or end-users to automate almost all of
Archivematica's workflow decision points by changing the default processing
configuration through the Administration tab. For more information, please see
:ref:`Processing configuration <process-config>`.

You can also automate workflow choices by placing a ``processingMCP.xml`` file
into the root directory of your transfer. For more information about the
processingMCP file and how to use it, please see :ref:`Using a custom processing
configuration file <processingmcp-file>`.

.. _config-using-fpr:

Preservation planning configuration
-----------------------------------

The Preservation Planning tab allows users to edit, add, or disable commands for
a variety of preservation tasks, including identification, characterization,
normalization, validation, and verification. Please see the :ref:`Preservation
Planning <preservation-planning>` documentation for more information.

.. _antivirus-config:

Antivirus configuration
-----------------------

Archivematica's antivirus capabilities can be customized by editing various
operating system environment variables. Please see :ref:`Antivirus
Administration <antivirus-admin>` for more information.

.. _email-config:

Email notification configuration
--------------------------------

Archivematica's MCPClient sends two types of email reports:

* Normalization reports are sent when the normalization process has resulted in
  at least one error.
* Failure reports are sent when the workflow fails unexpectedly.

The email reports are sent to all users who have an account on the pipeline.
Currently, there is no way to configure which users receive the email. If you
don't want a user to receive the email, the easiest way to disable this is to
change the email address associated with the user to an invalid one.

If you are running a QA environment, it is possible that your only registered
user is ``demo@example.com``. Be aware that Archivematica ignores this address
and will not send notifications to it. If you want to test the email reporting
functionality make sure to register a functional email address for a user.

Currently, emails are only sent by MCPClient. This means that in order to
configure the email backend settings, changes are required in the MCPClient
service configuration. For example, you can use the following environment
strings to send emails via a local MTA such as Postfix::

    ARCHIVEMATICA_MCPCLIENT_EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend
    ARCHIVEMATICA_MCPCLIENT_EMAIL_HOST=127.0.0.1
    ARCHIVEMATICA_MCPCLIENT_EMAIL_PORT=25

For more information about configuring the MCPClient, please see the
`MCPClient configuration documentation`_.

Archivematica sends emails using the Django Web Framework. You can install
third-party packages like ``django-ses`` to support additional email backends.
Packages must be installed in the Python environment of MCPClient.

.. _development-config:

Resources for development configuration
---------------------------------------

If you are working on developing Archivematica, it may be helpful to

A common area for development work is the MCP (Master Control Program). The MCP
is the core of Archivematica, and controls the various microservices that
Archivematica uses to carry out preservation tasks. Developers who wish to
modify the MCP configuration should consult the following resources on the
Archivematica wiki:

* `MCP`_
* `Basic MCP configuration`_

For other development resources, please see the `Development`_ section of the
Archivematica wiki.

.. _task-config:

Task output capturing configuration
-----------------------------------

When Archivematica's MCP client (a Gearman worker) runs a client script in order
to perform a preservation task, e.g., normalizing a single file, that client
script may write data to standard streams, i.e., standard output (stdout) or
standard error (stderr). By default, the worker serializes those outputs and
sends them back to the MCP server (the task manager), at which point they are
stored in the database (the ``Tasks`` table). However, in some cases these
outputs may be quite large and the job of serializing and moving them around can
have a noticeable performance impact. For this reason, Archivematica allows
users to configure their MCP clients in order to control whether or not these
output streams are captured. See :ref:`Task output capturing configuration
<task-output-capturing-admin>` for more details.

.. _customize-scalability:

Customizing for scalability and performance
-------------------------------------------

Archivematica includes a number of features and options to improve scalability
& performance. The default configuration options are geared towards "typical"
use cases and for many users won't require any modification. However, some
users will benefit from optimizing configuration options to meet their
specific preservation needs & available computing resources.

See :ref:`Scaling Archivematica <scaling-archivematica>` for a description of
three broad approaches to scaling & optimization and the specific techniques
available to each approach.

:ref:`Back to the top <customization>`

.. _`MCP`: https://wiki.archivematica.org/MCP
.. _`Basic MCP configuration`: https://wiki.archivematica.org/MCPServer#Config_File
.. _`Development`: https://wiki.archivematica.org/Development
.. _`MCPClient configuration documentation`: https://github.com/artefactual/archivematica/blob/qa/1.x/src/MCPClient/install/README.md
