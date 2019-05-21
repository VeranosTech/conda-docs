=====================
Managing environments
=====================

.. contents::

콘다를 사용하면 다른 버전의 파이썬 또는 패키지를 사용하는 환경들을 생성, 내보내기, 나열, 제거, 업데이트 할 수 있다. 환경 간에 전환이나 이동을 환경 활성화라 한다. 환경 파일을 동료와 공유할 수도 있다.

언제든 커맨드 뒤에 ``--help`` 플래그를 입력하면 그 커맨드에 대한 완전한 문서를 볼 수 있다. 예를 들어 conda environment 커맨드가 궁금하다면:

.. code::

   conda env --help

동일한 도움말을 온라인에서도 볼 수 있다. :doc:`커맨드 레퍼런스 문서 </commands_ko>`.

환경 생성
----------------------

환경을 관리하기에 앞서 최소한 두개의 환경을 생성해 이들 간에 전환을 할 수 있어야 한다.

새로운 환경 생성을 위해 conda create 커맨드를 사용한다. 커맨드 뒤에 올 환경명은 사용자가 원하는 이름으로 할 수 있다.:

.. code::

   conda create --name snowflakes biopython

콘다가 아래와 같이 묻는다면

.. code::

    proceed ([y]/n)? 

“y” 를 입력한다.

이제 ``/envs/snowflakes`` 라는 명칭의 새로운 환경이 생성되고 Biopython 이라는 프로그램을 포함한다. 파이썬 버전은 지정하지 않았기 때문에 현재 사용중인 것과 동일한 버전의 파이썬을 사용한다.

팁:  많은 사용자들이 옵션을 두개의 대시 (``--``) 이후에 사용하지만 옵션의 첫글자만 사용해도 된다. ``--name`` 은 ``--n`` 과 동일하고 ``--envs`` 는 ``-e`` 와 동일하다. ``conda --help`` 또는 ``conda -h`` 로 축약 리스트틑 볼 수 있다.

환경 변경 (활성화/비활성화)
----------------------------------------------------

**리눅스, OS X:** ``source activate snowflakes``

**윈도우:**  ``activate snowflakes``

콘다는 시스템 커맨드에 경로명 (snowflakes) 를 추가한다.

팁: 환경은 디폴트에 의해 사용자의 콘다 디렉토리 내부의 envs 디렉토리에 설치된다. 원한다면 다른 경로를 지정할 수도 있다. ``conda create --help`` 를 보자.

아래 커맨드로 환경을 비활성화 한다.:

**리눅스, OS X:** ``source deactivate``

**윈도우:**  ``deactivate``

콘다는 시스템 커맨드에서 경로명 (snowflakes) 를 제거한다.

분리된 환경 생성
----------------------------------

환경 간에 전환을 해보았으니 새로운 환경을 생성해보자. 이 두번쨰 환경에서 다른 버전의 파이썬과 몇개의 패키지를 설치할 수 있다.

.. code::

   conda create --name bunnies python=3 astroid babel 

이제 ``/envs/bunnies`` 라는 명칭의 새로운 환경이 생성되고 이 환경에 Python 3, Astroid, Babel 이 설치된다.

팁: 환경에 넣고자 하는 패키지를 한번에 설치하자. 패키지를 개별적으로 설치하면 하위요소 충돌이 나타날 수 있다.

팁: conda create 커맨드에 여러가지를 추가할 수 있다. ``conda create --help`` 를 보자.

환경 나열
---------------------

이제 콘다를 사용해 지금껏 설치된 환경들을 볼 수 있다. conda environment info 커맨드를 사용하자.:

.. code::

   conda info --envs

다음과 같이 설치된 환경의 목록을 볼 수 있다.

.. code::

   conda environments:
   snowflakes            /home/username/miniconda/envs/snowflakes
   bunnies               /home/username/miniconda/envs/bunnies

conda environments list 커맨드를 사용해도 된다.:

.. code::

   conda env list

나열된 환경 목록은 두 커맨드 모두 동일하게 나타난다.

현재 환경 확인
--------------------------

어떤 환경이 현재 사용중일까? snowflakes 일 수도 있고 bunnies 일 수도 있다. 다음 커맨드를 사용해보자.:

.. code::

   conda info --envs

콘다는 모든 환경을 나열하지만 현재 활성화된 환경은 '*' 문자로 강조된다.

환경 복제
-------------------------------------

