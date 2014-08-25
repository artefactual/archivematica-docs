.. _aip-structure:

=============
AIP structure
=============

This page documents the structure of the AIP produced by Archivematica.

Name
----

The AIP name is composed of the following:

   1. Either the name of the original transfer if no new name has been assigned
   to the SIP upon formation or the name of the SIP or SIPs created from the
   transfer and

   2. a UUID assigned during SIP formation

example: Pictures_of_my_cat-aebbfc44-9f2e-4351-bcfb-bb80d4914112

"Pictures_of_my_cat" is the name assigned by the user and
"aebbfc44-9f2e-4351-bcfb-bb80d4914112" is the UUID generated during SIP
formation.

Directory structure
-------------------

The AIP is zipped in the AIPsStore. The AIP directories are broken down into
UUID quad directories for efficient storage and retrieval.

.. note::

   UUID quad directories: Some file systems limit the number of items allowed in
   a directory, Archivematica uses a directory tree structure to store AIPs. The
   tree is based on the AIP UUIDs. The UUID is broken down into manageable 4
   character pieces, or "UUID quads", each quad representing a directory. The
   first four characters (UUID quad) of the AIP UUID will compose a sub directory
   of the AIP storage. The second UUID quad will be the name of a sub directory
   of the first, and so on and so forth, until the last four characters (last
   UUID Quad) create the leaf of the AIP store directory tree, and the AIP with
   that UUID resides in that directory.)
