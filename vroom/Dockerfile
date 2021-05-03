FROM ubuntu:18.04

ARG VROOM_SSH_USER
ARG VROOM_SSH_PASSWORD

RUN apt-get update
RUN apt-get install -y libssl-dev libasio-dev libglpk-dev git openssh-server

# INSTALL VROOM 
RUN git clone https://github.com/VROOM-Project/vroom.git

WORKDIR /vroom

RUN git checkout v1.9.0
RUN cd src && make && cd ..
RUN mv ./bin/vroom /bin/vroom

# INSTALL SSH
WORKDIR /

RUN mkdir /var/run/sshd

RUN echo '${VROOM_SSH_USER}:${VROOM_SSH_PASSWORD}' | chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
