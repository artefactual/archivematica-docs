.. _install-ansible:

====================================
Automated installation using Ansible
====================================

Installing from source using Ansible is the preferred method for new
installations on Ubuntu.

It is assumed here that your host operating system is Ubuntu. This can be
modified for a different Unix based operating system, such as Mac OS X or
another Linux distribution such as CentOS. These instructions will not
work if you are using Windows as the host OS. For Windows installations
you can create a virtual machine and follow the manual install instructions.

The Ansible roles referenced here can be used in production deployments
by creating your own Ansible playbook to run them. See the `deploy-pub`_ repo
for more details.

*On this page*

* :ref:`Installation instructions <ansible-instructions>`
* :ref:`Post-installation configuration <ansible-post-install-config>`

.. _ansible-instructions:

Instructions
------------

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
      sudo pip install -U ansible

   Vagrant must be at least version 1.5. Check your version with:

   .. code:: bash

      vagrant --version

   If it is not up to date, you can download the newest version from the
   `Vagrant website`_ .

2. Checkout the deployment repo:

   .. code:: bash

      git clone https://github.com/artefactual/deploy-pub.git

3. Download the Ansible roles:

   .. _ubuntu-16.04:

   Ubuntu 16.04 (Xenial):

   .. code:: bash

      cd deploy-pub/playbooks/archivematica-xenial
      ansible-galaxy install -f -p roles/ -r requirements.yml

   .. _ubuntu-18.04:

   Ubuntu 18.04 (Bionic):

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

   * Archivematica: `<http://192.168.168.192>`_. Username & password configured
     on installation.
   * Storage Service: `<http://192.168.168.192:8000>`_. Username & password configured
     on installation.

.. _ansible-post-install-config:

Post-install configuration
--------------------------

After successfully completing a new installation, follow these steps to complete
the configuration of your new server.

1. The Storage Service runs as a separate web application from the Archivematica
   dashboard. The Storage Service is exposed on port 8000 by default for Ansible
   installs. Use your web browser to navigate to the Storage Service at
   the IP address of the machine you have been installing on, e.g.,
   ``http://<MY-IP-ADDR>:8000`` (or ``http://localhost:8000`` or
   ``http://127.0.0.1:8000`` if this is a local development setup).

   If you are using an IP address or fully-qualified domain name instead of
   localhost, you will need to configure your firewall rules and allow access
   only to ports 80 and 8000 for Archivematica usage.

2. The Storage Service has its own set of users. Create a new user with full
   admin privileges:
   ::

      sudo -u archivematica bash -c " \
          set -a -e -x
          source /etc/default/archivematica-storage-service || \
              source /etc/sysconfig/archivematica-storage-service \
                  || (echo 'Environment file not found'; exit 1)
          cd /usr/lib/archivematica/storage-service
          /usr/share/archivematica/virtualenvs/archivematica-storage-service/bin/python manage.py createsuperuser
        ";

  After you have created this user, the API key will be generated automatically, and that key will connect the Archivematica pipeline to the Storage Service API. The API key can be found via the web interface (go to **Administration > Users**).

3. To finish the installation, use your web browser to navigate to the
   Archivematica dashboard using the IP address of the machine on which you have
   been installing, e.g., ``http://<MY-IP-ADDR>:80`` (or ``http://localhost:80``
   or ``http://127.0.0.1:80`` if this is a local development setup).

4. At the Welcome page, create an administrative user for the Archivematica
   pipeline by entering the organization name, the organization identifier,
   username, email, and password.

5. On the next screen, connect your pipeline to the Storage Service by entering
   the Storage Service URL and username, and by pasting in the API key that you
   copied in Step (2).

   - If the Storage Service and the Archivematica dashboard are installed on
     the same machine, then you should supply ``http://127.0.0.1:8000`` as the
     Storage Service URL at this screen.
   - If the Storage Service and the Archivematica dashboard are installed on
     different nodes (servers), then you should use the IP address or
     fully-qualified domain name of your Storage Service instance,
     e.g., ``http://<MY-IP-ADDR>:8000`` *and* you must ensure that any firewall
     rules (i.e., iptables, ufw, AWS security groups, etc.) are configured to
     allow requests from your dashboard IP to your Storage Service IP on the
     appropriate port.

:ref:`Back to the top <install-ansible>`

.. _`deploy-pub`: https://github.com/artefactual/deploy-pub
.. _`ansible-archivematica-src`: https://github.com/artefactual-labs/ansible-archivematica-src/#disable-elasticsearch-use
.. _`Vagrant website`: https://www.vagrantup.com/downloads.html
