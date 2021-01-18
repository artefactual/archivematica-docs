.. _install-advanced:

=============================
Advanced installation options
=============================

*On this page*

* :ref:`Installing for development <development>`
* :ref:`Scaling Archivematica <installation-scaling>`
* :ref:`Configuring Archivematica with SSL <SSL-support>`

.. _development:

Install for development
-----------------------

The recommended way to install Archivematica for development is with Docker.
For instructions on how to deploy Archivematica in Docker containers, see
the `development environment instructions`_.

It's also possible to deploy Archivematica using Ansible and Vagrant. For
instructions on how to install Archivematica from a virtual machine, see the
`Ansible & Vagrant installation instructions`_ on the Archivematica wiki. See
also instructions for installation on a virtual machine using Vagrant in the
:ref:`Quick Start Guide <quick-start-install>`.

.. _installation-scaling:

Scaling Archivematica
---------------------

There are several approaches to installing and configuring Archivematica
to handle large volumes of data and improve system performance.

The :ref:`Scaling Archivematica <scaling-archivematica>` section includes:

* :ref:`Scaling up: optimising on one machine <scaling-up>`
* :ref:`Scaling out: optimising across multiple machines <scaling-out>`
* :ref:`Process configuration strategies <config-strategies>`

.. _SSL-support:

Configure Archivematica with SSL
--------------------------------

Archivematica can be configured for HTTPS following the
`sample configurations for the dashboard`_
and `sample configurations for the Storage Service`_.

In order to obtain valid SSL certificates trusted by any browser, you can use
`Let's Encrypt`_.

:ref:`Back to the top <install-advanced>`

.. _`development environment instructions`: https://github.com/artefactual/archivematica/tree/qa/1.x/hack
.. _`Ansible & Vagrant installation instructions`: https://wiki.archivematica.org/Getting_started#Installation
.. _`sample configurations for the dashboard`: https://github.com/artefactual-labs/ansible-archivematica-src/blob/8b2aee1ba90053d030c31f3b8d0e5b0f14fcf57c/templates/etc/nginx/sites-available/dashboard-ssl.conf.j2
.. _`sample configurations for the Storage Service`: https://github.com/artefactual-labs/ansible-archivematica-src/blob/8b2aee1ba90053d030c31f3b8d0e5b0f14fcf57c/templates/etc/nginx/sites-available/storage-ssl.conf.j2
.. _`Let's Encrypt`: https://letsencrypt.org
