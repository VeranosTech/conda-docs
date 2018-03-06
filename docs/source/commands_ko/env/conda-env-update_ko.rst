
.. _env update_ref:

conda env update
=======================

.. raw:: html

   <PRE>
   <!-- Manpage converted by man2html 3.0.1 -->
   <B>CONDA(1)</B>                         사용자 명령                        <B>CONDA(1)</B>
   
   
   
   
   </PRE>
   <H2>이름</H2><PRE>
          conda - conda env update
   
   
   </PRE>
   <H2>설명</H2><PRE>
          사용법:  conda-env  update  [-h]  [-n  ENVIRONMENT  | <B>-p</B> PATH] [-f FILE]
          [--prune]
   
          [-q] [--json] [--debug] [--verbose]
                 [remote_definition]
   
          환경 파일로부터 현재 환경을 업데이트한다.

   
   </PRE>
   <H2>옵션</H2><PRE>
      <B>위치</B> <B>인수:</B>
          remote_definition
                 리모트 환경 정의 / IPython 노트북
   
      <B>선택</B> <B>인수:</B>
          <B>-h</B>, <B>--help</B>
                 도움말 메세지를 보고 종료한다.
   
          <B>-n</B> ENVIRONMENT, <B>--name</B> ENVIRONMENT
                 업데이트할 환경의 이름.

          <B>-p</B> PATH, <B>--prefix</B> PATH
                 환경 접두어로의 전체 경로.

          <B>-f</B> FILE, <B>--file</B> FILE
                 환경 정의 (기본: environment.yml)
   
          <B>--prune</B>
                 environment.yml 파일에 정의되지 않은 패키지는 삭제한다.
   
          <B>-q</B>, <B>--quiet</B>
   
          <B>--json</B> 모든 출력을 json으로 보고한다. 프로그래머식으로 콘다를 사용할 때 적합하다.

          <B>--debug</B>
                 디버그 출력을 본다.

          <B>--verbose</B>, <B>-v</B>
                 한번 사용하면 정보, 두번 사용하면 디버그, 세번 사용하면 기록을 본다.
   
      <B>예시:</B>
                 conda  env  update  conda  env  update  <B>-n</B>=<I>foo</I>  conda env update
                 <B>-f=</B>/path/to/environment.yml   conda   env   update    <B>--name</B>=<I>foo</I>
                 <B>--file</B>=<I>environment</I>.yml conda env update vader/deathstar
   
   
   
   
   </PRE>
   <H2>Anaconda, Inc.                      3i 2018                           CONDA(1)</H2><PRE>
   </PRE>
