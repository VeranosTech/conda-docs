테스트 드라이브
================

콘다 30분 테스트 드라이브를 시작하기 전에 2분 :doc:`/install/quick_ko` 가이드를 이미 따라해 봤어야 한다.
이 가이드는 미니콘다를 다운로드, 설치, 업데이트 하거나 이미 설치된 아나콘다나 미니콘다를 사용자의 것으로 만들기 위한 가이드이다.

주의: 설치 후에 터미널을 재시작해야 변경사항이 유효해진다.

콘다 테스트 드라이브 이정표:
----------------------------

#. :ref:`콘다 사용<managing-conda>`. 먼저 우리는 아나콘다 또는 미니콘다가 설치되었고 최신 버전으로 업데이트 되었는지 확인한다. 3분 소요
#. :ref:`환경 관리<managing-envs>`. 몇몇 환경을 생성함으로써 환경을 사용해보고 환경들 간에 전환하는 방법을 익힌다. 어떤 환경 하에 있는지 확인하고 백업을 위해 환경과 동일한 카피를 만들어 본다. 10분 소요
#. :ref:`파이썬 관리<managing-python>`. 설치 가능한 파이썬 버전을 확인하고 다른 버전의 파이썬을 설치해 본다. 설치된 파이썬 버전들 간에 전환을 해본다. 4분 소요
#. :ref:`패키지 관리<managing-pkgs>`. 패키지를 사용해 본다. a) 리스트 패키지를 컴퓨터에 설치하고 b) 사용가능한 패키지의 리스트를 본다. c) conda install 을 사용해 패키지를 설치하고 제거한다. conda install 로 설치할 수 없는 패키지는 d) Anaconda.org 를 검색한다. 어떤 위치에도 없는 패키지라면 e)pip 패키지 매니저를 사용해 설치한다. Continuum의 상업용 패키지 IOPro를 30일 체험판으로 설치한다. 10분 소요
#. :ref:`패키지, 환경, 콘다 삭제<remove-pkgs-envs-conda>`. 원한다면 하나 이상의 테스트 패키지, 환경 또는 콘다를 삭제함으로써 테스트 드라이브를 끝낸다. 3분 소요

총 30분이다.

팁:  어떤 커맨드에 대한 완전한 문서를 보고 싶다먼 커맨드 뒤에 ``--help`` 를 쓰면 된다.
예를 들어, conda update 커맨드가 궁금하다면 아래와 같이 하면 된다.:

.. code::

   conda update --help

.. _managing-conda:

1. 콘다 관리
-----------------

콘다는 패키지 관리자이면서 환경 관리자이다. 패키지 매니저는 패키지를 찾고 설치하는 것을 도와준다.
사용하고자 하는 패키지가 현재 사용하는 버전과 다른 버전의 파이썬을 요구한다고 하자.
몇개의 커맨드로 다른 버전의 파이썬을 사용하는 별개의 환경을 설정하면서 기존에 사용하던 파이썬 버전과 환경을 계속 실행할 수 있다.
콘다와 같은 환경 관리자를 사용하는 장점이라고 할 수 있다.

팁: 리눅스, OS X, 윈도우 터미널 프롬프트에서 터미널창에 입력하는 콘다 커맨드는 명시되어 있지 않는 한 모두 동일하다.

**콘다가 설치되어 있음을 확인한다.**

올바른 위치에서 시작하는지 확인하기 위해 아나콘다가 성공적으로 설치되었는지 보자.
터미널 윈도우에 아래와 같이 입력한다.:

.. code::

   conda --version

``conda 3.11.0`` 같이 콘다는 설치된 버전을 보여줄 것이다.

주의: 에러 메시지가 나타난다면 아나콘다 또는 미니콘다를 설치하고 터미널을 재시작 한 사용자 계정에 있는지 확인한다.

**콘다를 최신 버전으로 업데이트 한다.**

다음엔 conda update 커맨드로 콘다를 업데이트 한다.

