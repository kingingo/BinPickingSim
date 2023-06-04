#!/usr/bin/env bash
source /opt/ros/melodic/setup.bash
export GAZEBO_MODEL_PATH=/home/felix/catkin_ws/src/gazebo_sensors_tutorial/models/:${GAZEBO_MODEL_PATH}

v=$(eval "ps aux | grep -c 'gzserver'")
if [ $v -lt 2 ]; then
    source /home/felix/catkin_ws/devel/setup.sh
    roslaunch gazebo_sensors_tutorial binpacking.launch
else
    echo "gzserver is still running"
fi