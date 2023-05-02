# https://hub.docker.com/r/pytorch/pytorch/tags?page=1&name=devel
ARG BASE_IMAGE_TAG=2.0.0-cuda11.7-cudnn8-devel
FROM pytorch/pytorch:${BASE_IMAGE_TAG}

# setup user
ENV USERNAME dimage
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

# script for create user
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 777 /docker-entrypoint.sh

USER $USERNAME

WORKDIR /home/${USERNAME}
RUN cp /etc/skel/.bashrc .
RUN cp /etc/skel/.profile .

# tools, package
RUN sudo apt-get update &&\
    sudo apt-get install -y net-tools iputils-ping wget curl git git-lfs htop vim&&\
    git lfs install

# dependence
RUN sudo apt-get install -y libaio-dev ninja-build

RUN env | egrep -v "^(HOME=|USER=|MAIL=|LC_ALL=|LS_COLORS=|LANG=|HOSTNAME=|PWD=|TERM=|SHLVL=|LANGUAGE=|_=)" >> .container_env
RUN echo "export \$(cat /home/${USERNAME}/.container_env | xargs)" >> .bashrc

RUN pip install deepspeed lightning transformers datasets

ENTRYPOINT /docker-entrypoint.sh && /bin/bash
