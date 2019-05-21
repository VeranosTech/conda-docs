=================
 트러블 슈팅
=================

목차:

#. :ref:`permission-denied`
#. :ref:`fix-broken-conda`
#. :ref:`conda-claims-installed`
#. :ref:`DistributionNotFound`
#. :ref:`unknown-locale`
#. :ref:`AttributeError-getproxies`
#. :ref:`shell-command-location`
#. :ref:`wrong-python`
#. :ref:`unsatisfiable`
#. :ref:`version-from-channel`

.. _permission-denied:

문제:  설치 도중에 권한이 거부된 경우
===============================================

umask 커맨드는 새로 생성된 파일의 권한이 어떻게 설정되는지 결정하는 mask 설정을 지정한다.
만약 사용자가 077 과 같이 매우 제한적인 umask 값을 갖는다면 "권한 거부" 에러가 나타날 수 있다.

해결책:  콘다 커맨드를 호출하기 전에 덜 제한적인 umask 를 설정한다.
----------------------------------------------------------------------

콘다는 사용자 영역 툴로 고안되었지만 사용자는 때때로 전역 환경에서 콘다를 사용해야 한다.
제한적인 파일 권한이 설정되어 있을 때가 이에 해당한다.
콘다는 시스템의 다른 사용자에 의해 읽혀야 하는 파일을 설치할 때 링크를 생성한다.

사용자 스스로가 파일과 디렉토리에 대한 전체 권한을 가지면서 다른 사용자가 접근하는걸 막고 싶다면
설치하기 전에 umask 를 007 로 설정하고 콘다를 설치한다. 그리고 umask 를 원래 값으로 되돌리면 된다. 아래와 같이:

   .. code-block:: bash

      $ umask 007
      $ conda install
      $ umask 077


umask 에 대한 자세한 정보는 `http://en.wikipedia.org/wiki/Umask <http://en.wikipedia.org/wiki/Umask>`_ 를 방문하라.

.. _fix-broken-conda:

문제: 콘다가 손상되었고 현재의 설치를 날리지 않고 고치고자 하는 경우
============================================================================================

콘다 에러를 겪고 있고 미니콘다를 재설치해 해결하고자 한다. 하지만 이를 시도했을 때
미니콘다(또는 아나콘다)가 이미 설치되어 있기 때문에 더 진행할 수 없다는 에러가 나타났다.
설치를 강제하고자 한다.

해결책: -f (force) 옵션을 사용해 미니콘다를 설치한다.
---------------------------------------------------------

`Miniconda download page <https://conda.io/miniconda.html>`_ 에서 사용자의 컴퓨터 운영체제에 맞는
미니콘다를 다운 받아 설치할 수 있다. 아래와 같이 ``-f`` 옵션으로 설치를 강제한다.:

.. code-block:: bash

    bash Miniconda3-latest-MacOSX-x86_64.sh -f

주의: 적절한 파일명과 운영체제에 맞는 버전으로 대체한다.

주의: 현재 설치된 곳과 동일한 경로에 설치하여 코어 콘다 파일을 덮어쓰고 새로운 폴더에 사본을 설치하지 않아야 한다.


.. _conda-claims-installed:

문제: 콘다에 이미 설치된 패키지라고 나오지만 존재하지 않는 경우
=========================================================================

종정 콘다가 이미 설치된 패키지라고 하지만 존재하지 않을 수 있다.
예를 들어 파이썬 패키지라면 ImportError 가 나타난다.

이러한 문제의 원인이 될 수 있는 것이 몇가지 있다.:

해결책: 패키지와 동일한 콘다 환경에 있는지 확인한다.
---------------------------------------------------------------------------

``conda info`` 는 현재 어떤 환경이 활성화 되었는지 알려준다. ("디폴트 환경"에서)
아래와 같이 실행하면 파이썬을 올바른 환경에서 사용하고 있는지 확인할 수 있다.:

.. code:: python

   import sys
   print(sys.prefix)

해결책: 파이썬 패키지라면 ``PYTHONPATH`` 또는 ``PYTHONHOME`` 변수를 설정하지 않았는지 확인한다.
---------------------------------------------------------------------------------------------------------

``conda info -a`` 커맨드는 위 환경 변수값들을 알려준다.

위 환경 변수들은 파이썬이 표준 경로가 아닌 다른 곳에서 파일을 불러오게 한다.
위 변수들의 활용 사례들은 대부분 콘다 환경에는 해당하지 않는다. 위 환경 변수들이 설정되지 않았을 때 콘다가 가장 잘 작동한다.
또한 위 환경 변수들로 인해 파이썬이 잘못된 버전 또는 손상된 라이브러리 버전을 가져오는 것이 일반적으로 발생하는 문제이다.

