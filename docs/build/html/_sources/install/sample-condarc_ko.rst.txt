====================
샘플 .condarc 파일
====================

.. code-block:: yaml

  # 이 파일은 샘플 .condarc 파일이다. 이 파일은 r Anaconda.org 채널을 추가하고
  # show_channel_urls 옵션을 허용한다.

  # channel locations. 이 옵션은 콘다 디폴트를 무시한다. 예를 들어,
  # 콘다는 이 파일에 나열된 **채널만을** 순서대로 검색한다. "defaults" 로
  # 모든 디폴트 채널이 자동으로 포함된다. url이 아닌 채널은
  # Anaconda.org 의 사용자명으로 해석된다. (이 기능은
  # channel_alias key; 를 수정해 변경할 수 있다. 아래에서 설명한다.). 디폴트는 'defaults' 이다.
  channels:
    - r
    - defaults

  # 다운로드 될 패키지와 'conda list' 상의 패키지의Show channel URLs when displaying what is going to be downloaded and
  # 채널 url 을 보여주고 을 보여준다. 디폴트는 False 이다.
  show_channel_urls: True


  # https://conda.io/docs/config.html 에서 이 파일에 대한 상세 정보를 볼 수 있다.
