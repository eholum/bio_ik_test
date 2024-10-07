cmake_minimum_required(VERSION 3.22)
project(bio_ik_test)

set(THIS_PACKAGE_INCLUDE_DEPENDS
  moveit_core
  moveit_ros_planning_interface
  moveit_msgs
  pluginlib
)

foreach(Dependency IN ITEMS ${THIS_PACKAGE_INCLUDE_DEPENDS})
  find_package(${Dependency} REQUIRED)
endforeach()

find_package(bio_ik REQUIRED)

add_executable(bio_ik_test
    src/test.cpp
)
ament_target_dependencies(bio_ik_test
  bio_ik  # This should break everything
  ${THIS_PACKAGE_INCLUDE_DEPENDS}
)

install(TARGETS bio_ik_test 
  EXPORT export_bio_ik_test
  DESTINATION lib/${PROJECT_NAME}
)

install(DIRECTORY launch
  DESTINATION share/${PROJECT_NAME}
)

ament_export_targets(export_bio_ik_test)
ament_package()
