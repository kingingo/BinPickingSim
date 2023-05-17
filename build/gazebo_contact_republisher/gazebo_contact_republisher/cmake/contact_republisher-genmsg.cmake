# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "contact_republisher: 2 messages, 0 services")

set(MSG_I_FLAGS "-Icontact_republisher:/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(contact_republisher_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contacts_msg.msg" NAME_WE)
add_custom_target(_contact_republisher_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "contact_republisher" "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contacts_msg.msg" "contact_republisher/contact_msg"
)

get_filename_component(_filename "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg" NAME_WE)
add_custom_target(_contact_republisher_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "contact_republisher" "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(contact_republisher
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contacts_msg.msg"
  "${MSG_I_FLAGS}"
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/contact_republisher
)
_generate_msg_cpp(contact_republisher
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/contact_republisher
)

### Generating Services

### Generating Module File
_generate_module_cpp(contact_republisher
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/contact_republisher
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(contact_republisher_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(contact_republisher_generate_messages contact_republisher_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contacts_msg.msg" NAME_WE)
add_dependencies(contact_republisher_generate_messages_cpp _contact_republisher_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg" NAME_WE)
add_dependencies(contact_republisher_generate_messages_cpp _contact_republisher_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(contact_republisher_gencpp)
add_dependencies(contact_republisher_gencpp contact_republisher_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS contact_republisher_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(contact_republisher
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contacts_msg.msg"
  "${MSG_I_FLAGS}"
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/contact_republisher
)
_generate_msg_eus(contact_republisher
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/contact_republisher
)

### Generating Services

### Generating Module File
_generate_module_eus(contact_republisher
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/contact_republisher
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(contact_republisher_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(contact_republisher_generate_messages contact_republisher_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contacts_msg.msg" NAME_WE)
add_dependencies(contact_republisher_generate_messages_eus _contact_republisher_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg" NAME_WE)
add_dependencies(contact_republisher_generate_messages_eus _contact_republisher_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(contact_republisher_geneus)
add_dependencies(contact_republisher_geneus contact_republisher_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS contact_republisher_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(contact_republisher
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contacts_msg.msg"
  "${MSG_I_FLAGS}"
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/contact_republisher
)
_generate_msg_lisp(contact_republisher
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/contact_republisher
)

### Generating Services

### Generating Module File
_generate_module_lisp(contact_republisher
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/contact_republisher
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(contact_republisher_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(contact_republisher_generate_messages contact_republisher_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contacts_msg.msg" NAME_WE)
add_dependencies(contact_republisher_generate_messages_lisp _contact_republisher_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg" NAME_WE)
add_dependencies(contact_republisher_generate_messages_lisp _contact_republisher_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(contact_republisher_genlisp)
add_dependencies(contact_republisher_genlisp contact_republisher_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS contact_republisher_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(contact_republisher
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contacts_msg.msg"
  "${MSG_I_FLAGS}"
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/contact_republisher
)
_generate_msg_nodejs(contact_republisher
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/contact_republisher
)

### Generating Services

### Generating Module File
_generate_module_nodejs(contact_republisher
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/contact_republisher
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(contact_republisher_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(contact_republisher_generate_messages contact_republisher_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contacts_msg.msg" NAME_WE)
add_dependencies(contact_republisher_generate_messages_nodejs _contact_republisher_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg" NAME_WE)
add_dependencies(contact_republisher_generate_messages_nodejs _contact_republisher_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(contact_republisher_gennodejs)
add_dependencies(contact_republisher_gennodejs contact_republisher_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS contact_republisher_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(contact_republisher
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contacts_msg.msg"
  "${MSG_I_FLAGS}"
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/contact_republisher
)
_generate_msg_py(contact_republisher
  "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/contact_republisher
)

### Generating Services

### Generating Module File
_generate_module_py(contact_republisher
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/contact_republisher
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(contact_republisher_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(contact_republisher_generate_messages contact_republisher_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contacts_msg.msg" NAME_WE)
add_dependencies(contact_republisher_generate_messages_py _contact_republisher_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/felix/catkin_ws/src/gazebo_contact_republisher/gazebo_contact_republisher/msg/contact_msg.msg" NAME_WE)
add_dependencies(contact_republisher_generate_messages_py _contact_republisher_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(contact_republisher_genpy)
add_dependencies(contact_republisher_genpy contact_republisher_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS contact_republisher_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/contact_republisher)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/contact_republisher
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(contact_republisher_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/contact_republisher)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/contact_republisher
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(contact_republisher_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/contact_republisher)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/contact_republisher
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(contact_republisher_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/contact_republisher)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/contact_republisher
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(contact_republisher_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/contact_republisher)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/contact_republisher\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/contact_republisher
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(contact_republisher_generate_messages_py std_msgs_generate_messages_py)
endif()
