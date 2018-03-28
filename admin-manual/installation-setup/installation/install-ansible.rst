.. _install-ansible:

====================================
Automated installation using Ansible
====================================

Installing from source has been tested using Ansible scripts. Ansible
installations have been tested for new installations but are not fully tested
for upgrades.

These instructions are designed to create a test environment on your local
machine. A virtual machine running Ubuntu 14.04 will be created.

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

1. Install VirtualBox, Vagrant, and Ansible.

   .. code:: bash

      sudo apt-get install virtualbox vagrant
      sudo pip install -U ansible

   Vagrant must be at least version 1.5. Check your version with:

   .. code:: bash

      vagrant --version

   If it is not up to date, you can download the newest version from the
   `Vagrant website <https://www.vagrantup.com/downloads.html>`_ .

2. Checkout the deployment repo:

   .. code:: bash

      git clone https://github.com/artefactual/deploy-pub.git

3. Download the Ansible roles:

   .. code:: bash

      cd deploy-pub/playbooks/archivematica
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
   * Storage Service: `<http://192.168.168.192:8000>`_. Username: test,
     password: test.

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

   If you are using a public IP address, you will need to configure your
   firewall rules and allow access only to ports 80 and 8000 for Archivematica
   usage.

2. Create a new administrative user in the Storage Service. The Storage Service
   has its own set of users. Navigate to Administrators > Users and add at
   least one administrative user. We also recommend modifying the test user and
   changing the default password. After you have created an administrative user,
   copy the user's API key to your clipboard.

3. To finish the installation, use your web browser to navigate to the
   Archivematica dashboard using the IP address of the machine you have been
   installing on.

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
     different nodes (servers), then you must use the public IP of your Storage
     Service instance, e.g., ``http://<MY-IP-ADDR>:8000`` *and* you must ensure
     that any firewall rules (i.e., iptables, ufw, AWS security groups, etc.)
     are configured to allow requests from your dashboard IP to your Storage
     Service IP on the appropriate port.

:ref:`Back to the top <install-ansible>`

.. _`deploy-pub`: https://github.com/artefactual/deploy-pub