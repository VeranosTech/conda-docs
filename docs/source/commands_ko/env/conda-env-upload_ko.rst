
.. _env upload_ref:

conda env upload
=======================

.. raw:: html

   <PRE>
   <!-- Manpage converted by man2html 3.0.1 -->
   <B>CONDA(1)</B>                         사용자 명령                        <B>CONDA(1)</B>
   
   
   
   
   </PRE>
   <H2>이름</H2><PRE>
          conda - conda env upload
   
   
   </PRE>
   <H2>설명</H2><PRE>
          사용법:  conda-env  upload  [-h] [-n OLD_NAME] [-f FILE] [--summary SUM-
          MARY] [-q]
   
          [--json] [--debug] [--verbose]
                 [name]
   
          주의:  이 명령은 콘다 4.4에서 만료되었고 콘다 4.5에서 삭제될 예정이다.

          환경을 anaconda.org에 업로드한다.
   
   
   </PRE>
   <H2>옵션</H2><PRE>
      <B>위치</B> <B>인수:</B>
          name   환경 정의
   
      <B>선택</B> <B>인수:</B>
          <B>-h</B>, <B>--help</B>
                 도움말 메세지를 보고 종료한다.
   
          <B>-n</B> OLD_NAME, <B>--name</B> OLD_NAME
                 환경 정의 [만료]
   
          <B>-f</B> FILE, <B>--file</B> FILE
                 환경 정의 파일 (기본: environment.yml)
   
          <B>--summary</B> SUMMARY
                 환경에 대한 짧은 요악.

          <B>-q</B>, <B>--quiet</B>
   
          <B>--json</B> 모든 출력을 json으로 보고한다. 프로그래머식으로 콘다를 사용할 때 적합하다.

          <B>--debug</B>
                 디버그 출력을 본다.

          <B>--verbose</B>, <B>-v</B>
                 한번 사용하면 정보, 두번 사용하면 디버그, 세번 사용하면 기록을 본다.
   
      <B>예시:</B>
                 conda env upload conda  env  upload  project  conda  env  upload
                 <B>--file=</B>/path/to/environment.yml       conda      env      upload
                 <B>--file=</B>/path/to/environment.yml project
   
   
   
   
   </PRE>
   <H2>Anaconda, Inc.                      3i 2018                           CONDA(1)</H2><PRE>
   </PRE>
