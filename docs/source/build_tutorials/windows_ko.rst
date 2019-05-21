==================================
윈도우에서 콘다 패키지 빌드
==================================

.. contents:: Contents
   :depth: 2

개요
--------

이 튜토리얼은 윈도우에서 콘다 빌드를 사용해 콘다 패키지를 생성하는 방법을 다룬다.
SEP 와 pySLALIB 를 예시로 사용할 것이다.

`아나콘다 클라우드 <https://anaconda.org>`_ 에서 이번 튜토리얼에서 빌드할 패키지의 최종 버전을 확인할 수 있다.
`SEP <https://anaconda.org/wwarner/sep/files>`_, `pySLALIB <https://anaconda.org/wwarner/pyslalib/files>`_.

래시피를 작성하는 방법 또한 이번 튜토리얼에서 다룰 것이다.
이번 예시에서 사용한 래시피의 최종본은 `SEP 래시피
<https://github.com/conda/conda-docs/tree/master/docs/source/build_tutorials/sep>`_
, `pySLALIB 래시피
<https://github.com/conda/conda-docs/tree/master/docs/source/build_tutorials/pyslalib>`_ 이고
`콘다 문서 저장소 <https://github.com/conda/conda-docs>`_ 에 업로드 되어 있다.


시작에 앞서
----------------

:doc:`미니콘다 <../install/quick_ko>` 또는 `아나콘다 <https://docs.continuum.io/anaconda/install>`_ 가 설치되어 있어야 한다.

콘다 빌드를 설치하자:

.. code-block:: bash

    conda install conda-build

콘다와 콘다 빌드는 최신 버전을 권장한다. 다음 커맨드로 업데이트하자.

.. code-block:: bash

    conda upgrade conda
    conda upgrade conda-build

이제 윈도우에서 직접 콘다 패키지를 빌드할 준비가 되었다.

툴킷
-----------

마이크로 소프트 비주얼 스튜디오
~~~~~~~~~~~~~~~~~~~~~~~

콘다 개발자의 표준 관행에 따라 다른 파이썬 버전의 콘다 패키지는 비주얼 스튜디오 (VS) 버전에 맞춰 빌드 되었다.:

* **파이썬 2.7** Visual Studio 2008 패키지
* **파이썬 3.4** VS 2010 패키지
* **파이썬 3.5** VS 2015 패키지

위 VS 버전들을 사용해 각각의 파이썬 버전에 맞는 패키지를 빌드하는 것은 공식 python.org 파이썬 빌드의 관행이다.
VS2008과 VS2010 재판매업자를 통해서만 구매가능하고 VS 2015 는 마이크로소프트로부터 온라인으로 구매할 수 있다.

비주얼 스튜디오의 대안
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

다음 프로그램들은 각각의 VS 컴파일러 버전의 무료 대안이다.

VS 2008 대신 `free Microsoft
Visual C++ Compiler for Python 2.7
<https://www.microsoft.com/en-us/download/details.aspx?id=44266>`_ 를 사용할 수 있다..

VS 2010 대신 , `free Microsoft Windows SDK for Windows 7 and .NET Framework 4
<https://www.microsoft.com/en-us/download/details.aspx?id=8279>`_ 를 사용할 수 있다.

`VS 2010 Service Pack 1 (SP1)
<https://www.microsoft.com/en-us/download/details.aspx?id=23691>`_ 를 설치했는지 확인하자.
 
VS 2010 SP1 인스톨러의 버그로 인해 VS 2010 SP1 설치 도중 컴파일러 도구가 삭제될 수 있다.
삭제된 도구들은 https://www.microsoft.com/en-us/download/details.aspx?id=4422 를 따라 복원할 수 있다..

Visual Studio 2015 는 `전체 기능을 지원하는 무료 커뮤니티 에디션
<https://www.visualstudio.com/en-us/products/visual-studio-community-vs.aspx>`_
을 학문적 연구, 오픈소스 프로젝트, 그 외 다른 특정 목적을 위해 제공하고 있다.

MS Visual C++ Compiler for Python 2.7, Microsoft Windows SDK for Windows 7,
.NET Framework 4 모두 잘 검증된 프로그램이다. 콘다 빌드는 이 구성들을 지원하기 위해 세심하게 테스트 했지만
CMake 빌드 도구와 이 무료 대안들 간에 문제가 있다. 이번 예시에서는 VS 솔루션 생성기 대신 "NMake Makefile" 생성기를 사용하는게 좋다.

