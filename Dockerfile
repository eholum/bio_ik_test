ARG ROS_DISTRO=iron

FROM ros:${ROS_DISTRO} AS bio_ik_test
SHELL [ "/bin/bash", "-o", "pipefail", "-c" ]

RUN sudo apt update && sudo apt install -y \
    lld \
    ccache \
    tmux \
    gdb \
    gdbserver \
    vim

ENV WORKDIR=/opt/bio_ik_test/
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

RUN sudo apt install -y \
    ros-${ROS_DISTRO}-fastrtps-dbgsym \
    ros-${ROS_DISTRO}-rmw-fastrtps-dynamic-cpp-dbgsym \
    ros-${ROS_DISTRO}-rosidl-typesupport-fastrtps-cpp-dbgsym \
    ros-${ROS_DISTRO}-rmw-fastrtps-shared-cpp-dbgsym

COPY config/entrypoint.sh /entrypoint.sh
RUN sudo chmod a+x /entrypoint.sh
RUN echo "source /entrypoint.sh" >> ~/.bashrc
ENTRYPOINT ["/entrypoint.sh"]
