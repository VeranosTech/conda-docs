===========================================
conda skeleton 을 사용한 콘다 패키지 빌드
===========================================

개요
--------

이 튜토리얼에서 이미 PyPi 를 통해 사용가능한 파이썬 모듈의 콘다 패키지를 빠르게 빌드하는 방법을 배울 수 있다.
conda skeleton 커맨드는 PyPi 패키지 메타데이터를 가져와 콘다 빌드 래시피를 준비한다.
마지막 단계는 패키지 자체를 빌드하고 이를 콘다 환경에 설치하는 것이다.

튜토리얼 대상
----------------------

이 튜토리얼은 PyPi 패키지로부터 콘다 패키지를 생성하고자 하는 윈도우, 맥, 리눅스 사용자를 위한 튜토리얼이다.
콘다 빌드 또는 콘다 래시피에 대한 사전지식은 없어도 된다.


콘다 빌드 요약
~~~~~~~~~~~~~~~~~~~

PyPi 패키지로부터 콘다 패키지를 빌드하는 것은 2단계로 끝난다.
추가로 3단계가 더 있지만 다른 버전의 파이썬 또는 다른 아키텍쳐상의 콘다 환경에 패키지를 설치하고자 할 때 사용한다.

#. :ref:`before-you-start1`
#. :ref:`conda-build-skeleton`
#. :ref:`python-versions`
#. :ref:`convert-conda-package`
#. :ref:`upload-to-anaconda-org`
#. :ref:`troubleshooting`
#. :ref:`help1`


.. _before-you-start1:

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


.. _conda-build-skeleton:

conda skeleton pypi 로 간단한 패키지 빌드하기
-----------------------------------------------

PyPI 상에 호스팅된 파이썬 패키지를 위한 skeleton 래시피를 빌드하는 것은 어렵지 않다.
PyPI 는 파이썬 프로그래밍 언어를 위한 공식 타사 소프트웨어 저장소이다.

이 섹션에서 skeleton 을 사용해 콘다 래시피를 생성할 것이다.
콘다 빌드는 생성된 콘다 래시피로부터 어디에 소스파일이 위치하는지와 어떻게 패키지를 빌드하고 설치 할지에 대해 알 수 있다.

PyPI 에 호스팅된 Pyinstrument_ 패키지로 작업할 것이다.
Pyinstrument 란 통계 프로파일러로 매 밀리초마다 쌓인 모든 호출을 기록한다.
이를 통해 프로그래머는 코드의 어느 부분이 가장 느리고 어떻게 이를 개선 할지에 대해 알 수 있다.

.. _Pyinstrument: https://github.com/joerick/pyinstrument

먼저 사용자 홈 디렉토리에서 ``conda skeleton`` 커맨드를 실행한다.:

.. code-block:: bash

    conda skeleton pypi pyinstrument

``conda skeleton`` 의 두개의 인수는 호스팅 위치이다. 이번 예시에서는 ``pypi`` 와 패키지명이다.

이 커맨드는 Pyinstrument 로 명명된 디렉토리를 만들고 디렉토리 내부에 세개의 skeleton 파일을 생성한다. : meta.yaml, build.sh, bld.bat.
``ls`` (리눅스, OS X) ``dir`` (윈도우) 커맨드로 이 파일들이 생성되었는지 확인한다.
생성된 파일들은 PyPI 메타데이터로 채워져있고 대부분의 경우에 수정하지 않는다.

이 세개의 파일을 *콘다 빌드 래시피* 라 한다.:

    **meta.yaml:** 래시피의 모든 메타데이터를 포함한다. 패키지명과 버전에 대한 섹션만 필수이다. 나머지 요소들은 선택적이다.

    **bld.bat:** 패키지 빌드를 위한 윈도우 커맨드.

    **build.sh:** 패키지 빌드를 위한 리눅스와 OS X 커맨드.



이제 콘다 빌드 래시피가 준비되었다. 콘다 빌드를 사용해 패키지를 생성할 수 있다.

.. code-block:: bash

    conda build pyinstrument

콘다 빌드가 완료되면 콘다 패키지의 정확한 경로와 파일명을 보여준다.
:ref:`troubleshooting` 섹션에서 conda build 커맨드가 실패했을 때의 대처법을 보자.

윈도우 파일 경로 예시:

.. code-block:: text

    C:\Users\jsmith\Miniconda\conda-bld\win-64\pyinstrument-0.13.1-py27_0.tar.bz2

OS X 파일 경로 예시:

.. code-block:: text

    /Users/jsmith/miniconda/conda-bld/osx-64/pyinstrument-0.13.1-py27_0.tar.bz2

