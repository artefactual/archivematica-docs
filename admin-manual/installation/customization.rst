.. _customization:

============================
Customization and automation
============================

Some workflow and processing decisions can be made or viewed in the dashboard and
others are created at the development level.

Resources for dashboard configuration
-------------------------------------

The Preservation Planning tab allows editing or addition of commands for
identification, tools, characterization, event detail, extraction, normalization,
transcription, validation and verification. Please see the
:ref:`Format Policy Registry (FPR) documentation <fpr:index>` for instruction.

Basic workflow configuration is feasible by administrators or end-users in the
:ref:`Administration tab <dashboard-admin>` of the dashboard.


Resources for development configuration
---------------------------------------

When processing a SIP or transfer, you may automate workflow choices by putting a
``processingMCP.xml`` file into the root directory of a SIP/transfer.
See :ref:`Processing configuration <process-config>`.

The MCP is the core of the Archivematica system. It controls the various
micro-services in the Archivematica system. Developers who wish to modify the
MCP configuration should consult the following resources on the Archivematica
wiki:

* `MCP <https://www.archivematica.org/wiki/MCP>`_

* `Basic MCP configuration <https://wiki.archivematica.org/MCPServer#Config_File>`_

For other development resources, please see the
`Development <https://www.archivematica.org/wiki/Development>`_ section of our wiki.

:ref:`Back to the top <customization>`
