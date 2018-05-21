=================
패키지 관리
=================

.. contents::
   :local:
   :depth: 1

주의: 이 문서에서 다루는 명령에 사용 가능한 많은 옵션들이 있다. 보다 자세한 정보는 :doc:`../../commands_ko`\ 에서 볼 수 있다.


패키지 검색하기
=======================

터미널이나 아나콘다 프롬프트에서 다음 단계를 따라 진행한다.

사이파이(Scipy)와 같은 특정한 패키지가 설치 가능한지 확인하기 위해 다음을 실행한다.

.. code-block:: bash

   conda search scipy

사이파이가 Anaconda.org 를 통해 설치 가능한지 확인하기 위해 다음을 실행한다.

.. code-block:: bash

   conda search --override-channels --channel defaults scipy

이미뉴잇(iminuit)과 같은 특정한 패키지가 http://conda.anaconda.org/mutirri 와 같은 특정 채널에 있고
이 채널을 통해 설치 가능한지 확인하기 위해 다음을 실행한다.

.. code-block:: bash

   conda search --override-channels --channel http://conda.anaconda.org/mutirri iminuit


패키지 설치하기
===================

터미널이나 아나콘다 프롬프트에서 다음 단계를 따라 진행한다.

다음 명령으로 사이파이(Scipy)와 같은 특정한 패키지를 기존 콘다 환경 "myenv"에 설치한다.

.. code-block:: bash

   conda install --name myenv scipy

이번 예시의 ``--name myenv`` 옵션과 같이 환경 이름을 지정하지 않으면 패키지는 현재 환경에 설치된다.

.. code-block:: bash

   conda install scipy

다음 명령으로 특정한 버전의 사이파이를 설치한다.

.. code-block:: bash

   conda install scipy=0.15.0

.. _`installing multiple packages`:

다음 명령으로 사이파이와 씨유알엘(cURL)과 같은 복수의 패키지를 한번에 설치한다.

.. code-block:: bash

   conda install scipy curl

주의: 모든 패키지를 한번에 설치하여 모든 의존 요소가 동시에 설치되게 하는 것이 가장 좋다.

다음 명령으로 특정 버전으로 지정된 복수의 패키지를 한번에 설치한다.

.. code-block:: bash

   conda install scipy=0.15.0 curl=7.26.0

다음 명령으로 특정 버전의 파이썬 환경을 위한 패키지를 설치한다.

.. code-block:: bash

   conda install scipy=0.15.0 curl=7.26.0 -n py34_env

특정한 버전의 파이썬을 사용하는 가장 좋은 방법은 그 버전을 포함하는 환경을 사용하는 것이다.
더 자세한 정보는 :doc:`../troubleshooting_ko`\ 에 있다.


Anaconda.org에서 패키지를 받아서 설치하기
===============================================

콘다를 사용해 설치할 수 없는 패키지를 Anaconda.org에서 받을 수 있다.
이전에는 Binstar.org였던 Anaconda.org는 개인/공공 패키지 레포지토리를 위한 패키지 관리 서비스다.
아나콘다(Anaconda)나 미니콘다(Miniconda)와 같이 Anaconda.org는 아나콘다사의 제품이다.

Anaconda.org에서 패키지를 받아서 설치하기 위해 다음을 진행한다.

#. 브라우저에서 http://anaconda.org\ 로 들어간다.

#. bottleneck이라는 이름의 패키지를 찾기 위해 페이지 상단에 Search Packages 박스에 ``bottleneck``\ 을 입력한다.

#. 원하는 패키지를 찾아 클릭하여 세부사항 페이지로 들어간다.

   세부사항 페이지에 채널의 이름이 나타난다. 이번 예시의 채널 이름은 "pandas"다.

#. 채널 이름을 알게 되면 터미널이나 아나콘다 프롬프트에서 ``conda install`` 명령을 사용해 패키지를 설치한다.

   .. code::

      conda install -c pandas bottleneck

   이 명령으로 콘다는 Anaconda.org의 pandas 채널로부터 bottleneck 패키지를 설치한다.

#. 터미널이나 아나콘다 프롬프트에서 다음을 실행해 패키지가 설치되었는지 확인한다.

   .. code::

      conda list

   bottleneck을 포함한 패키지 목록이 나타난다.

주의: 복수의 채널로부터 패키지를 설치하는 방법은 :doc:`manage-channels_ko`\ 를 보자.


콘다 패키지가 아닌 패키지 설치하기
====================================================

콘다나 Anaconda.org로부터 설치할 수 없는 패키지는 pip와 같은 다른 패키지 관리자로 찾고 설치할 수 있다.

주의: pip와 콘다 모두 아나콘다와 미니콘다에 포함되어 있기 때문에 별도로 설치하지 않아도 된다.

주의: 콘다 환경은 virtualenv를 대체하므로 pip를 사용하기 전에 virtualenv를 활성화하지 않아도 된다.

pip가 콘다 환경 외부나 내부에 설치되는 것은 가능하다.

콘다 통합의 이점을 얻으려면, pip를 현재 활성화된 콘다 환경 안에 설치해야 하며 그 다음에 pip의
그 인스턴스에서 패키지를 설치해야 한다. ``conda list`` 명령어는 이 방식으로 설치된 패키지를
pip를 통해 설치됐다는 걸 보여주는 라벨과 함께 보여준다.

:ref:`pip-in-env`\ 에서 논의된 대로, 현재 콘다 환경에서 ``conda install pip`` 명령어로
pip를 설치할 수 있다.

