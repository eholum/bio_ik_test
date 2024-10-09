#!/bin/bash

ROS_DISTRO=${ROS_DISTRO:-iron}

docker build -t bio_ik_test:"${ROS_DISTRO}" --build-arg ROS_DISTRO="${ROS_DISTRO}" .
