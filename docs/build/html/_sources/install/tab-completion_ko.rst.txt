==============
Tab Completion
==============

``conda`` 는 ``argcomplete`` 패키지를 통해 bash 셀 내부의 tab completion 을 지원한다.
먼저 ``argcomplete`` 가 설치되어 있어야 한다.

.. code-block:: bash

   $ conda install argcomplete

그리고 다음을 bash 프로파일에 추가한다.

.. code-block:: bash

   eval "$(register-python-argcomplete conda)"

새로운 터미널창을 열고 다음 커맨드를 입력해 테스트할 수 있다.

.. code-block:: bash

   $ conda ins<TAB>

아래와 같이 완료되어야 한다.

.. code-block:: bash

   $ conda install

zsh에서 tab completion 을 하고 싶다면 `conda-zsh-completion <https://github.com/esc/conda-zsh-completion>`_ 을 보자.
