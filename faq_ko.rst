===
FAQ
===

.. contents::

자주 묻는 질문
=================

1. 콘다란 무엇인가?

콘다는 크로스 플랫폼이면서 파이썬에 구속받지 않는 패키지, 환경 관리 프로그램이다.
패키지와 그 하위 요소를 빠르게 설치, 실행, 업데이트 하고
로컬 컴퓨터의 환경을 손쉽게 생성, 저장, 불러오기, 전환할 수 있다.
콘다는 모든 버전의 아나콘다, 미니콘다, 아나콘다 저장소를 포함한다.

2. 미니콘다란 무엇인가?

미니콘다는 콘다, 파이썬, pip,zlib 을 포함한 몇몇 유용한 패키지들을 포함한다.

3. 아나콘다란 무엇인가?

아나콘다는 미니콘다의 모든 요소를 포함하며 안정된 150여개의 표준 오픈소스 패키지도 포함한다.
포함된 오픈소스 패키지들은 scipy, numpy 등 데이터 분석과 과학 연산을 위한 패키지들로 함께 잘 작동되는지 테스트 되었다.
한번의 빠르고 편리한 설치 과정을 통해 이 패키지들은 자동으로 설치된다.

4. 미니콘다와 아나콘다가 파이썬을 포함하는가?

포함한다. 아나콘다와 미니콘다가 파이썬을 포함하므로 일종의 파이썬 배포판이다.
아나콘다와 미니콘다로 초심자들도 파이썬을 쉽고 빠르게 설치할 수 있다.

5. 아나콘다 대신 미니콘다를 사용하는 때는 언제인가?

아나콘다 완전판 대신 미니콘다를 사용한다면 사용자는 반드시 원하는 패키지를 고르고 콘다를 통해 패키지를 다운로드 받아 설치해야 한다.
디스크 공간이 한정적이거나 모든 아나콘다 패키지를 한번에 받는 시간이 아깝다면 미니콘다를 사용할 수 있다.

6. 콘다를 사용하기 위해 다른 파이썬 설치나 패키지를 삭제해야 하는가?

삭제하지 않아도 된다. 이미 파이썬 시스템, OS X Homebrew 패키지 매니저와 같은 다른 소스로부터 설치된 파이썬, pip 로부터 전역에 설치된
numpy, pandas 와 같은 패키지를 가지고 있더라도 콘다를 사용하기 전에 제거할 필요는 없다.

바로 아나콘다나 미니콘다를 설치해 인스톨러가 사용자의 경로 환경 변수에 파이썬 콘다 설치를 추가하게 두면 된다.
PYTHONPATH 환경 변수를 설정할 필요는 없다.

경로 변수를 확인하고 그 경로에 파이썬 콘다 설치가 들어갔는지 보려면
OS X나 리눅스에서는 ``echo $PATH`` 윈도우에서는 ``echo %PATH%`` 를 사용한다.
어느 파이썬 설치가 현재 디폴트 설정인지 보려면 OS X나 리눅스는 ``which python``
윈도우는 ``where python`` 을 사용한다. 현재 콘다 환경에서 어떤 파이썬 패키지가 설치되었고
버전 번호는 무엇인지 보려면 ``conda list`` 를 사용한다.

도움말 보기
============

1. 어떤 콘다 커맨드가 지원되는지 보려면?

.. code-block:: bash

  conda -h

또는 웹에서 커맨드 레퍼런스 가이드를 본다. :doc:`/commands`.

2. **conda create** 와 같은 특정 커맨드에 대한 도움말을 보려면?

.. code-block:: bash

  conda create -h

3. 콘다 사용에 관한 도움말을 보려면?

:doc:`/using/cheatsheet_ko` 와 :doc:`/install/quick_ko` 가이드를 다운로드 한다.

30분이 걸리는 :doc:`test-drive_ko` 를 보고 , 콘다 문서 사이트 완전한 섹션인 :doc:`/using/index_ko` 을 본다.

`Google group <https://groups.google.com/a/continuum.io/forum/?fromgroups#!forum/anaconda/>`_ 에서 무료 커뮤티니 지원을 받을 수 있다.

유료 지원, 트레이닝, 컨설팅 옵션도 있다. `Support Services <http://continuum.io/support/>`_ 에서 더 많은 정보를 볼 수 있다.

검색 & 정보
================

1. 내가 설치한 콘다가 어느 버전인지 보려면?

아래 터미널 윈도우에 들어간다.:

.. code-block:: bash

  conda info

또는 아래와 같이 들어간다.:

.. code-block:: bash

  conda -V

참고: 콘다 문서 사이트의 완전한 섹션 :doc:`/using/index_ko`.

