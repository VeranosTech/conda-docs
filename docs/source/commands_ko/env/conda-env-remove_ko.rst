
.. _env remove_ref:

conda env remove
=======================

.. raw:: html

   <PRE>
   <!-- Manpage converted by man2html 3.0.1 -->
   <B>CONDA(1)</B>                         사용자 명령                        <B>CONDA(1)</B>
   
   
   
   
   </PRE>
   <H2>이름</H2><PRE>
          conda - conda env remove
   
   
   </PRE>
   <H2>설명</H2><PRE>
          사용법:  conda-env  remove  [-h]  [-n  ENVIRONMENT  |  <B>-p</B> PATH] [--json]
          [--debug]
   
                 [--verbose] [-q] [-y] [--dry-run]
   
          주어진 환경을 삭제한다. 삭제할 환경은 비활성화되어 있어야 한다.

   
   </PRE>
   <H2>옵션</H2><PRE>
      <B>선택</B> <B>인수:</B>
          <B>-h</B>, <B>--help</B>
                 도움말 메세지를 보고 종료한다.
   
          <B>-n</B> ENVIRONMENT, <B>--name</B> ENVIRONMENT
                 삭제할 환경의 이름.

          <B>-p</B> PATH, <B>--prefix</B> PATH
                 환경 접두어로의 전체 경로.

          <B>--json</B> 모든 출력을 json으로 보고한다. 프로그래머식으로 콘다를 사용할 때 적합하다.

          <B>--debug</B>
                 디버그 출력을 본다.

          <B>--verbose</B>, <B>-v</B>
                 한번 사용하면 정보, 두번 사용하면 디버그, 세번 사용하면 기록을 본다.
   
          <B>-q</B>, <B>--quiet</B>
                 진행바를 표시하지 않는다.

          <B>-y</B>, <B>--yes</B>
                 진행중에 확인을 요청하지 않는다.

          <B>--dry-run</B>
                 완료된 것만을 표시한다.

   
   </PRE>
   <H2>예시</H2><PRE>
                 conda env remove --name FOO conda env remove -n FOO
   
   
   
   
   </PRE>
   <H2>Anaconda, Inc.                      3i 2018                           CONDA(1)</H2><PRE>
   </PRE>
