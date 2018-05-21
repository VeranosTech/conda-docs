===========================================
콘다 스켈레톤을 사용한 콘다 패키지 빌드
===========================================


.. contents::
   :local:
   :depth: 1


이 튜토리얼은 이미 PyPI에 있는 파이썬 모듈을 콘다 패키지로 빠르게 빌드하는 방법을 설명한다.

먼저 간단한 패키지를 빌드한다.
사용자의 루트 환경과 같은 파이썬 버전을 사용하는 모든 콘다 환경에 설치할 수 있는 패키지를 빌드한다.
다음으로 다른 파이썬 버전이나 아키텍쳐(architecture)를 위한 패키지를 빌드하는 방법과
Anaconda.org 계정으로 패키지를 업로드하는 방법을 다룬다. 이 두 작업은 선택 사항이다.


튜토리얼 대상
=================

PyPI 패키지로부터 콘다 패키지를 빌드하고자 하는 윈도우,맥OS,리눅스 사용자를 위한 튜토리얼이다.
콘다 빌드(conda build)나 콘다 래시피(conda recipe)에 대한 사전 지식은 없어도 된다.


.. _before-you-start1:

시작에 앞서
=================

튜토리얼을 시작하기 전에 :doc:`요구 사항 <index_ko>`\ 을 확인한다.


.. _conda-build-skeleton:

conda skeleton pypi 명령으로 간단한 패키지 빌드하기
==================================================

``conda skeleton`` 명령은 PyPI 패키지의 메타데이터를 가져와 콘다 빌드 래시피를 준비한다.
마지막 단계는 패키지 자체를 빌드하고 사용자의 콘다 환경에 이를 설치하는 것이다.

파이썬 언어를 위한 공식 타사 소프트웨어 레포지토리인 PyPI에 호스팅된 파이썬 패키지라면 스켈레톤(skeleton) 래시피를 빌드하는 것은 쉽다.

이 절에서는 콘다 스켈레톤을 사용해 콘다 래시피를 생성한다.
콘다 래시피는 콘다 빌드에게 소스 파일의 위치와 패키지를 빌드하고 설치하는 방법을 알려준다.

PyPI에 호스팅된 `파이인스트루먼트(Pyinstrument)`_ 패키지를 다룰 것이다.
파이인스트루먼트는 매 밀리 초마다 쌓인 모든 호출 기록으로 프로그래머에게
코드의 어느 부분이 가장 느리고 어떻게 이를 개선할 수 있는지 알려주는 파이썬 통계 프로파일러다.

.. _파이인스트루먼트(Pyinstrument): https://github.com/joerick/pyinstrument

먼저 홈 디렉토리에서 ``conda skeleton`` 명령을 실행한다.

.. code-block:: bash

    conda skeleton pypi pyinstrument

``conda skeleton``\ 에 주어진 두개의 인수는 호스팅 위치와 패키지의 이름이다. 여기에서는 ``pypi``\ 와 ``pyinstrument``\ 가 된다.

``Pyinstrument``\ 라는 이름으로 디렉토리가 만들어지고 그 안에 스켈레톤 파일 ``meta.yaml``\ 가 생성된다.
나머지 두개의 스켈레톤 파일 :download:`build.sh <build.sh>`\ 와 :download:`bld.bat <bld.bat>`\ 을 다운로드한다.
이 파일들을 ``meta.yaml`` 파일과 같은 경로에 둔다.
맥OS, 리눅스의 ``ls`` 명령과 윈도우의 ``dir`` 명령을 사용해 파일이 생성되었는지 확인한다.
이 파일들은 PyPI 메타데이터를 가지고 있으며 대부분의 경우에 수정할 필요가 없다.

다음 파일의 모음을 콘다 빌드 래시피(conda build recipe)라 한다.

* ``meta.yaml``---래시피의 모든 메타데이터를 가지고 있다.
  패키지 이름과 버전은 필수 사항이며 나머지는 선택 사항이다.

* ``bld.bat``---윈도우에서 패키지 빌드에 사용되는 커맨드.

* ``build.sh``---리눅스,맥OS에서 패키지 빌드에 사용되는 커맨드.

콘다 빌드 래시피가 준비되었으므로 콘다 빌드로 패키지를 빌드할 수 있다.

.. code-block:: bash

    conda-build pyinstrument

빌드가 끝나면 콘다 패키지의 정확한 경로와 파일명이 나타난다.
``conda-build``\ 명령에 실패했다면 :ref:`troubleshooting`\ 을 보자.

윈도우 파일 경로 예시:

.. code-block:: text

    C:\Users\jsmith\Miniconda\conda-bld\win-64\pyinstrument-0.13.1-py27_0.tar.bz2

맥OS 파일 경로 예시:

.. code-block:: text

    /Users/jsmith/miniconda/conda-bld/osx-64/pyinstrument-0.13.1-py27_0.tar.bz2


리눅스 파일 경로 예시:

.. code-block:: text

    /home/jsmith/miniconda/conda-bld/linux-64/pyinstrument-0.13.1-py27_0.tar.bz2


주의: 경로와 파일명은 사용자의 설치와 운영체제에 따라 달라진다.
다음 단계를 위해 경로와 파일명을 저장해둔다.

이제 use-local 플래그를 사용해 새로 빌드한 패키지를 콘다 환경에 설치할 수 있다.

.. code-block:: bash

    conda install --use-local pyinstrument

파이인스트루먼트가 성공적으로 설치되었는지 확인한다.

.. code-block:: bash

    conda list

여기까지 빌드한 파이인스트루먼트 콘다 패키지는 사용자의 루트 환경과 동일한 파이썬 버전을 사용하는 모든 콘다 환경에 설치할 수 있다.
선택 사항으로 다음 절에서 다른 파이썬 버전이나 아키텍쳐를 위한 패키지를 만드는 방법과 Anaconda.org 계정으로 패키지를 업로드하는 방법을 다룬다.


.. _`python-versions`:

선택---다른 파이썬 버전을 위해 빌드하기
==================================================
콘다 빌드는 기본적으로 루트 환경에 설치된 파이썬 버전을 위한 패키지를 생성한다.
다른 버전의 파이썬을 위한 패키지를 빌드하려면 ``--python`` 플래그 뒤에 파이썬 버전을 입력한다.
예를 들어, 파이썬3.3을 위한 파이인스트루먼트를 빌드하려면 다음 명령을 사용한다.

.. code-block:: bash

    conda-build --python 3.3 pyinstrument

``conda-build`` 출력 파일의 파일명 끝에 명령에서 지정한 파이썬 버전이 나타나는 것을 확인한다.
``conda install`` 명령은 패키지 디렉토리에서 현재 파이썬 버전에 맞는 파일을 찾는다.

윈도우 파일 경로 예시:

.. code-block:: text

    C:\Users\jsmith\Miniconda\conda-bld\win-64\pyinstrument-0.13.1-py33_0.tar.bz2


맥OS 파일 경로 예시:

.. code-block:: text

    /Users/jsmith/miniconda/conda-bld/osx-64/pyinstrument-0.13.1-py33_0.tar.bz2


리눅스 파일 경로 예시:

.. code-block:: text

    /home/jsmith/miniconda/conda-bld/linux-64/pyinstrument-0.13.1-py33_0.tar.bz2


주의: 경로와 파일명은 사용자의 설치와 운영체제에 따라 달라진다.
다음 작업을 위해 경로와 파일명을 저장해둔다.

.. _convert-conda-package:

선택---다른 플랫폼의 콘다 패키지로 변환하기
========================================================

콘다 빌드를 사용해 사용자의 현재 플랫폼을 위한 패키지를 빌드했다.
``conda convert`` 명령과 플랫폼 지정자를 사용하면 다른 플랫폼을 위한 패키지로 변환할 수 있다.
플랫폼 지정자는 다음 플랫폼을 지원한다.

* osx-64.
* linux-32.
* linux-64.
* win-32.
* win-64.
* all.

출력 디렉토리에 지정한 플랫폼 갯수 만큼 폴더가 생성된다.
각 폴더는 플랫폼에 맞는 .tar.bz2 패키지 파일을 포함한다.

윈도우:

.. code-block:: text

    conda convert -f --platform all C:\Users\jsmith\Miniconda\conda-bld\win-64\pyinstrument-0.13.1-py27_0.tar.bz2
    -o outputdir\

맥OS, 리눅스:

.. code-block:: text

    conda convert --platform all /home/jsmith/miniconda/conda-bld/linux-64/pyinstrument-0.13.1-py27_0.tar.bz2
    -o outputdir/


주의: 파일명과 경로를 :ref:`python-versions`\ 에서 저장한 파일명과 경로로 바꾼다.

패키지를 다른 컴퓨터에 옮기고 플랫폼에 맞는 ``conda-bld/$ARCH`` 디렉토리에 두어야 사용할 수 있다.
여기서 ``$ARCH``\ 는 ``osx-64``, ``linux-32``, ``linux-64``, ``win-32``, ``win-64``\ 가 될 수 있다.

모든 bz2 파일을 Anaconda.org에 업로드하는 간단한 방법은 다음 단계에서 다룬다.


.. _`upload-to-anaconda-org`:

선택---Anaconda.org에 패키지 업로드하기
==============================================

이전에는 binstar.org였던 Anaconda.org는 공공/개인 패키지 레포지토리다.
Anaconda.org에 패키지를 업로드하면 다른 위치에 직접 타르볼(tarball) 파일을 복사해 옮기지 않아도
``conda install`` 명령을 사용해 어떤 환경에도 쉽게 설치할 수 있다.
업로드한 파일을 공개로 할지 비공개로 할지도 정할 수 있다.
Anaconda.org에 대한 자세한 정보는 `Anaconda.org 문서 <http://docs.anaconda.org/>`_\ 에 있다.

