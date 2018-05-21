============================================
.condarc 콘다 설정 파일 사용
============================================

.. contents::
   :local:
   :depth: 2


.. _config-overview:

개요
========

``.condarc`` 콘다 설정 파일은 선택 런타임 설정 파일이다.
고급 사용자는 이 파일로 패키지를 검색할 채널,프록시 설정,환경 디렉토리와 같은 콘다의 여러 요소들을 설정할 수 있다.

``.condarc`` 파일은 기본 설정에는 포함되지 않지만
``conda config`` 명령 파일을 처음 실행했을 때 사용자의 홈 디렉토리에 자동으로 만들어진다.

``.condarc`` 파일이 루트 환경에 있을 수도 있다.
이 경우에 루트 환경의 ``.condarc`` 파일이 홈 디렉토리의 ``.condarc`` 파일보다 우선시 된다.

주의: ``.condarc`` 파일이 관리자 제어 설치에 사용되면 사용자 설정은 무시된다.
자세한 정보는 :doc:`admin-multi-user-install_ko`\ 에 있다.

``.condarc`` 설정 파일은 간단한 `YAML 문법 <http://docs.ansible.com/YAMLSyntax.html>`_\ 을 따른다.

``.condarc`` 파일은 다음을 포함한 여러 변수를 설정할 수 있다.

* 콘다가 패키지를 찾는 곳을 설정한다.

* 콘다의 프록시 서버를 사용 여부와 사용법을 설정한다.

* 콘다가 확인된 환경을 나열할 곳을 설정한다.

* 배쉬 프롬프트를 현재 활성화된 환경 이름으로 업데이트할지 설정한다.

* 사용자가 빌드한 패키지를 `Anaconda.org <http://anaconda.org>`_\ 에 업데이트할지 결정한다.

* 새 환경이 기본 패키지나 기능을 포함할지 결정한다.

``conda config`` 명령을 사용하거나 텍스트 편집기로 ``.condarc`` 파일을 생성해
홈 디렉토리나 루트 디렉토리에 저장하면 ``.condarc`` 파일을 만들고 수정할 수 있다.

예시:

.. code-block:: yaml

  conda config --add channels conda-forge

:doc:`.condarc 파일 예시 <sample-condarc_ko>`\ 를 받아 편집기로
수정해 사용자의 홈 디렉토리나 루트 디렉토리에 저장해도 된다.

``.condarc`` 파일을 직접 수정하거나 ``conda config --set`` 명령을 사용해 설정 옵션을 정할 수 있다.

예시: 다음을 실행해 auto_update_conda 옵션을 ``False``\ 로 설정한다. ::

  conda config --set auto_update_conda False

conda config 명령의 전체 목록은 `커맨드 레퍼런스 <../../commands/conda-config>`\ 를 본다.
터미널이나 아나콘다 프롬프트에서 ``conda config --help``\ 를 실행해 동일한 목록을 볼 수 있다.

팁: 콘다는 내부 설정을 대신하는 외부 패키지의 :doc:`탭 자동 완성 <enable-tab-completion>`\ 을 지원하다.

더 자세한 정보는 `콘다 고급 기능 설정 파트 1 <http://continuum.io/blog/advanced-conda-part-1#configuration>`_\ 에 있다.


일반 설정
=====================

.. _config-channels:

채널 경로 (channels)
----------------------------

``.condarc`` 파일에 채널 경로를 나열하면 콘다 기본 채널을 무시하고 파일에 나열된 채널만을 순서대로 검색한다.

``defaults``\ 를 사용하면 모든 기본 채널이 자동으로 포함된다.
URL이 아닌 채널을 입력하면 Anaconda.org의 사용자명으로 해석된다.
:ref:`set-ch-alias`\ 에 나온대로 channel_alias을 수정하면 이 기능을 변경할 수 있다.
기본 설정은 ``defaults``\ 다.

예시:

.. code-block:: yaml

  channels:
    - <anaconda_dot_org_username>
    - http://some.custom/channel
    - file:///some/local/directory
    - defaults

환경의 루트 디렉토리에 ``.condarc`` 파일을 두면 그 환경의 채널만을 선택할 수 있다.