.. code::

   conda update conda

콘다는 버전을 비교하고 설치 가능한 버전을 알려줄 것이다. 자동으로 업데이트 되거나 업데이트로 변경될 패키지도 알려준다.

새로운 버전의 콘다가 있다면 Y 를 입력해 업데이트 한다.

.. code::

   Proceed ([y]/n)? y

콘다가 업데이트 되면 다음 주제로 넘어가자.

.. _managing-envs:

2. 환경 관리
------------------------

이제 몇개의 환경을 생섬함으로써 환경을 사용해 보고 환경 간에 전환을 해보자.

**환경을 생성하고 활성화 한다.**

conda create 커맨드 뒤에 호출하고자 하는 명칭을 입력한다.:

.. code::

   conda create --name snowflakes biopython

Biopython 프로그램과 함께 /envs/snowflakes 라는 명칭의 환경이 생성된다.

팁:  두개의 대시 (``--``) 이후에 자주 사용되는 옵션들은 하나의 대시와 옵션의 첫글자로 활성화 된다.
``--name--`` 은 ``-n`` 과 동일하고 ``--envs`` 는 ``-e`` 와 동일하다.
``conda --help`` 또는 ``conda -h`` 로 약자 리스트를 볼 수 있다.

**새로운 환경을 활성화 한다.:**

* 리눅스, OS X: ``source activate snowflakes``
* 윈도우:  ``activate snowflakes``

팁: 디폴트로 환경은 콘다 디렉토리 내부의 envs에 설치된다. 다른 경로를 지정할 수도 있다. ``conda create --help`` 를 참고하자.

팁: 파이썬의 버전을 지정하지 않았기 때문에 콘다와 동일한 버전의 파이썬을 설치한다.

**두번째 환경을 생성한다.**

이번엔 새로운 환경을 생성하고 이름을 지어주자. 다른 버전의 파이썬과 Astroid, Babel 두개의 패키지를 설치한다.

.. code::

   conda create --name bunnies python=3.5 astroid babel

파이썬3, Astroid, Babel 가 설치된 새로운 환경이 /envs/bunnies 라는 명칭으로 생성된다.

팁: 이 환경에 설치하고 싶은 모든 프로그램을 동시에 설치하자. 프로그램을 하나씩 설치하면 하위 요소 충돌이 발생할 수 있다.

팁: conda create 커맨드에 추가할 수 있는 것들이 더 있다. ``conda create --help`` 커맨드로 확인하자.

**모든 환경 나열한다.**

어떤 환경이 설치되었는지 확인하자. conda environment info 커맨드를 사용한다.:

.. code::

   conda info --envs

아래와 같은 리스트가 나타날 것이다.:

.. code::

   conda environments:

	snowflakes          * /home/username/miniconda/envs/snowflakes
	bunnies               /home/username/miniconda/envs/bunnies
        root                  /home/username/miniconda

**현재 환경을 확인한다.**

위에 나열된 환경 중 현재 사용중인 환경을 보자. 아래 커맨드를 입력한다.:

.. code::

   conda info --envs

콘다는 모든 환경의 리스트를 보여준다. 현재 환경은 프롬프트 상단에 괄호(소괄호 또는 대괄호)와 함께 나타난다.

.. code::

   (snowflakes)

주의: 콘다는 현재 활성화된 환경 앞에 별표(*)를 두기도 한다. 위에 나타난 환경 리스트를 보자.

**다른 환경으로 전환 (활성화/비활성화)**

다른 환경으로 전환하기 위해 아래 커맨드와 환경의 이름을 입력한다.:

* 리눅스, OS X: ``source activate bunnies``
* 윈도우:  ``activate bunnies``

현재 환경으로부터 경로를 전환해 루트로 돌아간다.:

* 리눅스, OS X: ``source deactivate``
* 윈도우:  ``deactivate``

팁: 환경이 비활성화 되면 ``(bunnies)`` 는 더이상 프롬프트에 나타나지 않는다.

