콘다 vs. pip vs. virtualenv
============================

pip 또는 virtualenv 에 익숙하다면 :download:`콘다, pip, and virtualenv <conda-pip-virtualenv-translator.html>` 를 비교한 표를 보자.

.. raw:: html

        <html><head><meta http-equiv="refresh" content="0; URL='../_downloads/conda-pip-virtualenv-translator.html'" /></head><body></body></html>

pip 와 virtualenv 를 사용한 경험이 있다면 콘다를 사용해 동일한 작업을 할 수 있다.
pip 는 패키지 관리자, virtualenv 는 환경 관리자이지만 콘다는 두가지 모두 가능하다.

=====================================   ========================================================   ========================================================================   ========================================================
작업                                     콘다 패키지, 환경 관리 커맨드                                     Pip 패키지 관리 커맨드                                                          Virtualenv 환경 관리 커맨드
=====================================   ========================================================   ========================================================================   ========================================================
Install a package                       ``conda install $PACKAGE_NAME``                            ``pip install $PACKAGE_NAME``                                              X
Update a package                        ``conda update --name $ENVIRONMENT_NAME $PACKAGE_NAME``                      ``pip install --upgrade $PACKAGE_NAME``                                    X
Update package manager                  ``conda update conda``                                     Linux/OSX: ``pip install -U pip`` Win: ``python -m pip install -U pip``    X
Uninstall a package                     ``conda remove --name $ENVIRONMENT_NAME $PACKAGE_NAME``    ``pip uninstall $PACKAGE_NAME``                                            X
Create an environment                   ``conda create --name $ENVIRONMENT_NAME python``           X                                                                          ``cd $ENV_BASE_DIR; virtualenv $ENVIRONMENT_NAME``
Activate an environment                 ``source activate $ENVIRONMENT_NAME``                      X                                                                          ``source $ENV_BASE_DIR/$ENVIRONMENT_NAME/bin/activate``
Deactivate an environment               ``source deactivate``                                      X                                                                          ``deactivate``
Search available packages               ``conda search $SEARCH_TERM``                              ``pip search $SEARCH_TERM``                                                X
Install package from specific source    ``conda install --channel $URL $PACKAGE_NAME``             ``pip install --index-url $URL $PACKAGE_NAME``                             X
List installed packages                 ``conda list --name $ENVIRONMENT_NAME``                    ``pip list``                                                               X
Create requirements file                ``conda list --export``                                    ``pip freeze``                                                             X
List all environments                   ``conda info --envs``                                      X                                                                          Install virtualenv wrapper, then ``lsvirtualenv``
Install other package manager           ``conda install pip``                                      ``pip install conda``                                                      X
Install Python                          ``conda install python=x.x``                               X                                                                          X
Update Python                           ``conda update python`` *                                  X                                                                          X
=====================================   ========================================================   ========================================================================   ========================================================

* ``conda update python`` 커맨드는 시리즈의 가장 최선 버전으로 업데이트 한다. 예를 들어 파이썬 2.7 은 파이썬 2 시리즈 중 가장 높은 버전으로 업데이트 된다. 파이썬 3.6 이라면 파이썬 3 시리즈 중 가능 높은 버전이 된다.

.. 패키지가 설치한 파일들을 보여주는 ``pip show --files $PACKAGE_NAME``  커맨드는 불가능하다.
.. 개별 패키지의 세부사항을 보여주는 ``pip show $PACKAGE_NAME``  커맨드는 불가능하다.
.. 사용 가능한 환경을 나열하는 것은 불가능 하다. ``conda info -e``
.. #user will want to pass that through ``tail -n +3 | awk '{print $1;}'``