리눅스 파일 경로 예시:

.. code-block:: text

    /home/jsmith/miniconda/conda-bld/linux-64/pyinstrument-0.13.1-py27_0.tar.bz2

주의: 경로와 파일명은 사용자의 설치와 운영체제에 따라 달라질 수 있다. 다음 단계를 위해 파일명과 경로를 저장해 두자.

콘다 환경에 새로 빌드한 패키지를 설치해보자. use-local 플래그를 사용한다.:

.. code-block:: bash

    conda install --use-local pyinstrument

Pyinstrument 가 성공적으로 설치되었는지 확인한다.:

.. code-block:: bash

    conda list

이제 pyinstrument 의 콘다 패키지를 갖게 되었다. pyinstrument 는 루트 디렉토리와 동일한 파이썬 버전을 사용하는 환경이라면 어디든 설치될 수 있다.
남은 선택 섹션들은 다른 버전의 파이썬이나 아키텍쳐를 위한 패키지 생성과 Anaconda.org 에 업로드 하는 방법을 다룬다.


.. _`python-versions`:

선택 - 다른 버전의 파이썬을 위한 패키지 빌드
-----------------------------------------------
디폴트에 의해 콘다 빌드는 루트 디렉토리에 설치된 파이썬 버전으로 패키지를 빌드한다.
다른 버전의 파이썬으로 패키지를 생성하려면 ``--python`` 플래그에 원하는 버전을 붙이면 된다.
예를 들어, 파이썬 3.3 을 위한 Pyinstrument 패키지를 빌드하려면 다음 커맨드를 입력하면 된다.

.. code-block:: bash

    conda build --python 3.3 pyinstrument

콘다 빌드 출력 끝에 인쇄된 파일이 지정한 파이썬 버전과 동일함을 확인할 수 있다.
conda install 커맨드는 패키지 디렉토리에서 현재 파이썬 버전과 동일한 파일을 찾는다.

윈도우 파일 경로 예시:

.. code-block:: text

    C:\Users\jsmith\Miniconda\conda-bld\win-64\pyinstrument-0.13.1-py33_0.tar.bz2

OS X 파일 경로 예시:

.. code-block:: text

    /Users/jsmith/miniconda/conda-bld/osx-64/pyinstrument-0.13.1-py33_0.tar.bz2

리눅스 파일 경로 예시:

.. code-block:: text

    /home/jsmith/miniconda/conda-bld/linux-64/pyinstrument-0.13.1-py33_0.tar.bz2

주의: 경로와 파일명은 사용자의 설치와 운영체제에 따라 달라질 수 있다. 다음 단계를 위해 파일명과 경로를 저장해 두자.

.. _convert-conda-package:

선택 - 다른 운영체제의 콘다 패키지로 변환
----------------------------------------------------

콘다 빌드를 사용해 현재 운영체제에 맞는 패키지를 빌드했다. conda convert 커맨드와 운영체제 지정자를 사용해 다른 운영체제에서 사용가능한 패키지로 변환할 수 있다. 운영체제 지정자는 {osx-64,linux-32,linux-64,win-32,win-64,all} 가 있다. 출력 디렉토리에 지정한 플랫폼 당 하나의 롤더가 생성된다. 각각의 폴더는 폴더에 지정된 플랫폼을 위한 .tar.bz2 패키지 파일을 포함한다.

윈도우 사용자:

.. code-block:: text

    conda convert -f --platform all C:\Users\jsmith\Miniconda\conda-bld\win-64\pyinstrument-0.13.1-py27_0.tar.bz2 -o outputdir\

리눅스, OS X 사용자:

.. code-block:: text

    conda convert --platform all /home/jsmith/miniconda/conda-bld/linux-64/pyinstrument-0.13.1-py27_0.tar.bz2 -o outputdir/

주의: 경로와 파일명을 2단계에서 저장한 것과 동일하게 맞춘다.

이 패키지들을 사용하려면 다른 컴퓨터에 패키지를 옮기고 위에 나타난 것과 같이 알맞은 ``conda-bld/$ARCH`` 디렉토리에 넣어야 한다.
``$ARCH`` 는 ``osx-64``, ``linux-32``, ``linux-64``, ``win-32``, ``win-64`` 가 될 수 있다.

더 간단한 방법은 모든 bz2 파일을 Anaconda.org 에 업로드 하는 것이다. 다음 섹션에서 다루도록 하자.


.. _`upload-to-anaconda-org`:

선택 - Anaconda.org 에 패키지 업로드
------------------------------------------