현재 콘다 환경의 내부와 외부에 모두 설치된 pip의 인스턴스들이 있다면, 현재 콘다 환경 내부에
설치된 pip의 인스턴스가 사용된다.

다음 단계를 따라 콘다 패키지가 아닌 패키지를 설치한다.

#. 프로그램을 설치할 환경을 활성화한다.

   * 윈도우: 아나콘다 프롬프트에서 ``activate myenv``\ 를 실행한다.
   * 리눅스, 맥OS: 터미널에서 ``source activate myenv``\ 를 실행한다.

#. pip를 사용해 see와 같은 프로그램을 설치하기 위해 터미널이나 아나콘다 프롬프트에서 다음을 실행한다. ::

     pip install see

#. 패키지가 설치되었는지 확인하기 위해 터미널이나 아나콘다 프롬프트에서 다음을 실행한다.

   .. code::

      conda list

패키지가 보이지 않는다면, pip를 :ref:`pip-in-env`\ 에 나온대로 설치해보고 이 명령어들을
다시 실행해봐라.


상용 패키지 설치하기
==============================

IOPro와 같은 상용 패키지도 다른 패키지와 같은 방법으로 설치한다.

.. code-block:: bash

   conda install --name myenv iopro

이 커맨드는 아나콘다의 상용패키지 `IOPro <https://docs.continuum.io/iopro/>`_\ 의 체험판을 설치한다.
IOPro는 파이썬 처리 속도를 향상시킨다. 학술적 목적이 아닌 경우, 이 체험판은 30일 이후에 만료된다.


설치된 패키지 목록 보기
====================================

터미널이나 아나콘다 프롬프트에서 다음 단계를 따라 진행한다.

다음을 실행해 현재 활성화된 환경에 설치된 패키지를 나열한다.

.. code::

   conda list

다음을 실행해 비활성화된 환경에 설치된 패키지 목록을 나열한다. 여기에서는 myenv 환경에 설치된 패키지들이 나열된다.

.. code::

   conda list -n myenv


패키지 업데이트하기
====================

``conda update`` 명령으로 새로운 업데이트가 가능한지 확인한다.
업데이트가 있다고 나타나면 이를 설치할지 결정할 수 있다.

터미널이나 아나콘다 프롬프트에서 다음 단계를 따라 진행한다.

다음을 실행해 특정한 패키지를 업데이트한다. 여기에서는 biopython을 업데이트한다.

.. code::

   conda update biopython

다음을 실행해 파이썬을 업데이트한다.

.. code::

   conda update python

다음을 실행해 콘다를 업데이트한다.

.. code::

   conda update conda

주의: 콘다는 패키지의 시리즈 중 가장 최신 버전으로 업데이트한다.
따라서 파이썬 2.7은 파이썬2 중 가능한 최신 버전으로 업데이트되고
파이썬 3.6은 파이썬3 중 가능한 최신 버전으로 업데이트된다.

다음을 실행해 아나콘다 메타패키지를 업데이트한다.

.. code-block:: bash

   conda update conda
   conda update anaconda

업데이트하는 패키지에 관계없이 콘다는 패키지의 버전을 비교하고 설치 가능한 버전을 보고한다.
가능한 업데이트가 없다면 "All requested packages are already installed." 라고 나타날 것이다.

패키지의 새로운 버전이 설치 가능하고 업데이트를 진행하고 싶다면 ``y``\ 를 입력한다.

.. code::

   Proceed ([y]/n)? y


.. _pinning-packages:

패키지 업데이트 막기 (pinning)
===========================================

환경의 패키지 사양을 피닝(pinning)하면 ``pinned`` 파일에 나열된 패키지는 업데이트되지 않는다.

환경의 ``conda-meta`` 디렉토리에 ``pinned``\ 라는 이름의 파일을 추가한다.
이 파일은 업데이트를 막고 싶은 패키지의 목록을 포함한다.

예시: 다음 파일은 넘파이(Numpy)를 1.7로 시작하는 모든 버전인 1.7 시리즈로 유지하고
사이파이 버전을 0.14.2에 고정되도록 한다. ::

  numpy 1.7.*
  scipy ==0.14.2

이 ``pinned`` 파일이 있으면 ``conda update numpy`` 명령은 넘파이를 1.7.1 에 머무르게 하고
``conda install scipy=0.15.0`` 명령은 에러가 나타난다.

``--no-pin`` 플래그를 사용하면 패키지의 업데이트 제한을 무시한다. 터미널이나 아나콘다 프롬프트에서 다음을 실행한다.

.. code-block:: bash

   conda update numpy --no-pin

``pinned`` 사양이 각 콘다 설치에 포함되어 있기 때문에
이후에 ``--no-pin`` 없이 ``conda update`` 명령을 실행하면 넘파이를 1.7 시리즈로 되돌린다.


패키지 삭제하기
=================

터미널이나 아나콘다 프롬프트에서 다음 단계를 따라 진행한다.

다음을 실행해 myenv 환경의 사이파이 패키지를 삭제한다.

.. code-block:: bash

   conda remove -n myenv scipy

다음을 실행해 현재 환경의 사이파이 패키지를 삭제한다.

.. code-block:: bash

   conda remove scipy

다음을 실행해 복수의 패키지를 삭제한다. 여기에서는 사이파이와 씨유알엘을 삭제한다.

.. code-block:: bash

   conda remove scipy curl

다음을 실행해 패키지가 삭제되었는지 확인한다.

.. code::

   conda list
