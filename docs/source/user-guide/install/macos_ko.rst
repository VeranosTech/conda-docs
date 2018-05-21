===================
맥OS에서 설치
===================

#. 인스톨러를 다운로드한다.

   * `맥OS용 미니콘다 인스톨러 <https://conda.io/miniconda.html>`_.

   * `맥OS용 아나콘다 인스톨러 <https://www.anaconda.com/download/>`_.

#. 설치한다.

   * 미니콘다---터미널에서 다음을 실행한다.

     .. code::

        bash Miniconda3-latest-MacOSX-x86_64.sh

   * 아나콘다---``.pkg`` 파일을 더블클릭한다.

#. 설치 화면의 프롬프트를 따라 진행한다.

   어떤 설정에 대한 확신이 없다면 기본으로 설정한다. 나중에 변경할 수 있다.

#. 터미널을 종료하고 다시 열어야 변경사항이 적용된다.

#. :doc:`설치를 테스트한다  <test-installation_ko>`.


.. _install-macos-silent:

자동 설치
=========================

주의: 다음은 미니콘다를 위한 설명이다. 아나콘다에서는 모든 명령의 ``Miniconda``\ 를 ``Anaconda``\ 로 바꾼다.

맥OS,리눅스용 :ref:`자동 설치 <silent-mode-glossary>`\ 를 실행한다.
배시 인스톨러에서 -b 인수와 -p 인수를 지정한다. 다음 인수를 지원한다.

* -b---``~/.bashrc`` PATH를 수정하지 않는 배치 모드다. 라이센스에 동의한 것으로 가정한다.
  ``.bashrc``\ 나 ``.bash_profile`` 파일을 수정하지 않는다.
* -p---설치 접두어/path.
* -f---접두어 -p가 이미 있어도 강제 설치한다.

예시:

.. code-block:: bash

    wget http://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O ~/miniconda.sh
    bash ~/miniconda.sh -b -p $HOME/miniconda
    export PATH="$HOME/miniconda/bin:$PATH"

주의: PATH를 현재 세션에서만 설정하고 유지되지 않는다. PATH에 콘다가 없을 때 콘다 명령을 사용하면
"command not found." 와 같은 에러 메세지가 나타난다.

콘다를 사용하기 전에 새 배치 세션마다 PATH를 설정하고 콘다 패키지의 활성화 스크립트를 실행하기 위해 다음 명령을 사용한다. ::

  source $HOME/miniconda/bin/activate

주의: ``$HOME/miniconda/bin/activate``\ 를 사용자의 콘다 설치의 활성화 스크립트 경로로 바꾼다.

PATH를 지속적으로 설정하려면 ``.bashrc`` 파일에 줄을 추가한다.
이 작업으로 활성화 스크립트를 실행하지 않고 콘다를 사용할 수 있게 되면 에러가 생길 수 있다.

예시 ::

  export PATH="$HOME/miniconda/bin:$PATH"


아나콘다/미니콘다 업데이트
==============================

#. 터미널을 연다.

#. ``anaconda`` 디렉토리로 찾는다.

#. ``conda update conda``\ 를 실행한다.


아나콘다/미니콘다 삭제
==================================

#. 터미널을 연다.

#. 다음 명령으로 미니콘다 설치 디렉토리를 전체 삭제한다. ::

     rm -rf ~/miniconda

#. 다음을 할 수 있다.

#. 선택: ``~/.bash_profile``\ 을 수정해 PATH 환경 변수에서 미니콘다 디렉토리를 삭제한다.

#. 선택: 홈 디렉토리에 생성되었을 수 있는 숨겨진 파일과 폴더를 삭제한다.

   * ``.condarc`` 파일
   * ``.conda`` 디렉토리
   * ``.continuum`` 디렉토리

   다음을 실행한다. ::

     rm -rf ~/.condarc ~/.conda ~/.continuum
