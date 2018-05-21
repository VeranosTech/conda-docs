====================================
기초부터 패키지 빌드
====================================


.. contents::
   :local:
   :depth: 1

이 튜토리얼은 콘다 래시피(conda recipe)에 필요한 파일을 작성해 파이인스트루먼트(Pyinstrument)를 콘다 패키지로 빌드하는 방법을 설명한다.

튜토리얼 대상
================

필요한 파일을 작성해 콘다 패키지를 생성하고자 하는 윈도우,맥OS,리눅스 사용자를 위한 튜토리얼이다.
콘다 빌드(conda build)와 콘다 래시피에 대한 선행 지식이 도움이 될 것이다.


.. _before-you-start2:

시작에 앞서
================

* :doc:`요구 사항 <index_ko>`\ 을 확인한다.

* :doc:`build-pkgs-skeleton_ko`\ 를 미리 해봐야 한다.


.. _edit-meta-yaml:

meta.yaml 파일 편집하기
===========================

#. 이 튜토리얼을 위해 ``pyinstrument``\ 라는 이름으로 디렉토리를 만들고 그 디렉토리로 이동한다.

   .. code-block:: bash

     mkdir pyinstrument
     cd pyinstrument

#. ``meta.yaml`` 파일을 생성하기 위해 가장 잘사용하는 편집기를 연다.
   새 텍스트 파일을 생성하고 아래 정보를 입력한다.
   빈 ``meta.yaml`` 샘플의 테이블을 따라가면 정보를 더 쉽게 입력할 수 있다.

   주의: 알맞은 분류와 비교를 위해 ``version``\ 을 문자열로 입력한다.

   .. list-table::
      :widths: 10 90

      * - name
        - pyinstrument
      * - version
        - "0.13.1" (or latest from
          https://github.com/joerick/pyinstrument/releases)
      * - git_rev
        - v0.13.1 (or latest from
          https://github.com/joerick/pyinstrument/releases)
      * - git_url
        - https://github.com/joerick/pyinstrument.git
      * - imports
        - pyinstrument
      * - home
        - https://github.com/joerick/pyinstrument
      * - license
        - BSD
      * - license_file
        - LICENSE

   .. code-block:: yaml

     package:
       name:
       version:

     source:
       git_rev:
       git_url:

     requirements:
       host:
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

#. 편집한 파일을 ``pyinstrument`` 디렉토리에 ``meta.yaml``\ 로 저정한다.
   :download:`이 meta.yaml 파일 <meta.yaml>`\ 과 일치해야 한다.


.. _build-sh-bld-bat:

빌드 스크립트 파일 build.sh와 bld.bat 작성하기
====================================================

``meta.yaml`` 외에도 빌드를 위한 파일이 2개 더 필요하다.

* ``build.sh``---맥OS와 리눅스를 위한 셸 스크립트
* ``bld.bat``---윈도우를 위한 배치 파일

이 빌드 파일들을 32-bit나 64bit 아키텍처와 같은 ARCH 변수나 빌드 환경 접두어와 같은 PREFIX 변수 등 모든 변수를 포함한다.
``build.sh``\ 와 ``bld.bat``\ 는 반드시 ``meta.yaml`` 파일과 동일한 디렉토리에 있어야 한다.

이 튜토리얼은 ``build.sh``\ 와 ``bld.bat``\ 를 모두 만들어 다른 사용자가 각자의 아키텍처에 맞는 패키지를 빌드할 수 있게 하는 방법을 설명한다.

#. 텍스트 편집기를 열어 ``bld.bat``\ 라는 이름으로 파일을 생성하고 다음과 같이 입력한다.

   .. code-block:: bash

       "%PYTHON%" setup.py install --single-version-externally-managed --record=record.txt
       if errorlevel 1 exit 1

   주의: ``bld.bat``\ 의 모든 명령 뒤에 ``if errorlevel 1 exit 1``\ 을 추가해 명령이 실패했을 때 빌드도 실패하게 하면 좋은 연습이 될 것이다.

#. ``bld.bat`` 파일을 ``meta.yaml`` 파일과 같은 디렉토리에 저장다.

#. 텍스트 편집기를 열어 ``build.sh``\ 라는 이름으로 파일을 생성하고 다음과 같이 입력한다.

   .. code-block:: bash

       $PYTHON setup.py install --single-version-externally-managed --record=record.txt  # Python command to install the script.


#. ``build.sh`` 파일을 ``meta.yaml`` 파일과 같은 디렉토리에 저장한다.

``build.sh`` 파일은 ``bash -x -e``\ 로 실행할 수 있다.
``-x``\ 는 실행된 각 명령은 에코(echo)한다.
``-e``\ 는 스크립트의 명령이 0이 아닌 exit 상태를 반환하면 스크립트를 종료한다.
스크립트에서 이를 되돌리려면 ``build.sh``\ 에 ``set`` 명령을 사용한다.


.. _build-and-install:

빌드와 설치하기
========================

이제 준비된 3개의 빌드 파일과 콘다 빌드를 사용해 패키지를 생성하고 로컬 컴퓨터에 설치할 수 있다.

#. 콘다 빌드를 실행한다.

   .. code-block:: bash

      conda-build pyinstrument

   콘다 빌드가 끝나면 패키지 파일명과 위치를 보여준다.

   이 예제에서는 다음과 같이 저장된다.

   .. code-block:: bash

      ~/anaconda/conda-bld/linux-64/pyinstrument-0.13.1-py27_0.tar.bz2


   주의: 다음 작업을 위해 이 경로와 파일 정보를 저장해둔다.
   정확한 경로와 파일명은 운영체제와 미니콘다와 아나콘다 중 어느 것을 사용했는지에 따라 달라진다.
   ``conda-build`` 명령은 정확한 경로와 파일명을 알려준다.

#. ``use-local`` 플래그를 사용해 새로 빌드한 프로그램을 로컬 컴퓨터에 설치한다.

   .. code-block:: bash

      conda install --use-local pyinstrument

   에러메세지가 안나타나면 파이인스트루먼트가 성공적으로 설치된 것이다.


.. _convert:

모든 플랫폼을 위해 패키지 변환하기
=============================================

콘다 빌드로 현재 플랫폼을 위한 패키지를 빌드했다.
``build.sh``\ 와 ``bld.bat``\ 를 사용하면 이 패키지를 다른 플랫폼에서 사용할 수 있게 변환할 수 있다.

``conda convert`` 명령에 플랫폼 지정자를 사용해 변환한다. 플랫폼 지정자는 다음과 같다.

* ``osx-64``.
* ``linux-32``.
* ``linux-64``.
* ``win-32``.
* ``win-64``.
* ``all``.

예시: 플랫폼 지정자 ``all``\ 을 사용한다.

.. code-block:: bash

     conda convert --platform all ~/anaconda/conda-bld/linux-64/pyinstrument-0.13.1-py27_0.tar.bz2 -o outputdir/


주의: 경로와 파일명을 :ref:`build-and-install`\ 에서 저장한 것으로 바꾼다.


.. _pypi-source:

선택---깃헙 대신 PyPI를 소스로 사용하기
======================================================

깃헙(Github) 대신 PyPI나 다른 레포지토리를 사용할 수 있다.
PyPI와 같은 레포지토리의 타르볼(tarball) 파일로 빌드하거나 깃(Git)으로부터 빌드해도 콘다 빌드에는 큰 차이가 없다.
동일한 소스가 호스팅되기 때문에 깃헙 대신 PyPI에서도 쉽게 스크립트를 찾을 수 있다.

위의 예제의 ``source`` 부분을

.. code-block:: bash

   git_rev: v0.13.1
   git_url: https://github.com/joerick/pyinstrument.git

아래와 같이 바꾼다.

.. code-block:: bash

    fn: pyinstrument-0.13.1.tar.gz
    md5: e347036acc50720c0903dc2221b2605d
    url: https://pypi.python.org/packages/source/p/pyinstrument/pyinstrument-0.13.1.tar.gz


주의: ``md5``\ 는 `PyPI 파이인스트루먼트 페이지 <https://pypi.python.org/pypi/pyinstrument>`_\ 에서 찾을 수 있다.


.. _anaconda-org:

선택---새 패키지를 Anaconda.org에 업로드하기
=================================================

다른 플랫폼에서 사용할 수 있게 패키지 변환을 하고 나면 이전엔 binstar.org였던 Anaconda.org에 파일을 업로드할지 결정할 수 있다.
무료 Anaconda.org 계정이 있다면 몇 분 만에 할 수 있다.

#. Anaconda.org 계정이 없다면 무료 계정을 만들고 사용자명과 암호를 기록해 둔다.

#. ``conda install anaconda-client``명령을 실행하고 앞서 만든 사용자명과 암호를 입력한다.

#. 다음 명령으로 `Anaconda.org <http://anaconda.org>`_ 계정에 로그인한다.

   .. code-block:: bash

      anaconda login

#. 패키지를 Anaconda.org에 업로드한다.

   .. code-block:: bash

      anaconda upload ~/miniconda/conda-bld/linux-64/pyinstrument-0.12-py27_0.tar.bz


   주의: 경로와 파일명을 :ref:`build-and-install`\ 에서 저장한 것으로 바꾼다.

   팁: ``conda config --set anaconda_upload yes``\ 명령을 사용해
   콘다가 성공적으로 빌드된 패키지를 항상 Anaconda.org에 업로드하게 하면 시간을 절약할 수 있다.


.. _more-resources:

추가 정보
================

* ``meta.yaml``\ 에 사용할 수 있는 모든 값에 대한 정보는
  :doc:`../tasks/build-packages/define-metadata`\ 에 있다.

* :doc:`../../commands_ko`.
