
.. _env attach_ref:

conda env attach
=======================

.. raw:: html

   <PRE>
   <!-- Manpage converted by man2html 3.0.1 -->
   <B>CONDA(1)</B>                         사용자 명령                        <B>CONDA(1)</B>
   
   
   
   
   </PRE>
   <H2>이름</H2><PRE>
          conda - conda env attach
   
   
   </PRE>
   <H2>설명</H2><PRE>
          사용법: conda-env attach [-h] (<B>-n</B> NAME | <B>-r</B> REMOTE) [-p PATH] [--force]
   
          [--no-builds] [--json] [--debug] [--verbose]
                 notebook
   
          주의:  이 명령은 콘다 4.4에서 만료되었고 콘다 4.5에서 삭제될 예정이다.

          노트북 메타데이터에 사용자의 콘다 환경에 대한 정보를 넣는다.

   
   </PRE>
   <H2>옵션</H2><PRE>
      <B>위치</B> <B>인수:</B>
          notebook
                 노트북 파일
   
      <B>선택</B> <B>인수:</B>
          <B>-h</B>, <B>--help</B>
                 도움말 메세지를 보고 종료한다.

          <B>-n</B> NAME, <B>--name</B> NAME
                 로컬 환경 정의.

          <B>-r</B> REMOTE, <B>--remote</B> REMOTE
                 리모트 환경 정의.

          <B>-p</B> PATH, <B>--prefix</B> PATH
                 환경 접두어로의 경로.

          <B>--force</B>
                 기존 환경 정의를 대체한다.

          <B>--no-builds</B>
                 의존 요소로부터의 빌드 사양을 제거한다.

          <B>--json</B> 모든 출력을 json으로 보고한다. 프로그래머식으로 콘다를 사용할 때 적합하다.

          <B>--debug</B>
                 디버그 출력을 본다.

          <B>--verbose</B>, <B>-v</B>
                 한번 사용하면 정보, 두번 사용하면 디버그, 세번 사용하면 기록을 본다.
   
      <B>예시:</B>
                 conda env attach <B>-n</B> base  notebook.ipynb  conda  env  attach  <B>-r</B>
                 user/environment notebook.ipynb
   
   
   
   
   </PRE>
   <H2>Anaconda, Inc.                      3i 2018                           CONDA(1)</H2><PRE>
   </PRE>