환경의 복제를 만듬으로써 환경과 동일한 카피를 생성할 수 있다. 다음 커맨드로 flowers 라는 명칭의 snowflakes 카피를 만들어 보자.:

.. code::

   conda create --name flowers --clone snowflakes

동일한 카피가 생성 되었는지 확인한다.:

.. code::

   conda info --envs

이제 목록에 세개의 환경이 나타나야 한다.:  flowers, bunnies, and snowflakes.

환경 제거
-----------------------

flowes 라는 명칭이 마음에 안든다면 이 환경을 제거해보자.:

.. code::

   conda remove --name flowers --all

flowers 환경이 제거 되었는지 확인하기 위해 다음 커맨드를 입력한다.:

.. code::

   conda info --envs

Flowers 는 이제 목록에 존재하지 않는다. 삭제 되었음을 확인했다.

환경 공유
------------------------

다른 사용자와 환경을 공유하고 싶을 수 있다. 환경 공유에는 사용자가 이미 시행한 테스트를 다른 사용자가 재성성하게 하는 것과 같이 여러 목적이 있을 것이다. 환경 yml 파일의 사본을 보내면 패키지와 버전을 동일하게 포함한 환경을 다른 사용자가 빠르게 재현할 수 있다.

환경 파일 내보내기
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

사용자의 환경과 동일한 사본을 다른 사용자가 생성하려면 활성화된 환경 파일을 내보내면 된다.

먼저 내보내고자 하는 환경을 활성화 한다.:

**리눅스, OS X:** ``source activate peppermint``

**윈도우:** ``activate peppermint``

주의: “peppermint” 를 사용자의 환경명으로 대체한다.

주의: 현재 디렉토리에 이미 환경 yml 파일이 존재한다면 새 파일로 덮어쓰게 된다.

활성화된 환경을 새 파일로 내보낸다.:

**모든 운영체제:** ``conda env export > environment.yml``

주의: 이 파일은 콘다 패키지 뿐 아니라 환경의 pip 패키지도 처리한다.

내보내진 환경 yml 파일을 다른 사용자에게 복사하거나 메일로 보낸다.

yml 파일을 받은 사용자는 다음 커맨드로 환경을 생성해야 한다.:

``conda env create -f environment.yml``

파일로부터 환경 사용
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

환경 yml 파일로부터 얻은 다른 개발자 환경의 카피를 생성한다.

.. code::

   conda env create -f environment.yml

새로운 환경을 활성화한다.:

**리눅스, OS X:** ``source activate peppermint``

**윈도우:** ``activate peppermint``

주의: “peppermint” 를 활성화 할 환경명으로 대체한다.

새로운 환경이 제대로 설치 되었는지 확인한다.

.. code::

   conda list

수동으로 환경 파일 생성
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

환경 파일을 수동으로 생성하고 동일한 커맨드로 환경을 생성하는데 사용할 수 있다.: ``conda env create -f environment.yml``

다음은 간단한 환경 파일의 예시이다.:

.. code::

    name: stats
    dependencies:
      - numpy
      - pandas

다음은 좀 더 복잡한 환경 파일의 예시이다.:

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

디폴트 채널은 채널 리스트에 ``nodefaults`` 를 추가해 제외할 수 있다. 콘다 커맨드에 ``--override-channels`` 옵션을 추가하는 것과 동일하다. ``environment.yml`` 의 채널 리스트에 ``nodefaults`` 를 추가하는 것은 ``.condarc`` 파일의 :ref:`채널 리스트 <config-channels_ko>` 에서 ``defaults`` 를 제거하는 것과 동일하다. 하지만 ``environment.yml`` 파일의 수정은 그 환경에만 영향을 주지만 ``.condarc`` 파일의 수정은 모든 콘다 환경에 적용된다.

동일한 콘다 환경 생성
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

특정 사양 파일을 사용해 동일한 운영체제 상에 동일한 콘다 환경을 생성할 수 있다. 기기는 동일하지 않아도 생성 가능하다.

``conda list --explicit`` 커맨드는 다음과 같이 사양 리스트를 보여준다.:

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

``conda list --explicit > spec-file.txt`` 커맨드는 현재 작업 디렉토리에 사양 리스트를 담고 있는 파일을 생성한다. 파일명은 ``spec-file.txt`` 가 아니어도 된다.

파일 상단에서 설명하고 있는 것처럼 ``conda create --name MyEnvironment --file spec-file.txt`` 커맨드를 입력하면 사양 파일을 사용해 동일한 환경을 생성한다. 다른 기기에서도 가능하다.

