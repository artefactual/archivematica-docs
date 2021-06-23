.. _install-ansible:

====================================
Automated installation using Ansible
====================================

Installing from source using Ansible is the preferred method for new
installations on Ubuntu.

It is assumed here that your host operating system is Ubuntu. This can be
modified for a different Unix based operating system, such as Mac OS X or
another Linux distribution such as CentOS.

The Ansible roles referenced here can be used in production deployments
by creating your own Ansible playbook to run them. See the `deploy-pub`_ repo
for more details.

*On this page*

* :ref:`Installation instructions <ansible-instructions>`
* :ref:`Deploying development branches <ansible-deploy-dev-branches>`

.. _ansible-instructions:

Installation instructions
-------------------------

.. note::

   These instructions assume that you have a Python package manager, such as
   pip, installed on your system. From pip, you should be able to install a
   released version of Ansible.

.. important::

   If you would like to install :ref:`Archivematica without Elasticsearch
   <install-elasticsearch>` or with limited Elasticsearch functionality, you
   must first change the role variable ``archivematica_src_search_enabled`` to
   one of the available values. For more information about Archivematica's
   Ansible role, please see the `ansible-archivematica-src`_ repo.

1. Install VirtualBox, Vagrant, and Ansible.

   .. code:: bash

      sudo apt-get install virtualbox vagrant
      sudo pip install ansible==2.9.10 jmespath

   Vagrant must be at least version 1.9. Check your version with:

   .. code:: bash

      vagrant --version

   If it is not up to date, you can download the newest version from the
   `Vagrant website`_ .

2. Checkout the deployment repo:

   .. code:: bash

      git clone https://github.com/artefactual/deploy-pub.git

3. Download the Ansible roles:

   .. code:: bash

      cd deploy-pub/playbooks/archivematica-bionic
      ansible-galaxy install -f -p roles/ -r requirements.yml

4. Create the virtual machine and provision it:

   .. code:: bash

      vagrant up

   .. warning::

     This will take a while. It depends on your computer, but it could take up
     to an hour. Your computer may be very slow while Archivematica is being
     provisioned - be sure to save any work and be prepared to step away from
     your computer while Archivematica is building.

   If there are any errors, reprovisioning the VM often fixes the issue.

   .. code:: bash

      vagrant provision

5. Once it's done provisioning, you can log in to your virtual machine:

   .. code:: bash

      vagrant ssh

   You can also access your Archivematica instance through the web browser:

   * Archivematica: `<http://192.168.168.198>`_.
   * Storage Service: `<http://192.168.168.198:8000>`_.

   The credentials can be found in the `vars-singlenode-qa.yml`.


.. _ansible-deploy-dev-branches:

Deploy development branches
---------------------------

The previous section described how to deploy the latest stable Archivematica
release.

Our Ansible role can also be used to deploy development branches, e.g. if you
want to help us QA our product.

Using `deploy-pub`_, where we host our reference playbooks, please follow these
steps:

1. Download the roles defined in ``requirements-qa.yml``:

   .. code:: bash

      cd deploy-pub/playbooks/archivematica-bionic
      ansible-galaxy install -f -p roles/ -r requirements-qa.yml

2. Update ``singlenode.yml`` to load ``vars-singlenode-qa.yml``. Inside the
   ``pre_tasks`` section, update the task ``include_vars`` as follows:

   .. code:: bash

      - include_vars: "vars-singlenode-qa.yml"
        tags:
          - "always"

3. Optionally, if you have a specific branch(es) that you want to deploy or
   other custom configuration needs, update ``vars-singlenode-qa.yml`` as
   needed. By default, we will deploy off branches ``qa/1.x`` (Archivematica)
   and ``qa/0.x`` (Storage Service).

4. Deploy the new configuration. If you're using Vagrant, please run:

   .. code:: bash

      vagrant provision


:ref:`Back to the top <install-ansible>`

.. _`deploy-pub`: https://github.com/artefactual/deploy-pub
.. _`ansible-archivematica-src`: https://github.com/artefactual-labs/ansible-archivematica-src/tree/d4474c3dbaef2b561c87e0650c6ee386be6910a7#disable-elasticsearch-use
.. _`Vagrant website`: https://www.vagrantup.com/downloads.html
