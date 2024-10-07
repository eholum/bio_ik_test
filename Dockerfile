ARG ROS_DISTRO=humble

FROM ros:${ROS_DISTRO} AS bio_ik_test
SHELL [ "/bin/bash", "-o", "pipefail", "-c" ]

RUN sudo apt update && sudo apt install -y \
    lld \
    ccache \
    tmux \
    gdb \
    gdbserver \
    vim

ENV WORKDIR=${HOME}/bio_ik_test/
RUN mkdir -p ${WORKDIR}/src

WORKDIR ${WORKDIR}
COPY src src
RUN sudo apt update && \
    rosdep update --rosdistro ${ROS_DISTRO} && \
    rosdep install -iry --rosdistro ${ROS_DISTRO} --from-paths src/

RUN colcon mixin add default \
    https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml || true && \
    colcon mixin update && \
    colcon metadata add default \
    https://raw.githubusercontent.com/colcon/colcon-metadata-repository/master/index.yaml || true && \
    colcon metadata update

COPY config/colcon-defaults.yaml ${HOME:-/root}/.colcon/defaults.yaml
RUN source /opt/ros/${ROS_DISTRO}/setup.bash && \
    colcon build

COPY config/entrypoint.sh /entrypoint.sh
RUN sudo chmod a+x /entrypoint.sh
RUN echo "source /entrypoint.sh" >> ~/.bashrc
ENTRYPOINT ["/entrypoint.sh"]
