=============
배열
=============

.. contents::


콘다 구성 파일 (.condarc)
=======================================

콘다 구성 파일 (.condarc)는 선택적 런타임 배열 파일로 고급 사용자로 하여금 콘다의 다양한 부분을 설정할 수 있도록 해준다.
이 파일로 패키지를 검색할 채널, 프록시 설정, 환경 디렉토리 등을 설정할 수 있다.

.condarc 파일은 디폴트에 포함되지 않고 ``conda config`` 커맨드를 처음 실행할 때 사용자의 홈 디렉토리에 생성된다.

홈 디렉토리에 있는 것을 무시할 경우 .condarc 파일은 루트 환경에 위치할 수 있다.

주의: .condarc 파일은 사용자의 설정을 무시하는 관리자 제어 설치에 사용되기도 한다. :doc:`install/central_ko` 를 보자.

콘다 구성 파일은 아래의 항목들을 변경하는데 사용된다.:

- 콘다가 패키지를 검색할 곳

- 콘다의 프록시 서버 사용 여부와 그 방법

- 콘다 리스트가 환경을 가져올 곳

- 현재 활성화된 환경명과 bash 프롬프트 업데이트

- 사용자 빌드 패키지의 Anaconda.org 업로드

- 디폴트 패키지 또는 새로운 환경에 포함될 기능

- 그 외.

.condarc 구성 파일을 생성하거나 수정하려면 커맨드 라인에서 ``conda config`` 를 입력하거나
텍스트 에디터로 .condarc 라고 명명된 파일을 생성해 사용자의 홈 디렉토리 또는 루트 디렉토리에 저장한다.

예시:

.. code-block:: yaml

  conda config --add channels conda-forge

참고: conda config 커맨드의 리스트가 필요하다면
:doc:`커맨드 레퍼런스 <commands/conda-config_ko>` 를 보자.
동일한 리스트를 ``conda config --help`` 커맨드를 입력했을 때 볼 수 있다.

.condarc 구성 파일은 간단한 `YAML 문법 <http://docs.ansible.com/YAMLSyntax.html>`_ 을 따른다.

:doc:`샘플 .condarc 파일 다운로드<install/sample-condarc>` 로 사용자의 에디터에서 수정하거나
홈 디렉토리 또는 루트 디렉토리에 저장할 .condarc 파일을 얻을 수 있다.and save to your user home directory or root directory.

팁: 콘다는 내부 설정 구성 :doc:`tab completion<install/tab-completion_ko>` 과 외부 패키지를 지원한다.

구성에 대한 더 많은 정보가 필요하다면: http://continuum.io/blog/advanced-conda-part-1#configuration


일반 구성
=====================


.. _config-channels:

채널 위치 (channels)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.condarc 파일에 채널 리스트를 넣으면 디폴트는 무시되고 콘다는 리스트에 존재하는 채널만을 검색한다.

``defaults`` 를 사용하면 모든 디폴트 채널이 자동으로 포함된다.
url 이 아닌 채널은 Anaconda.org 의 유저명으로 해석되고 이는 아래에서 설명할 ``channel_alias`` 를 수정하면 변경된다.
디폴트는 그대로 ``defaults`` 이다.

.. code-block:: yaml

  channels:
    - <anaconda_dot_org_username>
    - http://some.custom/channel
    - file:///some/local/directory
    - defaults

단일 환경을 위한 채널들을 지정하려면 지정할 환경의 루트 디렉토리에 ``.condarc`` 파일을 두면 된다.
파이썬 3 미니콘다를 설치했다면 홈 디렉토리와 환경은 "flowers" 로 명명된다.
경로는 ``~/miniconda3/envs/flowers/.condarc`` 가 될 것이고 다른 콘다 설치의 경로도 이와 비슷하게 나타난다.


콘다 자동 업데이트 (auto_update_conda)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

True 이면 콘다는 항상 사용자 업데이트와 루트 디렉토리 내부의 패키지 설치를 스스로 한다.
False 일 때는 콘다는 유저가 수동으로 conda update command 를 입력할 때만 업데이트를 진행한다.
디폴트는 ``True`` 이고 .condarc 파일이나 ``conda config --set auto_update_conda False`` 커맨드로 이를 변경할 수 있다.

.. code-block:: yaml

  auto_update_conda: False


항상 예 (always_yes)
^^^^^^^^^^^^^^^^^^^^^^^