``conda install --name MyEnvironment --file spec-file.txt`` 커맨드는 기존 환경에 사양 파일에 나열된 패키지를 추가한다.

주의: 이 특정 사양 파일은 일반적으로 운영체제에 의존한다. 따라서 파일에 나온 ``# platform: osx-64`` 과 같이 파일이 생성된 운영체제를 명시한다. 사양 파일은 명시된 운영체제에서 작동하고 다른 운영체제에서는 패키지 사양이 유효하지 않거나 몇몇 주요 패키지의 하위 요소가 손실될 수 있다.

주의: 콘다는 특정 사양 파일로부터 환경을 설치할 때 아키텍쳐나 하위 요소를 확인하지 않는다. 패키지가 제대로 작동하는지 확인하기 위해 파일이 작업중인 환경에서 생성 되었고 동일한 아키텍쳐와 운영체제를 사용하는지 확인한다.

저장된 환경 변수
---------------------------

콘다 환경은 리눅스, 맥 OS, 윈도우에 저장된 환경 변수를 담고 있다.

환경 'analytics' 에 서버에 로그인하기 위한 암호 키와 구성 파일로의 경로를 저장하고 싶을 것이다. 이를 위해 ``env_vars`` 라는 명칭의 스크립트를 작성한다.

리눅스와 맥 OS
~~~~~~~~~~~~~~~

``/home/jsmith/anaconda3/envs/analytics`` 과 같이 콘다 환경을 위한 디렉토리를 지정한다. 디렉토리에 들어가 다음과 같은 하위 디렉토리와 파일을 생성한다.::

  cd /home/jsmith/anaconda3/envs/analytics
  mkdir -p ./etc/conda/activate.d
  mkdir -p ./etc/conda/deactivate.d
  touch ./etc/conda/activate.d/env_vars.sh
  touch ./etc/conda/deactivate.d/env_vars.sh

두개의 파일을 수정한다. ``./etc/conda/activate.d/env_vars.sh`` 파일은 다음과 같아야 한다.::

  #!/bin/sh

  export MY_KEY='secret-key-value'
  export MY_FILE=/path/to/my/file/

``./etc/conda/deactivate.d/env_vars.sh`` 파일은 다음과 같아야 한다.::

  #!/bin/sh

  unset MY_KEY
  unset MY_FILE

 ``source activate analytics`` 를 사용할 때 환경 변수 MY_KEY 와 MY_FILE 은 파일에 작성된 값으로 설정된다. ``source deactivate`` 를 입력하면 설정된 변수들은 삭제된다.

윈도우
~~~~~~~

``C:\Users\jsmith\Anaconda3\envs\analytics`` 과 같이 콘다 환경을 위한 디렉토리를 지정한다. 디렉토리에 들어가 다음과 같은 하위 디렉토리와 파일을 생성한다.::

  cd C:\Users\jsmith\Anaconda3\envs\analytics
  mkdir .\etc\conda\activate.d
  mkdir .\etc\conda\deactivate.d
  type NUL > .\etc\conda\activate.d\env_vars.bat
  type NUL > .\etc\conda\deactivate.d\env_vars.bat

두개의 파일을 수정한다. ``.\etc\conda\activate.d\env_vars.bat`` 파일은 다음과 같아야 한다.::

  set MY_KEY='secret-key-value'
  set MY_FILE=C:\path\to\my\file

``.\etc\conda\deactivate.d\env_vars.bat`` 파일은 다음과 같아야 한다.::

  set MY_KEY=
  set MY_FILE=

``activate analytics`` 를 사용할 때 환경 변수 MY_KEY 와 MY_FILE 은 파일에 작성된 값으로 설정된다. ``deactivate`` 를 입력하면 설정된 변수들은 삭제된다.

환경 변수 스트립트에 대한 추가 정보
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

패키지를 포함한 환경이 활성화 되어 환경 변수들도 활성화되면 스크립트 파일은 콘다 패키지의 일부가 된다..

스크립트 파일명에 제한은 없지만 다수의 패키지가 스크립트 파일을 생성할 수 있으므로 다른 패키지와 중복되지 않고 기술적인 명칭을 갖는 파일명을 사용하자. 많이 사용하는 작명법은 패키지명-스크립트명.sh 이다. (윈도우 패키지명-스크립트명.bat)

다음으로 :doc:`/py2or3_ko` 를 보자.
