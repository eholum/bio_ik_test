#!/bin/bash

WORKDIR="/opt/bio_ik_test"
ROS_DISTRO=${ROS_DISTRO:-iron}

docker run -v ./src:"${WORKDIR}"/src:rw \
           -v "${FASTRTPS_DEFAULT_PROFILES_FILE:-./config/fastdds.xml}":/fastdds.xml:ro \
           -v "${CYCLONEDDS_URI:-./config/cyclonedds.xml}":/cyclonedds.xml:ro \
           -e ROS_DOMAIN_ID="${ROS_DOMAIN_ID:-1}" \
           -e RMW_IMPLEMENTATION=rmw_fastrtps_cpp \
           -e FASTRTPS_DEFAULT_PROFILES_FILE=/fastdds.xml \
           -e CYCLONEDDS_URI=/cyclonedds.xml \
           -it \
           bio_ik_test:${ROS_DISTRO} \
           bash