예시: 파이썬3를 사용하는 미니콘다를 홈 디렉토리에 설치했고 환경 이름이 "flowers"라면 경로는 다음과 같다. ::

  ~/miniconda3/envs/flowers/.condarc


다른 채널 허용하기 (allow_other_channels)
-------------------------------------------

시스템 레벨 ``.condarc`` 파일은 허용되는 채널 모음을 지정할 수 있고
이를 통해 사용자가 allow_other_channels 불리언 플래그로 다른 채널로부터 패키지를 설치하는 것을 허용할 수 있다.
기본은 ``True``\ 다.

allow_other_channels이 ``False``\ 로 설정되면 시스템 ``.condarc`` 파일에 지정된 채널만이 허용된다.

.. code-block:: yaml

  allow_other_channels: False

allow_other_channels를 ``True``\ 로 설정하거나 지정하지 않으면 각 사용자는
기본 채널이나 사용자가 로컬 ``.condarc`` 파일에 지정한 채널에 접근한다.
allow_other_channels를 ``False``로 설정했을 때 사용자가 다른 채널을 지정하면 그 채널은 차단되고
채널이 차단되었다는 메세지가 보고된다. 자세한 정보는 :ref:`admin-inst`\ 에 있다.

시스템 ``.condarc`` 파일이 channel_alias를 지정하면 사용자의 ``.condarc`` 파일에 설정된 모든 채널 별칭은 무시된다.,
자세한 정보는 :ref:`channel-alias`\ 에 있다.

기본 채널 (default_channels)
-----------------------------------

일반적으로 기본 채널은 `repo.continuum.io <http:repo.continuum.io>`_\ 에 있는
여러 채널을 가리키지만, default_channels를 설정하면 새로운 기본 채널 목록이 지정된다.
이 기능은 특히 에어갭(air gap)이나 엔터프라이즈 설치에 유용하다.

.. code-block:: yaml

  default_channels:
    - <anaconda_dot_org_username>
    - http://some.custom/channel
    - file:///some/local/directory

콘다 자동 업데이트 (auto_update_conda)
----------------------------------------------

auto_update_conda가 ``True``\ 면 사용자가 루트 환경에 패키지를 설치하거나 업데이트할 때마다 콘다도 업데이트된다.
``False``\ 로 설정하면 콘다는 사용자가 수동으로 ``conda update`` 명령을 입력할 때만 업데이트된다.
기본은 ``True``\ 다.

예:

.. code-block:: yaml

  auto_update_conda: False


항상 yes (always_yes)
-----------------------

설치와 같은 상황에서 진행을 물을 때마다 ``yes`` 옵션이 선택된다.
명령줄에 ``--yes`` 플래그를 추가하는 것과 같다.
기본은 ``False``\ 다.

예시:

.. code-block:: yaml

  always_yes: True


채널 URL 보여주기 (show_channel_urls)
-------------------------------------

다운로드되는 것을 보여주거나 ``conda list``\ 를 사용했을 때 채널 URL이 나타난다.
기본은 ``False``\ 다.

예시:

.. code-block:: yaml

  show_channel_urls: True


커맨드 프롬프트 변경 (changeps1)
---------------------------------

``activate`` 명령을 사용했을 때 커맨드 프롬프트를 ``$PS1``\ 에서 활성화된 환경을 포함하는 것으로 바꾼다.
기본은 ``True``\ 다.

예시:

.. code-block:: yaml

  changeps1: False


pip를 파이썬 의존 요소로 추가 (add_pip_as_python_dependency)
-----------------------------------------------------------

pip,휠(wheel),셋업툴즈(setuptools)를 파이썬 의존 요소로 추가한다.
이 설정으로 파이썬이 설치될 때마다 pip,휠,셋업툴즈가 설치된다.
기본은 ``True``\ 다.

예시:

.. code-block:: yaml

  add_pip_as_python_dependency: False


pip 사용 (use_pip)
------------------------

``conda list``\ 로 패키지를 나열할 때 pip를 사용한다.
이 설정은 ``conda list`` 명령의 출력을 제외한 모든 콘다 명령과 기능에 영향을 주지 않는다.
기본은 ``True``\ 다.

예시:

.. code-block:: yaml

  use_pip: False


