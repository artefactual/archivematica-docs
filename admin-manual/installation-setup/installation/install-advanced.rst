.. _install-advanced:

=============================
Advanced installation options
=============================

*On this page*

* :ref:`Installing for development <development>`
* :ref:`Installing across multiple machines <multiple-machines>`
* :ref:`Configuring Archivematica with SSL <SSL-support>`

.. _development:

Install for development
-----------------------

The recommended way to install Archivematica for development is with Docker.
For instructions on how to deploy Archivematica in Docker containers, see
the `Archivematica Docker repo`_.


It's also possible to deploy Archivematica using Ansible and Vagrant. For
instructions on how to install Archivematica from a virtual machine, see the
`Ansible & Vagrant Installation instructions <https://wiki.archivematica.org/Getting_started#Installation>`_
on the Archivematica wiki. See also instructions for installation on a
virtual machine using Vagrant in the :ref:`Quick Start Guide <quick-start-install>`.


.. _multiple-machines:

Installing across multiple machines
-----------------------------------

It is possible to spread Archivematica's processing load across several machines
by installing the following services on separate machines:

* Elasticsearch
* Gearman
* MySQL

For help, ask on the `Archivematica user forum`_ for more details.

Firewall
^^^^^^^^

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

.. _SSL-support:

Configure Archivematica with SSL
--------------------------------

Archivematica can be configured for HTTPS following the sample configurations for
`dashboard <https://github.com/artefactual-labs/ansible-archivematica-src/blob/qa/1.7.x/templates/etc/nginx/sites-available/dashboard-ssl.conf.j2>`_
and
`storage-service <https://github.com/artefactual-labs/ansible-archivematica-src/blob/qa/1.7.x/templates/etc/nginx/sites-available/storage-ssl.conf.j2>`_.

In order to obtain valid SSL certificates trusted by any browser, you can use `Let's Encrypt <https://letsencrypt.org>`_.

:ref:`Back to the top <install-advanced>`

.. _`archivematica-tech`: https://groups.google.com/forum/#!forum/archivematica-tech
.. _`Archivematica Docker repo`: https://github.com/artefactual-labs/am/tree/master/compose
.. _`Archivematica user forum`: https://groups.google.com/a/artefactual.com/forum/#!forum/archivematica
