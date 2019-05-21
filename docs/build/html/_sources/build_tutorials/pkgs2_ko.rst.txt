====================================
콘다 패키지 빌드 기초부터 시작하기
====================================

개요
--------

이 튜토리얼은 Pyinstrument 의 콘다 패키지를 빌드하지만 콘다 빌드 래시피에 요구되는 파일을 새로 작성한다.
콘다 패키지의 요소들에 대해서도 보다 자세하게 다룰 것이다.

튜토리얼 대상
-----------------------

이 문서는 콘다 패키지를 기초부터 생성하고자 하는 윈도우, 맥, 리눅스 사용자를 위한 튜토리얼이다.
콘다 빌드, 콘다 래시피에 대한 사전지식이 도움이 될 수 있다.


:doc:`pkgs_ko` 문서를 이미 학습했어야 한다.

콘다 패키지 빌드 요약
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

이 튜토리얼은 다음 단계를 따른다.:

#. :ref:`before-you-start2`
#. :ref:`what-is-a-conda-package`
#. :ref:`about-conda-build-recipe`
#. :ref:`edit-meta-yaml`
#. :ref:`build-sh-bld-bat`
#. :ref:`build-and-install`
#. :ref:`convert`
#. :ref:`pypi-source`
#. :ref:`anaconda-org`
#. :ref:`more-resources`


.. _before-you-start2:

시작에 앞서
----------------

`미니콘다`_ 또는 `아나콘다`_ 가 설치되어 있어야 한다..

.. _미니콘다: https://conda.io/docs/install/quick.html
.. _아나콘다: https://docs.continuum.io/anaconda/install

conda-build 설치:

.. code-block:: bash

    conda install conda-build

콘다와 콘다 빌드는 최신버전을 권장한다. 아래 커맨드로 업데이트 하자.:

.. code-block:: bash

    conda upgrade conda
    conda upgrade conda-build

직접 콘다 패키지를 빌드할 준비가 되었다.


.. _what-is-a-conda-package:

콘다 패키지란 무엇인가?
------------------------

콘다 패키지란 ``conda install [packagename]`` 커맨드로 설치할 수 있는 패키지를 말한다.

콘다 패키지는 .tar 또는 .bz2 아키이브로의 링크를 포함한다. 이 아카이브는 ``info/`` 디렉토리 하의 메타데이터를 포함하고 있으며
``install`` 접두어로 바로 설치되는 파일을 모아둔 것이다.

포맷은 모든 운영체제에서 동일하다. 설치 과정에서 ``info/`` 디렉토리의 파일을 제외한 나머지 파일은 설치 접두어로 추출된다.
콘다 패키지 파일을 환경에 설치하는 과정은 패키지 파일 디렉토리를 환경 디렉토리로 바꾸고 압축 파일과 하위요소를 추출하는 것으로 생각하면 된다.
이 과정이 ``conda install [packagename]`` 커맨드로 한번에 이루어 진다.

.. _about-conda-build-recipe:

콘다 빌드 래시피에 대해
------------------------

패키지를 빌드하려면 래시피가 필요하다. 콘다 빌드 래시피는 다음 파일들을 담고 있는 단층 디렉토리이다.:

* ``meta.yaml`` 은 래시피의 모든 메타데이터를 포함한다. 패키지명과 패키지버전 만이 필수요소이다.

* ``build.sh``  OS X 와 리눅스에서 패키지 파일을 설치하기 위한 유닉스 스크립트. bash 커맨드로 실행된다.

* ``bld.bat``  윈도우에서 패키지 파일을 설치하기 위한 빌드 스크립티. cmd 로 실행된다.

* ``run_test.py`` 선택적 파이썬 테스트 파일. 래시피에 이 파일이 존재하면 테스트 스크립트가 자동으로 실행된다.Optional Python test file, a test script that will run automatically if it is part of the recipe.

* 선택: 소스에 적용될 패치.

* 소스에 포함 되지 않는 다른 리로스는 빌드 스크립트에 의해 생성되지 않는다.

주의: conda skeleton 커맨드를 사용할 때 먼저 세 파일(``meta.yaml``, ``build.sh`` and ``bld.bat``)이 자동으로 생성된다.
:doc:`pkgs_ko` 에서 이 파일들에 대한 자세한 정보를 보자.

.. _edit-meta-yaml:

meta.yaml 파일 수동으로 편집하기
--------------------------------
이번 튜토리얼을 위해 ``pyinstrument`` 로 명명된 새 디렉토리를 만들어 보자. 생성된 디렉토리로 이동한다.

