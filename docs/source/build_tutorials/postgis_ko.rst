=================================================
Building conda packages for general code projects
=================================================

개요
--------
콘다 패키지는 프로젝트에 사용된 언어에 관계없이 빌드할 수 있다.
이 튜토리얼은 ``postgis`` 패키지로부터 래시피를 작성하는 방법을 다룬다.
튜토리얼 마지막에서는 패키지를 빌드해 `anaconda.org <http://anaconda.org/>`_ 에 업로드하고
콘다를 사용해 업로드 된 패키지를 설치해 볼 것이다.

튜토리얼 대상
----------------
이 튜토리얼은 파이썬이 아닌 언어를 사용하는 소스코드 프로젝트로부터 콘다 패키지를 빌드하고자 하는 리눅스와 맥 사용자를 위해 작성되었다.
사용자는 C/C++ 패키지를 구성, 컴파일, 설치하는 방법에 대해 알고 있어야 한다.

콘다 빌드 요약
~~~~~~~~~~~~~~~~~~~

일반 소스코드 패키지로부터 콘다 패키지를 빌드하는 과정은 네단계로 진행된다.

#. :ref:`before-you-start3`
#. :ref:`depends`
#. :ref:`conda-recipe`
#. :ref:`build-script`
#. :ref:`build-postgis`
#. :ref:`install`
#. :ref:`help3`

.. _before-you-start3:

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

.. _depends:

하위 요소
------------
콘다 래시피를 생성함에 있어 가장 중요한 부분은 하위 요소를 올바르게 나열하는 것이다.

`README.postgis`_ 파일은 다음 패키지에 요구되는 최소한의 버전을 명시한다.

.. _README.postgis: https://github.com/postgis/postgis/blob/2.2.2/README.postgis

.. code-block:: bash

    postgresql version 9.1
    proj4 version 4.0.6
    geos version 3.4
    libxml2 version 2.5
    json-c version 0.9
    gdal version 1.9

각각의 하위 요소를 위한 콘다 패키지가 존재해야 한다.
이는 콘다 빌드가 ``postgis`` 소스코드를 설치할 비공개 환경을 생성하고 필요한 모든 하위 요소를 생성된 환경에 설치하기 때문이다.

conda search 커맨드를 사용해 위의 하위 요소들을 검색한다. 디폴트 채널에서 찾을 수 없는 패키지는 ``json-c`` 뿐이다.
이 패키지를 설치하기 위해 conda config 커맨드를 사용해 ``jlaura`` 채널을 추가한다.:

.. code-block:: bash

    conda config --add channels jlaura

이제 모든 하위요소 패키지를 설치할 수 있게 되었다. 다음 단계에서 콘다 래시피를 작성한다.

.. _conda-recipe:

콘다 래시피
------------
콘다 래시피를 생성하는 첫 단계는 래시피가 저장될 디렉토리를 만드는 것이다.

.. code-block:: bash

    mkdir postgis
    cd postgis

콘다 래시피에는 세개의 주요 성분이 있다. 패키지명과 버전, 소스코드의 경로, 패키지 빌드와 실행에 필요한 하위 패키지가 그 주요 성분이다.

콘다 래시피의 소스코드 경로를 지정하는 방법은 여러 가지가 있다.
이번 예시에서는 Github 저장소의 경로와 사용하고자 하는 특정 리비전 태그를 지정함으로써 소스코드 경로를 설정한다.

주의: 모든 Github 저장소가 리비전 태그를 사용하는 것은 아니다. 몇몇 경우에는 최신 커밋이 나을 수 있다.

텍스트 편집기를 열고 postgis 디렉토리의 meta.yaml 파일에 다음과 같이 작성한다.

.. code-block:: yaml

   package:
     name: postgis
     version: "2.2.2"

   source:
     git_rev: 2.2.2
     git_url: https://github.com/postgis/postgis.git

   build:
     number: 0

   requirements:
     build:
       - gdal
       - geos
       - proj4
       - json-c
       - libxml2
       - postgresql >=9.1
     run:
       - gdal
       - geos
       - proj4
       - json-c
       - libxml2
       - postgresql >=9.1

   about:
     home: http://postgis.net
     license: GPL2


주의: 콘다 빌드는 격리된 환경에 패키지를 빌드한다. 이 환경은 빌드 하위요소에 의해 지정된 패키지로 구성된다.
사용자의 작업 환경에 패키지를 설치하는 것은 콘다 빌드에 영향을 주지 않는다.

.. _build-script:

빌드 스크립트
------------

콘다 래시피를 준비하기 위한 마지막 단계는 빌드 스크립트를 작성하는 것이다.
``postgis`` 가 리눅스와 맥을 위해 빌드 되었기 때문에 postgis 디렉토리의 build.sh 파일을 작성한다.

빌드 스크립트 파일은 소스 프로젝트를 구성, 빌드, 설치하기 위해 필요한 모든 커맨드를 포함한다.
이 스크립트는 반드시 사용자 간섭 없이 실행 되어야 한다.

`postgis 컴파일 문서 <http://postgis.net/docs/manual-2.2/postgis_installation.html#installation_configuration>`_ 에서
하위 패키지의 경로를 명시하기 위해 설정 커맨드에 추가되어야 하는 몇몇 플래그를 볼 수 있다.