설치와 같은 상황에서 진행을 물을 때 항상 예(yes) 를 입력하고 싶다면
커맨드 라인에 ``--yes`` 플래그를 사용한다. 디폴트는 ``False`` 이다.

.. code-block:: yaml

  always_yes: True


채널 URL 표시 (show_channel_urls)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

다운로드 되어 ``conda list`` 에 들어갈 것들을 나타낼 때 채널 URL 도 보여준다.
디폴트는 ``False`` 이다.

.. code-block:: yaml

  show_channel_urls: True


커맨드 프롬프트 변경 (changeps1)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``activate`` 를 사용할 때 커맨드 프롬프트 (``$PS1``) 를 변경해 활성화된 환경을 포함한다.
디폴트는 ``True`` 이다.

.. code-block:: yaml

  changeps1: False


파이썬 하위요소에 PIP 추가 (add_pip_as_python_dependency)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

pip, wheel, setuptools 를 파이썬이 하위요소에 추가한다.
이 구성으로 파이썬을 설치할 때마다 pip, wheel, setuptools 도 설치된다.
디폴트는 ``True`` 이다.

.. code-block:: yaml

  add_pip_as_python_dependency: False


PIP 사용 (use_pip)
^^^^^^^^^^^^^^^^^

``conda list`` 로 패키지를 나열할 때 pip 를 사용한다.
``conda list`` 커맨드의 출력이 아닌 콘다 커맨드나 기능에 영향을 주지 않는다는 것을 알아두자.
디폴트는 ``True`` 이다.

.. code-block:: yaml

  use_pip: False


프록시 서버 뒤에서의 사용을 위한 콘다 설정 (proxy_servers)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

디폴트에 의해 프록시 설정은 ``HTTP_PROXY``, ``HTTPS_PROXY`` 환경 변수 또는 시스템으로부터 가져온다.
아래와 같이 proxy_servers 를 설정하면 디폴트는 무시된다.

.. code-block:: yaml

  proxy_servers:
      http: http://user:pass@corp.com:8080
      https: https://user:pass@corp.com:8080

특정 scheme과 호스트에게 프록시를 부여하기 위해 scheme://hostname 형식을 키로 사용한다.
이는 주어진 scheme과 정확한 hostname 으로의 모든 요청과 일치하게 된다.

.. code-block:: yaml

  proxy_servers:
    'http://10.20.1.128': 'http://10.10.1.10:5323'

주의: 유저명과 암호를 포함하지 않거나 인증에 실패한다면 콘다는 유저명과 암호에 응답하지 않는다.

주의: 암호가 특수 문자를 포함하면 다음 문서에 나온대로 이스케이프 된다.:
https://en.wikipedia.org/wiki/Percent-encoding#Percent-encoding_reserved_characters

주의: ``http`` 와 ``https`` 를 혼동하지 않도록 주의한다.

주의: Cisco IronPort WSA 와 같은 SSL 검사를 하는 프록시 뒤에 있다면
:ref:`SSL_verification` 이 설명하는 대로 ``ssl_verify`` 을 사용해 SSL 인증 설정을 무시해야 한다.


오프라인 전용 모드 (offline)
^^^^^^^^^^^^^^^^^^^^^^^^^^^

``file://`` 프로토콜을 사용하지 않는 모든 채널 URL 을 걸러낸다. 디폹는 ``False`` 이다.

.. code-block:: yaml

  offline: True


고급 구성
======================


소프트 링크 차단(allow_softlinks)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``allow_softlinks`` 값이 ``True`` 이면 콘다는 가능할 때만 하드 링크를 사용하고
소프트 링크 (symlinks) 는 하드 링크를 할 수 없을 때 사용한다.
패키지 캐시가 없는 다른 파일 시스템의 설치하는 경우가 이에 해당한다.

``allow_softlinks`` 값이 ``False`` 일 때도 가능하다면 콘다는 하드 링크를 사용하지만
하드 링크가 불가능하면 파일을 복사한다. 개별 패키지는 이를 무시할 수 있고 옵션과 상관 없이
특정 파일은 절대 소프트 링크되지 않도록 지정한다. (빌드 레시피 문서에서 ``no_link`` 옵션을 보자.)

디폴트 ``True``.

.. code-block:: yaml

  allow_softlinks: False


채널 엘리어스 설정 (channel_alias)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

디폴트에 의해 ``conda install --channel asmeurer <package>`` 커맨드는
``conda install --channel https://conda.anaconda.org/asmeurer <package>`` 과 동일하다.
이는 디폴트 ``channel_alias`` 가 https://conda.anaconda.org/ 이기 때문이다.
URL 이 아닌 채널명이 콘다에 주어지면 채널명 앞에 ``channel_alias`` 를 추가한다.

