============================
 Travis CI 와 콘다 사용하기
============================

이미 Travis CI 를 사용하고 있다면 패키지를 설치함에 있어 콘다는 apt-get과 pip 보다 위한 좋은 대안이다.
Travis가 제공하는 Debian 저장소는 모든 버전의 파이썬을 위한 파이썬 패키지 버전을 포함하지 않거나 업데이트가 빠르지 않을 수 있다.
Travis가 각각의 빌드를 허용하면서 50분이라는 긴 시간을 차지하기 때문에 pip를 사용한 패키지 설치 또한 부적절할 수 있다.
콘다를 사용한 방식은 Travis 상의 콘다 레시피의 빌드를 테스트하게 한다.

콘다는 언어에 구속받지 않기 때문에 파이썬 뿐 아니라 어디에도 쓰일 수 있지만
아래 가이드는 Travis CI 상의 파이썬 패키지를 테스트 하는데 사용하는 방법을 다룬다.

.travis.yml 파일
====================

아래는 ``.travis.yml`` 파일을 수정함으로써 `미니콘다<https://conda.io/miniconda.html>`_ 를 사용하는 방법을 다룬다.
이는 파이썬 2.6, 2.7, 3.3, 3.4 를 지원하는 프로젝트를 위해 사용된다.

주의: `Travis 기본 설정 <http://docs.travis-ci.com/user/languages/python/#Examples>`_ 에 대한 정보를 위해 Travis CI 웹사이트를 참고하자.

.. code-block:: yaml

   language: python
   python:
     # 실제로 Travis 파이썬을 사용하진 않지만 아래 체계를 유지하자.
     - "2.6"
     - "2.7"
     - "3.3"
     - "3.4"
   install:
     - sudo apt-get update
     # 이 부분은 버전이 동일할 때 몇몇 다운로드를 저장하기 때문에
     # 상황에 따라 사용하자.
     - if [[ "$TRAVIS_PYTHON_VERSION" == "2.7" ]]; then
         wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -O miniconda.sh;
       else
         wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
       fi
     - bash miniconda.sh -b -p $HOME/miniconda
     - export PATH="$HOME/miniconda/bin:$PATH"
     - hash -r
     - conda config --set always_yes yes --set changeps1 no
     - conda update -q conda
     # 콘다와 관련된 문제를 디버깅 하는데 유용하다.
     - conda info -a

     # dep1 dep2 를 하위 요소로 대체한다.
     - conda create -q -n test-environment python=$TRAVIS_PYTHON_VERSION dep1 dep2 ...
     - source activate test-environment
     - python setup.py install

   script:
     # 스크립트가 이 부분에 온다.

추가 단계
================

공식 Continuum 빌드가 없는 패키지를 지원하고 싶다면 사용자가 이를 직접 빌드해 Anaconda.org 채널에 추가한다.
그리고 아래 커맨드를

.. code-block:: yaml

   - conda config --add channels your_Anaconda_dot_org_username

``.travis.yml`` 내부의 설치 단계에 추가해 채널 상의 패키지를 찾도록 한다.


콘다 레시피 빌드
=======================

사용자의 프로젝트를 위해 공식 콘다 패키지를 지원한다면
Travis 에서 ``conda build`` 를 사용해 사용자의 레시피가 테스트 되길 원할 것이다.
우리는 소스코드와 동일한 디렉토리에 콘다 레시피를 포함하는걸 권장한다.
그리고 아래와 같이 대체한다.:

.. code-block:: yaml

   - python setup.py install

코드를 아래 코드로.

.. code-block:: yaml

   - conda build your-conda-recipe
   - conda install your-package --use-local

콘다 패키지 빌드에 대한 추가 정보는 `콘다 빌드 <https://conda.io/docs/build.html>`_ 섹션과
`콘다 레시피 저장소 <https://github.com/conda/conda-recipes>`_ 의 예시 레시피에서 볼 수 있다.


AppVeyor
========

`AppVeyor <http://www.appveyor.com/>`_ 는 콘다를 사용할 때 Travis CI 의 대안이 된다.
Azure 상의 윈도우를 위한 지속적인 빌드 서비스이다.

Appveyor 상에서 콘다 패키지를 빌드하는데 예시가 되는 프로젝트를 https://github.com/rmcgibbo/python-appveyor-conda-example 에서 볼 수 있다.
