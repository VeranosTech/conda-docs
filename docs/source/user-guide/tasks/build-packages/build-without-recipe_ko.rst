=================================================
레시피 없이 빌드하기(bdist_conda)
=================================================

.. contents::
   :local:
   :depth: 2


``setup.py bdist_conda`` 로
콘다 빌드를 콘다를 설치하는 것이 아닌 파이썬 패키지를 빌드하는데 사용할 수 있다.
이 방법은 레시피를 사용하지 않고 패키지를 빌드하는 빠르고 지저분한 방법이지만 한계점이 있다.
스크립트는 빌드에 사용된 파이썬 버전에 한정되고 레시피를 사용한 빌드 만큼 재현성이 좋지 못하다.
콘다 빌드와 레시피를 함께 사용하는 것을 권장한다.

NOTE: Setiptools 를 사용한다면 우선 Setuptools 를 가져온 후에
``distutils.command.bdist_conda`` 를 가져와야 한다.
Setuptools 가 ``distutils.dist.Distribution`` 를 몽키패치(monkeypatch) 하기 때문이다.

예시
=======
name과 version 셋업 옵션을 사용한 최소한의 setup.py 파일이다. :

.. code::

   from distutils.core import setup, Extension
   import distutils.command.bdist_conda

  setup(
      name="foo",
      version="1.0",
      distclass=distutils.command.bdist_conda.CondaDistribution,
      conda_buildnum=1,
      conda_features=['mkl'],
  )


셋업 옵션
=============

옵션은 ``setup()`` 을 지날 수 있다.
(``distclass=distutils.command.bdist_conda.CondaDistribution`` 를 반드시 포함해야 한다.):

빌드 번호
--------------

빌드의 번호이다. ``--buildnum`` 플래그를 포함하는 커맨드 라인에서 무시될 수 있다.
디폴트는 0 이다.

.. code::

   conda_buildnum=1


빌드 문자열
-------------

빌드의 문자열이다. 디폴트는 파이썬 버전으로부터 자동 생성되고 다음에 빌드 번호가 온다. ``py34_0`` 와 같이 생성된다.
Numpy 와 관련 있다면 Numpy 버전으로부터 생성된다.

.. code::

   conda_buildstr=py34_0

임포트 테스트
-------------

임포트 테스트를 자동 실행할지 결정한다. 디폴트는 True 이고
패키지 내부 모든 모듈의 임포트 테스트를 실행한다.
False 로 지정되면 테스트를 실행하지 않는다.
테스트 할 모듈명의 리스트를 지정할 수도 있다.

.. code::

   conda_import_tests=False

커맨드 라인 테스트
-------------------

실행할 커맨드 라인 테스트. 디폴트는 True 이고 ``console_scripts``, ``gui_scripts entry_points`` 내부의
각각의 커맨드에 ``command --help`` 를 실행한다.
False 로 지정되면 테스트를 실행하지 않는다.
테스트 할 커맨드의 리스트를 지정할 수도 있다.

.. code::

   conda_command_tests=False

바이너리 파일 재배치 가능
------------------------

바이너리 파일이 재배치 가능하게 만들어져야 하는지 결정한다.
(OS X 의 ``install_name_tool`` 나 Linux 의 ``patchelf`` 에서 사용된다.)
디폴트는 True 이다.

.. code::

   conda_binary_relocation=False

참고: 콘다 빌드 내부 문서 :ref:`relocatable` 섹션에서 더 많은 정보를 얻을 수 있다.

egg directory 보존
-----------------------

Setuptools 에 의해 설치된 egg directory 를 보존할지 결정한다.
패키지가 Setuptools 에 의존하거나 ``console_scripts`` 와 ``gui_scripts`` 대신
Setuptools ``entry_points`` 를 가지고 있다면 디폴트는 True 이다.

.. code::

   conda_preserve_egg_dir=False

기능
-------------

패키지를 위한 기능 목록.

.. code::

   conda_features=['mkl']

참고:  콘다 빌드 문서 :ref:`features` 섹션에서 콘다의 기능에 대한 더 많은 정보를 얻을 수 있다.


기능 추적
-----------------

현재 패키지가 추적해야하는 기능 목록. (설치되었을 때 사용 가능한)

.. code::

   conda_track_features=['mkl']

참고:  콘다 빌드 문서 :ref:`features` 섹션에서 콘다의 기능에 대한 더 많은 정보를 얻을 수 있다.

커맨드 라인 옵션
====================

빌드 번호
-------------

빌드 번호를 설정한다. 디폴트는 ``conda_buildnum`` 로 ``setup()`` 를 지나거나 0 이 된다.
``setup()`` 을 지난 모든 ``conda_buildnum`` 를 무시한다.

.. code::

   --buildnum=1

Notes
=====

- ``bdist_conda`` 는 반드시 루트 콘다 환경에 설치되어 ``conda`` 와 ``conda_build`` 를 가져와야 한다. ``conda-build`` 패키지의 일부로 포함되어 있다.

- 모든 메타 데이터는 ``setup()`` 함수에서 나온 표준 메타 데이터로부터 수집되어야 한다. ``setup()`` 가 직접 지원하지 않는 메타 데이터는 아래 명시된 옵션을 사용해 추가할 수 있다.

- 디폴트에 의해 임포트 테스트는 패키지가 명시한 각각의 하위 패키지에 실행된다. 커맨드 라인 테스트 ``command --help`` 는 각각의 ``setuptools entry_points`` 커맨드에 실행된다. 이는 패키지가 제대로 빌드 되었는지 확인하기 위함이다. 테스트들은 아래 명시된 ``conda_import_tests`` 와 ``conda_command_tests`` 옵션으로 비활성화 되거나 변경될 수 있다.

- ``bdist_conda`` 가 ``conda-build`` 를 사용하기 때문에 빌드에 사용된 파이썬 버전은 콘다가 설치된 곳의 파이썬 버전과 동일해야 한다.

- ``bdist_conda`` 는 ``setup()`` 함수에 제공된 메타 데이터를 사용한다.

- 어떤 ``bdist_conda`` 특정 옵션을 ``setup()`` 에 보내고 싶다면, 반드시 ``setup()`` 에서 ``distclass=distutils.command.bdist_conda.CondaDistribution`` 를 설정해야 한다.
