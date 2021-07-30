FROM gradle:7.1.1-jdk8

ARG USERNAME
ENV USERNAME ${USERNAME:-root}

ARG UID
ENV UID ${UID:-1000}

ARG GID
ENV GID ${GID:-1000}

ENV LC_ALL en_US.UTF-8

# Change JVM max memory size
ENV _JAVA_OPTIONS -Xmx24g

RUN apt-get update && apt-get -y install libxext-dev \
    libxrender-dev \
    libxtst-dev \
    libxxf86vm-dev \
    libgl1-mesa-dev \
    libgl1-mesa-dri \
    libglu1-mesa-dev \
    libglu1-mesa \
    libglw1-mesa-dev \
    mesa-utils


RUN mkdir -p /home/${USERNAME}

# Install jtk
RUN git clone https://github.com/MinesJTK/jtk.git /home/${USERNAME}/jtk && \
    cd /home/${USERNAME}/jtk && \
    gradle

# Create Data folder for binding
RUN cd / && mkdir -p data

#Define usuário e suas permissões
RUN mkdir -p /home/${USERNAME}/.local/share && \
    mkdir -p /home/${USERNAME}/idh && \
    echo "${USERNAME}:x:${UID}:${GID}:${USERNAME},,,:/home/${USERNAME}:/bin/bash" >> /etc/passwd && \
    echo "${USERNAME}:x:${UID}:" >> /etc/group && \
    chown ${UID}:${GID} -R /home/${USERNAME}

USER ${USERNAME}
ENV HOME /home/${USERNAME}
WORKDIR ${HOME}