사용자의 저장소로 ``channel_alias`` 를 설정할 수 있다.
https://yourrepo.com 로 설정했다면 ``conda install --channel jsmith <package>`` 는
``conda install --channel https://yourrepo.com/jsmith <package>`` 과 동일하다.

.. code-block:: yaml

  channel_alias: https://your.repo/

주의: 윈도우 사용자라면 URL 끝에 슬래시(/) 를 두어야 한다. 예시 https://your.repo/conda/


디폴트 패키지 설정 (create_default_packages)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

새로운 환경을 생성할 때 지정한 패키지를 디폴트로 추가한다.
커맨드 프롬프트에 ``--no-default-packages`` 를 추가해 이 옵션을 무시할 수 있다.
디폴트에서는 어떤 패키지도 포함하지 않는다.

.. code-block:: yaml

  create_default_packages:
    - ipython


기능 추적 (track_features)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

디폴트로 특정 기능이 추적되는 것을 허용한다. 디폴트에서는 어떤 기능도 추적하지 않는다.
이는 ``create_default_packages`` 리스트에 ``mkl`` 를 추가하는 것과 유사하다.

.. code-block:: yaml

  track_features:
    - mkl

하위 요소 업데이트 비활성화 (update_dependencies)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

디폴트에 의해 ``conda install`` 은 주어진 패키지의 그 하위 요소 모두를 최신 버전으로 업데이트 한다.

커맨드 라인에 명시된 패키지만 업데이트 하고 기존에 설치된 패키지들은 가능한 한 업데이트하고 싶지 않다면
``update_dependencies`` 를 ``True`` 로 설정한다.

.. code-block:: yaml

   update_dependencies: True

콘다는 여전히 하위 요소 사양의 만족을 보장하므로 몇몇 하위 요소는 업데이트 될 수 있다.
반대로 말해 이 옵션은 커맨드 라인에 주어진 패키지가 최신 버전으로 업데이트 되는 것을 막기도 한다.
콘다가 주어진 버전의 설치를 강제하도록 커맨드 라인에 원하는 버전을 지정할 수 있다.
(예시 ``conda install numpy=1.9.3``)

이 옵션은 커맨드 라인의 ``--update-dependencies``, ``--no-update-dependencies`` 플래그로 활성화 되거나 비활성화 될 수 있다.

환경의 특정 패키지만 업데이트 되는 것을 막고 싶다면 *pin* 옵션이 더 나은 방법이다.
:ref:`pinning-packages` 에서 더 많은 정보를 얻을 수 있다.

콘다 빌드 구성
=========================

콘다의 빌드 출력 루트 디렉토리
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

빌드 출력 루트 디렉토리. ``CONDA_BLD_PATH`` 과 함께 설정될 수 있다.
디폴트는 ``<CONDA_PREFIX>/conda-bld/`` 이다.
``<CONDA_PREFIX>/conda-bld/`` 로의 작성 권한이 없는 경우 ``~/conda-bld/`` 가 디폴트가 된다.

.. code-block:: yaml

  conda-build:
      root-dir: ~/conda-builds


Anaconda.org 로의 콘다 빌드 패키지 자동 업로드 (anaconda_upload)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``conda build`` 로 생성된 패키지를 Anaconda.org 에 자동 업로드한다. 디폴트는 ``False`` 이다.

.. code-block:: yaml

  anaconda_upload: True


Anaconda.org 업로드에 사용되는 토큰 (conda-build 3.0+)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

토큰은 로그인 없이 anaconda.org 에 인증하는 수단이 된다.
이 .condarc 설정 또는 CLI 인수로 conda-build 에 토큰을 보낼 수 있다.
디폴트에서는 설정되지 않는다. 토큰을 내부적으로 설정하면 anaconda_upload 가 가능해진다.

.. code-block:: yaml

  conda-build:
      anaconda_token: gobbledygook


빌드 출력의 장황함 제한 (conda-build 3.0+)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Conda-build 출력의 장황함을 ``quiet`` 설정으로 줄일 수 있다. 더 큰 장황함에는 ``--debug`` CLI 플래그를 사용한다.

.. code-block:: yaml

  conda-build:
      quiet: true


