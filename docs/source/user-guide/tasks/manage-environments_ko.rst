=====================
환경 관리
=====================

.. contents::
   :local:
   :depth: 1

콘다를 사용하면 다른 버전의 파이썬과 패키지가 설치된 환경을 생성,내보내기,나열,삭제,업데이트할 수 있다.
환경 간에 전환하는 것을 환경 활성화라고 한다. 환경 파일을 공유할 수도 있다.

주의: 이 문서에서 다루는 명령에 추가할 수 있는 많은 옵션이 있다. 자세한 정보는 :doc:`../../commands_ko`\ 에 있다.


명령으로 콘다 환경 생성하기
=====================================

팁: 환경은 기본적으로 사용자의 콘다 디렉토리 내부에 있는 ``envs`` 디렉토리에 설치된다.
``conda create --help``\ 로 다른 경로를 지정하는 방법을 볼 수 있다.

터미널이나 아나콘다 프롬프트에서 다음 단계를 따라 진행한다.

#. 다음 명령으로 환경을 생성한다.

   .. code::

      conda create --name myenv

   주의: (위 명령에서) ``myenv``\ 를 생성하고자 하는 환경 이름으로 바꾼다.

#. 계속 진행하려면 ``y``\ 를 입력한다.

   .. code::

      proceed ([y]/n)?

``/envs/``\ 에 myenv 환경에 생성된다. 파이썬 버전을 지정하지 않았기 때문에
이 환경은 현재 사용중인 것과 동일한 파이썬 버전을 사용한다.

다음 명령으로 특정한 버전의 파이썬을 사용하는 환경을 생성한다.

.. code-block:: bash

      conda create -n myenv python=3.4

다음 명령으로 특정 패키지가 설치된 환경을 생성한다.

.. code-block:: bash

   conda create -n myenv scipy

또는

.. code-block:: bash

   conda create -n myenv python
   conda install -n myenv scipy

다음을 실행해 특정 버전으로 지정한 패키지가 설치된 환경을 생성한다.

.. code-block:: bash

   conda create -n myenv scipy=0.15.0

또는

.. code-block:: bash

   conda create -n myenv python
   conda install -n myenv scipy=0.15.0

다음을 실행해 특정한 버전의 파이썬과 복수의 패키지가 설치된 환경을 생성한다.

.. code-block:: bash

   conda create -n myenv python=3.4 scipy=0.15.0 astroid babel

팁: 환경에 설치하고자 하는 모든 프로그램을 한번에 설치한다.
프로그램을 하나씩 설치하면 의존 요소 충돌이 일어날 수 있다.

새로운 환경을 생성할 때마다 pip와 다른 프로그램들이 자동으로 설치되게 하려면
사용자의 ``.condarc`` 설정 파일의 :ref:`기본 패키지 설정 <config-add-default-pkgs>`\ 에 기본 프로그램을 추가해야 한다.
기본 패키지는 새로운 환경을 생성할 때마다 그 환경에 설치된다. 특정 환경에 기본 패키지를 설치하고 싶지 않다면
``--no-default-packages`` 플래그를 사용한다.

.. code-block:: bash

   conda create --no-default-packages -n myenv python

팁: ``conda create`` 명령에 많은 옵션을 추가할 수 있다.
자세한 정보는 ``conda create --help``\ 를 실행해 볼 수 있다.

.. _create-env-from-file:


environment.yml 파일을 사용해 환경 생성하기
====================================================

터미널이나 아나콘다 프롬프트에서 다음 단계를 따라 진행한다.

#. 다음 명령으로 ``environment.yml``\ 로부터 환경을 생성한다.

   .. code::

      conda env create -f environment.yml

``yml`` 파일의 첫 줄에 새로운 환경의 이름을 세팅해라. 자세한 내용은
:ref:`수동으로 환경 파일 생성하기 <create-env-file-manually>`\ 를 봐라.

#. 다음 명령으로 새로운 환경을 활성화한다.

   * 윈도우: ``activate myenv``

   * 맥OS, 리눅스: ``source activate myenv``

   주의: (위 명령에서) ``myenv``\ 를 생성된 환경 이름으로 바꾼다.

#. 다음 명령으로 환경이 제대로 생성되었는지 확인한다.

   .. code::

      conda list


환경 복사하기
=======================

터미널이나 아나콘다 프롬프트에서 다음 단계를 따라 진행한다.

환경의 복사본을 생성해 그 환경과 완전히 동일한 복사본을 만들 수 있다.

.. code::

   conda create --name myclone --clone myenv

주의: (위 명령에서) ``myclone``\ 을 새로운 환경의 이름으로 바꾼다.
``myenv``\ 은 복사하고자 하는 기존 환경의 이름으로 바꾼다.

