=================
패키지 관리
=================

.. contents::

시작에 앞서 미니콘다 또는 아나콘다를 설치하고 :doc:`환경 관리 <envs_ko>` 섹션을 익혔는지 확인해보자. 잘 따라왔다면 환경을 설치할 때 몇몇 패키지가 설치 되었을 것이다.

주의: 다음에 소개할 커맨드들은 여러 옵션을 사용할 수 있다. :doc:`커맨드 레퍼런스 </commands_ko>` 를 참고하자.

패키지 나열
~~~~~~~~~~~~~~~~~

활성화된 환경의 모든 패키지를 나열한다.:

.. code::

   conda list

snowflakes 라는 명칭의 비활성화 된 환경이 갖는 모든 패키지를 나열한다.

.. code::

   conda list -n snowflakes

패키지 검색
~~~~~~~~~~~~~~~~~~~~

특정 패키지가 콘다를 통해 설치 가능한지 보려면 다음 커맨드를 사용한다.:

.. code::

   conda search beautiful-soup

위 커맨드는 패키지명을 보여줄 것이다. 이는 설치 가능하다는 의미이다.

패키지 설치
~~~~~~~~~~~~~~~~~

"Beautiful Soup" 패키지를 현재 환경에 설치해 보자. conda install 커맨드를 사용한다.:

.. code::

   conda install --name bunnies beautiful-soup

주의: 패키지를 설치할 환경명을 지정하지 않으면 현재 환경에 패키지가 설치된다. 위 예시에서는 --name bunnies 로 환경을 지정했다.


bunnies 환경을 활성화 하고 conda list 커맨드로 새 패키지가 잘 설치 되었는지 보자.:

**리눅스, OS X:** ``source activate bunnies``
**윈도우:**  ``activate bunnies``

**모든 운영체제:**  ``conda list``

주의: IOPro 와 같은 상업용 패키지를 설치할 때도 동일하게 하면 된다.: ``conda install --name bunnies iopro``

Anaconda.org 로부터 패키지 설치
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

conda install 을 사용해 설치할 수 없는 패키지들은 Anaconda.org 의 저장소를 확인해보자. Anaconda.org (이전에는 Binstar.org) 는 패키지 관리 서비스로 공용 패키지와 개인 패키지 저장소 모두 지원한다. 아나콘다와 미니콘다와 같은 Continuum Analytics 제품이다.

브라우저에서 http://anaconda.org 로 간다. "bottleneck" 패키지를 찾기 위해 왼쪽 상단의 "Search Packages" 창에 "bottleneck" 을 입력한다.

원하는 패키지를 찾았다면 이를 클릭해 세부사항 페이지로 들어간다. 채널명을 볼 수 있을 것이다. 이번 예시에서는 "pandas" 채널이다.

채널명을 알았으니 conda install 커맨드로 설치해보자. 다음 커맨드를 사용한다.:

.. code::

   conda install -c pandas bottleneck

위 커맨드는 Anaconda.org 상의 Pandas 채널에서 bottleneck 패키지를 설치한다.

이제 패키지가 설치될 것이다.

패키지가 설치 되었는지 확인해 보자.:

.. code::

   conda list

bottleneck 을 포함하는 패키지 리스트가 나타날 것이다.

주의:  콘다는 :doc:`다양한 채널 <../channels_ko>` 로부터 패키지를 설치할 수 있다.

콘다가 아닌 패키지 설치
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

콘다나 Anaconda.org 에서 설치할 수 없는 패키지는 다른 패키지 관리자를 사용해 설치할 수 있다. 다른 패키지 관리자로는 pip 가 있다.

주의: pip 와 콘다 모두 아나콘다와 미니콘다에 포함되어 있으므로 따로 설치하지 않아도 된다.

주의: 콘다 환경은 virtualenv 를 대체하므로 pip 를 사용하기 전에 virtualenv 를 활성화 하지 않아도 된다.

패키지를 넣을 환경을 활성화 하고 pip install 로 "See" 라는 패키지를 설치해보자.:

**리눅스, OS X:** ``source activate bunnies``

**윈도우:**  ``activate bunnies``

**모든 운영체제:**  ``pip install see``

See 패키지가 pip 로 설치되었는지 확인해보자.:

.. code::

   conda list

상업 패키지 설치
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

상업 패키지도 콘다를 사용한 다른 패키지와 동일하게 설치한다. 파이썬 처리 속도를 향상시켜주는 Continuum 의 상업 패키지 IOPro 의 체험판을 설치하고 제거해보자.

.. code::

   conda install iopro

팁: 학문적 용도를 제외하고 이 체험판은 30일 이후에 만료된다.

이제 콘다를 사용해 원하는 패키지를 설치하고 확인할 수 있다. 콘다 커맨드, Anaconda.org, pip 설치 를 사용할 수 있고 오픈소스와 상업용 패키지 모두 설치할 수 있다.

패키지 업데이트
~~~~~~~~~~~~~~~~~

conda update 커맨드로 사용가능한 신규 업데이트가 있는지 확인할 수 있다. 업데이트가 존재하면 설치 여부를 결정할 수 있다.

conda update 커맨드로 특정 패키지를 업데이트 해보자.:

.. code::

   conda update biopython

conda update 커맨드로 conda 도 업데이트 할 수 있다.:

.. code::

   conda update conda

Python 도 conda update 커맨드로 업데이트 할 수 있다.:

.. code::

   conda update python

주의: 콘다는 패키지의 시리즈 중 가장 높은 버전을 업데이트 한다. 예를 들어 파이썬 2.7 은 파이썬 2 시리즈 중 가장 높은 버전으로 업데이트 된다. 파이썬 3.6 이라면 파이썬 3 시리즈 중 가능 높은 버전이 된다.

어떤 패키지던 간에 콘다는 버전을 비교하고 설치 가능한 버전을 알려줄 것이다. 설치 가능한 버전이 없다면 "All requested packages are already installed." 메시지가 나타난다.

새로운 버전의 패키지가 존재하고 업데이트를 진행하고 싶다면 Y 를 입력하자.:

.. code::

   Proceed ([y]/n)? y

"y" 를 입력해 업데이트 한다.

패키지 제거
~~~~~~~~~~~~~~~~~

패키지를 더이상 사용하지 않는다면 이를 제거할 수 있다. 예를 들어, bunnies 환경에서 IOPro 를 제거해보자.:

.. code::

   conda remove --name bunnies iopro

패키지가 제거 되었는지 확인한다.:

.. code::

   conda list

다음은 :doc:`/r-with-conda_ko` 를 보자.

.. toctree::
   :hidden:

   ../channels