**환경과 동일한 카피를 생성한다.**

클론(clone)을 생성함으로써 환경과 동일한 카피를 생성한다.
flowers 라는 이름으로 snowflakes 를 클론해 보자.:

.. code::

   conda create --name flowers --clone snowflakes

**동일한 카피가 생성되었는지 확인한다.:**

.. code::

   conda info --envs

이제 환경 리스트에 flowers, bunnies, snowflakes 세개가 나타나야 한다.

**환경을 삭제한다.**

flowers 환경을 원하지 않는다면 아래와 같이 삭제하면 된다.:

.. code::

   conda remove --name flowers --all

flowers 환경이 삭제되었는지 확인하기 위해 아래 커맨드를 입력한다.:

.. code::

   conda info --envs

flowers 는 더이상 환경 리스트에 존재하지 않는다. 삭제 되었음을 확인했다.

**환경에 대해 더 알아보자.s**

어떤 콘다 커맨드던 뒤에 ``--help`` 를 입력하면 정보를 볼 수 있다.:

.. code::

   conda remove --help

.. _managing-python:

3. 파이썬 관리
------------------

콘다는 파이썬을 다른 패키지와 동일하게 취급하기 때문에 여러개의 설치를 관리하고 업데이트 하기 용이하다.

**파이썬 버전을 확인한다.**

설치 가능한 파이썬 버전을 확인하자.

.. code::

   conda search --full-name python

``conda search python`` 으로 "python" 을 포함하는 명칭을 가진 모든 패키지를 볼 수 있다.
``--full-name`` 옵션을 추가하면 풀네임이 정확히 "python" 인 패키지만 볼 수 있다.

**다른 버전의 파이썬을 설치한다.**


프로그래밍을 배우기 위해 파이썬3가 필요하지만 파이썬을 업데이트 하면서 파이썬 2.7 환경을 지우고 싶지 않다고 하자.
snakes라는 명칭의 새로운 환경을 생성해 활성화 할 수 있다.
또한 아래와 같이 최신 버전의 파이썬3를 설치할 수 있다.:

.. code::

   conda create --name snakes python=3

* 리눅스, OS X: ``source activate snakes``
* 윈도우:  ``activate snakes``

팁: 재미있지는 않지만 위와 같은 환경의 명칭을 "python3" 처럼 기술적으로 짓는 것이 좋다.

**환경이 추가되었는지 확인한다.**

snakes 환경이 추가되었는지 확인하기 위해 아래 커맨드를 입력한다.:

.. code::

   conda info --envs

콘다는 모든 환경의 리스트를 보여준다. 현재 환경은 프롬프트 상단에 괄호(소괄호 또는 대괄호)와 함께 나타난다.

.. code::

   (snakes)

**새로운 환경의 파이썬 버전을 확인한다.**

snakes 환경이 파이썬3를 사용하는지 확인한다.:

.. code::

   python --version

**다른 버전의 파이썬을 사용한다.**

다른 버전의 파이썬을 사용하는 새로운 환경으로 전환하려면 이를 간단히 활성화 하면 된다. 디폴트인 파이썬 2.7로 돌아가자.:

* 리눅스, OS X: ``source activate snowflakes``
* 윈도우:  ``activate snowflakes``

**환경의 파이썬 버전을 확인한다.**

snowflakes 환경이 콘다와 함께 설치된 파이썬 버전을 사용하는지 확인한다.:

.. code::

   python --version

**현재 환경을 비활성화 한다.**

snowflakes 환경에서의 작업을 마쳤다면 이를 비활성화 하고 이전 상태의 경로로 돌아간다.

* 리눅스, OS X: ``source deactivate``
* 윈도우: ``deactivate``

.. _managing-pkgs:

4. 패키지
--------------------

