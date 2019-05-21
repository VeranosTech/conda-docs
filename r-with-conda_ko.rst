==================
콘다와 R 사용하기
==================

리눅스, OS X, 윈도우를 위함.

콘다가 설치 되었다면 R 프로그래밍 언어와 80여개의 사용 빈도가 높은 R 패키지를 손쉽게 설치할 수 있다.
이 패키지들은 하나의 커맨드로 설치되며 데이터 사이언스를 위한 패키지들이다.
콘다는 사용자의 패키지와 하위 요소들이 최신 버전이 되도록 돕는다.
사용자만의 R 패키지를 손쉽게 생성하고 공유할 수 있다.

R-Essentials 는 아나콘다와 매우 유사하게 작동한다.:

* 하나의 커맨드로 많이 사용되는 패키지와 그 하위 요소를 모두 설치한다.: ``conda install r-essentials``
* 하나의 커맨드로 모든 패키지와 그 하위 요소를 업데이트 한다.: ``conda update r-essentials``
* 커맨드로 R-Essentials 의 단일 패키지를 업데이트 한다. (R 채널에서 신규 버전의 패키지가 사용 가능한 경우): ``conda update r-XXXX``

"R Essentials" 설치
=============================

1. `아나콘다를 다운받고 설치한다. <https://www.continuum.io/downloads>`_
2. 현재 환경에 R Essentials 패키지를 설치한다.: ``conda install r-essentials``

사용자만의 R 번들을 생성하고 공유
=========================================

사용자만의 R 번들을 생성하고 공유하는 것은 콘다 패키지를 생성 공유하는 것과 유사하다.

예를 들어 간단한 커스텀 R 번들 메타 패키지를 생성하고 "Custom-R-Bundle" 로 이름 짓는다.
이 번들은 몇개의 일반적인 프로그램과 그 하위 요소를 포함한다. 아래 커맨드를 사용::

  conda metapackage custom-r-bundle 0.1.0 --dependencies r-irkernel jupyter r-ggplot2 r-dplyr --summary "My custom R bundle"

이제 사용자는 손쉽게 새로운 메타 패키지를 친구나 동료와 공유할 수 있다.
사용자의 채널을 `Anaconda Cloud <https://anaconda.org>`_ 에 업로드 한다.::

  conda install anaconda-client
  anaconda login
  anaconda upload path/to/custom-r-bundle-0.1.0-0.tar.bz2

이제 사용자의 친구와 동료는 아래 커맨드로 어떤 컴퓨터에서든 사용자의 커스텀 R 번들에 접근할 수 있다.::

  conda install -c <your anaconda.org username> custom-r-bundle

더 많은 정보가 필요하다면 Christine Doig의 블로그 포스트를 보자. `Jupyter and conda for R language <https://www.continuum.io/blog/developer/jupyter-and-conda-r>`_.

다음은 :doc:`mro_ko` 를 보자..
