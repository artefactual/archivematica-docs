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
the :ref:`Archivematica Docker repo <docker>`.


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

For help, send an email to the `archivematica-tech`_ mailing list.

Firewall
^^^^^^^^

When installing Archivematica on multiple machines, all the machines must be
able to reach each other on the following ports: : ``http``, ``mysqld``,
``gearman``, ``nfs``, ``ssh``.

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
.. _`docker`: https://github.com/artefactual-labs/am/tree/master/compose