콘다 빌드 커맨드를 실행하는 동안 ``$PREFIX`` 환경 변수는 콘다 패키지의 설치 경로를 나타내는데 사용된다.
우리는 ``$PREFIX`` 변수를 빌드에 나열된 하위 패키지 경로의 설정 커맨드를 알려주고 콘다 래시피 요구사항을 실행하는데 사용한다.

텍스트 편집기를 사용해 postgis 디렉토리에 build.sh 파일을 생성하고 다음 내용을 입력한다.

.. code-block:: bash

    sh autogen.sh
    ./configure \
      --prefix=$PREFIX \
      --with-pgconfig=$PREFIX/bin/pg_config \
      --with-gdalconfig=$PREFIX/bin/gdal-config \
      --with-xml2config=$PREFIX/bin/xml2-config \
      --with-geosconfig=$PREFIX/bin/geos-config \
      --with-projdir=$PREFIX \
      --with-jsondir=$PREFIX \
      --without-raster \
      --without-topology

    make
    make install

주의: ``$PREFIX`` 환경 변수로의 레퍼런스가 없으면 설정 커맨드는 요구되는 패키지를 위해 디폴트 시스템 디렉토리를 보게 된다.
당장 패키지가 제대로 빌드 되었다 하더라도 다른 사용자도 컴파일된 콘다 패키지를 동일하게 빌드할 수 있다는 보장은 없다.

주의: 이 래시피에서 콘다 빌드를 실행하기 위해 C/C++ 컴파일러, autoconf, automake 를 설치해야 한다.
이 패키지들은 반드시 시스템 계층에 설치되어야 하고 콘다를 통해 설치해선 안된다.

.. _build-postgis:

패키지 빌드
-----------------
래시피가 완성 되었으므로 conda build 커맨드를 사용해 postgis 디렉토리의 파일로부터 콘다 패키지를 빌드할 수 있다.

.. code-block:: bash

    conda build .

콘다 빌드의 출력은 다음과 같이 시작해야 한다.

.. code-block:: text

    Removing old build environment
    Removing old work directory
    BUILD START: postgis-2.2.2-0
    Using Anaconda Cloud api site https://api.anaconda.org
    Fetching package metadata: ..........
    Solving package specifications: .........

하위 패키지 설치와 소스코드 컴파일에 성공하면 다음 메시지와 함께 콘다 빌드가 종료된다.

맥 사용자:

.. code-block:: text

    BUILD END: postgis-2.2.2-0
    Nothing to test for: postgis-2.2.2-0
    # anaconda.org 에 패키지를 업로드 하고 싶다면 다음을 입력한다.:
    #
    # $ anaconda upload /Users/adefusco/Applications/anaconda3/conda-bld/osx-64/postgis-2.2.2-0.tar.bz2
    #
    # 콘다 빌드가 자동으로 anaconda.org 에 업로드하게 하려면 다음을 입력한다.:
    # $ conda config --set anaconda_upload yes

리눅스 사용자:

.. code-block:: text

    BUILD END: postgis-2.2.2-0
    Nothing to test for: postgis-2.2.2-0
    # anaconda.org 에 패키지를 업로드 하고 싶다면 다음을 입력한다.:
    #
    # $ anaconda upload /home/adefusco/anaconda3/conda-bld/linux-64/postgis-2.2.2-0.tar.bz2
    #
    # 콘다 빌드가 자동으로 anaconda.org 에 업로드하게 하려면 다음을 입력한다.:
    # $ conda config --set anaconda_upload yes

주의: 사용자의 경로는 아나콘다가 설치된 위치에 따라 달라질 수 있다.

주의: troubleshooting 섹션에서 콘다 빌드 에러 진단에 대한 도움말을 보자.

주의: 패키지는 동일한 아키텍쳐를 사용하는 시스템에만 설치될 수 있다.
맥과 리눅스에서 conda build 커맨드를 별도로 실행해 각각의 아키텍쳐를 위한 패키지를 생성해야 한다.

.. _install:

패키지 배포와 설치
----------------------------------
이번에는 다음 커맨드를 사용해 사용자의 로컬 기기에 패키지를 설치해보자.

.. code-block:: bash

    conda install postgis --use-local

콘다 빌드 출력 끝부분에 나타난 anaconda upload 커맨드로 사용자의 Anaconda.org 채널에 패키지를 업로드 할 수 있다.
이를 통해 다음 커맨드를 사용하면 어떤 사용자도 패키지를 설치할 수 있다.

.. code-block:: bash

    conda install -c CHANNEL postgis

주의: CHANNEL 을 사용자의 anaconda.org_ username 으로 대체한다..

.. _help3:

트러블 슈팅과 추가 정보
------------------------------------------
`트러블 슈팅`_ 페이지는 콘다 빌드가 실패한 상황을 위한 유용한 도움말을 포함하고 있다.

.. _트러블 슈팅: https://conda.io/docs/troubleshooting.html

전체 콘다 래시피 `문서`_ 와 `간단 래시피 <https://conda.io/docs/building/sample-recipes.html>`_ 페이지에서 콘다 래시피 meta.yaml 파일에 대한 옵션들을 볼 수 있다.

.. _문서: https://conda.io/docs/building/meta-yaml.html