모든 운영체제:

.. code-block:: bash

  mkdir pyinstrument
  cd pyinstrument


새로운 meta.yaml 파일을 만들기 위해 가장 선호하는 텍스트 편집기를 실행한다. 새로운 텍스트 파일을 생성하고 다음 정보를 입력한다.
다음의 빈 meta.yaml 파일을 샘플로 사용해 정보를 쉽게 입력할 수 있다.

+--------------+---------------------------------------------------------------------------+
| name         | pyinstrument                                                              |
+--------------+---------------------------------------------------------------------------+
| version      | "0.13.1" (or latest from https://github.com/joerick/pyinstrument/releases)|
+--------------+---------------------------------------------------------------------------+
| git_rev      | v0.13.1 (or latest from https://github.com/joerick/pyinstrument/releases) |
+--------------+---------------------------------------------------------------------------+
| git_url      | https://github.com/joerick/pyinstrument.git                               |
+--------------+---------------------------------------------------------------------------+
| imports      | pyinstrument                                                              |
+--------------+---------------------------------------------------------------------------+
| home         | https://github.com/joerick/pyinstrument                                   |
+--------------+---------------------------------------------------------------------------+
| license      | BSD                                                                       |
+--------------+---------------------------------------------------------------------------+
| license_file | LICENSE                                                                   |
+--------------+---------------------------------------------------------------------------+

.. code-block:: yaml

  package:
    name:
    version:

  source:
    git_rev:
    git_url:

  requirements:
    build:
      - python
      - setuptools

    run:
      - python

  test:
    imports:
      -

  about:
    home:
    license:
    license_file:

작성을 완료하면 동일한 pyinstrument 디렉토리에 ``meta.yaml`` 로 파일을 저장한다.
:download:`이 meta.yaml 파일 <meta.yaml>`. 과 일치해야 한다.

주의: 올바른 분류와 비교를 위해 버전 넘버를 문자열로 지정해야 한다.


.. _build-sh-bld-bat:

빌드 스크립트 파일 (build.sh, bld.bat) 작성
-------------------------------------------------

빌드를 위해 필요한 나머지 두 파일은 다음과 같다.

* **build.sh** 리눅스, OS X 를 위한 쉘 스크립트,
* **bld.bat** 윈도우를 위한 배치 파일.

이 두개의 빌드 파일은 32-bit 또는 64-bit (ARCH 변수) 를 포함한 모든 변수와 빌드 접두어 (PREFIX) 를 포함한다.
``build.sh``, ``bld.bat`` 파일은 반드시 ``meta.yaml`` 파일과 동일한 디렉토리에 위치해야 한다.
이 튜토리얼에서 ``build.sh``, ``bld.bat`` 파일 모두를 만들 것이다.
이를 통해 다른 사용자도 각자의 아키텍쳐에 맞는 패키지를 빌드할 수 있다.

먼저 윈도우 빌드 파일을 작성하고 그 다음에 리눅스와 OS X 빌드 파일을 작성한다.

모든 사용자는 각자 선호하는 텍스트 편집기에서 ``bld.bat`` 파일을 생성하고 다음과 같이 입력한다.:

.. code-block:: bash

    "%PYTHON%" setup.py install
    if errorlevel 1 exit 1


주의: ``bld.bat``에서 가장 좋은 연습법은 매 커맨드 마다 ``if errorlevel 1 exit 1`` 를 추가하는 것이다. 이를 통해 커맨드가 실패하면 빌드도 실패하게 된다.

``bld.bat`` 파일을 ``meta.yaml`` 과 동일한 디렉토리에 저장한다.

모든 사용자는 각자 선호하는 텍스트 편집기에서 ``build.sh`` 파일을 생성하고 다음과 같이 입력한다.:

.. code-block:: bash

    $PYTHON setup.py install     # Python command to install the script.

``build.sh`` 파일을 ``meta.yaml`` 과 동일한 디렉토리에 저장한다.

``build.sh`` 파일은 ``bash -x -e`` 커맨드로 실행된다. (``-x`` 플래그는 실행되는 모든 커맨드에 반향하게 하고
``-e`` 플래그는 스크립트의 커맨드가 0이 아닌 exit status 를 리턴하면 스크립트를 종료시킨다.)
build.sh 의 set 커맨드로 스크립트에서 이를 되돌릴 수 있다.


.. _build-and-install:

빌드와 설치
-----------------

세개의 빌드 파일이 준비 되었으므로 conda build 커맨드로 새로운 패키지를 생성해 로컬 컴퓨터에 설치할 수 있다.

콘다 빌드를 실행한다:

.. code-block:: bash

    conda build pyinstrument

콘다 빌드가 완료되면 빌드 마지막에 파일명과 파일의 위치를 보여준다. 이번 예시에서는 다음 경로에 파일이 저장된다.:

.. code-block:: bash

    ~/anaconda/conda-bld/linux-64/pyinstrument-0.13.1-py27_0.tar.bz2

주의: 다음 단계를 위해 이 경로와 파일 정보를 저장하자. 아나콘다와 미니콘다에 관계 없이 경로와 파일명은 운영체제에 의존한다.
콘다 빌드는 정확한 경로와 파일명을 알려줄 것이다.

이제 use-local 플래그를 사용해 로컬 컴퓨터에 새로 빌드된 프로그램을 설치한다.

.. code-block:: bash

    conda install --use-local pyinstrument

에러 메시지가 없다면 Pyinstrument 가 제대로 설치된 것이다.

.. _convert:

모든 운영체제에서의 사용을 위해 패키지 변환하기
----------------------------------------

콘다 빌드를 사용해 현재 운영체제를 위한 패키지를 빌드했다. 이제 이 패키지를 다른 운영체제의 패키지로 변환할 수 있다.
이를 위해 이전 단계에서 두개의 빌드 파일을 생성한 것이다.

conda convert 커맨드와 운영체제 지정자를 사용한다. 운영체제 지정자는 {osx-64,linux-32,linux-64,win-32,win-64,all} 가 있다.
우리는 all 을 운영체제 지정자로 사용할 것이다.:

.. code-block:: bash

    conda convert --platform all ~/anaconda/conda-bld/linux-64/pyinstrument-0.13.1-py27_0.tar.bz2 -o outputdir/

주의: 6단계에서 저장한 정확한 파일 경로와 파일명을 사용한다.

.. _pypi-source:

선택l: GitHub 대신 PyPI 를 소스로 사용하려면?
---------------------------------------------------------

GitHub 대신 PyPI 나 다른 저장소를 사용하고자 한다면 어떻게 할 것인가?
Git 을 통해 빌드하는 것과 PyPI 와 같은 다른 저장소의 tarball 을 빌드하는 것은 콘다 빌드에 약간의 차이가 있다.
동일한 소스가 PyPI 와 GitHub 에 호스팅 된다면 GitHub 대신 PyPI 의 스크립트를 찾는다.
간단히 ``source`` 섹션을 대체하면 된다.:

.. code-block:: bash

   git_rev: v0.13.1
   git_url: https://github.com/joerick/pyinstrument.git

위 섹션을 아래와 같이 대체한다.:

.. code-block:: bash

    fn: pyinstrument-0.13.1.tar.gz
    md5: e347036acc50720c0903dc2221b2605d
    url: https://pypi.python.org/packages/source/p/pyinstrument/pyinstrument-0.13.1.tar.gz

주의: md5 는 `PyPI Pyinstrument 페이지 <https://pypi.python.org/pypi/pyinstrument>`_ 에서 찾을 수 있다.


.. _anaconda-org:

선택: 새로운 패키지를 Anaconda.org 에 업로드 하기
---------------------------------------------

패키지 파일들은 타 플랫폼을 위한 패키지 파일로 변환했다면 Anaconda.org 에 업로드 할 것이다.
무료 Anaconda.org 계정이 있다면 1분이면 된다.

계정이 없다면 Anaconda.org 에서 계정을 생성한다.

다음은 터미널창에서 ``conda install anaconda-client`` 커맨드를 실행하고 유저명과 암호를 입력한다.

다시 터미널창에서 다음 커맨드로 Anaconda.org 에 로그인한다.:

.. code-block:: bash

    anaconda login

Anaconda.org 에 패키지를 업로드 한다.:

.. code-block:: bash

    anaconda upload ~/miniconda/conda-bld/linux-64/pyinstrument-0.12-py27_0.tar.bz

주의: 6단계에서 저장한 파일명과 파일 경로를 사용한다.

팁: 시간을 절약하기 위해 성공한 빌드를 Anaconda.org 에 자동 업데이트 되게 할 수 있다. ``conda config --set anaconda_upload yes`` 커맨드를 사용한다.

.. _more-resources:

추가 리소스
--------------
meta.yaml 파일에 사용할 수 있는 모든 값들은 :doc:`../build_ko` 페이지에 설명되어 있다.


:doc:`../commands_ko`