파일명 해시 비활성화 (conda-build 3.0+)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Conda-build 3 는 파일명에 해시를 추가해 하위 요소 버전에 보다 넓은 사용자 정의를 허용한다.
이 툭성이 다른 부분에 지장을 준다고 느낀다면 아래 config 항목으로 비활성화 할 수 있다.:

.. code-block:: yaml

  conda-build:
      filename_hashing: false

conda-build 는 패키지를 클로버링하는 동안 확인을 하지 않는다.
conda-build 3 의 빌드 행렬을 빌드 구성과 함께 사용할 때 빌드 구성이 빌드 문자열 나타나지 않는다면
클로버링으로 인해 패키지가 손실될 수 있다.


레시피와 패키지 인증 비활성화 (conda-build 3.0+)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

디폴트에 의해 conda-build 는 conda-verify 를 사용해 레시피와 패키지가 촤소한의 정상 여부 검사를 만족하는지 확인한다.
아래 코드로 이를 비활성화 할 수 있다.:

.. code-block:: yaml

  conda-build:
      no_verify: true


빌드당 폴서 생성 비활성화 (conda-build 3.0+)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

디폴트에 의해 conda-build 는 빌드마다 새로운 폴더를 생성하고 패키지명에 타임스탬프를 붙여 명명한다.
이 기능으로 인해 여러 빌드를 동시에 할 수 있다. 경로가 너무 길어지는 것이 문제가 된다면 이 기능을 비활성화 해야 한다.
먼저 ``root-dir`` 를 사용해 빌드 출력 루트 디렉토리를 변경해보고 안될 시에 아래 코드를 사용한다.:

.. code-block:: yaml

  conda-build:
      set_build_id: false


기존 패키지의 빌드 생략 (conda-build 3.0+)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

디폴트에 의해 conda-build 는 명시한 모든 레시피를 빌드한다.
원한다면 이미 빌드된 레시피의 빌드는 생략할 수 있다.
레시피의 모든 출력이 현재 구성된 채널에서 유효할 때만 레시피의 빌드가 생략된다.

.. code-block:: yaml

  conda-build:
      skip_existing: true


패키지의 레시피 생략 (conda-build 3.0+)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

디폴트에 의해 conda-build 는 패키지를 빌드하는데 사용한 레시피를 생략한다.
민감한 정보나 소유권 정보가 포함된다면 레시피를 생략할 수 있다.

.. code-block:: yaml

  conda-build:
      include_recipe: false

레시피를 포함하지 않으면 빌드를 마친 후 conda-build 를 사용해 패키지를 테스트할 수 없다.
이로 인해 두개의 다른 CLI 커맨드 (``conda build --notest recipe`` 와 ``conda build -t recipe``) 에서
빌드와 테스트 단계를 나눌 수 없게 된다. 만약 레시피는 생략하고 단계는 나누고 싶다면
테스트를 마친 후 tarball 아티팩트에서 레시피 파일을 삭제해야 하는 방법 밖에 없다.
conda-build 는 이러한 작업을 위한 툴을 제공하지 않는다.


빌드/테스트 도중 환경의 활성화 해제 (conda-build 3.0+)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

디폴트에 의해 conda-build 는 빌드와 테스트 스크립트 실행에 앞서 빌드와 테스트 환경을 활성화 시킨다.
이 과정은 필수적인 경로 항목을 추가하고 보유하고 있는 스크립트 중 활성화된 것은 어떤 것이든 실행한다.
활성화를 해제하면 경로는 여전히 수정되어 있지만 활성화된 스크립트는 실행하지 않는다.
권장하는 옵션은 아니지만 사용자에 따라 이 옵션을 선호하기도 한다.

.. code-block:: yaml

  conda-build:
      activate: false


PyPI 업로드 설정 (conda-build 3.0+)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

디폴트에 의해 해제되어 있다. 레시피에 wheel 출력이 있다면 conda-build 는 ``pypi_repository`` 설정으로 지정된 PyPI 저장소에 업로드 하려 할 것이다.
``pypi_repository`` 설정은 파일 경로로부터 인증된다.

.. code-block:: yaml

  conda-build:
      pypirc: ~/.pypirc


업로드할 PyPI 저장소 (conda-build 3.0+)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

디폴트에 의해 해제되어 있다. 레시피에 wheel 출력이 있다면 conda-build 는 ``pypi_repository`` 설정으로 지정된 PyPI 저장소에 업로드 하려 할 것이다.

.. code-block:: yaml

  conda-build:
      pypi_repository: pypi




.. toctree::
   :hidden:

   install/sample-condarc_ko
   install/tab-completion_ko
