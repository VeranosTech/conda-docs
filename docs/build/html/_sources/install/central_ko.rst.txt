========================================================================
중앙 설치
========================================================================

.. contents::

개요
========

사용자가 설치할 프로그램을 제한하고자 하는 관리자는 시스템 구성 파일 또는 .condarc 파일을 통해 설치를 제한할 수 있다.
이 파일은 `YAML 문법 <http://docs.ansible.com/YAMLSyntax.html>` 을 따른다.
시스템 구성 파일은 다른 사용자에 의해 설치된 모든 .condarc 구성 파일을 무시한다.

디폴트에 의해 콘다와 아나콘다를 포함한 콘다가 설치하는 모든 패키지는 로컬에 설치되고 user-specific 설정을 따른다.
관리자 권한은 요구되지 않으며 어떤 업스트림 파일이나 다른 사용자도 설치에 영향을 받지 않는다.

관리자가 콘다와 패키지들을 생성해 사용자 그룹에 제공하면서 원치 않는 패키지의 설치는 제한하고 싶을 수 있다.
이 때는 관리자에 의해 관리되고 다른 사용자는 접근 권한을 갖는 위치에 콘다와 패키지를 설치하면 된다.

이제 다른 사용자는 중앙 콘다 설치를 사용하고 각각의 사용자의 홈 디렉토리에 있는 .condarc 구성 파일의 설정을 따르게 된다.
사용자 구성은 2차 "system" .condarc 파일에 의해 제한된다. 이 .condarc 파일로의 경로는 ``conda info`` 에 의해 나타나느 루트 환경 접두어와 동일하다.
아래 :ref:`admin-inst` 를 보자.

시스템 구성 설정은 시스템 구성 파일에서 주로 사용되지만 사용자 구성 파일에도 사용될 수 있다.
모든 사용자 구성 설정 또한 시스템 구성 파일에서 사용될 수 있다.

:doc:`콘다 구성 파일 </config_ko>` 을 참고하자.

시스템 구성 설정
=============================

다른 채널 허용하기 (allow_other_channels)
-------------------------------------------

관리자 시스템 설정 .condarc 는 허용되는 채널들을 설정하고 다른 사용자들의 타 채널로부터의 패키지 설치를 허용할 수 있다.
allow_other_channels 부올리언 플래그를 사용한다. 디폴트는 True 이다.

allow_other_channels 이 false이면 관리자 .condarc 파일에 명시된 채널에서만 패키지를 설치할 수 있다.

.. code-block:: yaml

  allow_other_channels: False

``allow_other_channels`` 가 True 이거나 지정되지 않으면 각각의 사용자들은 디폴트 채널 외에도
사용자의 로컬 .condarc 파일에 명시한 채널들로부터 패키지를 다운로드 할 수 있다.
``allow_other_channels`` 이 False 이면 사용자가 다른 채널을 지정했을 때 이 채널은 막히게 되고 메시지가 나타난다. 아래 예시를 보자.

시스템 .condarc  파일이 channel_alias 을 지정하면 사용자 .condarc 파일에서 지정한 모든 채널 별칭이 무시된다. 아래 채널 별칭을 보자.

디폴트 채널 (default_channels)
-----------------------------------

일반적으로 디폴트 저장소는 repo.continuum.io 이지만 default_channels 이 지정되면 새로운 디폴트 채널 리스트를 따른다.
이 기능은 air gap 과 enterprise 설치에 유용하다.

.. code-block:: yaml

  channels:
    - <anaconda_dot_org_username>
    - http://some.custom/channel
    - file:///some/local/directory
    - defaults

.. _SSL_verification:

SSL 인증 (ssl_verify)
-----------------------------

만약 사용자가 Cisco IronPort WSA 와 같은 SSL 인증을 사용하는 프록시 하에 있다면
``ssl_verify`` 를 사용해 SSL 인증 설정을 무시해야할 수 있다.

디폴트에 의해 이 변수는 ``True`` 이며 이 때 SSL 인증은 사용되고 콘다는 SSL 연결을 위한 인증서를 확인한다.
변수가 ``False`` 로 설정될 수 있지만 연결의 기초적인 보안을 비활성화 하므로 권장하지 않는다.

.. code-block:: yaml

  ssl_verify: False

``ssl_verify`` 변수는 SSL 연결에 사용되는 인증서의 문자열 경로로 설정할 수 있다.

.. code-block:: yaml

  ssl_verify: corp.crt

오프라인 전용 모드 (offline)
---------------------------

Offline 모드는 ``file:`` 로 시작하니 않는 모든 채널 url 을 걸러낸다. 디폴트는 False 이다.

.. code-block:: yaml

  offline: True

채널 별칭 (channel_alias)
-----------------------------

url이 아닌 채널을 위한 별칭은 -c 또는 --channel 플래그로 사용된다. 디폴트는 ``https://conda.anaconda.org/`` 이다.

.. code-block:: yaml

  channel_alias: https://your.repo/conda
  
주의: 윈도우 사용자라면 url 끝에 슬래시를 사용해야 한다. 예시 https://your.repo/conda/


특정 패키지 설치 금지 (disallow)
-----------------------------------------------------

패키지 설치를 금지하는 설정. 디폴트는 모든 패키지를 허용한다.

.. code-block:: yaml

  disallow:
    - anaconda