.. _config-proxy:

프록시 서버 하에서 콘다 사용 설정 (proxy_servers)
-------------------------------------------------------------

프록시 설정은 기본적으로 HTTP_PROXY, HTTP_PROXY 환경 변수 또는 시스템으로부터 가져온다.
proxy_servers를 설정하면 기본 설정을 덮어쓴다.

.. code-block:: yaml

  proxy_servers:
      http: http://user:pass@corp.com:8080
      https: https://user:pass@corp.com:8080

특정 스키마나 호스트를 위해 프록시를 부여하려면 scheme://hostname 형태를 키로 사용한다.
이 키는 주어진 스키마와 정확한 호스트명으로의 요청이 된다.

.. code-block:: yaml

  proxy_servers:
    'http://10.20.1.128': 'http://10.10.1.10:5323'

사용자명과 암호를 넣지 않거나 인증에 실패하면 콘다는 유저명과 암호를 요구한다.

암호가 특수 문자를 포함하면 위키피이다의 `퍼센트 예약 문자 <https://en.wikipedia.org/wiki/Percent-encoding#Percent-encoding_reserved_characters>`_\
에서 설명하는 대로 이스케이프해야 한다.

``http``\ 와 ``https``\ 를 혼동하지 않게 주의한다.


.. _SSL_verification:

SSL 인증 (ssl_verify)
-----------------------------

Cisco IronPort Web Security Appliance (WSA)와 같이 SSL 인증을 사용하는 프록시 하에서는
ssl_verify를 사용해 SSL 인증 설정을 덮어써야 한다.

기본인 ``True``\ 에서 SSL 인증이 사용되고 콘다는 SSL 연결을 위한 인증서를 확인한다.
``False``\ 로 설정하면 연결의 기본 보안이 비활성화되므로 권장하지 않는다.

.. code-block:: yaml

  ssl_verify: False

ssl_verify를 SSL 연결에 사용되는 인증서의 문자열 경로로 설정할 수 있다.

.. code-block:: yaml

  ssl_verify: corp.crt


오프라인 모드만 사용하기 (offline)
-----------------------------------------------

``file://`` 프로토콜을 사용하지 않는 채널 URL을 모두 걸러낸다.
기본은 ``False``\ 다.

예시:

.. code-block:: yaml

  offline: True


고급 설정
======================


소프트링크 허용 안함 (allow_softlinks)
---------------------------------------

allow_softlinks가 ``True``\ 면 콘다는 하드링크가 가능한 경우에만 하드링크를 사용한다.
패키지 캐시가 없는 다른 파일 시스템에 설치할 때와 같이 하드링크가 불가능하면 소프트링크(심볼릭링크)를 사용한다.

allow_softlinks가 ``False``\ 면 콘다는 하드링크가 가능하면 사용하고 하드링크가 불가능할 때는 파일을 복사한다.
특정 파일이 절대 소프트링크되지 않도록 지정하면 개별 패키지는 이 옵션을 무시할 수 있다. 자세한 정보는 :ref:`no-link`\ 에 있다.

기본은 ``True``\ 다.

예시:

.. code-block:: yaml

  allow_softlinks: False


.. _set-ch-alias:

.. _channel-alias:

채널 별칭 설정 (channel_alias)
-----------------------------------

``-c``\ 나 ``--channel`` 플래그로 채널 URL이 아닌 채널 이름을 줄 때
콘다는 channel_alias에 주어진 채널 이름을 붙인다.
기본 channel_alias 는 https://conda.anaconda.org/ 다.

예시: 아래 명령은 ::

  conda install --channel asmeurer <package>

다음 명령과 같다. ::

  conda install --channel https://conda.anaconda.org/asmeurer <package>

사용자의 레포지토리를 channel_alias로 설정할 수 있다.

예시: channel_alias를 https://yourrepo.com 에 있는 레포지토리로 설정한다.

.. code-block:: yaml

  channel_alias: https://your.repo/

윈도우에서는 URL 끝에 반들시 슬래시("/")가 있어야 한다.

예시: https://your.repo/conda/

channel_alias가 https://yourrepo.com 에 있는 레포지토리로 설정되면 다음 명령은 ::

  conda install --channel jsmith <package>