윈도우 버전
~~~~~~~~~~~~~~~~

현재 버전의 윈도우라면 모두 사용할 수 있다. 이번 예시에서는 윈도우 8.1 을 사용했다.

필요한 다른 도구
~~~~~~~~~~~~~~~~~~

몇몇 환경들은 처음부터 bzip2 나 Git 같은 도구가 없을 수 있다.
이 도구 들은 빌드 과정에서 필요할 수 있다.

다음 커맨드로 Git 을 설치할 수 있다.: ``conda install git``

bzip2 도 동일하게 설치할 수 있다. 콘다 bzip2 패키지는 bzip 라이브러리만을 포함하고 bzip2 실행 파일은 포함하지 않는다.
실행 파일은 http://gnuwin32.sourceforge.net/packages/bzip2.htm 와 같은 다른 소스로부터 설치할 수 있다.
이 실행파일은 PATH 상의 어느 위치에 저장되어야 한다. Library/bin 폴더의 Miniconda/Anaconda 설치 경로가 좋은 예시이다.

빌드 전략
--------------

콘다 래시피는 일반적으로 시행착오법으로 패키지를 빌드한다.
패키지 빌드의 첫번째 시도는 보통 하위요소 손실로 인한 컴파일러, 링크 에러로 실패할 수 있다.
래시피 작성자는 이 에러를 조사하고 손실된 하위요소를 포함하도록 래시피를 수정한다.
손실된 하위요소는 주로 meta.yaml 파일의 일부이다.
이제 래시피 작성자는 빌드를 다시 시도하고 몇번의 시행착오를 더 거친 후 성공적으로 패키지를 빌드한다.

사용자의 미니콘다 설치와 다른 파이썬 버전으로 빌드하기
-------------------------------------------------------------------------

미니콘다2와 미니콘다3는 모두 파이썬2와 파이썬3를 위한 패키지를 빌드할 수 있다.
빌드하고자 하는 파이썬 버전을 지정하면 된다.

미니콘다2는 파이썬2 만을 포함하고 미니콘다3는 파이썬3 만을 포함한다.
이 중 하나만을 설치해야 빌드를 지속적으로 추적하기 쉬워진다. 하지만 두개를 같은 시스템에 동시에 설치해도 상관없다.
두개를 모두 설치했다면 어떤 버전이 경로에서 먼저 나타나는지 확인한다. 먼저 나타나는 버전이 현재 사용중인 버전이다.

"where" 커맨드를 사용하면 쉽게 확인할 수 있다.: ``where python``

미니콘다 설치와 다른 파이썬 버전의 패키지를 빌드하려면 conda build 커맨드에서 ``--python`` 옵션을 사용한다.:

예시: 미니콘다2에서 파이썬 3.5 패키지 빌드::

    conda build recipeDirectory --python=3.5

주의: "recipeDirectory" 를 사용자의 래시피 디렉토리와 동일한 명칭과 경로로 대체한다.

자동 테스트
-----------------

빌드 후에 래시피 디렉토리가 run_test.bat (윈도우) 또는 run_test.py (다른 운영체제) 테스트 파일을 포함한다면
이 파일은 패키지를 테스트 하기 위해 실행되고 에러가 리포트 된다.
(OS X 나 리눅스에서 run_test.sh 파일이 래시피 디렉토리에 위치할 수 있다.)

주의: 데이터 파일은 래시피 디렉토리에 저장될 수 있고 테스트가 "files" 섹션을 사용한다면 테스트 디렉토리로 이동될 수 있다.
("files" 섹션은 :ref:`meta.yaml 파일의 "test" 섹션 <meta-test>` 을 참고하자.)

윈도우에서 파이썬 3와 콘다로 SEP 패키지 빌드하기
-----------------------------------------------------------

**비주얼 스튜디오 2015** 를 아직 설치하지 않았다면 "Custom" 설치를 선택해 "Programming Languages" 의 "Visual C++" 를 설치한다.

`SEP 문서 <https://sep.readthedocs.io>`_ 에 따르면 SEP 이 작동하는 파이썬 버전은 오직 NumPy 에 따라 결정된다고 한다.
SEP 와 PyPI 를 검색해보면 `SEP 를 위한 PyPI 패키지 <https://pypi.python.org/pypi/sep>`_ 가 이미 존재함을 알 수 있다.

