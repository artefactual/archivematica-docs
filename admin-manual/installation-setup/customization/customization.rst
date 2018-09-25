.. _customization:

============================
Customization and automation
============================

*On this page*

* :ref:`Configuring microservices using the dashboard <config-using-dashboard>`
* :ref:`Preservation planning configuration <config-using-fpr>`
* :ref:`Antivirus configuration <antivirus-config>`
* :ref:`Resources for development configuration <development-config>`
* :ref:`Task output capturing configuration <task-config>`

.. _config-using-dashboard:

Configuring microservices using the dashboard
---------------------------------------------

It is possible for administrators or end-users to automate almost all of
Archivematica's microservices by preconfiguring choices using the
:ref:`Administration tab <dashboard-config>` of the dashboard.

.. _config-using-fpr:

Preservation planning configuration
-----------------------------------

The Preservation Planning tab allows editing or addition of commands for
identification, tools, characterization, event detail, extraction, normalization,
transcription, validation and verification. Please see the
:ref:`Format Policy Registry (FPR) documentation <fpr:index>` for instruction.

.. _antivirus-config:

Antivirus configuration
-----------------------

Antivirus can be customized through various operating system environment
variables rather than via the Dashboard. See :ref:`Antivirus Administration
<antivirus-admin>`

.. _development-config:

Resources for development configuration
---------------------------------------

When processing a SIP or transfer, you may automate workflow choices by putting
a ``processingMCP.xml`` file into the root directory of a SIP/transfer. See
:ref:`Processing configuration <process-config>`.

The MCP is the core of the Archivematica system. It controls the various
micro-services in the Archivematica system. Developers who wish to modify the
MCP configuration should consult the following resources on the Archivematica
wiki:

* `MCP <https://www.archivematica.org/wiki/MCP>`_

* `Basic MCP configuration <https://wiki.archivematica.org/MCPServer#Config_File>`_

For other development resources, please see the
`Development <https://www.archivematica.org/wiki/Development>`_ section of our
wiki.

.. _task-config:

Task output capturing configuration
-----------------------------------

When Archivematica's MCP client (a Gearman worker) runs a client script in
order to perform a preservation task, e.g., normalizing a single file, that
client script may write data to standard streams, i.e., standard output
(stdout) or standard error (stderr). By default, the worker serializes those
outputs and sends them back to the MCP server (the task manager), at which
point they are stored in the database (the ``Tasks`` table). However, in some
cases these outputs may be quite large and the job of serializing and moving
them around can have a noticeable performance impact. For this reason,
Archivematica allows users to configure their MCP clients in order to control
whether or not these output streams are captured. See
:ref:`Task output capturing configuration <task-output-capturing-admin>` for
more details.


:ref:`Back to the top <customization>`
