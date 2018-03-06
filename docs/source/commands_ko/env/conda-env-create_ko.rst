
.. _env create_ref:

conda env create
=======================

.. raw:: html

   <PRE>
   <!-- Manpage converted by man2html 3.0.1 -->
   <B>CONDA(1)</B>                         사용자 명령                        <B>CONDA(1)</B>
   
   
   
   
   </PRE>
   <H2>이름</H2><PRE>
          conda - conda env create
   
   
   </PRE>
   <H2>설명</H2><PRE>
          사용법: conda-env create [-h] [-f FILE] [-n ENVIRONMENT | <B>-p</B> PATH] [-q]
   
          [--force] [--json] [--debug] [--verbose]
                 [remote_definition]
   
          환경 파일로부터 콘다 환경을 생성한다.

   
   </PRE>
   <H2>옵션</H2><PRE>
      <B>위치</B> <B>인수:</B>
          remote_definition
                 리모트 환경 정의 / IPython 노트북
   
      <B>선택</B> <B>인수:</B>
          <B>-h</B>, <B>--help</B>
                 도움말을 보고 종료한다.

          <B>-f</B> FILE, <B>--file</B> FILE
                 환경 정의 파일. (기본: environment.yml)
   
          <B>-n</B> ENVIRONMENT, <B>--name</B> ENVIRONMENT
                 생성할 환경 이름.
   
          <B>-p</B> PATH, <B>--prefix</B> PATH
                 환경 접두어로의 경로.

          <B>-q</B>, <B>--quiet</B>
   
          <B>--force</B>
                 강제로 환경을 생성한다. (같은 이름을 갖는 기존 환경이 있으면 삭제한다.)

          <B>--json</B> 모든 출력을 json으로 보고한다. 콘다를 프로그래머식으로 사용할 때 적합하다.

          <B>--debug</B>
                 디버그 출력을 본다.

          <B>--verbose</B>, <B>-v</B>
                 한번 사용하면 정보, 두번 사용하면 디버그, 세번 사용하면 기록을 본다.

      <B>예시:</B>
                 conda  env  create  conda  env  create  <B>-n</B> name conda env create
                 vader/deathstar  conda  env  create  <B>-f=</B>/path/to/environment.yml
                 conda env create <B>-f=</B>/path/to/requirements.txt <B>-n</B> deathstar conda
                 env  create  <B>-f=</B>/path/to/requirements.txt  <B>-p</B>   <I>/home/user/soft-</I>
                 <I>ware/deathstar</I>
   
   
   
   
   </PRE>
   <H2>Anaconda, Inc.                      3i 2018                           CONDA(1)</H2><PRE>
   </PRE>
