��          <               \      ]     }   S  �  q  �     W    w  S  �   Adding Windows Start menu items The easiest way to ensure that a package made with `conda constructor <https://github.com/conda/constructor>`_ does not install any menu shortcuts is to remove ``menuinst`` from the list of conda packages included. To do this, add the following to the ``constuct.yaml`` file: When a package is installed, it can add a shortcut to the Windows **Start** menu. Conda and conda build handle this with the package `menuinst <https://github.com/ContinuumIO/menuinst>`_, which currently supports only Windows. For instructions on using ``menuinst``, see `the menuinst wiki <https://github.com/ContinuumIO/menuinst/wiki>`_. Project-Id-Version: Conda  
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2018-12-11 11:28+0900
PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE
Last-Translator: FULL NAME <EMAIL@ADDRESS>
Language: ko
Language-Team: ko <LL@li.org>
Plural-Forms: nplurals=1; plural=0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.6.0
 Adding Windows Start menu items The easiest way to ensure that a package made with `conda constructor <https://github.com/conda/constructor>`_ does not install any menu shortcuts is to remove ``menuinst`` from the list of conda packages included. To do this, add the following to the ``constuct.yaml`` file: When a package is installed, it can add a shortcut to the Windows **Start** menu. Conda and conda build handle this with the package `menuinst <https://github.com/ContinuumIO/menuinst>`_, which currently supports only Windows. For instructions on using ``menuinst``, see `the menuinst wiki <https://github.com/ContinuumIO/menuinst/wiki>`_. 