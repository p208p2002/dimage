# https://hub.docker.com/r/nvidia/cuda/tags?page=1&name=devel-ubuntu
ARG BASE_IMAGE_TAG=12.1.1-devel-ubuntu20.04
FROM nvidia/cuda:${BASE_IMAGE_TAG}

# setup user
ARG USERNAME=dimage
ENV USERNAME=${USERNAME}
RUN useradd -ms /bin/bash $USERNAME
RUN usermod -aG sudo $USERNAME
RUN apt-get update && apt-get install -y sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# TZ
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei
RUN apt-get update && apt-get install -y tzdata

# ssh
RUN apt-get install -y openssh-server 

# switch to USER
USER $USERNAME
WORKDIR /home/${USERNAME}
ENV HOME=/home/${USERNAME}

# create bash config for user 
RUN cp /etc/skel/.bashrc .
RUN cp /etc/skel/.profile .

# tools, package, git
RUN sudo apt-get update &&\
    sudo apt-get install -y net-tools iputils-ping wget curl git git-lfs htop vim&&\
    git lfs install

# dependence (DeepSpeed)
RUN sudo apt-get install -y libaio-dev ninja-build

# pyenv
ARG PYTHON_VERSION=3.10

#set mirrors if you need
#RUN sed -i 's/dl-cdn.alpinelinux.org/repo.huaweicloud.com/g' /etc/apk/repositories

# https://github.com/pyenv/pyenv/wiki
RUN sudo apt update && sudo apt install -y build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev curl \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv

ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

#set mirrors if you need
#ENV PYTHON_BUILD_MIRROR_URL="https://repo.huaweicloud.com/python"
#ENV PYTHON_BUILD_MIRROR_URL_SKIP_CHECKSUM=1
RUN pyenv install $PYTHON_VERSION
RUN pyenv global $PYTHON_VERSION

RUN pip install poetry nvitop

# copy env varable for USER
RUN env | egrep -v "^(HOME=|USER=|MAIL=|LC_ALL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=)" >> .container_env
RUN echo "export \$(cat /home/${USERNAME}/.container_env | xargs)" >> .bashrc

# entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN sudo chmod 777 /docker-entrypoint.sh
ENTRYPOINT /docker-entrypoint.sh && /bin/bash || /bin/bash