현재 터미널 세션에서 위 변수들을 일시적으로 취소하려면 ``unset PYTHONPATH`` 를 실행한다.
영구적으로 취소하고 싶다면 bash 에서는 ``~/.bashrc``, ``~/.bash_profile``, ``~/.profile`` 파일,
zsh 에서는  ``~/.zshrc`` 파일, 윈도우의 PowerShell 에서는 ``$PROFILE`` 의 파일 출력 내부의 라인을 확인하자.

해결책: 파이썬 패키지라면, 모든 위치 특정 디렉토리를 제거한다.
---------------------------------------------------------------------

문제가 파이썬 패키지일 경우에 위치 특정 파일로 인한 문제일 수 있다.
일반적으로 위치 특정 파일은 유닉스 운영체제의 ``~/.local`` 디렉토리에 위치한다.
사이트 특정 패키지에 대한 완전한 기술은 `PEP 370 <http://legacy.python.org/dev/peps/pep-0370/>`_ 를 보자.
``PYTHONPATH`` 가 설정된 것과 같이 파이썬이 ``~/.local``  디렉토리로부터 패키지를 가져오면서
위와 같은 문제가 나타날 수 있다. 권장하는 해결책은 위치 특정 디렉토리를 삭제하는 것이다.

해결책: C 라이브러리라면, 리눅스의 ``LD_LIBRARY_PATH``, OS X의 ``DYLD_LIBRARY_PATH`` 환경변수를 재설정한다.
---------------------------------------------------------------------------------------------------------------------------

이 환경 변수들은 파이썬의 ``PYTHONPATH`` 와 유사한 기능을 한다. 변수가 설정되어 있으면
라이브러리를 콘다 환경으로부터 가져오지 않고 변수에 지정된 위치로부터 로드한다.
파이썬에서와 같이 위 환경 변수들의 활용 사례들은 대부분 콘다 환경에는 해당하지 않는다.
따라서 이 변수들이 설정되어 있다면 재설정 하는 것을 권장한다.
``conda info -a`` 커맨드로 이 변수들이 어떻게 설정되어 있는지 확인할 수 있다.
(관련 운영체제 상에.)

Resolution: 때때로 설치된 패키지에 오류가 생길 수 있다.
--------------------------------------------------------------------

콘다는 패키지 디렉토리의 패키지를 풀고 이를 환경과 하드 링크함으로써 작동한다.
종종 왜인지 이 과정이 충돌하고 패지지를 사용하는 모든 환경을 망가뜨린다.
동일한 파일들이 매번 하드 링크되기 때문에 추가적인 환경도 문제가 생길 수 있다.

**conda install -f 커맨드는 패기지를 보관 해제하고 다시 링크한다.**
이 커맨드는 패키지에 md5 검증을 실행한다. (보통 md5 검증이 다르게 나타난다면
사용자의 채널이 변경되었고 동일한 명칭, 버전, 빌드 번호를 갖는 다른 패키지가 존재하기 때문이다.)
이 때 이미 이 패키지를 설치한 모든 환경으로의 링크가 망가지기 때문에 기존 환경에도 패키지를 다시 설치해 주어야 한다.
환경의 갯수가 많아 ``conda install -f`` 를 여러번 실행해야 한다면
이는 많은 디스크 용량을 사용해야 함을 의미한다. ``conda install`` 를 강제하는 ``-f`` 플래그는
``--no-deps`` 를 내포하고 있으므로 ``conda install -f package`` 는 패키지의 하위 요소는 재설치하지 않는다.

.. _DistributionNotFound:

문제: pkg_resources.DistributionNotFound: conda==3.6.1-6-gb31b0d4-dirty
========================================================================

해결책: 콘다 강제 재설치
---------------------------------

콘다 개발 버전을 사용하기에 유용한 방법은 `콘다 git 저장소 <https://github.com/conda/conda>`_ 의 체크아웃으로
``python setup.py develop`` 커맨드를 실행하는 것이다. 콘다의 정기 업데이트를 받지 못하기 때문에
``git pull`` 을 자주 사용하지 않는다면 un-develop 하는 것이 나을 수 있다.
일반적인 방법으로는 ``python setup.py develop -u`` 를 실행한다..

