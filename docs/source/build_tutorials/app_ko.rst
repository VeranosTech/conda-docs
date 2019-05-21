========================================
아나콘다 네비게이터 어플리케이션 빌드
========================================

개요
--------

이 튜토리얼은 `Rodeo IDE <https://www.yhat.com/products/rodeo>`_ 의 아나콘다 네비게이터 어플리케이션 빌드를 위해 작성되었다.


튜토리얼 대상
---------------------

이 튜토리얼은 PyPi 패키지로부터 아나콘다 네비게이터 어플리케이션의 콘다 패키지를 생성하고자 하는 윈도우, 맥, 리눅스 사용자를 위한 튜토리얼이다.
콘다 빌드 또는 콘다 래시피에 대한 사전지식은 없어도 된다.


콘다 빌드 요약
~~~~~~~~~~~~~~~~~~~

Rodeo 의 콘다 빌드 래시피는 conda skeleton 에 의해 생성된다.
패키지를 어플리케이션으로 선언하기 위해 빌드 래시피 파일에 세가지 수정을 해주어야 한다.
패키지는 빌드 되어 아나콘다 클라우드 채널에 업로드 된다.
마지막으로 아나콘다 네비게이터에 채널을 추가하면 홈 창에 어플리케이션이 나타난다.

#. :ref:`before-you-start4`
#. :ref:`skeleton`
#. :ref:`requires`
#. :ref:`app-entry`
#. :ref:`build4`
#. :ref:`upload`
#. :ref:`navigator`
#. :ref:`troubleshooting4`
#. :ref:`help4`


.. _before-you-start4:

시작에 앞서
----------------
주의: 아나콘다 네비게이터를 위해 빌드할 어플리케이션은 GUI 를 가지고 있어야 한다.
모든 콘다 패키지가 GUI 를 갖는 것은 아니다.

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


`아나콘다 클라우드 <https://anaconda.org>`_ 계정이 필요하다. 사용자의 유저명이 아나콘다 클라우드 채널이 된다.


.. _skeleton:

skeleton 래시피 생성
----------------------

먼저 사용자 홈 디렉토리에서 ``conda skeleton`` 커맨드를 실행한다.:

.. code-block:: text

    conda skeleton pypi rodeo


이 커맨드는 rodeo 로 명명된 디렉토리를 만들고 디렉토리 내부에 세개의 skeleton 파일을 생성한다. : meta.yaml, build.sh, bld.bat
``ls`` (리눅스, OS X) ``dir`` (윈도우) 커맨드로 이 파일들이 생성되었는지 확인한다.


.. _requires:

요구사항 변경
-------------------

텍스트 편집기에서 ``requirements`` 섹션의 ``ipython`` 항목을 ``jupyter`` 로 바꾼다.
``requirements`` 섹션은 다음과 같이 보여야 한다.

.. code-block:: yaml

    requirements:
      build:
        - python
        - setuptools
        - jupyter
        - flask >=0.10.1
        - docopt
        - pyzmq >=13
        - mistune

      run:
        - python
        - jupyter
        - flask >=0.10.1
        - docopt
        - pyzmq >=13
        - mistune

.. _app-entry:

meta.yaml 의 app 항목
----------------------

콘다 패키지를 어플리케이션으로 선언하기 위해 ``meta.yaml`` 파일에 ``app`` 매개 변수가 추가되어야 한다.
``app`` 섹션은 네개의 키를 포함한다. : ``entry``, ``icon``, ``summary``, ``type``

``app`` 섹션의 ``entry`` 태그는 패키지가 아나콘다 네비게이터에 의해 실행되는 방식을 결정한다.
Rodeo IDE 라면 윈도우, 리눅스, OS X 를 위한 각각 다른 ``entry`` 태그가 요구된다.

텍스트 편집기에서 ``meta.yaml`` 파일을 열고 다음과 같이 라인을 추가한다.

Windows 와 Linux 에서 ``entry`` 태그는 다음과 같다.