2. *SciPy* 와 같은 특정 패키지가 나의 설치에서 사용 가능한지 보려면?

.. code-block:: bash

  conda search scipy

3. *SciPy* 와 같은 특정 패키지가 Continuum repos 로부터의 설치에서 사용 가능한지 보려면? (예시 Anaconda)

.. code-block:: bash

  conda search --override-channels --channel defaults scipy

참고: 콘다 문서 사이트의 섹션 :doc:`/using/pkgs_ko`

4. *iminuit* 와 같은 특정 패키지가 특정 채널에 존재 여부와 사용 가능 여부를 확인하려면?
   (예시,  http://conda.anaconda.org/mutirri)

.. code-block:: bash

  conda search --override-channels --channel http://conda.anaconda.org/mutirri iminuit

.. _customization:


패키지 관리
==================

패키지 설치
-------------------

1. SciPy 와 같은 특정 패키지를 설치하려면?

   .. code-block:: bash

      conda install scipy

2. SciPy 와 같은 패키지를 특정 버전으로 설치하려면?

   .. code-block:: bash

      conda install scipy=0.15.0

3. SciPy 와 *cURL* 처럼 여러개의 패키지를 동시에 설치하려면?

   .. code-block:: bash

      conda install scipy curl

주의: 모든 하위 요소가 동시에 설치되도록 모든 패키지를 한번에 받는 것을 권장한다.

4. 여러개의 패키지를 한번에 설치하면서 버전까지 지정하려면?

   .. code-block:: bash

      conda install scipy=0.15.0 curl=7.26.0

5. 특정 파이썬 버전을 위한 패키지를 설치하려면?

일반적으로 특정 파이썬 버전을 사용하고자 한다면 그 버전의 환경을 사용하는 것이 가장 좋다.  :doc:`/troubleshooting_ko` 에서 세부적인 예시를 볼 수 있다.

   .. code-block:: bash

      conda install scipy=0.15.0 curl=7.26.0 -n py34_env

주의: 모든 하위 요소가 동시에 설치되도록 모든 패키지를 한번에 받는 것을 권장한다.

패키지 업데이트
-----------------

#. *conda* 자체를 업데이트 하려면?

   .. code-block:: bash

      conda update conda

#. *Anaconda* 메타 패키지를 업데이트 하려면?

   .. code-block:: bash

      conda update conda
      conda update anaconda

#. SciPy 와 같은 특정 패키지를 업데이트 하려면?

   .. code-block:: bash

      conda update scipy

#. 특정 패키지가 업데이트 되는 것을 막으려면?


   See :ref:`pinning-packages`.


패키지 제거
------------------

#. SciPy 와 같은 특정 패키지를 제거하려면?

   .. code-block:: bash

      conda remove scipy

#. SciPy 와 *cURL* 처럼 여러개의 패키지를 한번에 제거하려면?

   .. code-block:: bash

      conda remove scipy curl

환경 관리
=====================

환경에 대한 정보 얻기
-------------------------------

1. 나의 모든 환경이 담긴 리스트를 얻으려면?

   .. code-block:: bash

      conda info -e

참고: 콘다 문서 사이트의 :doc:`/using/envs_ko` 섹션을 보자.

2. 커맨드 프롬프트가 활성화된 환경을 표시하게 하려면?

   이 옵션은 ``conda config --set changeps1 false`` 커맨드로 비활성화거나
   ``conda config --set changeps1 true`` 커맨드로 활성화 할 수 있다.
   디폴트로 비활성화 되어있고 아무 환경이나 활성화, 비활성화 하면서 테스트할 수 있다.

3. ``myenv`` 와 같이 특정 환경에 설치된 모든 패키지의 리스트를 보려면?

   If ``myenv`` is not activated:

     .. code-block:: bash

        conda list -n myenv

   If ``myenv`` is activated:

     .. code-block:: bash

        conda list

4. ``myenv`` 와 같은 이미 존재하는 환경에 특정 패키지가 설치되었는지 보려면? (예시 Scipy)

     .. code-block:: bash

        conda list -n myenv scipy

새로운 환경 생성
-------------------------

1. ``myenv``라는 명칭으로 잘 정돈된 새 환경을 생성하려면?

   .. code-block:: bash

      conda create -n myenv python

참고: 콘다 문서 사이트의 :doc:`/using/envs_ko` 섹션을 보자.

2. 내부에 특정 버전의 *파이썬* 을 디폴트 인터프리터로 갖는 새로운 환경을 ``myenv`` 라는 명칭으로 생성하려면?

   .. code-block:: bash

      conda create -n myenv python=3.4

3. Scipy 와 같은 특정 패키지를 포함하는 새로운 환경을 ``myenv`` 라는 명칭으로 생성하려면?

   - 한줄:

     .. code-block:: bash

        conda create -n myenv scipy

   - 여러줄:

     .. code-block:: bash

        conda create -n myenv python
        conda install -n myenv scipy

4. 특정 패키지의 특정 버전을 포함하는 새로운 패키지를 생성하려면?

   - 한줄:

     .. code-block:: bash

        conda create -n myenv scipy=0.15.0

   - 여러줄:

     .. code-block:: bash

        conda create -n myenv python
        conda install -n myenv scipy=0.15.0

5. ``myenv`` 환경에서 pip 를 사용하려면?

   .. code-block:: bash

      conda install -n myenv pip
      source activate myenv
      pip <pip_subcommand>

활성화와 비활성화
-----------------------

1. 기존 환경 ``myenv`` 를 활성화 하려면?

**리눅스, OS X:** ``source activate myenv``

**윈도우:** ``activate myenv``

참고: 콘다 문서 사이트의 :doc:`/using/envs_ko` 섹션을 보자.

2. 활성화된 환경 ``myenv`` 를 비활성화 하려면?

**리눅스, OS X:** ``source deactivate myenv``

**윈도우:** ``deactivate myenv``

참고: 윈도우에서 다른 환경을 활성화 하기 전에 기존 환경을 비활성화 하는 것은 좋은 연습이 될 것이다.

패키지 설치
-------------------

1. 기존 환경 ``myenv`` 에 SciPy 와 같은 특정 패키지를 설치하려면?

     .. code-block:: bash

        conda install -n myenv scipy

2. 기존 환경 ``myenv`` 에 SciPy 와 같은 특정 패키지를 지정한 버전으로 설치하려면?

   ``myenv`` 가 비활성화 되었을 때:

     .. code-block:: bash

        conda install -n myenv scipy=0.15.0

 -n 또는 name 은 콘다가 패키지를 설치할 환경을 알려준다.

   ``myenv`` 가 활성화 되었을 때:

     .. code-block:: bash

        conda install scipy=0.15.0

3. 새로운 환경을 생성할 때마다 pip 또는 다른 프로그램이 자동으로 설치되게 하려면?

   .. code-block:: bash

      conda config --add create_default_packages pip

   위 커맨드를 실행하고 나면 새로운 환경을 일반적인 방법으로 생성할 수 있다.
   디폴트 패키지는 생성된 환경마다 설치된다.

4. 새로운 환경을 생성할 때마다 SciPy 와 같은 특정 패키지가 자동으로 설치되게 하려면?

   .. code-block:: bash

      conda config --add create_default_packages scipy

   위 커맨드를 실행하고 나면 새로운 환경을 일반적인 방법으로 생성할 수 있다.
   Scipy는 새로운 환경이 생성될 때마다 최신 버전으로 설치된다.

5. 새로운 환경을 생성할 때마다 SciPy 와 같은 특정 패키지가 지정한 버전으로 자동 설치되게 하려면?

   .. code-block:: bash

      conda config --add create_default_packages scipy=0.15.0

   위 커맨드를 실행하고 나면 새로운 환경을 일반적인 방법으로 생성할 수 있다.
   Scipy는 새로운 환경이 생성될 때마다 0.15.0 버전으로 설치된다.

6. 디폴트 설정된 패키지의 설치를 무시하고 정돈된 환경을 생성하려면? (명칭 ``myenv``)

   .. code-block:: bash

      conda create --no-default-packages -n myenv python

7. 어플리케이션을 위한 파이썬 패키지를 만들 때 필자는 파이썬을 2.7.9 버전으로 설정하는 req.txt 파일로부터 환경을 생성했다.
그러나 콘다가 필자의 패키지를 설치할 때 자동으로 파이썬을 2.7.10 버전으로 업그레이드 했다. 이 상황을 어떻게 피할 수 있을까?

콘다 빌드를 사용해 어플리케이션을 위한 콘다 패키지를 생성할 때 패키지의 하위 요소들을 특정 버전으로 지정할 수 있다.
`이번 예시 <https://conda.io/docs/building/meta-yaml.html>`_ 에서 요구되는 커맨드 라인은
"- python" 대신 "- python ==2.7.9" 를 사용한다. 커맨드 라인에서 == 앞에는 공백이 하나 오고 뒤에는 공백을 쓰지 않는다.

패키지와 환경 제거
----------------------------------

#. 기존 환경 ``myenv`` 에서 Scipy 패키지를 지우려면?

   ``myenv`` 가 비활성화 되었을 때:

     .. code-block:: bash

        conda remove -n myenv scipy

   ``myenv`` 가 활성화 되었을 때:

     .. code-block:: bash

        conda remove scipy

#. 기존 환경 ``myenv`` 를 삭제하려면?

     .. code-block:: bash

        conda remove -n myenv --all


사용자화 (.condarc file)
=============================

주의: 커맨드 앞에 ``-f`` 를 붙여 "force" 옵션을 추가해야 할 수도 있다.

#. 사용자의 .condarc 파일로부터 모든 키와 값들을 가져오려면?

   .. code-block:: bash

      conda config --get

#. 사용자의 .condarc 파일로부터 channels 와 같은 특정 키의 값을 가져오려면?

   .. code-block:: bash

      conda config --get channels

#. channels 와 같은 특정 키에 새로운 값 (http://conda.anaconda.org/mutirri) 을 추가하려면?

   .. code-block:: bash

      conda config --add channels http://conda.anaconda.org/mutirri

#. 특정 키의 기존 값 (for example, http://conda.anaconda.org/mutirri) 을 삭제하려면?

   .. code-block:: bash

      conda config --remove channels http://conda.anaconda.org/mutirri

#. 특정 키 channels 와 키의 모든 값을 삭제하려면?

   .. code-block:: bash

      conda config --remove-key channels

#. 하나의 환경에서만 채널과 그 우선 순위를 설정하려면?

:ref:`root directory of that environment <config-channels>` 에 ``.condarc`` 파일을 만든다.


콘다 빌드와 레시피
=======================

#. *bottle* 과 같은 특정 패키지가 PyPI 기반이라는걸 알고 있다고 하자. 이 패키지를 위한 스켈레톤 콘다 레시피를 생성하려면?

   .. code-block:: bash

      conda skeleton pypi bottle

   이제 아래 코드로 빌드할 수 있다.

   .. code-block:: bash

      conda build bottle

참고: :doc:`/build_tutorials/pkgs_ko` 튜토리.

.. toctree::
   :hidden:

   redirects
   help/silent
   travis
   help/conda-pip-virtualenv-translator.rst
   winxp-proxy


.. _pinning-packages:

패키지 고정
================

환경 내부의 패키지 사양을 *고정* 함으로써 업데이트를 막을 수 있다.
``--no-pin`` 플래그가 콘다를 통과하지 않는한 업데이트 되기 않는다.
사양 목록이 담긴 환경의 ``conda-meta`` 디렉토리에 파일명이 ``pinned`` 인 파일을 추가하면 된다.
예를 들어 ``pinned`` 파일은 아래 커맨드를 포함한다.

::

   numpy 1.7.*
   scipy ==0.14.2

위 커맨드로 numpy 는 1.7 시리즈 (1.7로 시작하는 어떤 버전), scipy 는 0.14.2 버전에 고정된다.

주의: 위와 같은 pinned 파일이 있으면, ``conda update numpy`` 커맨드는 numpy 를 1.7.1 버전으로 유지하고
``conda install scipy=0.15.0`` 커맨드는 에러가 된다. 두 커맨드를 강제로 실행하려면
``conda update numpy --no-pin`` 커맨드와 같이 ``--no-pin`` 플래그를 사용하면 된다.
작업을 고정하는 방식을 통해 고정된 사양이 각각의 콘다 인스톨에 포함되므로
이후의  ``--no-pin`` 없이 ``conda update`` 커맨드를 실행하면 numpy 는 1.7 시리즈로 되돌아간다.

콘다, pip, virtualenv
==========================

pip 나 virtualenv 에 이미 익숙하다면, 콘다와 pip, virtualenv 를 비교한 아래 차트를 보라.
:doc:`Conda, pip, and virtualenv <help/conda-pip-virtualenv-translator>`

자동 설치
===================

미니콘다 또는 아나콘다의 :doc:`자동 설치 <help/silent_ko>` 는 배포, 테스트, 빌딩 서비스(Travis CI, Appveyor 등)에 사용될 수 있다.

Travis CI 와 콘다 사용하기
==========================

콘다는 Travis CI, AppVeyor 와 같이 코드를 자동으로 반복 테스트하는 :doc:`continuous integration systems <travis>` 과 결합될 수 있다.

윈도우 XP 와 프록시 설정
===================================

마이크로 소프트가 제공하는 윈도우 XP 의 지원은 종료되었다. 윈도우 XP 는 더 이상 아나콘다가 지원하는 운영체제가 아니지만
몇몇 사용자는 :doc:`Anaconda on Windows XP with proxy configuration <winxp-proxy>` 설정으로 아나콘다를 설치했다..