그러나 이 커맨드는 ``conda`` 스크립트 자체를 대체하진 않는다.
``conda`` 를 사용헤 다른 패키지들을 재설치 할 수 있기 때문에 그리 중요한 일은 아니지만
콘다가 설치되었다면 ``conda`` 는 사용할 수 없다.

해결책은 콘다 git 저장소에서 ``./bin/conda`` 실행을 사용해 콘다를 강제 재설치 하는 것이다.
``./bin/conda install -f conda`` 커맨드와 같이 하면 된다.
콘다가 최신 버전인지는 ``conda info`` 로 확인할 수 있고 git 체크아웃으로는 불가능하다.
(버전은 어떤 해시도 포함해선 안된다.)

.. _unknown-locale:

문제: OS X 에서 ``ValueError unknown locale: UTF-8``
===================================================

해결책: 터미널 설정에서 "set locale environment variables on startup" 설정을 해제한다.
----------------------------------------------------------------------------------------------

이는 OS X 터미널 어플리케이션의 버그로 특정 로케일에서만 나타난다. (지역/언어의 조합)
/Applications/Utilities 에서 터미널을 열고 "Set locale environment variables on startup" 박스의 체크를 해제한다.

.. image:: help/locale.jpg

이 방법은 ``LANG`` 환경 변수를 비우게 되고 터미널이 사용자의 로케일에 맞지 않는 설정을 사용하게 할 수 있다.
터미널의 ``locale`` 커맨드는 어떤 설정이 사용되고 있는지 보여준다.
올바른 언어를 사용하기 위해 bash 프로파일에 라인을 추가한다. (일반적으로 ``~/.profile``)

.. code-block:: bash

   export LANG=your-lang

``your-lang`` 을 사용자의 언어에 알맞은 로케일 지정자로 대체한다.
``locale -a`` 는 모든 지정자를 보여준다. 예를 들어, 언어 코드 US English는 ``en_US.UTF-8`` 이다.
로케일은 변환이 가능할 때 사용될 변환과 날짜, 통화, 십진법이 포맷되는 방식에 영향을 준다.


.. _AttributeError-getproxies:

문제: ``AttributeError`` 또는 ``getproxies`` 누락
===================================================

``conda update ipython`` 와 같은 커맨드를 실행할 때,
``AttributeError: 'module' object has no attribute 'getproxies'`` 를 볼 수 있다.

해결책: ``requests`` 를 업데이트하고 ``PYTHONPATH`` 가 지정되지 않았는지 확인한다.
---------------------------------------------------------------------

구버전의 ``requests`` 또는 ``PYTHONPATH`` 환경 변수가 설정되었을 때 나타나는 문제이다.

``conda info -a`` 는 ``requests`` 버전과 ``PYTHONPATH`` 같은 다양한 환경 변수를 보여준다.

``requests`` 버전은 ``pip install -U requests`` 로 업데이트 할 수 있다.

윈도우 ``PYTHONPATH`` 는 환경 변수 설정에서 취소할 수 있다.
OS X 와 리눅스는 bash 프로파일에서 제거하거나 쉘을 다시 시작함으로써 취소한다.


.. _shell-command-location:

문제:  잘못된 위치에서 쉘 커맨드 사용
===============================================

콘다 환경에서 커맨드를 실행할 때 콘다가 올바른 패키지 실행 파일에 접근하지 못한다.

해결책:  환경을 재활성화 하거나 ``hash -r`` (bash) 또는 ``rehash`` (zsh) 를 실행한다.
-------------------------------------------------------------------------------------------

bash 와 zsh 모두 커맨드를 입력하면 쉘은 커맨드를 찾을 때까지 ``PATH`` 의 경로들을 일일이 검색한다.
일단 커맨드를 찾으면 동일한 커맨드가 입력되었을 때 ``PATH`` 경로를 다시 검색하지 않도록
커맨드 위치를 캐싱한다. 이를 쉘 용어로 해싱(hashing) 이라 한다.

문제는 콘다가 프로그램을 설치하기 전에 ``PATH`` 상의 다른 위치에 있는 것을 해시 한 커맨드를 실행했을 때이다.
이 때 ``conda install`` 를 사용해 프로그램을 설치해도 쉘은 여전히 이전에 해시한 것을 가지고 있다.

``source activate`` 를 실행하면 콘다는 자동으로 ``hash -r`` (bash) 또는 ``rehash`` (zsh) 를 실행해
해시된 커맨드를 삭제해 콘다가 ``PATH`` 상의 새로운 경로를 검색하게 한다.
그러나 ``conda install`` 가 실행 되었을 때는 기존 해시를 삭제할 방법이 없다.
(커맨드는 반드시 쉘 내부에서 자체적으로 실행되어야 한다. 이는 커맨드를 직접 작성하거나 커맨드를 포함하는 파일을 가져와야 한다는 것을 의미한다.)