이제 패키지를 사용해보자. 환경을 생성할 때 이미 몇개의 패키지가 설치되었다. (Astroid, Babel, 특정 버전의 파이썬)
어떤 패키지를 가지고 있는지 확인하고 패키지들이 사용 가능한지 보자. 특정 패키지를 찾고 설치한다.
그리고 Anaconda.org 저장소에서 특정 패키지를 찾고 설치한다. 콘다 대신 pip 를 사용해 패키지를 더 설치하고 상업용 패키지도 설치한다.

**환경에 설치된 모든 패키지와 버전을 확인한다.**

어떤 버전의 파이썬과 다른 프로그램들이 환경에 설치 되었는지 확인한다. 패키지를 삭제하거나 추가한 후에 이를 확인할 수도 있다.
터미널창에 아래 커맨드를 입력한다.:

.. code::

   conda list

**conda install 커맨드로 설치 가능한 패키지를 확인한다.**

conda install 로 설치 가능한 패캐지는 http://docs.continuum.io/anaconda/pkg-docs.html 에서 볼 수 있다.
파이썬 버전에 따라 분류된다.

**패키지를 검색한다.**

먼저 원하는 패키지가 conda 로 설치 가능한지 확인한다.:

.. code::

   conda search beautifulsoup4

위 커맨드로 패키지가 나타나면 설치 가능한 것이다.

**새로운 패키지를 설치한다.**

현재 환경에 Beautiful Soup 를 설치한다. 아래와 같이 conda install 을 사용한다.:

.. code::

   conda install --name bunnies beautifulsoup4

주의: 콘다에 환경 명칭을 알려주어야 한다. (``--name bunnies``) 명칭을 입력하지 않으면 현재 환경에 설치된다.

bunnies 환경을 활성화 하고 conda list 로 패키지가 설치 되었는지 보자.:

* 리눅스, OS X: ``source activate bunnies``
* 윈도우:  ``activate bunnies``

모든 운영 체제에서:

.. code::

   conda list

**Anaconda.org 로부터 패키지를 설치한다.**

conda install 로 설치할 수 없는 패키지는 Anaconda.org 를 본다.
Anaconda.org 는 공개 저장소와 개인 저장소 모두를 위한 패키지 관리 서비스다.
아나콘다와 미니콘다와 같이 Anaconda.org 는 Continum Analytics 제품이다.

팁: 파일을 다운로드 하기 위해 Anaconda.org 에 등록할 필요는 없다.

Anaconda.org 로부터 현재 환경에 다운로드 하기 위해 패키지의 전체 URL 을 입력해 Anaconda.org 를 채널로 지정해야 한다.

브라우저에서 http://anaconda.org 로 간다. “bottleneck” 이라는 패키지를 찾고 있다.
“Search Anaconda Cloud” 라는 박스가 상단 좌측에 있다. “bottleneck” 을 입력해 검색한다.

Anaconda.org 에서 사용 가능한 “bottleneck” 카피가 많이 존재하지만 우리는 가장 많이 다운로드 된 카피가 필요하다.
다운로드 횟수로 정렬해 최상단의 것을 클릭한다.

패키지명을 클릭함으로써 가장 많이 다운로드 된 버전을 선택한다.
Anaconda.org 세부사항 페이지로 들어가면 다운로드를 위한 커맨드를 볼 수 있다.:

.. code::

   conda install --channel https://conda.anaconda.org/pandas bottleneck


**패키지가 다운로드 되었는지 확인한다.**

.. code::

   conda list

**pip 로 패키지를 설치한다.**

콘다나 Anaconda.org 로 설치할 수 없는 패키지는 대체로 pip 를 통해 설치한다.

팁:  pip는 패키지 관리자이기 때문에 환경을 관리할 수는 없다.
pip는 콘다와 달리 파이썬을 패키지로 취급하지 않기 때문에 파이썬을 업데이트 하는데 사용할 수 없다.
콘다 또는 pip에서만 다운로드 할 수 있는 패키지가 있기 때문에 아나콘다와 미니콘다는 pip와 콘다 모두를 포함한다.