SEP 의 PyPI 패키지가 이미 존재하기 때문에 ``conda skeleton`` 커맨드로 skeleton 또는 PyPI 패키지에 기반한 콘다 래시피 아웃라인을 생성할 수 있다.
이제 래시피 아웃라인을 직접 완성할 수 있고 콘다는 완성된 래시피로부터 콘다 패키지를 빌드할 수 있다.

conda skeleton 래시피 생성하기
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

skeleton 커맨드를 실행한다.::

    conda skeleton pypi sep

skeleton 은 새로 생성된 "sep" 디렉토리에 설치된다. 생성된 디렉토리로 가서 파일을 보자.::

    cd sep

skeleton 파일 수정하기
~~~~~~~~~~~~~~~~~~~~~~~~

세개의 skeleton 파일이 이 디렉토리에 생성되었다.:

* **bld.bat** 윈도우
* **build.sh** OS X/리눅스
* **meta.yaml** 모든 운영체제.

이 패키지에서 bld.bat 과 build.sh 는 수정하지 않아도 된다.
NumPy 하위요소를 추가하고 빌드된 패키지를 가져오는 옵션 테스트를 추가해 meta.yaml 파일을 수정할 것이다.

meta.yaml 파일에서 requirements 섹션에 라인을 추가해 NumPy 를 패키지를 빌드하기 위한 요구사항으로 지정한다.
두번째 라인에서는 NumPy 를 패키지를 실행하기 위한 요구사항으로 지정한다.
"x.x" 로 NumPy 버전을 지정한다. 새로 작성한 라인들이 "- python" 라인에 맞춰 정렬되었는지 확인한다.

예시:

.. code-block:: yaml

    requirements:
      build:
        - python
        - numpy     x.x
    
      run:
        - python
        - numpy     x.x

주의: "1.11" 와 같은 특정 버전 대신 "x.x" 로 버전을 지정하면 NumPy 를 유동적으로 지정하게 된다.
빌드 커맨드에서는 실제 NumPy 버전이 사용될 것이다.
SEP 패키지는 Cython 을 통해 NumPy 의 C API 를 사용하기 때문에 NumPy 버전을 지정하는 것은 중요하다.
API 는 NumPy 버전에 따라 달라지고 실행과 빌드 시에 동일한 NumPy 버전을 사용해야 한다.

빌드된 패키지를 위한 옵션 테스트: 이 테스트는 빌드 마지막 단계에서 파이썬 선언 "import sep" 이 잘 작동하는지 확인한다.
테스트 섹션에서 "test:" 와 "imports:" 라인을 코멘트 아웃 시키는 "#" 를 제거하고 "- sep" 을 추가한다.
들여쓰기가 yaml 파일의 다른 라인과 일치하는지 확인한다.

예시:

.. code-block:: yaml

    test:
      # Python imports
      imports:
        - sep

테스트 파일 생성하기
~~~~~~~~~~~~~~~~~~~

"run_test.py" 테스트 파일을 생성한다. 이 파일은 https://sep.readthedocs.org/en/v0.5.x/detection.html 에서 가져온 코드를 포함하고
이를 "sep" 디렉토리에 저장한다.:

.. code-block:: python

    import numpy as np
    import sep
    
    data = np.random.random((256, 256))
    
    # Measure a spatially variable background of some image data
    # (a numpy array)
    bkg = sep.Background(data)
    
    # ... or with some optional parameters
    # bkg = sep.Background(data, mask=mask, bw=64, bh=64, fw=3, fh=3)

빌드 후에 이 파일은 빌드된 패키지를 테스트 하기 위해 실행된다.

이제 래시피가 완성됐다.

패키지 빌드하기
~~~~~~~~~~~~~~~~~~

앞서 생성한 래시피로 패키지를 빌드한다.::

    conda build . --numpy=1.11

출력 체크하기
~~~~~~~~~~~~~~~~~

출력을 체크해 빌드가 성공적으로 완료 되었는지 확인한다.
출력은 최종 패키지 파일의 위치와 패키지를 아나콘다 클라우드에 업로드 하기 위한 커맨드를 포함한다.