이 문제는 사용자가 환경을 활성화 하거나 루트 환경을 사용할 때만 발생하므로 상대적으로 드문 문제이다.
어딘가로부터 커맨드를 실행하면 콘다는 프로그램을 설치하고 이를 다시 실행할 때는
``source activate`` 나 ``source deactivate`` 없이 프로그램을 실행하려 한다.

``type command_name`` 커맨드는 항상 무엇이 실행되고 있는지를 정확히 보여준다.
그러한 점에서 해시된 커맨드를 무시하고 ``PATH`` 를 바로 검색하는 ``which command_name`` 커맨드보다 낫다.
``hash -r`` (bash) 또는 ``rehash`` (zsh) 는 해시를 재설정한다. ``source activate`` 를 사용해도 된다.

.. _wrong-python:

문제:  프로그램이 시스템 파이썬이 아닌 콘다 파이썬을 호출해 발생하는 문제
========================================================================

파이썬을 실행하는 프로그램은 이전엔 시스템 파이썬을 호출하지만 아나콘다 또는 미니콘다를 설치하면
루트 콘다 환경에서 파이썬을 호출한다. 따라서 루트 콘다 환경에 없는 특정 설정이나 하위 요소로 인해
시스템 파이썬에 의존하는 프로그램은 충돌할 수 있다. 예를 들어 리눅스 민트의 Cinnamon 데스크탑 환경
사용자는 이러한 충돌을 경험한다.

해결책: ``PATH`` 변수를 수정한다.
-------------------------------------------------

``.bash_profile`` 과 ``.bashrc`` 파일을 수정해 ``~/miniconda3/bin`` 같은
콘다 바이너리 디렉토리가 ``PATH`` 환경 변수에 추가되지 않도록 한다.
``~/miniconda3/bin/conda`` 처럼 전체 경로을 사용하면
``conda`` ``activate`` 와 ``deactivate`` 가 여전히 실행중일 수 있다.

심볼릭 링크로 ``conda`` ``activate`` 와 ``deactivate`` 로의 폴더를 만들고
사용자의 ``.bash_profile`` 또는 ``.bashrc`` 을 수정해 생성된 폴더를 ``PATH`` 에 추가할 수 있다.
이제 파이썬을 실행하면 시스템 파이썬을 불러오지만 콘다 커맨드를 실행해
``source activate MyEnv``, ``source activate root``, ``source deactivate`` 는 정상적으로 작동한다.

``source activate`` 를 실행해 어떤 환경을 활성화 하고 (``source activate root`` 포함)
파이썬을 실행하면 활성화된 콘다 환경으로부터 파이썬을 불러온다.

.. _unsatisfiable:

문제: ``UnsatisfiableSpecifications`` 에러
============================================

모든 콘다 설치 사양을 만족시키지 못한 경우

예를 들어, ``conda create -n tmp python=3 wxpython=3`` 는 ``UnsatisfiableSpecifications`` 에러를 야기한다.
이는 wxPython 3 가 파이썬 2.7에 의존해 파이썬 3를 설치하기 위한 사양과 wxPython 3의 사양이 충돌하기 때문이다.

해결책: 설치 요청에서 충돌을 해결한다.
---------------------------------------------------------

콘다에 부적절한 요청이 들어오면 콘다는 아래와 같은 메시지를 보여준다.::

    The following specifications were found to be in conflict:
    - python 3*
    - wxpython 3* -> python 2.7*
    Use "conda info <package>" to see the dependencies for each package.

위 메시지는 wxpython 3 의 설치 사양이 Python 2.7 설치에 의존해 파이썬 3를 위한 설치 사양과 충돌함을 알려준다.

"conda info wxpython" 또는 "conda info wxpython=3" 을 사용해 패키지와 하위 요소에 대한 정보를 볼 수 있다.::

    wxpython 3.0 py27_0
    -------------------
    file name   : wxpython-3.0-py27_0.tar.bz2
    name        : wxpython
    version     : 3.0
    build number: 0
    build string: py27_0
    channel     : defaults
    size        : 34.1 MB
    date        : 2014-01-10
    fn          : wxpython-3.0-py27_0.tar.bz2
    license_family: Other
    md5         : adc6285edfd29a28224c410a39d4bdad
    priority    : 2
    schannel    : defaults
    url         : https://repo.continuum.io/pkgs/free/osx-64/wxpython-3.0-py27_0.tar.bz2
    dependencies:
        python 2.7*
        python.app