Anaconda.org 는 공개, 비공개 패키지를 위한 저장소이다.
Anaconda.org 에 업로드하면 어떤 환경에서도 conda install 커맨드를 사용해 패키지를 손쉽게 설치할 수 있다.
수동으로 tarball 파일을 복사하고 다른 컴퓨터로 옮기지 않아도 된다.
사용자의 파일을 공개할 수도 있고 비공개로 할 수도 있다. Anaconda.org 에 대한 자세한 정보는 Anaconda.org 페이지를 참고하자.

1. 무료 Anaconda.org 계정을 만들고 유저명과 암호를 기록한다.
2. ``conda install anaconda-client`` 커맨드를 실행하고 유저명과 암호를 입력한다.
3. 터미널에서 ``anaconda login`` 커맨드를 사용해 Anaconda.org 계정으로 로그인한다.

이제 로컬 패키지를 Anaconda 에 업로드 할 수 있다.

윈도우 사용자:

.. code-block:: text

    anaconda upload C:\Users\jsmith\Miniconda\conda-bld\win-64\pyinstrument-0.13.1-py27_0.tar.bz2

리눅스, OS X 사용자:

.. code-block:: text

    anaconda upload /home/jsmith/miniconda/conda-bld/linux-64/pyinstrument-0.13.1-py27_0.tar.bz2


주의: 경로와 파일명을 2단계에서 저장한 것과 동일하게 맞춘다. 경로와 파일명은 사용자의 설치와 운영체제에 따라 달라질 수 있다.

여러 버전의 파이썬을 위한 패키지를 만들었거나 conda convert 커맨드로 각각의 아키텍쳐를 위한 패키지를 만들었다면
각각의 패키지는 anaconda upload 커맨드로 업로드 되어야 한다.
이 과정은 모든 아키텍쳐 상에서 파이썬 2.7, 3.4, 3.5 를 위한 패키지를 만들어보는 가장 좋은 연습이 될 것이다.

팁: 성공적으로 빌드된 패키지를 자동으로 Anaconda.org 에 업로드 하고 싶다면 다음 커맨드를 사용한다.:

.. code-block:: bash

    conda config --set anaconda_upload yes

다음 커맨드로 Anaconda.org 에서 로그아웃 할 수 있다.:

.. code-block:: bash

    anaconda logout

Anaconda.org 에 대한 상세 정보는 `Anaconda.org 문서 페이지 <http://docs.anaconda.org/>`_ 를 보자.

.. _`troubleshooting`:

트러블슈팅
---------------

skeleton 과 콘다 빌드를 사용해 PyPi 로부터 얻은 패키지를 빌드할 때 여러 문제들이 발생할 수 있다.
이 섹션은 몇몇 보편적인 문제에 대한 설명과 해결책을 다룬다.

A. 빌드할 패키지 손실
~~~~~~~~~~~~~~~~~~~~~~~~

콘다 빌드가 패키지를 찾을 수 없다는 에러를 겪을 수 있다. Skyfield 의 conda skeleton 패키지를 만들어 보자. 다음 커맨드를 사용한다.

.. code-block:: bash

    conda skeleton pypi skyfield

이 커맨드는 Skyfield 콘다 빌드 래시피를 생성한다. ``conda build skyfield`` 를 사용하면 실패와 함께 다음 출력이 나타난다.

.. code-block:: text

    Removing old build environment
    Removing old work directory
    BUILD START: skyfield-0.8-py35_0
    Using Anaconda Cloud api site https://api.anaconda.org
    Fetching package metadata: ......
    Solving package specifications: .
    Error:  Package missing in current osx-64 channels:
      - sgp4 >=1.4

이번 예시에서 sgp4 는 skyfield 패키지를 위한 나의 콘다 래시피에 의해 요구된다.
skyfield 래시피는 conda skeleton 에 의해 생성된다. 이 에러는 콘다가 sgp 패키지를 찾지 못하는 상황을 의미한다.

많은 PyPi 패키지가 다른 PyPi 패키지에 의존하기 때문에 이 문제는
conda skeleton 을 사용해 다른 패키지를 위한 콘다 래시피를 먼저 생성하고 패키지를 빌드함으로써 간단히 해결할 수 있다.

.. code-block:: bash

    conda skeleton sgp4
    conda build sgp4

conda skeleton 에 --recursive 플래그를 사용할 수 있다. 이 플래그는 모든 요구된 패키지를 위한 래시피를 생성한다.
이미 conda install 로 설치 가능한 패키지의 래시피까지 생성할 수 있다.


.. _`help1`:

추가정보
----------------------
conda skeleton 문서_ 에서 더 많은 정보를 얻을 수 있다.

.. _문서: https://conda.io/docs/commands/build/conda-skeleton-pypi.html
