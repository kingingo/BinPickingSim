# BinPickingSim

installation:
````
export GAZEBO_MODEL_PATH=~/catkin_ws/src/gazebo_sensors_tutorial/models/:${GAZEBO_MODEL_PATH}
source ~/.bashrc
````

start with
````
roslaunch gazebo_sensors_tutorial binpacking.launch
````

auto restart with crontab

````
tty > /dev/pts/0
````

````
/path/catkin_ws/run.sh > /dev/pts/0
````