.. code-block:: yaml

    app:
      entry: rodeo .                              [win]
      entry: rodeo .                              [linux]


OS X 에서는 실행 스크립트가 추가되어야 한다.
콘다 빌드 래시피 디렉토리에서 텍스트 편집기를 사용해 새로운 파일을 생성한다. 파일명은 ``rodeo_mac.command`` 이다.
파일의 내용은 다음과 같다.

.. code-block:: bash

    DIR=$(dirname $0)

    $DIR/rodeo ${HOME}

파일이 설치 되었는지 확인하기 위해 ``build.sh`` 에 다음 라인들을 추가한다.

.. code-block:: bash

    if [ `uname` == Darwin ]
    then
        cp $RECIPE_DIR/rodeo_mac.command $PREFIX/bin
    fi

이제 ``meta.yaml`` 파일의 ``app`` 섹션에 다음 라인을 추가한다.

.. code-block:: yaml

      entry: open ${PREFIX}/bin/rodeo_mac.command [osx]

마지막으로 콘다 빌드 래시피에 추가된 로고 PNG 파일 아나콘다 네비게이터에 나타난다.
`app.png 파일 <https://github.com/yhat/rodeo/blob/master/resources/app.png>`_ 을 Github 저장소에서 직접 받을 수 있다.
이 파일은 반드시 ``meta.yaml`` 과 동일한 디렉토리에 다운 받아야 한다.

완성된 ``app`` 섹션은 다음과 같이 구성되어야 한다.

.. code-block:: yaml

    app:
      entry: rodeo .                              [win]
      entry: rodeo .                              [linux]
      entry: open ${PREFIX}/bin/rodeo_mac.command [osx]
      icon: app.png
      summary: Rodeo Data Science IDE
      type: web


:download:`meta.yaml <rodeo/meta.yaml>` 과 :download:`build.sh <rodeo/build.sh>` 파일의 완성된 버전을 다운로드 할 수 있다.


.. _build4:

빌드
-----

이제 콘다 빌드 래시피가 준비 됐으므로 콘다 빌드를 사용해 패키지를 생성할 수 있다.
윈도우, OS X, 리눅스 기기를 위한 rodeo 패키지를 각각 따로 빌드하고 업로드 해야 모든 운영체제에서 사용할 수 있다.

.. code-block:: bash

    conda build rodeo

콘다 빌드가 완료되면 콘다 패키지의 정확한 경로명과 파일명을 보여준다.
:ref:`troubleshooting` 섹션에서 콘다 빌드가 실패했을 때의 해결책을 다룰 것이다.

윈도우 파일 경로 예시:

.. code-block:: text

    C:\Users\jsmith\Miniconda\conda-bld\win-64\rodeo-0.4.4-py35_0.tar.bz2

OS X 파일 경로 예시:

.. code-block:: text

    /Users/jsmith/miniconda/conda-bld/osx-64/rodeo-0.4.4-py35_0.tar.bz2

리눅스 파일 경로 예시:

.. code-block:: text

    /home/jsmith/miniconda/conda-bld/linux-64/rodeo-0.4.4-py35_0.tar.bz2

주의: 경로와 파일명은 사용자의 설치와 운영체제에 따라 달라질 수 있다. 다음 단계를 위해 파일명과 경로를 저장해 두자.


.. _upload:

아나콘다 클라우드로 업로드
------------------------

이제 새로운 로컬 패키지를 아나콘다 클라우드에 업데이트 할 수 있다.

먼저 터미널 어플리케이션에서 아나콘다 클라우드에 로그인한다.

.. code-block:: text

    anaconda login

위 커맨드를 입력하면 아나콘다 클라우드 계정과 암호를 요구할 것이다.
로그인이 성공적으로 되면 다음 출력이 나타난다.

.. code-block:: text

    Using Anaconda Cloud api site https://api.anaconda.org
    Username: defusco
    defusco's Password:
    login successful