"빌드 전략" 섹션에서 다룬 바와 같이 링크나 컴파일러 에러가 나타나면 래시피를 수정하고 다시 실행해야 한다.

윈도우에서 파이썬 2와 콘다로 SEP 패키지 빌드하기
-----------------------------------------------------------

**비주얼 스튜디오 2008** 을 아직 설치하지 않았다면 "Custom" 설치를 선택해 "X64 Compilers and Tools" 를 설치한다.

**비주얼 스튜디오 2008 서비스팩 1 설치**

`SEP 문서 <https://sep.readthedocs.io>`_ 에 따르면 SEP 이 작동하는 파이썬 버전은 오직 NumPy 에 따라 결정된다고 한다.
SEP 와 PyPI 를 검색해보면 `SEP 를 위한 PyPI 패키지 <https://pypi.python.org/pypi/sep>`_ 가 이미 존재함을 알 수 있다.

SEP 의 PyPI 패키지가 이미 존재하기 때문에 ``conda skeleton`` 커맨드로 skeleton 또는 PyPI 패키지에 기반한 콘다 래시피 아웃라인을 생성할 수 있다.
이제 래시피 아웃라인을 직접 완성할 수 있고 콘다는 완성된 래시피로부터 콘다 패키지를 빌드할 수 있다.

conda skeleton 래시피 생성하기
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

skeleton 커맨드를 실행한다.::

    conda skeleton pypi sep

skeleton 은 새로 생성된 "sep" 디렉토리에 설치된다. 생성된 디렉토리로 가서 파일을 보자.::

    cd sep

skeleton 파일 수정하기
~~~~~~~~~~~~~~~~~~~~~~~~

세개의 skeleton 파일이 이 디렉토리에 생성되었다.:

* **bld.bat** 윈도우
* **build.sh** OS X/리눅스
* **meta.yaml** 모든 운영체제.

이 패키지에서 bld.bat 과 build.sh 는 수정하지 않아도 된다.
NumPy 하위요소를 추가하고 빌드된 패키지를 가져오는 옵션 테스트를 추가해 meta.yaml 파일을 수정할 것이다.

meta.yaml 파일에서 requirements 섹션에 라인을 추가해 NumPy 를 패키지를 빌드하기 위한 요구사항으로 지정한다.
두번째 라인에서는 NumPy 를 패키지를 실행하기 위한 요구사항으로 지정한다.
"x.x" 로 NumPy 버전을 지정한다. 새로 작성한 라인들이 "- python" 라인에 맞춰 정렬되었는지 확인한다.

예시:

.. code-block:: yaml

    requirements:
      build:
        - python
        - numpy     x.x
    
      run:
        - python
        - numpy     x.x

주의: "1.11" 와 같은 특정 버전 대신 "x.x" 로 버전을 지정하면 NumPy 를 유동적으로 지정하게 된다.
빌드 커맨드에서는 실제 NumPy 버전이 사용될 것이다. 현재 NumPy 만이 유동적으로 지정할 수 있는 패키지이다.

빌드된 패키지를 위한 옵션 테스트: 이 테스트는 빌드 마지막 단계에서 파이썬 선언 "import sep" 이 잘 작동하는지 확인한다.
테스트 섹션에서 "test:" 와 "imports:" 라인을 코멘트 아웃 시키는 "#" 를 제거하고 "- sep" 을 추가한다.
들여쓰기가 yaml 파일의 다른 라인과 일치하는지 확인한다.

예시:

.. code-block:: yaml

    test:
      # Python imports
      imports:
        - sep

테스트 파일 생성하기
~~~~~~~~~~~~~~~~~~~

"run_test.py" 테스트 파일을 생성한다. 이 파일은 https://sep.readthedocs.org/en/v0.5.x/detection.html 에서 가져온 코드를 포함하고
이를 "sep" 디렉토리에 저장한다.:

.. code-block:: python

    import numpy as np
    import sep
    
    data = np.random.random((256, 256))
    
    # Measure a spatially variable background of some image data
    # (a numpy array)
    bkg = sep.Background(data)
    
    # ... or with some optional parameters
    # bkg = sep.Background(data, mask=mask, bw=64, bh=64, fw=3, fh=3)

빌드 후에 이 파일은 빌드된 패키지를 테스트 하기 위해 실행된다.

이제 래시피가 완성됐다.

