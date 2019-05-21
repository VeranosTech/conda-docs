=================
커맨드 레퍼런스
=================

콘다는 패키지와 환경 관리를 위한 여러 커맨드를 제공한다. 다음 페이지에 각각의 커맨드를 위한 도움말이 있다.
커맨드 도움말은 커맨드 라인에 ``--help`` 플래그를 추가해 볼 수 있다.:

.. code-block:: bash

   conda install --help


콘다 일반 커맨드
======================

다음 커맨드들이 콘다를 구성한다.

.. toctree::
   :glob:
   :maxdepth: 2

   commands/*


콘다 빌드 커맨드
====================

다음 커맨드들이 ``conda-build`` 패키지를 구성한다. ``conda install conda-build`` 커맨드에 의해 설치된다.

.. toctree::
   :glob:
   :maxdepth: 2

   commands/build/*


콘다 환경 커맨드
==========================

다음 커맨드들이 ``conda-env`` 패키지를 구성한다. 콘다와 함께 자동으로 설치된다.

.. toctree::
   :glob:
   :maxdepth: 2

   commands/env/*