주의: 이 단계는 반드시 루트 콘다 디렉토리에서 진행해야 한다.

이제 사용자의 채널에 로그인 되었고 이 채널에 Rodeo 콘다 패키지를 업데이트 할 수 있다.

윈도우 사용자:

.. code-block:: text

    anaconda upload C:\Users\jsmith\Miniconda\conda-bld\win-64\rodeo-0.4.4-py35_0.tar.bz2

리눅스, OS X 사용자:

.. code-block:: text

    anaconda upload /home/jsmith/miniconda/conda-bld/linux-64/rodeo-0.4.4-py35_0.tar.bz2


주의: 경로와 파일명을 2단계에서 저장한 것과 동일하게 맞춘다. 경로와 파일명은 사용자의 설치와 운영체제에 따라 달라질 수 있다.


콘다 클라우드에 대한 상세 정보는 `아나콘다 클라우드 문서 페이지 <http://docs.anaconda.org/>`_ 를 참고하자.


.. _navigator:

아나콘다 네비게이터 구성
----------------------------

아나콘다 클라우드 채널에 Rodeo 패키지가 업로드 되었고 아나콘다 네비게이터에 채널을 추가해야 한다.

아나콘다 네비게이터 어플리케이션을 실행한다. 윈도우와 리눅스에서는 시작메뉴에서 실행할 수 있다.
OS X 사용자라면 데스크톱 또는 스포트라이트를 통해 실행할 수 있다.

좌측의 환경창을 연다.:

.. image:: rodeo/navigator-home.png
    :scale: 50%


채널을 추가하기 위해 먼저 Channel 버튼을 클릭한다. 다음엔 Add 버튼을 클릭한다. 마지막으로 사용자의 아나콘다 클라우드 채널 URL 을 입력한다.

.. code-block:: text

    https://conda.anaconda.org/CHANNEL

CHANNEL 을 아나콘다 클라우드 유저명으로 대체한다.

마지막으로 Update Channels 버튼을 클릭한다.:

.. image:: rodeo/navigator-channel.png
    :scale: 50%

마지막 단계는 아나콘다 네비게이터를 종료하고 다시 실행하는 것이다. Rodeo 어플리케이션이 홈 창에 나타날 것이다.

.. image:: rodeo/navigator-rodeo.png
    :scale: 50%



.. _`troubleshooting4`:

트러블 슈팅
---------------

A. 콘다 빌드 실패
~~~~~~~~~~~~~~~~~~~~
콘다 래시피가 빌드에 실패한다면 :doc:`../troubleshooting_ko` 페이지를 보자.


B. 어플리케이션이 홈 창에 나타나지 않을 때
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
콘다 패키지가 아나콘다 클라우드 채널에 업데이트 되었는지 확인한다.

사용자의 채널이 채널 리스트에 추가 되었는지 확인한다.

``.anaconda/navigator`` 디렉토리를 제거하고 네비게이터를 재실행 해야 할 수도 있다.

윈도우, OS X, 리눅스에서 이 디렉토리는 사용자의 홈 디렉토리에 위치한다.

C. 어플리케이션이 실행되지 않을 때
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
설치한 어플리케이션을 실행되지 않는다면 다음 커맨드로 어플리케이션이 잘 작동하는지 확인해보자.

.. code-block:: text

    conda run rodeo

rodeo 가 문제없이 실행된다면 ``.anaconda/navigator`` 디렉토리를 제거하고 네비게이터를 재실행한다.

윈도우, OS X, 리눅스에서 이 디렉토리는 사용자의 홈 디렉토리에 위치한다.



.. _`help4`:

추가 정보
----------------------
:doc:`../commands/build/conda-skeleton-pypi_ko` 레퍼런스 페이지에서 추가 옵션을 볼 수 있다.

윈도우 시작 메뉴 항목에 대한 추가 정보는 menuinst_ 문서를 보자.

.. _menuinst: https://github.com/ContinuumIO/menuinst/wiki