아래 명령과 동일하다. ::

  conda install --channel https://yourrepo.com/jsmith <package>


.. _config-add-default-pkgs:

기본으로 패키지 항상 추가 (create_default_packages)
--------------------------------------------------------

새 환경을 만들 때 기본으로 특정 패키지를 추가한다.
기본 패키지는 사용자가 생성하는 모든 환경에 설치된다.
명령에 ``--no-default-packages`` 플래그를 추가하면 이 옵션을 무시할 수 있다.
기본에서는 어떤 패키지도 기본으로 설치되지 않는다.

예시:

.. code-block:: yaml

  create_default_packages:
    - pip
    - ipython
    - scipy=0.15.0


기능 추적 (track_features)
-------------------------------

특정 기능을 기본으로 추척하게 한다. 기본에서는 어떤 기능도 추적하지 않는다.
다음과 같이 설정하면 mkl을 create_default_packages 목록에 추가하는 것과 비슷하다.

예시:

.. code-block:: yaml

  track_features:
    - mkl

의존 요소 업데이트 비활성화 (update_dependencies)
------------------------------------------------------

기본적으로 ``conda install``\ 는 주어진 패키지를 최신 버전으로 업데이트 하고,
그 패키지에 대한 의존 요구사항들을 설치한다. 그러나 만약 패키지가 필요로 하는 의존 요소들이
이미 설치돼 있다면, conda는 그 패키지들을 최신 버전으로 업데이트 하지 않는다.

이런 경우에, conda가 모든 의존 요소를 환경과 호환가능한 최신버전으로 업데이트 하게 만들고 싶으면,
update_dependencies를 ``True``\ 로 설정한다.

.. code-block:: yaml

   update_dependencies: True

주의: 콘다는 여전히 의존 요소 사양이 만족되었는지 확인한다.
따라서 몇몇 의존 요소가 업데이트 되거나 반대로 이 설정으로 인해
명령줄에 주어진 패키지가 최신 버전으로 업데이트되지 않을 수 있다.
명령줄에 버전을 지정하면 언제든 ``conda install numpy=1.9.3``\ 와
같이 주어진 버전의 패키지를 강제 설치할 수 있다.

환경의 특정 패키지의 업데이트만을 막고 싶다면 패키지를 고정하는 것이 나을 수 있다.
자세한 정보는 :ref:`pinning-packages`\ 에 있다.


특정 패키지 설치 금지 (disallow)
-----------------------------------------------------

특정 패키지의 설치를 금지한다.
기본 설정에서는 모든 패키지의 설치를 허용한다.

예시:

.. code-block:: yaml

  disallow:
    - anaconda


Anaconda.org 토큰을 추가해 자동으로 비공개 패키지 보기 (add_anaconda_token)
---------------------------------------------------------------------------------

채널 별칭이 Anaconda.org 또는 아나콘다 서버 GUI일 때
사용자가 자동으로 비공개 패키지를 보게 하는 시스템 설정을 지정할 수 있다.
Anaconda.org는 이전엔 binstar.org였다. 이 설정은 ``conda install anaconda-client``\ 로 설치되는
아나콘다 명령줄 클라이언트를 사용해 채널 URL로의 토큰을 자동으로 추가한다.

기본은 ``True``\ 다.

예시:

.. code-block:: yaml

  add_anaconda_token: False

주의: add_anaconda_token을 ``True``\ 로 설정해도 아나콘다 명령줄 클라이언트가 설치되어 있고
``anaconda login`` 명령으로 로그인 했을 때만 활성화된다.


환경 디렉토리 지정 (envs_dirs)
-------------------------------------------

환경이 위치할 디렉토리를 지정한다. 이 키가 설정되면 루트 접두어
``envs_dir``\ 가 명시적으로 포함되지 않는 한 사용되지 않는다.
이 키는 패키지 캐시의 위치도 결한다.

보통의 ``root_dir/pkgs``\ 가 사용되는 루트 디렉토리의 표준 ``envs`` 디렉토리가 아니라면,
``envs_dir``\ 로 설정한 위치에서 각 envs의 ``envs/pkgs``\ 가 pkgs 캐시로 사용된다.

예시:

.. code-block:: yaml

  envs_dirs:
    - ~/my-envs
    - /opt/anaconda/envs

CONDA_ENVS_PATH 환경 변수는 다음 설정을 덮어쓴다.

* 맥OS, 리눅스:
  ``CONDA_ENVS_PATH=~/my-envs:/opt/anaconda/envs``

* 윈도우:
  ``set CONDA_ENVS_PATH=C:\Users\joe\envs;C:\Anaconda\envs``


콘다 빌드 설정
=========================


콘다 빌드 출력 디렉토리 지정 (root-dir)
----------------------------------------------------

빌드 출력 루트 디렉토리다. CONDA_BLD_PATH 환경 변수로도 설정할 수 있다.
기본은 ``<CONDA_PREFIX>/conda-bld/``\ 다.
``<CONDA_PREFIX>/conda-bld/``\ 에 작성 권한이 없으면 ``~/conda-bld/``\ 가 기본이 된다.

예시:

.. code-block:: yaml

  conda-build:
      root-dir: ~/conda-builds


Anaconda.org에 콘다 빌드 패키지 자동 업로드 (anaconda_upload)
---------------------------------------------------------------------------

콘다 빌드(conda build)로 빌드된 패키지가 `Anaconda.org <http://anaconda.org>`_\ 에 자동 업로드된다.
기본은 ``False``\ 다.

예시:

.. code-block:: yaml

  anaconda_upload: True


Anaconda.org 업로드에 사용되는 토클 (conda-build 3.0+) (anaconda_token)
-----------------------------------------------------------------------------

토큰은 로그인 없이 anaconda.org에 인증할 때 사용하는 수단이다.
이 condarc 설정이나 CLI 인수로 conda-build에 토큰을 보낸다.
기본에서 이 기능은 설정되어 있지 않다.
이 설정을 사용하면 anaconda_upload도 활성화된다.

  .. code-block:: yaml

     conda-build:
         anaconda_token: gobbledygook


빌드 출력 상세 표시 제한 (conda-build 3.0+) (quiet)
-------------------------------------------------------

Conda-build의 출력 상세 표시는 ``quiet`` 설정으로 제한된다.
더 많은 상세 표시는 CLI 플래그 ``--debug``\ 를 사용한다.

.. code-block:: yaml

   conda-build:
       quiet: true


파일명 해시 비활성화 (conda-build 3.0+) (filename_hashing)
--------------------------------------------------------------

콘다 빌드3는 파일에 해시를 추가해 의존 요소 버전의 사용자화를 향상시킨다.
이 기능이 불편하다면 다음과 같이 설정해 비활성화할 수 있다.

.. code-block:: yaml

   conda-build:
       filename_hashing: false

주의: 콘다 빌드는 패키지를 클로버링 할 때 확인 작업을 하지 않는다.
빌드 문자열에 나타나지 않은 빌드 설정으로 콘다 빌드3의 빌드 행렬을 사용하면 클로버링으로 인해 패키지가 손실될 수 있다.


래시피와 패키지 확인 비활성화 (conda-build 3.0+) (no_verify)
----------------------------------------------------------------------

기본으로 콘다 빌드는 conda-verify를 사용해 래시피와 패키지가 최소한의 정상 검사를 만족하는지 확인한다.
이 기능을 비활성화하려면 다음과 같이 설정한다.

.. code-block:: yaml

   conda-build:
       no_verify: true


빌드 별 폴더 생성 비활성화 (conda-build 3.0+) (set_build_id)
-------------------------------------------------------------------

콘다 빌드는 기본으로 빌드마다 새 폴더를 생성한다. 폴더명은 패키지 이름에 타임스탬프를 붙인 것이 된다.
이 기능으로 복수의 빌드를 한번에 할 수 있다. 경로가 길어지는 것이 문제가 된다면 이 기능을 비활성화해야 할 것이다.
먼저 ``root-dir`` 설정에서 다룬 빌드 출력 루트 디렉토리를 바꿔보고 필요하다면 다음을 설정한다.

.. code-block:: yaml

   conda-build:
       set_build_id: false


이미 존재하는 패키지 빌드 건너뛰기 (conda-build 3.0+) (skip_existing)
----------------------------------------------------------------------------

