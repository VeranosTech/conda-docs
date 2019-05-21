자동 설치
-------------------

미니콘다 또는 아나콘다의 자동설치는 Travis CI, Appveyor 와 같은 개발 서비스나 배포, 테스트 등에 사용될 수 있다.
자동 모드에서 스크린 프롬프트는 나타나지 않고 디폴트 설정은 자동으로 허용된다.

주의: 이 설명서는 미니콘다를 위해 작성되었다. 아나콘다를 사용중이라면 아래 예시들에서 "Miniconda" 를 "Anaconda" 로 대체한다.

아나콘다 또는 미니콘다의 최신 버전을 사용하는 것을 권장한다. 다음 커맨드로 버전을 확인하자.

.. code-block:: console

    conda update conda


윈도우
~~~~~~~

미니콘다의 윈도우 인스톨러는 ``/S`` 인수를 사용해 자동 설치 모드를 실행할 수 있다.
아래 선택 인수들이 지원된다.:

- ``/InstallationType=[JustMe|AllUsers]``, 디폴트: ``JustMe``
- ``/AddToPath=[0|1]``, 디폴트: ``1``
- ``/RegisterPython=[0|1]``, 시스템의 디폴트 파이썬으로 지정한다. 디폴트: ``0`` (현재 사용자), ``1`` (모든 사용자)
- ``/S``
- ``/D=<installation path>``

모든 인수는 대소문자를 구분한다. 설치 경로는 반드시 마시막 인수여야 하고 인용 문자로 둘러싸면 안된다.
``/S``  인수로 자동 설치를 사용할 때 ``/D`` 로 최종 설치 경로를 지정해야 한다.

다음 커맨드는 현재 사용자를 위해 미니콘다를 설치한다. 파이썬을 시스템 디폴트로 인증하지 않고 진행한다.

.. code-block:: bat

    start /wait "" Miniconda4-latest-Windows-x86_64.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%UserProfile%\Miniconda3


리눅스와 OS X
~~~~~~~~~~~~~~

리눅스와 OS X 의 미니콘다 자동 설치는 bash 인스톨러에서 ``-b``, ``-p`` 인수를 지정해주면 된다.
아래 인수들이 지원된다.:

- ``-b``, 배치 모드, ``~/.bashrc`` 로의 경로 수정을 하지 않는다.
- ``-p``, 설치 접두어/경로
- ``-f``, ``-p`` 가 이미 존재하더라도 강제 설치를 진행한다.

배치 모드는 사용자가 라이센스에 동의했다고 간주하고 설치를 진행한다. .bashrc 또는 .bash_profile 파일을 수정하지 않는다.

완성된 예시:

.. code-block:: bash

    wget http://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O ~/miniconda.sh
    bash ~/miniconda.sh -b -p $HOME/miniconda
    export PATH="$HOME/miniconda/bin:$PATH"

주의: 현재 세션의 경로만을 지정하므로 영구적이지 않다. 콘다가 지정한 경로에 없을 때 콘다를 사용하면 "command not found" 메시지가 나타난다.

새로운 배치 세션마다 콘다를 사용하기 전에 ``source $HOME/miniconda3/bin/activate`` 를 실행하는 것을 권장한다.
이 커맨드로 경로를 설정하고 콘다 패키지의 활성화 스크립트를 실행한다.
``$HOME/miniconda3/bin/activate`` 를 콘다 설치의 활성화 스크립트의 경로로 대체한다.

``.bashrc`` 파일에 ``export PATH="$HOME/miniconda3/bin:$PATH"`` 과 같은 라인을 추가함으로써 경로를 영구적으로 설정할 수 있다.
그러나 이 방법은 콘다를 콘다 패키지의 활성화 스크립트 없이 사용할 수 있게 하므로 에러가 발생할 수 있다.