패키지 빌드하기
~~~~~~~~~~~~~~~~~~

앞서 생성한 래시피로 패키지를 빌드한다.::

    conda build . --numpy=1.11

출력 체크하기
~~~~~~~~~~~~~~~~~

출력을 체크해 빌드가 성공적으로 완료 되었는지 확인한다.
출력은 최종 패키지 파일의 위치와 패키지를 아나콘다 클라우드에 업로드 하기 위한 커맨드를 포함한다.

"빌드 전략" 섹션에서 다룬 바와 같이 링크나 컴파일러 에러가 나타나면 래시피를 수정하고 다시 실행해야 한다.

윈도우에서 콘다와 파이썬3로 pySLALIB 패키지 빌드하기
----------------------------------------------------------------

pySLALIB 패키지가 Fortran 을 포함하므로 빌드를 위해 Fortran 컴파일러가 필요하다.
pySLALIB 를 위한 PyPI 패키지가 없기 때문에 skeleton 래시피를 사용할 수 없고 기초부터 작성해야 한다.
pySLALIB 를 빌드하는 과정는 앞선 SEP 빌드와 유사하지만 Fortran 컴파일러를 설치하는 과정과
PyPI 대신 GitHub 에 패키지를 페치하기 위해 meta.yaml 파일을 작성하는 과정 그리고 Fortran 코드에 알맞은 패치를 적용하는 과정이 추가된다.

**비주얼 스튜디오 2015 설치**. "Custom" 설치를 선택해 "Programming Languages" 의 "Visual C++" 를 설치한다.

**Intel Parallel Studio Composer Edition 설치**. `인텔 Fortran 컴파일러 페이지 <https://software.intel.com/en-us/fortran-compilers>`_ 로 가자.
"Try & Buy" 를 선택하고 Parallel Studio Composer Edition for Windows 를 고른다.
Fortran 과 C++ 버전 대신 Fortran 만을 포함하는 버전을 선택해도 된다.
30일 무료 체험판이 제공된다. 이메일 주소가 포함된 양식을 작성하면 이메일로 다운로드 링크를 받을 수 있다.
"Intel Parallel Studio XE Composer Edition for Fortran Windows" 을 다운로드 해 설치한다.

**Git 설치**. 빌드를 위한 pySLALIB 패키지 소스를 GitHub 에서 검색하기 때문에 Git 을 설치해야 한다.::

    conda install git

**래시피 생성**. 래시피를 시작부터 작성하거나 `우리가 작성한 래시피
<https://github.com/conda/conda-docs/tree/master/docs/source/build_tutorials/pyslalib>`_ 를 사용해도 된다.
래시피는 다음 파일들을 포함한다.:

* **meta.yaml** pySLALIB 파일의 GitHub 경로와
  시스템이 intel_fortran_use.patch 를 적용하는 방법을 설정한다.
* **bld.bat** 윈도우 배치 스크립트로 빌드와 빌드 실행 과정에서
  알맞은 32비트 또는 64 비트 라이브러리가 연결되는 것을 보장한다.
* **run_test.py** pySLALIB GitHub 저장소로부터 가져온 테스트이다.
  빌드가 성공적으로 완성 되었는지 확인한다.
* **intel_fortran_use.patch** pySLALIB Fortran 코드로의 패치이다.
  이 패치로 코드가 인텔 Fortran 컴파일러와 작동할 수 있다.

홈 디렉토리에서 "pyslalib" 로 명명된 래시피 디렉토리를 생성하고 위의 래시피 파일들을 복사한다.

**패키지 빌드**. "Intel Parallel Studio XE 2016" 의 Apps 메뉴에서
"Compiler 16.0 Update 3 for Intel 64 Visual Studio 2015 environment" 커맨드 프롬프트를 연다.

콘다 빌드를 실행하고 유저명을 포함하는 알맞은 래시피 디렉토리 경로를 사용한다.
우리 예시에서 유저명은 "builder" 이다.:

``conda build C:\Users\builder\pyslalib``

**출력 체크**. 출력을 체크해 빌드가 제대로 완성 되었는지 확인한다.
출력은 최종 패키지 파일의 위치와 패키지를 아나콘다 클라우드에 업로드 하기 위한 커맨드를 포함한다.

