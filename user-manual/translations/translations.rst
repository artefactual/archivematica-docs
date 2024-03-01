.. note::

	We are not currently working on translations for Archivematica.
	(March 2024)


.. _translations:

============
Translations
============

Thank you for your interest in translating Archivematica! Community translators
are vital for internationalizing Archivematica for use around the world. We
appreciate the efforts of all volunteer translators on the Archivematica
project!

We use Transifex to support the publication of translations. Transifex allows
multiple users to contribute translated strings, makes the harvesting process
faster and easier, and enables Artefactual to publish translations more often.
There are multiple Archivematica projects to translate: the documentation, the
interface, the website, and the Storage Service.

*On this page:*

* :ref:`Join the Archivematica project <transifex-project>`
* :ref:`Start translating <start-translating>`
* :ref:`Finding the context of a string <string-context>`
* :ref:`Editing translated strings <editing-strings>`

.. _transifex-project:

Join the Archivematica project
------------------------------

#. Go to `Transifex`_ and log in or create an account if you don't already have
   one.

#. Once you have created an account, you will be redirected to a configuration
   page. Fill in your name and preferences.

#. On the second configuration page, you will be given the option to start your
   own project or to join an existing one. Select **Join an existing project**.

#. The last configuration page will ask you to identify languages that you speak.
   Select as many as are applicable and click on **Get started**.

#. A pop-up window will appear. After you click on **Find a project to translate**,
   type *archivematica* into the search bar and then click on the Archivematica
   project when it appears below. You will be redirected to the Archivematica project
   homepage.

#. In the top right corner of the page, select **Join team**.

#. A pop-up will appear with a list of the available languages. Select your
   chosen translation language from the list. When you've found it, click the
   Submit button (if you wish to translate Archviematica into multiple languages,
   you can repeat this process again later).

#. You will see a confirmation message informing you that your request has been
   submitted. One of the Artefactual project maintainers will review the request
   and approve your account.

.. _start-translating:

Start translating
-----------------

#. Once your account is approved by the Archivematica project maintainers, you
   will receive an email notification from Transifex. Once you've received this
   email, return to the `Archivematica Project homepage`_ in Transifex.

#. Select the project that you would like to translate - the Archivematica
   interface, the documentation, Storage Service, or website - and click on the
   blue Translate button to start translating.

   .. figure:: images/project-dashboard.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: Select the translate button to start translating.

      Select the Translate button

#. Follow the on-screen prompts to select your language from the dropdown.

   .. figure:: images/language.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: Select a language

      Select a language.

#. You will be taken to a page listing the available resources for for your
   chosen language. A resource is a component of the project, such as a page of
   the documentation.

   .. figure:: images/resources.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: Select a resource

      Select a resource.

#. Once you have selected a resource, you will be taken to the Translations
   Editor. From this page, you can select strings (paragraphs) of text to
   translate. Note strings that have already been translated will have a green
   checkmark on the far left. Select a string that has not been translated - it
   will have a grey circle to the far left.

#. To translate the string, enter your translation in the middle column.
   Remember to click **Save translations** when you're done!

   .. figure:: images/translate-a-string.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: Translate a string

      Translate a string of text.

.. _string-context:

Finding the context of a string
-------------------------------

It can be difficult to discern the meaning of a string without looking at the
context in which it appears. It is possible to look at the string as it appears
in the project by following these steps.

Archivematica documentation
^^^^^^^^^^^^^^^^^^^^^^^^^^^

#. In the Translations Editor, look for the section called **More info** (you
   may need to click on **Context**, depending on how your browser is sized).
   Under this, there is a subsection called *Occurrences*.

#. *Occurrences* contains the URL slug where the string occurs in the
   documentation. Copy the part of the slug that is located between ``..`` and
   ``.rst``. For example, if the slug is
   ``../../admin-manual/installation/customization.rst:5``, copy
   ``/admin-manual/installation/customization``.

   .. figure:: images/string-context.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: The context of the string is listed under More Info.

      Copy the slug that points to where the string comes from.

#. Go to ``https://www.archivematica.org/docs/archivematica-1.6`` (or whatever
   version of the documentation you are translating, i.e. archivematica-1.7,
   1.8, etc).

#. Append the copied slug to the above link. Using the above example, the URL
   would now read ``https://www.archivematica.org/docs/archivematica-1.6/admin-manual/installation/customization``.
   Press enter to go to this URL.

#. The page you are now on contains the string that you are translating. Search
   for the string on the page by hitting control+f (or command+f) and typing in
   the first few words of the string.

   .. figure:: images/search-for-string.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: Search for the string on the page of the documentation where it occurs.

      The string is highlighted in orange. Note that this example uses Google
      Chrome; other browsers may look different.

.. _editing-strings:

Editing translated strings
--------------------------

If you have a better translation or want to fix a typo, it is possible to edit
or recommend edits for strings that have already been translated by other users.

#. Click on a string that has already been translated. Make your edits in the
   Translation Editor and click **Save translation**.

   .. figure:: images/edit-string.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: Edit a translated string.

      Make edits in the centre column.

#. To make a suggestion, rather than a direct edit, click on Suggestions in the
   right-hand column. Click on **Add suggestion** and input your
   recommendations. A project maintainer will be notified of the suggestion.

   .. figure:: images/edit-history.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: Suggest an improvement to a string.

      Make suggestions in the right-hand column.

#. The edit history of a string is available in the right-hand column.

   .. figure:: images/edit-history.*
      :align: center
      :figwidth: 60%
      :width: 100%
      :alt: View the edit history.

      View past edits as well as their authors.

:ref:`Back to the top <translations>`

.. _`Transifex`: https://www.transifex.com/
.. _`Archivematica project homepage`: https://www.transifex.com/artefactual/archivematica/
