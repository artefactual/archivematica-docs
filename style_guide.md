# Archivematica Documentation Style Guide

This style guide is used for the [Archivematica documentation][Archivematica
documentation].

1. [Changing the documentation](#changing-the-documentation)
1. [Audience](#audience)
1. [Tone](#tone)
1. [Style](#style)
1. [Structure](#structure)
    * [Manuals](#manuals)
    * [Chapters](#chapters)
    * [Pages](#pages)
    * [Indexes and toctrees](#indexes-and-toctrees)
    * [Images](#images)
    * [Tables](#tables)
    * [Scripts](#scripts)
    * [Admonitions](#admonitions)
1. [Sources](#sources)

## Changing the documentation

All documentation changes should begin with an [issue][issue]. The Archivematica
project follows an issue-first approach to solving problems with or enhancing
the software, which includes the documentation. Filing an issue allows others to
provide feedback, advice, and guidance regarding an issue or enhancement idea.
The issues repository also acts as a master list of bug fix and enhancement
ideas that any Archivematica community member can address.

To file an issue, you must have a GitHub account. In the [Archivematica Issues
repository][Archivematica Issues repository], create a new issue and choose the
Documentation template.

Note that all issues relating to the Archivematica project in any way should be
filed in the [Archivematica Issues repository][Archivematica Issues repository].

## Audience

The Archivematica user community ranges from archivists and librarians to
developers and systems administrators. These varied users all rely on the
documentation to understand, implement, and maintain their Archivematica
instances. Generally speaking, the User Manual applies front-end users like
archivists and librarians while the Administrator Manual applies to back-end
users like systems administrators and developers.

Assume that the audience has some background knowledge of digital preservation,
software development, and/or software administration. The Archivematica
documentation is not an introduction to digital preservation, so do not include
general information about digital preservation theories or practices.

The Archivematica documentation is the place where users learn to use the
software. Users are not looking for a narrative; they are looking for an answer.
Write to answer a potential user's question, providing clear instructions for
use of Archivematica.

## Tone

* Write accessibly in clear, simple sentences intended for a global audience.
* Avoid colloquial language, humour, cultural references, and personal opinion.
  Keep your writing technical.
* Write from a second-person point of view. Use "you" and "your", not "my",
  "our", or "their".
* Avoid jargon and acronyms, if you can. Spell out acronyms at least once per
  page.
* Be consistent. Use the same consistently-formatted word or phrase for a
  concept throughout the documentation.
* Do not qualify or prejudge actions. Do not write that something is "easy" or
  "quick" as this is a deterrent if the user is not able to complete the action.
* Do not reference future development or features that don't yet exist.

## Style

### Golden rules

**Golden rule 1**

* Limit each sentence to less than 25 words.

**Golden rule 2**

* Limit each paragraph to one topic; limit each sentence to one idea; limit each
  procedure step to one action.

**Golden rule 3**

* Use explicit examples to demonstrate how the software works. Provide
  instructions rather than descriptions.

Adapted from the [GNOME Documentation Style Guide][GNOME Documentation Style
Guide].

### Formatting and punctuation

* Use sentence case for page titles and section headings.
* Use numbered lists for actions that happen in sequence.
* Use bulleted lists for most other lists.
* Truncate lines after 80 characters.
* Put UI elements in bold. If you're telling a user to click on the Start
  Transfer button, for example, the instruction should be "Click on **Start
  Transfer**."
* Use serial (Oxford) commas for clarity (preferred, not enforced).
* Use standard Canadian spelling and punctuation (preferred, not enforced).

### Including images

[Inline images][Inline images] in the Archivematica documentation usually take
the form of screenshots. Images are formatted in a particular way in
reStructuredText - see the [Images](#images) section below for more information.

* Avoid screenshots unless absolutely necessary.
* Never rely on images as the only way to convey information.
* Always describe the content of the screenshot in the text of the documentation
  so that the content may be understood independently of the image.
* Provide an alt tag for all images.
* Provide the highest resolution images possible.
* Use SVG or PNG images, rather than JPGs.

### Including admonitions

[Inline images][Text admonitions] are specially-marked sections of text that
programmatically distinguish important information for the user. See the
[Admonitions](#admonitions) section below for more information.

* Use red-flag admonitions (such as DANGER or WARNING) only when absolutely
  critical.
* Use gentler admonitions (such as IMPORTANT or NOTE) sparingly.
* Aim for no more than one admonition per section to reduce visual clutter.

### Local style rules

* MCPClient instead of MCP Client.
* MCPServer instead of MCP Server.
* Microservice instead of micro-service.

## Structure

### Manuals

The top level division within the Archivematica documentation is a manual. The
Archivematica documentation consists of three manuals:

* [Getting started][Getting started]
* [Administrator manual][Administrator manual]
* [User manual][User manual]

These manuals correspond to three top-level directories in the
[Archivematica documentation][Archivematica documentation]:

* [getting-started][getting-started]
* [admin-manual][admin-manual]
* [user-manual][user-manual]

The manuals are meant to be stable. Changes at this level may also require
layout changes to the documentation website. New top-level directories should
not be added unless there is consensus with Artefactual staff to make a major
change.

### Chapters

Each manual contains chapters, which are represented in the repository as
subdirectories within a manual. For example, the [User manual][User manual] has
a chapter called [Transfer][Transfer]. Within Transfer are individual
reStructuredText (reST) files, which represent pages, as well as a directory of
images that are referenced by the reST files. There may be other reference
directories as well.

Chapters generally correspond to tabs in the interface (such as Transfer and
Ingest) or topics that are in some way greater than the interface (such as
Metadata or Translations). Be thoughtful about adding a new chapter. Most
features occur within an already-defined workflow. Here are two examples for
why a new chapter might be added:

* A new tab is added to the Archivematica dashboard. For example, when the
  Appraisal tab was introduced in Archivematica 1.6, a chapter titled
  [Appraisal][Appraisal] was added to the User manual as a place to record
  appraisal workflow instructions.
* A feature is introduced that has implications outside normal user workflows.
  For example, when internationalization hooks were added to the code, a chapter
  titled [Translations][Translations] was added to the User Manual as a place to
  put translation instructions.

Though somewhat less strictly enforced than the creation of a new manual, new
chapters should only be created if there is consensus with Artefactual staff.

Chapters can contain sub-directories if needed. For example, the [Installation
and setup][Installation and setup] chapter in the Administrator Manual includes
sub-directories for customization, installation, integrations, and upgrading.
These sub-directories are not required, but can be helpful for organizing a
chapter with many pages that cover many topics.

Chapters do not need to be linked to any toctrees or indexes.

### Pages

A page is an individual reST file, or reStructuredText file. reST files end with
the extension `.rst`. All reST files should be nested within chapter
directories, with the exception of the following:

* contents.rst - the top-level toctree for the documentation
* index.rst - the main index for the documentation, which acts as the homepage

All pages should begin with an anchor, which acts as the linking mechanism for
the page. The anchor should be short and descriptive. Anchors always begin with
two periods, a space, and an underscore, followed by the anchor text, and end
with a semicolon: `.. _example:`

The page title is placed below the anchor. The page title should be title-cased
and enclosed top and bottom by equals signs. Note that the equals signs should
match the length of the title. The title should be followed by introductory text
about the page.

```
.. _my-page:

=============
My Page Title
=============

Introductory page text goes here.
```

The page title is equivalent to an `<h1>` tag. Only one title should appear per
page.

#### Section headings

Use section headings to break up longer pages. Section headings in
reStructuredText are a single line of text (no line breaks!) with an underline
adornment. Similar to the title, the underline adornment should match the length
of the title. Section headings should be sentence-case.

Section headings should be preceded by an anchor, which are used to link to the
section from anywhere else in the documentation, including the page's table of
contents. All first-level headings should be listed in the [table of
contents](#table-of-contents) and therefore require an anchor. Lower-level
headings only require an anchor if you would like to include them in the table
of contents or link to them from anywhere else in the documentation.

```
.. _my-page:

=============
My Page Title
=============

Introductory page text goes here.

.. _first-level:

This is a first-level section
-----------------------------

Information about this section. Note that this section has an anchor, since
it is a first-level section. Using the anchor, we can link to it from the
table of contents or anywhere else in the documentation.

A second-level section
^^^^^^^^^^^^^^^^^^^^^^

Detailed information about this subsection. Note that this section does not
have an anchor, so you cannot link to it from anywhere else.

.. _another-first-level:

This is another first-level section
-----------------------------------

Information about this section. Note that this section has an anchor, since
it is a first-level section. Using the anchor, we can link to it from the
table of contents or anywhere else in the documentation.
```

reStructuredText allows you to use any non-alpha-numeric character for the
underline adornment; however, pages must be internally consistent. The
Archivematica documentation has not been particularly consistent across pages
with the characters used for adornment in the past, but going forward we will
try to use the following:

* Title: === (overlined AND underlined)
* First-level heading: ---
* Second-level heading: ^^^
* Third-level heading: +++
* Fourth-level heading level: ###

Note that the title should be overlined and underlined; section headings should
only be underlined.

#### Table of contents

Include a table of contents after the page's introductory text block, linking to
the anchor for each section. In reStructuredText, tables of contents are built
by hand. The table of contents should be preceded by the italicized phrase _On
this page_.

Using the section anchors, create bulleted list containing an internal reference
for each section that you would like to include in the table of contents using
the reStructuredText link format.

```
.. _my-page:

=============
My Page Title
=============

Introductory page text goes here.

*On this page*

* :ref:`This is a first-level section <first-level>`
* :ref:`This is another first-level section <another-first-level>`

.. _first-level:

This is a first-level section
-----------------------------

Information about this section. Note that this section has an anchor, since
it is a first-level section. Using the anchor, we can link to it from the
table of contents or anywhere else in the documentation.

A second-level section
^^^^^^^^^^^^^^^^^^^^^^

Detailed information about this subsection. Note that this section does not
have an anchor, so you cannot link to it from anywhere else.

.. _another-first-level:

This is another first-level section
-----------------------------------

Information about this section. Note that this section has an anchor, since
it is a first-level section. Using the anchor, we can link to it from the
table of contents or anywhere else in the documentation.

```

#### Text

Text blocks should truncated after 80 characters.

```
Archivematica packages are hosted at packages.archivematica.org as a central
place to store packages for multiple operating systems. Packages for both Ubuntu
14.04 and 16.04 are available.
```

Code blocks are an exception to this rule. A line of code can extend beyond 80
characters since a mid-line break may cause rendering errors.

```
.. code:: bash
   sudo sh -c 'echo "ARCHIVEMATICA_DASHBOARD_DASHBOARD_SEARCH_ENABLED=false" >> /etc/default/archivematica-dashboard'
   sudo sh -c 'echo "ARCHIVEMATICA_MCPSERVER_MCPSERVER_SEARCH_ENABLED=false" >> /etc/default/archivematica-mcp-server'
   sudo sh -c 'echo "ARCHIVEMATICA_MCPCLIENT_MCPCLIENT_SEARCH_ENABLED=false" >> /etc/default/archivematica-mcp-client'
```

#### Back to the top

All pages should have a _Back to the top_ link at the bottom of the page, which
refers to the page anchor.

```
    :ref:`Back to the top <my-page>`
```

#### External Links

In the Archivematica documentation we are in the process of converting all
external links to use hyperlink targets, rather than embedded inline hyperlinks.
This helps text blocks adhere to the 80-character limit and is generally tidier.

Inline hyperlinks look like this:

```
Here is a link to a `reStructuredText Primer <http://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html`_.
```

Instead, style hyperlinks as a target, like so:

```
Here is a link to the `reStructuredText Primer`_. You can also refer to
documentation about the `Sphinx documentation generator`_.
```

Make the text that you use for a hyperlink target clear, concise, and meaningful
out of context. Screen readers allow users to pull up a list of all the links on
a page; clearly identifying the contents of the link will make it easier to
understand whether or not a user wants to click through. Here are good and bad
examples of hyperlink target text:

```
Good: Here is a link to the `reStructuredText Primer`_.

Bad: The link to the reStructuredText Primer is `here`_.
```

And at the very bottom of the page, create a list of external links. This list
should be below the _Back to the top_ link. This list does not need to adhere to
the 80-character limit.

```
.. _`reStructuredText Primer`: http://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html
.. _`Sphinx documentation generator`: http://www.sphinx-doc.org/en/master/index.html
```

Where possible, always use permalinks. For example, when linking to a GitHub
page, it is possible to link to a specific commit, rather than the pretty URL
provided on the page - the pretty URL can break if the page is changed or
moved, but the permalink remains.

For more information about generating GitHub permalinks, see
[Getting permanent links to files][Getting permanent links to files].

#### Internal Links

To create a hyperlink to another section of the Archivematica documentation, use
a [reference label][reference label] that points to the anchor of the linked
page:

```
:ref:`Processing configuration <dashboard-processing>`
```

In the example above, `dashboard-processing` is the anchor for a page from the
same documentation repo.

When linking to a page in another documentation repository, precede the anchor
with the appropriate tag - `archivematica:`, `storageservice`, or `atom:`.

```
:ref:`Administrators Manual <storageservice:administrators>` links to Storage Service documentation
:ref:`Appraisal <archivematica:appraisal>` links to Archivematica documentation
```

As with external links, make sure that the text that you use for the reference
label is clear, concise, and meaningful out of context.

### Indexes and toctrees

Sphinx is an index-based documentation system, but it does not create indexes
automatically. Indexes are hand-created and serve as landing pages for users
of the documentation. The index pages contain toctrees which support navigation.
If you create a new page, it must be added to the appropriate toctree. There are
several different indexes in the Archivematica documentation, and some contain
toctrees.

* `archivematica-docs/index.rst` - this is used as the site homepage. Links can
  be added to this page as needed.
* `archivematica-docs/admin-manual/index.rst` - the index for the Administrator
  Manual, which contains the manual's toctree. All pages within the
  Administrator Manual must be listed in this toctree.
* `archivematica-docs/getting-started/index.rst` - the index for the Getting
  Started Manual, which contains the manual's toctree. All pages within the
  Getting Started Manual must be listed in this toctree.
* `archivematica-docs/user-manual/index.rst` - the index for the User Manual,
  which contains the manual's toctree. All pages within the User Manual must be
  listed in this toctree.

For example, if you create a new page in the Administrator Manual, the page must
be added to the toctree in `admin-manual/index.rst`. You may also wish to link
to the page from the main `index.rst`, but this is not required.

### Images

Images should be saved in an `/images` directory within the appropriate chapter.
For example, in the User Manual's [Transfer][Transfer] chapter, there is an
[images subdirectory][images subdirectory] that contains all images referenced
in the pages of the Transfer chapter.

Images should be saved at the highest resolution possible and in PNG format.

Alt text is critical for people who are visually impaired and those who use
devices such as screen readers. Alt text is required for all images.

If the image is annotated, be sure that the annotation is captured in the
image's alt text. Ideally, avoid using text to annotate images. There are many
resources available online for writing good alt text.

To include an image on a page, reference the image using the `image` directive.

```
.. image:: images/transfer-tab.png
   :align: center
   :width: 80%
   :alt: The Transfer tab is where transfers into Archivematica begin.
```

The `align` option should always be set to center.

The `width` option can be adjusted per image as required.

If you would like to include a caption, use the `figure` directive.

```
.. figure:: images/generalConfig.*
   :align: center
   :figwidth: 70%
   :width: 100%
   :alt: General configuration options in Administration tab of the dashboard

   This is where you put the caption.
```

The `figwidth` and `width` options for figures can be set per image. `figwidth`
sets the width of the figure as a whole (including the caption) while `width`
sets the width of just the image within the figure. For more information on
available options, see the [reStructuredText Directives][reStructuredText Directives].

### Tables

Tables can be useful for organizing complex information. Basic tables can be
added manually in the documentation using the `.. list-table::` directive. See
the [reStructuredText Directives][reStructuredText Directives] for more information

For more complex tables, it is possible to reference a CSV file instead of
building the table manually. After creating a table in a program like Excel,
save the table as a CSV file in a `/csv` directory within the appropriate
chapter. For example, in the Administrator Manual's [Installation][Installation]
sub-chapter, there is a [_csv][_csv] subdirectory that contains tables
referenced in the pages of the Installation sub-chapter.

To include a table on a page, reference the table using the `csv-table`
directive.

```
.. csv-table::
   :file: _csv/install-landing.csv
   :header-rows: 1
```

Setting the `header-rows` option will make the header row a different colour
than the body of the table.

### Scripts

Short, simple scripts can be added as code blocks using the `code` directive.

```
.. code:: bash

   sudo wget -O - https://packages.archivematica.org/1.8.x/key.asc  | sudo apt-key add -
   sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.8.x/ubuntu xenial main" >> /etc/apt/sources.list'
   sudo sh -c 'echo "deb [arch=amd64] http://packages.archivematica.org/1.8.x/ubuntu-externals xenial main" >> /etc/apt/sources.list'
```

For longer scripts, or scripts that will be referenced on multiple pages, you
may wish to reference a script file, rather than inserting the script directly
into the text.

After creating and saving the script, place it in a `scripts` directory within
the appropriate chapter. For example, in the Administrator Manual's
[Installation][Installation] sub-chapter, there is a [scripts][scripts]
subdirectory that contains scripts referenced in the pages of the Installation
sub-chapter.

To include a script on a page, reference the script using the `literal-include`
directive.

```
.. literalinclude:: scripts/am18-centos-rpm.sh
   :language: bash
   :lines: 3
```

Setting the `language` option will display the script with appropriate syntax
highlighting.

Setting the `lines` option will display only the specified lines. You may
specify one line, as above, or multiple lines:

```
.. literalinclude:: scripts/am18-centos-rpm.sh
   :language: bash
   :lines: 5-12
```

### Admonitions

There are several different admonition directives available in reStructuredText.
See the [reStructuredText Directives][reStructuredText Directives] for a
complete list.

Commonly used in the Archivematica documentation are `note`, `important`, and
`warning`. The chosen admonition will have an impact on how the contents are
displayed.

```
.. note::
   Skip this step if you are planning to run :ref:`Archivematica without
   Elasticsearch <install-elasticsearch>`.
```

## Sources

This guide reuses content from the following resources:

* [Write the Docs Style Guides][Write the Docs Style Guides]
* [GNOME Documentation Style Guide][GNOME Documentation Style Guide]
* [University of Minnesota Accessible U][University of Minnesota Accessible U]

[Archivematica documentation]: https://github.com/artefactual/archivematica-docs
[issue]: https://github.com/archivematica/Issues/issues
[Archivematica Issues repository]: https://github.com/archivematica/Issues/issues
[Inline images]: http://docutils.sourceforge.net/docs/ref/rst/directives.html#images
[Text admonitions]: http://docutils.sourceforge.net/docs/ref/rst/directives.html#admonitions
[Getting started]: https://www.archivematica.org/en/docs/archivematica-1.7/#getting-started
[Administrator manual]: https://www.archivematica.org/en/docs/archivematica-1.7/#administrator-manual
[User manual]: https://www.archivematica.org/en/docs/archivematica-1.7/#user-manual
[documentation repository]: https://github.com/artefactual/archivematica-docs
[getting-started]: https://github.com/artefactual/archivematica-docs/tree/1.7/getting-started
[admin-manual]: https://github.com/artefactual/archivematica-docs/tree/1.7/admin-manual
[user-manual]: https://github.com/artefactual/archivematica-docs/tree/1.7/user-manual
[Transfer]: https://github.com/artefactual/archivematica-docs/tree/1.7/user-manual/transfer
[Appraisal]: https://github.com/artefactual/archivematica-docs/tree/1.7/user-manual/appraisal
[Translations]: https://github.com/artefactual/archivematica-docs/tree/1.7/user-manual/translations
[Installation and setup]: https://github.com/artefactual/archivematica-docs/tree/1.7/admin-manual/installation-setup
[reference label]: http://www.sphinx-doc.org/en/master/usage/restructuredtext/roles.html#ref-role
[images subdirectory]: https://github.com/artefactual/archivematica-docs/tree/1.7/user-manual/transfer/images
[reStructuredText Directives]: http://docutils.sourceforge.net/docs/ref/rst/directives.html
[Installation]: https://github.com/artefactual/archivematica-docs/tree/1.8/admin-manual/installation-setup/installation
[_csv]: https://github.com/artefactual/archivematica-docs/tree/1.8/admin-manual/installation-setup/installation/_csv
[scripts]: https://github.com/artefactual/archivematica-docs/tree/1.8/admin-manual/installation-setup/installation/scripts
[Write the Docs Style Guides]: http://www.writethedocs.org/guide/writing/style-guides/
[GNOME Documentation Style Guide]: https://developer.gnome.org/gdp-style-guide/2.32/gdp-style-guide.html
[University of Minnesota Accessible U]: https://accessibility.umn.edu/core-skills/hyperlinks
[Getting permanent links to files]: https://help.github.com/en/articles/getting-permanent-links-to-files
