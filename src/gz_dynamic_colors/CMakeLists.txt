cmake_minimum_required(VERSION 3.0.2)
project(gz_dynamic_colors)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  roscpp
  gazebo_ros
  std_msgs
  gazebo_msgs
)

add_message_files(
  FILES 
  DColor.msg  
)
generate_messages(DEPENDENCIES std_msgs)

# Depend on system install of Gazebo
find_package(gazebo REQUIRED)

include_directories(
  ${Boost_INCLUDE_DIR} 
  ${catkin_INCLUDE_DIRS} 
  ${GAZEBO_INCLUDE_DIRS}
  #${CMAKE_CURRENT_BINARY_DIR}/msgs 
)
link_directories(
  ${GAZEBO_LIBRARY_DIRS} 
  #${CMAKE_CURRENT_BINARY_DIR}/msgs
)
#add_subdirectory(msgs)

catkin_package(
  LIBRARIES
    rviz
    ${OGRE_LIBRARIES}
    ${rviz_ADDITIONAL_LIBRARIES}
    ${OPENGL_LIBRARIES}
  CATKIN_DEPENDS roscpp gazebo_ros 
)

add_library(${PROJECT_NAME} src/gz_dynamic_colors.cc)
target_link_libraries(${PROJECT_NAME} ${catkin_LIBRARIES} ${GAZEBO_LIBRARIES})