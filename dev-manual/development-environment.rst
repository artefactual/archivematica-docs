.. _development-environment:

=======================
Development environment
=======================

Archivematica's development environment and workflows are based on
`Docker Compose <https://docs.docker.com/compose/reference/overview/>`_, a tool
for defining and running multi-container Docker applications.

.. warning::

   Docker Compose can be used in production environments, but installing
   Archivematica using Docker is not officially supported for production
   deployments. When installing for production, Archivematica can be installed
   using packages or Ansible scripts in either CentOS/Red Hat or Ubuntu.

For the latest information on Archivematica's development workflow based on
Docker and Docker Compose, visit the `hack directory`_ under the Archivematica
repository.

.. _`hack directory`: https://github.com/artefactual/archivematica/tree/qa/1.x/hack