각각의 패키지의 하위 요소들을 보면 설치 요청이 충돌한 이유를 알 수 있을 것이다.
이제 이를 만족시켜 충돌을 해결하면 된다. 이번 예시에서는 wxPython 을 파이썬 2.7과 설치하면 된다.::

    conda create -n tmp python=2.7 wxpython=3

.. _version-from-channel:

문제: 채널로부터 특정 버전을 설치하는 경우
===============================================

파이썬 3.4와 파이썬 ``cx_freeze`` 모듈을 설치할 필요가 있을 수 있다.
먼저 파이썬 3.4 환경을 생성한다.:

.. code-block:: bash

   conda create -n py34 python=3.4

이 환경을 사용해 첫번째 시도를 한다.:

.. code-block:: bash

   conda install -n py34 cx_freeze

그러나 위 코드 블럭을 실행했을 때 아래와 같은 에러가 나타날 수 있다. (사용중인 플랫폼에서 위 코드가 작성됐을 때)::

   Using Anaconda Cloud api site https://api.anaconda.org
   Fetching package metadata .........
   Solving package specifications: .
   Error: Package missing in current osx-64 channels:
   - cx_freeze

   You can search for packages on anaconda.org with

     anaconda search -t conda cx_freeze

위 에러는 ``cx_freeze`` 를 찾을 수 없고 최소한 *디폴트* 패키지 채널엔 없다는 의미이다. 그러나 커뮤티니 생성 버전 중 사용 가능한 것이 있을 수 있다.
그렇다면 위에 나열된 정확한 커맨드로 유효한 버전을 찾으면 된다.

.. code-block:: bash

   $ anaconda search -t conda cx_freeze
   Using Anaconda Cloud api site https://api.anaconda.org
   Run 'anaconda show <USER/PACKAGE>' to get more details:
   Packages:
        Name                      |  Version | Package Types   | Platforms
        ------------------------- |   ------ | --------------- | ---------------
        inso/cx_freeze            |    4.3.3 | conda           | linux-64
        pyzo/cx_freeze            |    4.3.3 | conda           | linux-64, win-32, win-64, linux-32, osx-64
                                             : http://cx-freeze.sourceforge.net/
        silg2/cx_freeze           |    4.3.4 | conda           | linux-64
                                             : create standalone executables from Python scripts
        takluyver/cx_freeze       |    4.3.3 | conda           | linux-64
   Found 4 packages

위 예시에서 우리가 시도할 수 있는 네가지 ``cx_freeze`` 가 있다.
모두 공식 지원이 아니거나 Continuum 에 승인되지 않았지만 콘다 커뮤니티의 구성원들이 여러 귀중한 패키지를 제공한다.
여론을 참고하고 싶다면 `웹 인터페이스 <https://anaconda.org/search?q=cx_freeze>`_ 에 추가 정보가 제공된다.

.. figure:: images/package-popularity.png
   :alt: cx_freeze packages on anaconda.org

``pyzo`` 의 ``cx_freeze`` 가 가장 많이 다운로드 되었고 이 패키지를 선택해도 된다.
아래와 같이 커맨드 라인에 ``pyzo`` 의 채널을 명시하면 된다.:

.. code-block:: bash

   $ conda create -c pyzo -n cxfreeze_py34 cx_freeze python=3.4
   Using Anaconda Cloud api site https://api.anaconda.org
   Fetching package metadata: ..........
   Solving package specifications: .........

   Package plan for installation in environment /Users/ijstokes/anaconda/envs/cxfreeze_py34:

   The following packages will be downloaded:

       package                    |            build
       ---------------------------|-----------------
       cx_freeze-4.3.3            |           py34_4         1.8 MB
       setuptools-20.7.0          |           py34_0         459 KB
       ------------------------------------------------------------
                                              Total:         2.3 MB

   The following NEW packages will be INSTALLED:

       cx_freeze:  4.3.3-py34_4
       openssl:    1.0.2h-0
       pip:        8.1.1-py34_1
       python:     3.4.4-0
       readline:   6.2-2
       setuptools: 20.7.0-py34_0
       sqlite:     3.9.2-0
       tk:         8.5.18-0
       wheel:      0.29.0-py34_0
       xz:         5.0.5-1
       zlib:       1.2.8-0

이제 파이썬 3.4와 ``cx_freeze`` 로 생성된 소프트웨어 환경 샌드박스를 만들었다.
