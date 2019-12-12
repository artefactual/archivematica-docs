.. _web-dashboard:

===================
Web-based dashboard
===================

From the end-user perspective, all of Archivematica's functions take place
within a web-based dashboard which can be accessed from anywhere by logging in
through a web browser.

.. image:: images/Dashboard.*
   :align: center
   :width: 90%
   :alt: Archivematica's web-based dashboard

The Dashboard is akin to a "processing space" for digital archives, allowing
archivists to move packages of digital materials through the Archivematica
pipeline before sending packages for storage or dissemination.

A description of the Dashboard elements follows, with numbers referencing the
image above.

1. Tabs
-------

The Dashboard is divided into a number of tabs, with the grey area indicating
the tab currently in view. Alerts appear in red circles when there is action
required by the archivist in a tab. The names of the tabs (Transfer, Backlog,
Appraisal, Ingest, Archival storage, Preservation planning, Access,
Administration) reference both the OAIS model and sections of the user
documentation.

2. User login
-------------

The user login name appears beside the tabs, and is where the user logs out from
when processing work is complete.

3. Packages
-----------

At any given time, any number of packages could be present in the Transfer and
Ingest tabs, representing a Transfer of material or a Submission Information
Package (SIP), respectively. A package will either be:

* In progress, indicated by green arrows
* In need of a decision to be made, indicated by a bell icon
* Completed, indicated by a green checkmark
* Failed, indicated by a red stop symbol
* Rejected by the archivist, indicated by a grey stop symbol

It is a good practice to "clean up" the Dashboard periodically by removing
packages using the red "remove" button (see below).

4. Microservices and Jobs
-----------------------------

Archivematica's processing is performed through a number of:ref:`microservices
<microservices>`. Microservices are provided by a combination of Archivematica
Python scripts and one or more of the free, open-source `external software
tools <external-tools>` bundled in the Archivematica system.

These microservices are broken down into a number of jobs, which users can see
by clicking on the microservice to expand. Clicking on the gear icon within a
job will open a new browser tab showing the tasks performed for that particular
job.

5. Decision
-----------

Certain microservices result in a decision point for the archivist. The decision
is completed by choosing an available option from a drop-down menu. Many of the
decision points can be pre-configured if desired in the
:ref:`Administration tab <dashboard-processing>`.

6. Report/remove icons
----------------------

Report (paper and pencil) icons appear on Transfer and Ingest packages and link
the user to the :ref:`descriptive <add-metadata>` and :ref:`rights <add-rights>`
metadata entry page. (The same icon is used for forensic disk image transfer
metadata entry as well as the :ref:`normalization report <normalize>`).

The red remove icon removes the package from the Dashboard. The package can be
removed whether the processing is completed or not. It is best practice to
remove completed packages periodically as a "cleanup" procedure to keep the web
browser running smoothly. Note that removing a package **does not** delete the
package or any AIPs or DIPs associated with it. If a package was not fully
processed, it will remain unprocessed at its last decision point, even if
removed from the Dashboard.

:ref:`Back to the top <web-dashboard>`