다음을 실행해 환경이 복사되었는지 확인한다.

.. code::

   conda info --envs

나타난 환경 목록에서 원래 환경과 복사된 환경을 모두 볼 수 있어야 한다.


동일한 콘다 환경 빌드하기
=====================================

사양 명시 파일을 사용해 기존 환경과 동일한 콘다 환경을 같은 운영 체제에서 빌드할 수 있다.
이 작업은 기존에 환경이 있던 기기 뿐 아니라 다른 기기에서도 할 수 있다.

터미널이나 아나콘다 프롬프트에서 다음 단계를 따라 진행한다.

#. ``conda list --explicit``\ 를 실행해 다음과 같은 사양 목록을 생성한다.

   .. code::

      # This file may be used to create an environment using:
      # $ conda create --name <env> --file <this file>
      # platform: osx-64
      @EXPLICIT
      https://repo.continuum.io/pkgs/free/osx-64/mkl-11.3.3-0.tar.bz2
      https://repo.continuum.io/pkgs/free/osx-64/numpy-1.11.1-py35_0.tar.bz2
      https://repo.continuum.io/pkgs/free/osx-64/openssl-1.0.2h-1.tar.bz2
      https://repo.continuum.io/pkgs/free/osx-64/pip-8.1.2-py35_0.tar.bz2
      https://repo.continuum.io/pkgs/free/osx-64/python-3.5.2-0.tar.bz2
      https://repo.continuum.io/pkgs/free/osx-64/readline-6.2-2.tar.bz2
      https://repo.continuum.io/pkgs/free/osx-64/setuptools-25.1.6-py35_0.tar.bz2
      https://repo.continuum.io/pkgs/free/osx-64/sqlite-3.13.0-0.tar.bz2
      https://repo.continuum.io/pkgs/free/osx-64/tk-8.5.18-0.tar.bz2
      https://repo.continuum.io/pkgs/free/osx-64/wheel-0.29.0-py35_0.tar.bz2
      https://repo.continuum.io/pkgs/free/osx-64/xz-5.2.2-0.tar.bz2
      https://repo.continuum.io/pkgs/free/osx-64/zlib-1.2.8-3.tar.bz2


#. 생성된 사양 목록을 현재 디렉토리에 파일로 만들기 위해 다음을 실행한다. ::

     conda list --explicit > spec-file.txt

   주의: ``spec-file.txt``\ 를 파일명으로 사용해도 되고 원하는 파일명으로 바꿔도 된다.

파일 상단에서 파일이 생성된 운영체제를 보여주는 ``# platform: osx-64``\ 에서
알 수 있듯이 사양 명시 파일은 일반적으로 교차 플랫폼 파일이 아니다.
파일에 나타난 플랫폼에서 이 사양 파일이 작동한다.
다른 플랫폼에서는 지정된 패키지를 사용할 수 없거나 사양에 포함된 핵심 패키지의 의존 요소가 손실될 수 있다.

같은 기기나 다른 기기에서 사양 파일을 사용해 동일한 환경을 생성하려면 다음 명령을 실행한다. ::

  conda create --name myenv --file spec-file.txt

사양 파일을 사용해 이 파일에 나열된 패키지를 기존 환경에 설치하려면 다음 명령을 실행한다. ::

  conda install --name myenv --file spec-file.txt

사양 파일로부터 패키지를 설치할 때 콘다는 아키텍쳐와 의존 요소를 확인하지 않는다.
사양 파일이 작업 중인 환경에서 생성되었고 linux-64나 osx-64와 같이 동일한 아키텍쳐와 운영체제를 사용하는지
확인해야 패키지가 제대로 작동한다고 보장할 수 있다.


.. _activate-env:

환경 활성화하기
=========================

다음 명령으로 환경을 활성화한다.

* 윈도우: 아나콘다 프롬프트에서 ``activate myenv``\ 를 실행한다.

* 맥OS, 리눅스: 터미널에서 ``source activate myenv``\ 를 실행한다.

시스템 명령에 경로명 ``myenv``\ 가 추가된다.


환경 비활성화하기
===========================

다음 명령으로 환경을 비활성화한다.

* 윈도우: 아나콘다 프롬프트에서 ``deactivate``\ 를 실행한다.

* 맥OS, 리눅스: 터미널에서 ``source deactivate``\ 를 실행한다.

시스템 명령에서 경로명 ``myenv``\ 가 제거된다.

팁: 윈도우에서 다른 환경을 활성화 하기 전에 환경을 비활성화 해보면 좋은 연습이 될 것이다.


.. _determine-current-env:

현재 환경 결정하기
====================================

터미널이나 아나콘다 프롬프트에서 다음 단계를 따라 진행한다.

현재 사용중인 환경, 즉 활성화된 환경은 기본적으로 프롬프트 앞에 (소괄호)나 [대활호] 안에 나타난다. ::

  (myenv) $

위와 같이 나타나지 않으면 다음을 실행한다.

.. code::

   conda info --envs

나타난 환경 목록에서 현재 환경은 별표(*)로 강조된다.

명령 프롬프트는 기본적으로 활성화된 환경 이름을 보여주게 설정되어 있다.
이 옵션을 비활성화하려면 다음 명령을 실행한다. ::

  conda config --set changeps1 false

이 옵션을 다시 활성화 하려면 다음 명령을 실행한다. ::

  conda config --set changeps1 true


사용자의 환경 목록 보여주기
===================================

사용자의 모든 환경 목록을 보려면 터미널이나 아나콘다 프롬프트에서 다음을 실행한다.

.. code::

   conda info --envs

또는

.. code::

   conda env list

다음과 유사하게 환경 목록이 나타난다.

.. code::

   conda environments:
   myenv                 /home/username/miniconda/envs/myenv
   snowflakes            /home/username/miniconda/envs/snowflakes
   bunnies               /home/username/miniconda/envs/bunnies


환경의 패키지 목록 보여주기
================================================

특정한 환경에 설치된 모든 패키지의 목록을 보려면 다음 단계를 따라 진행한다.

* 환경이 활성화되어있지 않다면 터미널이나 아나콘다 프롬프트에서 다음을 실행한다.

  .. code-block:: bash

     conda list -n myenv

* 환경이 활성화되면 터미널이나 아나콘다 프롬프트에서 다음을 실행한다.

  .. code-block:: bash

     conda list

특정한 패키지가 환경에 설치되어 있는지 보려면 터미널이나 아나콘다 프롬프트에서 다음을 실행한다.

.. code-block:: bash

   conda list -n myenv scipy


.. _pip-in-env:

환경에서 pip 사용하기
===========================

사용자의 환경에서 pip를 사용하려면 터미널이나 아나콘다 프롬프트에서 다음을 실행한다.

.. code-block:: bash

   conda install -n myenv pip
   source activate myenv
   pip <pip_subcommand>


환경 변수 저장하기
============================

콘다 환경은 저장된 환경 변수를 포함할 수 있다.

서버에 로그인할 때 필요한 암호키와 설정 파일의 경로를 저장하기 위해 "analytics"라는 환경을 원한다고 가정하자.
이번 절은 ``env_vars``\ 라는 스크립트를 작성해 :ref:`윈도우 <win-save-env-variables>`,
:ref:`맥OS, 리눅스 <macos-linux-save-env-variables>`\ 에서 환경에 암호키와 설정 파일 경로를 저장하는 방법을 설명한다.

``env_vars``\ 와 같은 스크립트 파일은 콘다 패키지에 포함될 수 있으며 패키지가 설치된 환경이 활성화될 때
스크립트에 설정한 변수도 활성화된다.

스크립트의 이름을 원하는대로 설정할 수 있다. 하지만 복수의 패키지가 스크립트 파일을 생성할 수 있으므로
구별할 수 있는 파일명을 사용해 다른 패키지와 스크립트 파일명이 중복되지 않도록 한다.
자주 사용하는 스크립트 파일명은 ``packagename-scriptname.sh``\ 와 같은 형태다.
윈도우에서는 ``packagename-scriptname.bat``\ 가 된다.

.. _win-save-env-variables:

윈도우
-------

#. 아나콘다 프롬프트에서 ``C:\Users\jsmith\Anaconda3\envs\analytics``\ 와 같이 콘다 환경의 디렉토리를 찾는다.

#. 찾아낸 디렉토리에 들어가 다음과 같은 하위 디렉토리와 파일을 생성한다. ::

    cd C:\Users\jsmith\Anaconda3\envs\analytics
    mkdir .\etc\conda\activate.d
    mkdir .\etc\conda\deactivate.d
    type NUL > .\etc\conda\activate.d\env_vars.bat
    type NUL > .\etc\conda\deactivate.d\env_vars.bat

#. ``.\etc\conda\activate.d\env_vars.bat`` 파일에 다음을 작성한다. ::

     set MY_KEY='secret-key-value'
     set MY_FILE=C:\path\to\my\file

#. ``.\etc\conda\deactivate.d\env_vars.bat`` 파일에 다음을 작성한다. ::

     set MY_KEY=
     set MY_FILE=

