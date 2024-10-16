from launch import LaunchDescription
from launch_ros.actions import Node


def generate_launch_description():

    bio_ik_test = Node(
        name="test_tutorial",
        package="bio_ik_test",
        executable="bio_ik_test",
        output="both",
        # prefix=['gdbserver localhost:3000'],
    )

    return LaunchDescription([bio_ik_test])
