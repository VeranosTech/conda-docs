=================================
NLTK 를 위한 콘다 패키지 빌드
=================================

자연어 처리 툴킷 (NLTK) 은 인간 언어 데이터의 통계적 자연어 처리 (NLP) 에 사용되는 파이썬 패키지 개발에 사용되는 플랫폼이다.
설치하기 쉽지는 않지만 NLTK 콘다 패키지를 빌든하는 것은 어렵지 않다.

이 패키지는 모든 NLTK 데이터셋을 포함한다. 데이터셋은 8GB 정도를 차지한다.

다음 파일을 다운로드 한다. https://gist.github.com/danielfrg/d17ffffe0dc8ed56712a0470169ff546 (우측 상단의 Download
ZIP 버튼을 클릭한다.).

다운로드한 파일의 압축을 풀고 다운로드 된 디렉토리를 ``/nltk-with-data/`` 로 변경한다.

conda build 가 없다면 설치한다.:

``conda install conda-build``


``cd`` 를 사용해 nltk-with-data directory 의 한단계 상위 디렉토리로 변경한다.

필요한 파이썬 버전들을 위해 conda build 를 실행하고 커맨드를 실행 중인 운영체제에 해당하는 패키지를 선택한다.:

.. code-block:: bash

    conda build nltk-with-data --python 2.7
    conda build nltk-with-data --python 3.4
    conda build nltk-with-data --python 3.5
    conda build nltk-with-data --python 3.6

출력되는 콘다 패키지는 $CONDA_ROOT/conda-bld/$ARCH/nltk-with-data.tar.bz2 에 위치한다.
$CONDA_ROOT 는 아나콘다가 설치된 루트이고 $ARCH 는 패키지를 빌드할 아키텍쳐이다.

출력된 콘다 패키지를 사용자의 로컬 저장소 또는 `아나콘다 노트북 확장 <https://docs.continuum.io/anaconda/jupyter-notebook-extensions>` 을 사용하는
`아나콘다 클라우드 <https://anaconda.org>`_ 로 업로드 한다.

.. code-block:: bash

    anaconda upload $CONDA_ROOT/conda-bld/$ARCH/nltk-with-data.tar.bz2
    anaconda upload $CONDA_ROOT/conda-bld/$ARCH/nltk-with-data.tar.bz2
    anaconda upload $CONDA_ROOT/conda-bld/$ARCH/nltk-with-data.tar.bz2
    anaconda upload $CONDA_ROOT/conda-bld/$ARCH/nltk-with-data.tar.bz2

선택: 위의 단계들을 다른 운영체제에서 반복하면 그 운영체제를 위한 콘다 패키지를 빌드한다.
순수 파이썬 패키지라면 conda convert 를 사용해도 된다. 새로운 버전의 NLTK 가 배포되면 래시피를 업데이트하고 위 단계를 반복할 수 있다.

콘다로부터 설치
==================

.. code-block:: bash

    $ conda install nltk-with-data
    $ ipython

.. code-block:: python

    import nltk.corpus
    nltk.corpus.treebank
    
위 커맨드는 콘다 패키지를 사용해 데이터를 로드하고 있음을 보여줄 것이다.

콘다가 패키지를 설치하고나면 모든 데이터셋과 함께 라이브러리를 사용할 수 있다.

참고: `NLTK documentation <http://www.nltk.org/>`_
