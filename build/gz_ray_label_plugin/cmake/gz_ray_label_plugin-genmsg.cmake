# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "gz_ray_label_plugin: 2 messages, 0 services")

set(MSG_I_FLAGS "-Igz_ray_label_plugin:/home/felix/catkin_ws/src/gz_ray_label_plugin/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg;-Ivisualization_msgs:/opt/ros/melodic/share/visualization_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/melodic/share/geometry_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(gz_ray_label_plugin_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoints.msg" NAME_WE)
add_custom_target(_gz_ray_label_plugin_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gz_ray_label_plugin" "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoints.msg" "gz_ray_label_plugin/LabelPoint"
)

get_filename_component(_filename "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg" NAME_WE)
add_custom_target(_gz_ray_label_plugin_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "gz_ray_label_plugin" "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(gz_ray_label_plugin
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoints.msg"
  "${MSG_I_FLAGS}"
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gz_ray_label_plugin
)
_generate_msg_cpp(gz_ray_label_plugin
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gz_ray_label_plugin
)

### Generating Services

### Generating Module File
_generate_module_cpp(gz_ray_label_plugin
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gz_ray_label_plugin
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(gz_ray_label_plugin_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(gz_ray_label_plugin_generate_messages gz_ray_label_plugin_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoints.msg" NAME_WE)
add_dependencies(gz_ray_label_plugin_generate_messages_cpp _gz_ray_label_plugin_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg" NAME_WE)
add_dependencies(gz_ray_label_plugin_generate_messages_cpp _gz_ray_label_plugin_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gz_ray_label_plugin_gencpp)
add_dependencies(gz_ray_label_plugin_gencpp gz_ray_label_plugin_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gz_ray_label_plugin_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(gz_ray_label_plugin
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoints.msg"
  "${MSG_I_FLAGS}"
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gz_ray_label_plugin
)
_generate_msg_eus(gz_ray_label_plugin
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gz_ray_label_plugin
)

### Generating Services

### Generating Module File
_generate_module_eus(gz_ray_label_plugin
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gz_ray_label_plugin
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(gz_ray_label_plugin_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(gz_ray_label_plugin_generate_messages gz_ray_label_plugin_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoints.msg" NAME_WE)
add_dependencies(gz_ray_label_plugin_generate_messages_eus _gz_ray_label_plugin_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg" NAME_WE)
add_dependencies(gz_ray_label_plugin_generate_messages_eus _gz_ray_label_plugin_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gz_ray_label_plugin_geneus)
add_dependencies(gz_ray_label_plugin_geneus gz_ray_label_plugin_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gz_ray_label_plugin_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(gz_ray_label_plugin
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoints.msg"
  "${MSG_I_FLAGS}"
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gz_ray_label_plugin
)
_generate_msg_lisp(gz_ray_label_plugin
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gz_ray_label_plugin
)

### Generating Services

### Generating Module File
_generate_module_lisp(gz_ray_label_plugin
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gz_ray_label_plugin
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(gz_ray_label_plugin_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(gz_ray_label_plugin_generate_messages gz_ray_label_plugin_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoints.msg" NAME_WE)
add_dependencies(gz_ray_label_plugin_generate_messages_lisp _gz_ray_label_plugin_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg" NAME_WE)
add_dependencies(gz_ray_label_plugin_generate_messages_lisp _gz_ray_label_plugin_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gz_ray_label_plugin_genlisp)
add_dependencies(gz_ray_label_plugin_genlisp gz_ray_label_plugin_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gz_ray_label_plugin_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(gz_ray_label_plugin
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoints.msg"
  "${MSG_I_FLAGS}"
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gz_ray_label_plugin
)
_generate_msg_nodejs(gz_ray_label_plugin
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gz_ray_label_plugin
)

### Generating Services

### Generating Module File
_generate_module_nodejs(gz_ray_label_plugin
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gz_ray_label_plugin
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(gz_ray_label_plugin_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(gz_ray_label_plugin_generate_messages gz_ray_label_plugin_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoints.msg" NAME_WE)
add_dependencies(gz_ray_label_plugin_generate_messages_nodejs _gz_ray_label_plugin_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg" NAME_WE)
add_dependencies(gz_ray_label_plugin_generate_messages_nodejs _gz_ray_label_plugin_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gz_ray_label_plugin_gennodejs)
add_dependencies(gz_ray_label_plugin_gennodejs gz_ray_label_plugin_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gz_ray_label_plugin_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(gz_ray_label_plugin
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoints.msg"
  "${MSG_I_FLAGS}"
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gz_ray_label_plugin
)
_generate_msg_py(gz_ray_label_plugin
  "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gz_ray_label_plugin
)

### Generating Services

### Generating Module File
_generate_module_py(gz_ray_label_plugin
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gz_ray_label_plugin
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(gz_ray_label_plugin_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(gz_ray_label_plugin_generate_messages gz_ray_label_plugin_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoints.msg" NAME_WE)
add_dependencies(gz_ray_label_plugin_generate_messages_py _gz_ray_label_plugin_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/felix/catkin_ws/src/gz_ray_label_plugin/msg/LabelPoint.msg" NAME_WE)
add_dependencies(gz_ray_label_plugin_generate_messages_py _gz_ray_label_plugin_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(gz_ray_label_plugin_genpy)
add_dependencies(gz_ray_label_plugin_genpy gz_ray_label_plugin_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS gz_ray_label_plugin_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gz_ray_label_plugin)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/gz_ray_label_plugin
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(gz_ray_label_plugin_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET visualization_msgs_generate_messages_cpp)
  add_dependencies(gz_ray_label_plugin_generate_messages_cpp visualization_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gz_ray_label_plugin)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/gz_ray_label_plugin
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(gz_ray_label_plugin_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET visualization_msgs_generate_messages_eus)
  add_dependencies(gz_ray_label_plugin_generate_messages_eus visualization_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gz_ray_label_plugin)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/gz_ray_label_plugin
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(gz_ray_label_plugin_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET visualization_msgs_generate_messages_lisp)
  add_dependencies(gz_ray_label_plugin_generate_messages_lisp visualization_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gz_ray_label_plugin)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/gz_ray_label_plugin
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(gz_ray_label_plugin_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET visualization_msgs_generate_messages_nodejs)
  add_dependencies(gz_ray_label_plugin_generate_messages_nodejs visualization_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gz_ray_label_plugin)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gz_ray_label_plugin\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/gz_ray_label_plugin
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(gz_ray_label_plugin_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET visualization_msgs_generate_messages_py)
  add_dependencies(gz_ray_label_plugin_generate_messages_py visualization_msgs_generate_messages_py)
endif()
