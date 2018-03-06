
.. _env export_ref:

conda env export
=======================

.. raw:: html

   <PRE>
   <!-- Manpage converted by man2html 3.0.1 -->
   <B>CONDA(1)</B>                         사용자 명령                        <B>CONDA(1)</B>
   
   
   
   
   </PRE>
   <H2>이름</H2><PRE>
          conda - conda env export
   
   
   </PRE>
   <H2>설명</H2><PRE>
          사용법: conda-env export [-h] [-c CHANNEL] [--override-channels]
   
          [-n ENVIRONMENT | <B>-p</B> PATH] [-f FILE] [--no-builds]
                 [--ignore-channels] [--json] [--debug] [--verbose]
   
          주어진 환경을 내보낸다.

   
   </PRE>
   <H2>옵션</H2><PRE>
      <B>위치</B> <B>인수:</B>
          <B>-h</B>, <B>--help</B>
                 도움말 메세지를 보고 종료한다.
   
          <B>-c</B> CHANNEL, <B>--channel</B> CHANNEL
                 출력에 포함될 추가 채널.

          <B>--override-channels</B>
                 .condarc 채널을 포함하지 않는다.

          <B>-n</B> ENVIRONMENT, <B>--name</B> ENVIRONMENT
                 내보낼 환경 이름.

          <B>-p</B> PATH, <B>--prefix</B> PATH
                 환경 접두어로의 경로.
   
          <B>-f</B> FILE, <B>--file</B> FILE
   
          <B>--no-builds</B>
                 의존 요소로부터의 빌드 사양을 제거한다.
   
          <B>--ignore-channels</B>
                 패키지 이름에 채널 이름을 포함하지 않는다.

          <B>--json</B> 모든 출력을 json으로 보고한다. 프로그래머식으로 콘다를 사용할 때 적합하다.

          <B>--debug</B>
                 디버그 출력을 본다.
   
          <B>--verbose</B>, <B>-v</B>
                 한번 사용하면 정보, 두번 사용하면 디버그, 세번 사용하면 기록을 본다.
   
      <B>예시:</B>
                 conda env export conda env export <B>--file</B> SOME_FILE
   
   
   
   
   </PRE>
   <H2>Anaconda, Inc.                      3i 2018                           CONDA(1)</H2><PRE>
   </PRE>