비공개 패키지 열람을 위한 Anaconda.org 토큰 추가 (add_anaconda_token)
---------------------------------------------------------------------------------

channel_alias 가 Anaconda.org 또는 Anaconda Server GUI 일 때 시스템 구성 파일을 설정해 사용자가 자동으로 비공개 패키지를 열람하게 할 수 있다.
(Anaconda.org 는 이전에 binstar.org 였다.)
이 기능은 아나콘다 커맨드 라인 클라이언트를 사용해 채널 url에 토큰을 자동으로 추가한다.
(``conda install anaconda-client`` 로 설치 가능)

디폴트는 True.

.. code-block:: yaml

  add_anaconda_token: False

주의: True 로 설정 되었더라도 아나콘다 커맨드 라인 클라이언트가 설치되어 ``anaconda login`` 커맨드로 로그인 했을 때만 유효하다.

환경 디렉토리 지정 (envs_dirs)
-------------------------------------------

환경이 위치할 디렉토리를 지정한다. 이 키가 설정되면 루트 접두사 envs_dir 는 명시적으로 포함시키지 않는 한 사용되지 않는다.
이 키는 패키지 캐시가 위치할 곳도 지정한다.

``envs/pkgs`` 가 이 디렉토리의 환경들의 패키지 캐시로 사용된다. 루트 디렉토리의 표준 환경 디렉토리는 예외로 ``root_dir/pkgs`` 를 사용한다.
``CONDA_ENVS_PATH`` 환경 변수는 이 구성 파일 설정을 덮어쓴다.

.. code-block:: yaml

  envs_dirs:
    - ~/my-envs
    - /opt/anaconda/envs


* **리눅스, OS X:** ``CONDA_ENVS_PATH=~/my-envs:/opt/anaconda/envs``
* **윈도우:** ``set CONDA_ENVS_PATH=C:\Users\joe\envs;C:\Anaconda\envs``

.. _admin-inst:

admin-controlled 설치 예시
=====================================

이번 예시에서 우리는 시스템 구성 파일을 들여다보고 설정을 복습할 것이다.
시스템 구성 파일과 사용자 구성 파일을 비교하고 사용자가 제한된 채널의 파일에 접근하려 할 때 어떤 일이 일어나는지 보자.
마지막으로 관리자에 의해 허용된 채널에 접근하기 위해 사용자가 구성 파일을 어떻게 변경해야 하는지 알아보자.

**시스템 구성 파일**

시스템 구성 파일은 반드시 아나콘다 설치 디렉토리의 최상위에 위치해야 한다. 먼저 콘다가 설치된 위치를 보자.:

.. code-block:: bash

  which conda
  /tmp/miniconda/bin/conda

이제 관리자 디렉토리에 위치한 .condarc 파일의 내용을 볼 수 있다.

.. code-block:: bash

  cat /tmp/miniconda/.condarc

이 관리자 .condarc 파일은 allow_other_channels 을 False 로 설정했다.
다른 사용자는 'admin' 채널에서만 패키지를 다운로드 받도록 설정되어 있다.

.. code-block:: none

  cat /tmp/miniconda/.condarc
  allow_other_channels : false
  channel_alias: https://conda.anaconda.org/
  channels:
    - admin

``allow_other_channels`` 이 False 이고 'defaults' 가 명시되지 않았으므로
사용자는 디폴트 채널로부터 패키지를 다운로드 받을 수 없다.
이는 다음 단계에서 확인해보자.

주의: 관리자 채널은 https://conda.anaconda.org/admin/ 에서도 다루고 있다.

**사용자 구성 파일**

사용자의 콘다가 설치된 위치를 확인해보자.:

.. code-block:: bash

  conda info
  Current conda install:
  . . .
         channel URLs : http://repo.continuum.io/pkgs/free/osx-64/
                        http://repo.continuum.io/pkgs/pro/osx-64/
          config file : /Users/gergely/.condarc

'conda info' 커맨드는 콘다가 ``/Users/gergely/.condarc`` 에 위치한 사용자 .condarc 파일을 사용하고 있음을 보여준다.
``repo.continuum.io`` 와 같은 디폴트 채널은 채널 URL 리스트에 나열되어 있다.

이제 이 디렉토리에 위치한 관리자 .condarc 파일의 내용을 살펴보자.

.. code-block:: none

  cat ~/.condarc
  channels:
    - defaults

이 사용자의 .condarc 파일에는 디폴트 채널만 명시되어 있다.

하지만 관리자 구성 파일이 디폴트 채널을 막았기 때문에 "admin" 채널만 사용가능하다.
사용자가 디폴트 채널에서 패키지를 검색하려고 하면 다음 메시지가 나타날 것이다.
이 메시지는 사용가능한 채널을 알려준다.

.. code-block:: bash

   conda search flask
   Fetching package metadata:
   Error: URL 'http://repo.continuum.io/pkgs/pro/osx-64/' not in allowed channels.
   Allowed channels are:
    - https://conda.anaconda.org/admin/osx-64/

이 에러 메시지는 "admin" 채널을 사용자 구성 파일에 추가해야 한다고 알려주고 있다.

결론: 유저는 로컬 .condarc 파일을 수정해 admin 채널을 통해 패키지를 받아야 한다.:

.. code-block:: yaml

  channels:
    - admin

이제 사용자는 admin 채널에서 패키지를 검색할 수 있다.