"빌드 전략" 섹션에서 다룬 바와 같이 링크나 컴파일러 에러가 나타나면 래시피를 수정하고 다시 실행해야 한다.

윈도우에서 콘다와 파이썬2로 pySLALIB 패키지 빌드하기
----------------------------------------------------------------

pySLALIB 패키지가 Fortran 을 포함하므로 빌드를 위해 Fortran 컴파일러가 필요하다.
pySLALIB 를 위한 PyPI 패키지가 없기 때문에 skeleton 래시피를 사용할 수 없고 기초부터 작성해야 한다.
pySLALIB 를 빌드하는 과정는 앞선 SEP 빌드와 유사하지만 Fortran 컴파일러를 설치하는 과정과
PyPI 대신 GitHub 에 패키지를 페치하기 위해 meta.yaml 파일을 작성하는 과정 그리고 Fortran 코드에 알맞은 패치를 적용하는 과정이 추가된다.

**비주얼 스튜디오 2008 설치**. "Custom" 설치를 선택해 "X64 Compilers and Tools" 를 설치한다.
비주얼 스튜디오 2008 서비스팩 1 을 설치한다.

**Intel Parallel Studio Composer Edition 설치**. `인텔 Fortran 컴파일러 페이지 <https://software.intel.com/en-us/fortran-compilers>`_ 로 가자.
"Try & Buy" 를 선택하고 Parallel Studio Composer Edition for Windows 를 고른다.
Fortran 과 C++ 버전 대신 Fortran 만을 포함하는 버전을 선택해도 된다.
30일 무료 체험판이 제공된다. 이메일 주소가 포함된 양식을 작성하면 이메일로 다운로드 링크를 받을 수 있다.
링크를 클릭하면 "Intel Parallel Studio XE Composer Edition for Fortran Windows" 다운로드 페이지가 나타난다.
"Additional downloads, latest updates and prior versions." 에서 version 2013 Update 6 를 선택한다.
"Intel Visual Fortran Composer XE 2013 SP1 (compiler version 14.0)" 은
비주얼 스튜디오 2008 에서 작동하는 가장 최신 버전의 Fortran 컴파일러이다.
"Download Now" 를 선택해 이 버전을 설치한다.

**Git 설치**. 빌드를 위한 pySLALIB 패키지 소스를 GitHub 에서 검색하기 때문에 Git 을 설치해야 한다.::

    conda install git


**래시피 생성**. 래시피를 시작부터 작성하거나 `우리가 작성한 래시피
<https://github.com/conda/conda-docs/tree/master/docs/source/build_tutorials/pyslalib>`_ 를 사용해도 된다.
래시피는 다음 파일들을 포함한다.:

* **meta.yaml** pySLALIB 파일의 GitHub 경로와
  시스템이 intel_fortran_use.patch 를 적용하는 방법을 설정한다.
* **bld.bat** 윈도우 배치 스크립트로 빌드와 빌드 실행 과정에서
  알맞은 32비트 또는 64 비트 라이브러리가 연결되는 것을 보장한다.
* **run_test.py** pySLALIB GitHub 저장소로부터 가져온 테스트이다.
  빌드가 성공적으로 완성 되었는지 확인한다.
* **intel_fortran_use.patch** pySLALIB Fortran 코드로의 패치이다.
  이 패치로 코드가 인텔 Fortran 컴파일러와 작동할 수 있다.

홈 디렉토리에서 "pyslalib" 로 명명된 래시피 디렉토리를 생성하고 위의 래시피 파일들을 복사한다.

**패키지 빌드**. "Intel Parallel Studio XE 2013" 의 Apps 메뉴에서
"Intel 64 Visual Studio 2008 mode" 커맨드 프롬프트를 연다.

콘다 빌드를 실행하고 유저명을 포함하는 알맞은 래시피 디렉토리 경로를 사용한다.
우리 예시에서 유저명은 "builder" 이다.:

``conda build C:\Users\builder\pyslalib``

**출력 체크**. 출력을 체크해 빌드가 제대로 완성 되었는지 확인한다.
출력은 최종 패키지 파일의 위치와 패키지를 아나콘다 클라우드에 업로드 하기 위한 커맨드를 포함한다.

"빌드 전략" 섹션에서 다룬 바와 같이 링크나 컴파일러 에러가 나타나면 래시피를 수정하고 다시 실행해야 한다.