프로그램을 넣고자 하는 환경을 활성화 하고 "See" 라는 프로그램을 pip 를 사용해 설치한다.:

* 리눅스, OS X: ``source activate bunnies``
* 윈도우:  ``activate bunnies``

모든 운영 체제에서:

.. code::

   pip install see

**pip 설치를 확인한다.**

See 가 설치 되었는지 확인한다.:

.. code::

   conda list

**상업 패키지를 설치한다.**

상업 패키지를 설치하는 것은 콘다와 다른 패키지를 설치하는 것과 동일하다.
아래 예시와 같이 Continuum 의 상업용 패키지 IOPro 를 설치하고 삭제해 보자.
IOPro 는 파이썬 처리의 속도를 향상시킨다.:

.. code::

   conda install iopro

팁: 학문적인 용도를 제외하고 무료 체험판은 30일 이후에 만료된다.

이제 콘다, Anaconda.org, pip 를 사용해 오픈소스 또는 상업용 패키지를 설치하고 확인할 수 있다.

.. _remove-pkgs-envs-conda:

5. 패키지, 환경, 콘다 삭제
--------------------------------------------

원한다면 하나 이상의 테스트 패키지, 환경 또는 콘다를 삭제함으로써 테스트 드라이브를 마치자.


**패키지 삭제**

상업용 패키지 IOPro 를 삭제하기로 정했다고 하자. 아래 커맨드로 bunnies 환경으로 부터 IOPro 를 삭제할 수 있다.:

.. code::

   conda remove --name bunnies iopro

**프로그램이 삭제 되었는지 확인한다.**

conda list 로 확인한다.:

.. code::

   conda list

**환경 삭제**

snakes 환경이 필요 없어졌다고 하자. 아래 커맨드를 입력한다.:

.. code::

   conda remove --name snakes --all

**환경이 삭제 되었는지 확인한다.**

아래 커맨드로 확인한다.:

.. code::

   conda info --envs

이제 환경 리스트에서 snakes 를 볼 수 없다. 삭제 되었음을 확인했다.

**콘다 삭제**

* 리눅스, OS X:

아나콘다 또는 미니콘다 설치 디렉토리를 삭제한다.:

.. code::

   rm -rf ~/miniconda OR  rm -rf ~/anaconda

* 윈도우:  환경 관리자에서 “Add or remove Program,” 를 클릭. “Python 2.7 (Anaconda)” 또는 “Python 2.7 Miniconda)” 클릭해 프로그램을 삭제한다.


**참고 자료**

* conda 커맨드를 위한 완전한 문서는 커맨드 뒤에 ``-h`` 를 입력한다.
  예를 들어 conda update 라면 ``conda update -h`` 커맨드이다.
* 전체 문서: 	https://conda.io/docs/
* 치트 시트: :doc:`/using/cheatsheet`
* FAQs: 				http://docs.continuum.io/anaconda/faq.html and :doc:`/faq_ko`
* 무료 지원:	 https://groups.google.com/a/continuum.io/forum/#!forum/anaconda
* 과금 지원 옵션:	http://continuum.io/support
* `Continuum Analytics Training & Consulting <http://continuum.io/contact-us>`_ : Continuum Analytics 은 파이썬 트레이닝 과정을 제공한다. 우리의 교육 철학은 실질적인 문제를 해결하면서 배우는 것이 최선의 방법이라는 것이다. 교육 과정은 개인에게는 여러 사이트로부터 온라인으로 제공되며 직장에서 인하우스로 제공되기도 한다. 과학과 비즈니스 데이터를 위한 연구, 관리, 시각화를 위한 컨설팅과 최신 하드웨어와 GPU에서의 처리 과정을 위한 최적화를 제공한다.
offers Python training courses. Our teaching philosophy is that the best way to learn is with hands-on experience to real world problems. Courses are available to individuals online, at numerous sites, or in-house at your place of business. We also offer consulting services for the analysis, management and visualization of scientific and business data or optimizing your processing workflows on modern hardware and GPUs.