#. 무료 Anaconda.org 계정을 만들고 사용자명과 암호를 기록해 둔다.

#. ``conda install anaconda-client`` 명령을 실행하고 Anaconda.org 사용자명과 암호를 입력한다.

#. 터미널이나 아나콘다 프롬프트에서 ``anaconda login`` 명령으로 Anaconda.org 계정에 로그인한다.

이제 로컬 패키지를 Anaconda.org에 업로드할 수 있다.

윈도우:

.. code-block:: text

    anaconda upload C:\Users\jsmith\Miniconda\conda-bld\win-64\pyinstrument-0.13.1-py27_0.tar.bz2


맥OS, 리눅스:

.. code-block:: text

    anaconda upload /home/jsmith/miniconda/conda-bld/linux-64/pyinstrument-0.13.1-py27_0.tar.bz2


주의: 경로와 파일명을 :ref:`python-versions`\ 에서 저장한 것으로 바꾼다.
경로와 파일명은 사용자의 설치와 운영체제에 따라 달라질 수 있다.

여러 버전의 파이썬을 위한 패키지를 생성했거나 ``conda convert``\ 로 각 아키텍쳐를 위한 패키지를 만들었다면
각 패키지를 ``anaconda upload`` 명령을 사용해 업로드해야 한다.
모든 아키텍쳐를 위해 파이썬 2.7, 3.4, 3.5 패키지를 생성해 보는 것이 가장 좋은 연습이다.

팁: 성공적으로 빌드된 패키지가 항상 자동으로 Anaconda.org에 업로도되게 하려면 다음 명령을 실행한다.

.. code-block:: bash

    conda config --set anaconda_upload yes

다음 명령으로 Anaconda.org 계정을 로그아웃한다.

.. code-block:: bash

    anaconda logout


.. _`troubleshooting`:

예시 문제를 위한 트러블슈팅
===============================

콘다 빌드를 실행했을 때 "Build Package missing." 에러 메세지가 나타날 수 있다.

이 에러를 살펴본다.

#. 스카이필드(skyfield)를 위한 콘다 스켈레톤 패키지를 생성한다.
   이를 위한 ``conda skeleton`` 명령은 다음과 같다.

   .. code-block:: bash

       conda skeleton pypi skyfield

   이 명령은 스카이필드 콘다 빌드 래시피를 생성한다.

#. ``conda-build skyfield``\ 를 실행한다. 다음 출력이 나타나면서 빌드에 실패한다.

   .. code-block:: text

       Removing old build environment
       Removing old work directory
       BUILD START: skyfield-0.8-py35_0
       Using Anaconda Cloud api site https://api.anaconda.org
       Fetching package metadata: ......
       Solving package specifications: .
       Error:  Package missing in current osx-64 channels:
         - sgp4 >=1.4

이 예제에서 콘다 래시피는 스카이필드 패키지를 위해 ``spg4``\ 를 필요로 한다.
스카이필드 래시피는 ``conda skeleton``\ 으로 생성되었다.
이 에러는 콘다가 spg4 패키지를 찾을 수 없고 설치할 수 없음을 의미한다.

많은 PyPI 패키지들이 빌드와 실행을 할 때 다른 PyPI 패키지에 의존한다.
따라서 ``conda skeleton`` 명령으로 손실된 패키지의 래시피를 생성하고 빌드하는 것이 문제의 해결책이 되곤 한다.

.. code-block:: bash

    conda skeleton sgp4
    conda build sgp4

``conda skeleton`` 명령에 ``--recursive`` 플래그를 사용할 수도 있다.
하지만 이 플래그는 이미 콘다로 설치 가능한 패키지의 래시피까지 모두 생성한다.


.. _`working_around_proxies`:

MITM 프록시 피하기
==============================

몇몇 공동 환경은 암호화된 트래픽을 알아내기 위한
중간자공격(Man-In-The-Middle attack, MITM)을 사용하는 프록시 서버를 사용한다.
이 서비스들은 PyPI와 같이 레포지토리에서 패키지를 다운로드 하기 위해 콘다와 pip에서 사용되는 것들의
SSL 연결을 방해할 수 있다.

이 방해와 맞닥뜨리게 되면, 콘다에서 사용되는 ``requests`` 패키지가 인식하고 인증서를 사용할 수 있도록
프록시 서비스의 인증서를 세팅해야 한다.

이 방법이 안되는 경우에, 3.0.31 버전 이상의 conda-build에는 SSL 인증서 검증을 사용하지 않고
이 트래픽이 계속될 수 있게 해주는 옵션이 있다:

:doc:`../configuration/disable-ssl-verification`


.. _`help1`:

추가 정보
=================

더 많은 옵션은 :doc:`콘다 스켈레톤 명령 문서 <../../commands_ko>`\ 에서 볼 수 있다.