``source activate analytics``\ 를 실행하면 위 파일에 작성한 값으로 환경 변수 MY_KEY와 MY_FILE이 설정된다.
``source deactivate``\ 를 실행하면 두 변수는 지워진다.

.. _macos-linux-save-env-variables:

맥OS와 리눅스
---------------

#. 터미널에서 ``/home/jsmith/anaconda3/envs/analytics``\ 와 같이 콘다 환경의 디렉토리를 찾는다.

#. 찾아낸 디렉토리에 들어가 다음과 같은 하위 디렉토리와 파일을 생성한다. ::

     cd /home/jsmith/anaconda3/envs/analytics
     mkdir -p ./etc/conda/activate.d
     mkdir -p ./etc/conda/deactivate.d
     touch ./etc/conda/activate.d/env_vars.sh
     touch ./etc/conda/deactivate.d/env_vars.sh

#. ``./etc/conda/activate.d/env_vars.sh`` 파일에 다음을 작성한다. ::

     #!/bin/sh

     export MY_KEY='secret-key-value'
     export MY_FILE=/path/to/my/file/

#. ``./etc/conda/deactivate.d/env_vars.sh`` 파일에 다음을 작성한다. ::

     #!/bin/sh

     unset MY_KEY
     unset MY_FILE

``source activate analytics``\ 를 실행하면 위 파일에 작성한 값으로 환경 변수 MY_KEY와 MY_FILE이 설정된다.
``source deactivate``\ 를 실행하면 두 변수는 지워진다.


환경 공유하기
=======================

사용자가 시행한 테스트를 다른 사용자가 재생성하는 경우와 같이 사용자의 환경을 다른 사용자와 공유하길 원할 수 있다.
``environment.yml`` 파일을 복사해 주면 사용자의 모든 패키지와 버전이 포함된 환경을 다른 사용자가 빠르게 재생성할 수 있다.

환경 파일 내보내기
-------------------------------

주의: 현재 디렉토리에 이미 ``environment.yml`` 파일이 있다면 이 과정에서 파일이 덮어쓰여질 수 있다.

#. 내보낼 환경을 활성화한다.

   * 윈도우: 아나콘다 프롬프트에서 ``activate myenv``\ 를 실행한다.

   * 리눅스, 맥OS: 터미널에서 ``source activate myenv``\ 를 실행한다.

   주의: ``myenv``\ 를 활성화할 환경 이름으로 바꾼다.

#. 활성화된 환경을 새로운 파일로 내보낸다. ::

     conda env export > environment.yml

   주의: 이 파일은 환경의 pip 패키지와 콘다 패키지를 모두 다룬다.

#. 내보낸 ``environment.yml`` 파일을 다른 사용자에게 이메일로 보내거나 복사해 준다.


.. _create-env-file-manually:

수동으로 환경 파일 생성하기
---------------------------------------

환경 파일을 수동으로 생성해 다른 사용자와 공유할 수 있다.

예시: 간단한 환경 파일

.. code::

    name: stats
    dependencies:
      - numpy
      - pandas

예시: 더 복잡한 환경 파일

.. code::

   name: stats2
   channels:
     - javascript
   dependencies:
     - python=3.4   # or 2.7
     - bokeh=0.9.2
     - numpy=1.9.*
     - nodejs=0.10.*
     - flask
     - pip:
       - Flask-Testing

channels 목록에 ``nodefaults``\ 를 추가하면 기본 채널을 제외할 수 있다.

.. code::

   channels:
     - javascript
     - nodefaults

위의 코드는 대부분의 ``conda`` 명령에 ``--override-channels`` 옵션을 추가하는 것과 같다.

``environment.yml`` 파일의 channels 목록에 ``nodefaults``\ 를 추가하는 것은
``.condarc`` 파일의 :ref:`채널 목록 <config-channels>`\ 에서 ``defaults``\ 를 제거하는 것과 비슷하다.
그러나 ``environment.yml`` 파일의 수정은 하나의 콘다 환경에만 영향을 주는 반면에 ``.condarc`` 파일을 수정하면 모든 환경이 영향을 받는다.

이 ``environment.yml`` 파일에서 환경을 생성하는 것에 대한 자세한 내용은
:ref:`create-env-from-file`\ 을 봐라.


환경 삭제하기
=======================

터미널이나 아나콘다 프롬프트에서 다음을 실행해 횐경을 삭제한다.

.. code::

   conda remove --name myenv --all

(위의 명령 대신 ``conda env remove --name myenv``\ 를 사용해도 된다.)

터미널이나 아나콘다 프롬프트에서 다음을 실행해 환경이 삭제되었는지 확인한다.

.. code::

   conda info --envs

나타난 환경 목록에 삭제한 환경이 있어선 안된다.
