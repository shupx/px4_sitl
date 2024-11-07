cmake_minimum_required(VERSION 3.0.2)
project(px4_sitl)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
)


###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if your package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES px4
#  CATKIN_DEPENDS roscpp rospy std_msgs
#  DEPENDS system_lib
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)


# )

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# catkin_install_python(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables for installation
## See http://docs.ros.org/melodic/api/catkin/html/howto/format1/building_executables.html
# install(TARGETS ${PROJECT_NAME}_node
#   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark libraries for installation
## See http://docs.ros.org/melodic/api/catkin/html/howto/format1/building_libraries.html
# install(TARGETS ${PROJECT_NAME}
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   RUNTIME DESTINATION ${CATKIN_GLOBAL_BIN_DESTINATION}
# )

## Mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

# targets

# install(DIRECTORY build/px4_sitl_default/bin
# 	USE_SOURCE_PERMISSIONS # file permissions will be copied from the source directory structure
#    DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}/${PROJECT_NAME}
# )

# 1. 已经编译好的动态链接库必须放在install/lib下面，才能被 echo $LD_LIBRARY_PATH 找到
# 2. 另外这些动态链接库还必须被gazebo_ros找到，因此还需要在px4_sitl的package.xml中添加
#  <gazebo_ros plugin_path="${prefix}/../../lib"/> 其中${prefix}表示install/share/px4_sitl
# 确保rospack plugins --attrib=plugin_path gazebo_ros能找到这些动态链接库
install(DIRECTORY build/px4_sitl_default/build_gazebo-classic/
  USE_SOURCE_PERMISSIONS # copy file permissions from the source directory structure
  DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
)

# 可执行程序（node节点）必须放在 install/lib/包名 目录下面，才能被rosrun找到
install(DIRECTORY build/px4_sitl_default/bin
  USE_SOURCE_PERMISSIONS # copy file permissions from the source directory structure
  DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}/px4_sitl
)

# single_vehicle_spawn_sdf.launch中用到了$(find px4_sitl)/build/px4_sitl_default/etc，
# 所以etc文件夹必须放在install/share/px4_sitl/build/px4_sitl_default下面
install(DIRECTORY build/px4_sitl_default/etc
  USE_SOURCE_PERMISSIONS # copy file permissions from the source directory structure
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}/build/px4_sitl_default
)

# directory
install(DIRECTORY launch
	DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

install(DIRECTORY models
	DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)

install(DIRECTORY worlds
	DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)