콘다 빌드는 기본으로 사용자가 지정한 모든 래시피를 빌드한다.
이미 빌드된 래시피를 건너뛰도록 설정할 수 있다.
현재 설정된 채널에 래시피의 *모든* 출력이 있을 때만 래시피를 건너뛴다.

.. code-block:: yaml

   conda-build:
       skip_existing: true


패키지에서 온 래시피 생략 (conda-build 3.0+) (include_recipe)
------------------------------------------------------------

콘다 빌드는 기본으로 패키지를 빌드하는데 사용한 래시피를 포함한다.
이 래시피에 민감한 정보나 특허 정보가 포함되어 있다면 래시피를 생략할 수 있다.

.. code-block:: yaml

   conda-build:
       include_recipe: false

주의: 래시피를 포함하지 않으면 빌드를 마친 후 콘다 빌드로 패키지를 테스트할 수 없다.
이는 ``conda build --notest recipe``, ``conda build -t recipe``
두개의 CLI 명령으로 빌드와 테스트 단계를 나눌 수 없을 의미한다.
래시피를 생략하면서 빌드와 테스트 단계를 나눠야 한다면 테스트 단계를 마치고
타르볼(tarball) 아티팩트에서 래시피 파일을 삭제하는 방법 밖에 없다.
콘다 빌드는 이를 위한 도구를 제공하지 않는다.


빌드/테스트 도중 환경 활성화 막기 (conda-build 3.0+) (activate)
----------------------------------------------------------------------------------

콘다 빌드는 기본으로 빌드나 테스트를 실행하기 전에 빌드/테스트 환경을 활성화한다.
이 기능은 필요한 PATH 항목을 추가하고 사용자가 가진 어떤 activate.d 스크립트도 실행한다.
이를 비활성화하면 PATH는 수정하지만 activate.d 스크립트는 실행하지 않는다.
비활성화를 선호하는 사람도 있지만 권장하진 않는다.

.. code-block:: yaml

   conda-build:
       activate: false


PyPI 업로드 설정 (conda-build 3.0+) (pypirc)
------------------------------------------------

기본에서는 설정되어 있지 않다.
래시피에 휠 출력이 있다면 콘다 빌드는 이 설정에 지정된 파일 경로의 크리덴셜을 사용해
``pypi_repository``\ 설정으로 지정된 PyPI 레포지토리에 업로드를 시도한다.

.. code-block:: yaml

   conda-build:
       pypirc: ~/.pypirc


업로드할 PyPI 레포지토리 (conda-build 3.0+) (pypi_repository)
-----------------------------------------------------------------

기본에서는 설정되어 있지 않다.
래시피에 휠 출력이 있다면 콘다 빌드는 ``pypirc`` 설정으로 지정된 파일의 크리덴셜을 사용해
이 설정에 지정된 PyPI 레포지토리에 업로드를 시도한다.

.. code-block:: yaml

   conda-build:
       pypi_repository: pypi


.condarc 파일로부터 정보 얻기
==============================================

주의: 다음 명령에 ``-f``\ 로 "force" 옵션을 추가해야 할 수도 있다.

다음 명령으로 모든 키와 그 값을 얻는다.

.. code-block:: bash

   conda config --get

다음 명령으로 특정 키의 값을 얻는다. 여기에서는 channels 키의 값을 얻는다.

.. code-block:: bash

   conda config --get channels

다음 명령으로 특정 키에 새 값을 추가한다. 여기에서는 channels 키에 http://conda.anaconda.org/mutirri 를 추가한다.

.. code-block:: bash

   conda config --add channels http://conda.anaconda.org/mutirri

다음 명령으로 특정 키의 기존 값을 제거한다. 여기에서는 channels http://conda.anaconda.org/mutirri 를 제거한다.

.. code-block:: bash

   conda config --remove channels http://conda.anaconda.org/mutirri

다음 명령으로 특정 키와 그 키의 모든 값을 제거한다. 여기에서는 channels 키를 제거한다.

.. code-block:: bash

   conda config --remove-key channels

하나의 환경의 채널과 채널 선호도를 설정하려면 :ref:`환경의 루트 경로 <config-channels>`\ 에 ``.condarc`` 파일을 생성한다.
