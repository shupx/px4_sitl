# px4_sitl

This is a ROS package containing the px4 SITL (Software In The Loop) targets and gazebo simulation plugins. All these targets and plugins are compiled from the [PX4 source code](https://github.com/PX4/PX4-Autopilot). The aim of this package is to simpilify the process of PX4 SITL simulation with gazebo as all the targets are prebuilt.

## Dependencies

```bash
sudo apt install ros-noetic-mavros ros-noetic-mavros-extras -y
wget https://gitee.com/shu-peixuan/ros-install-command/raw/c9865c748045a0cce0173fcfcb95729784bd31e5/install_geographiclib_datasets.sh
sudo chmod a+x ./install_geographiclib_datasets.sh
sudo ./install_geographiclib_datasets.sh # this step takes some time
rm install_geographiclib_datasets.sh
```

```bash
sudo apt install gazebo11 -y
sudo apt install ros-noetic-gazebo-ros -y
sudo apt install xmlstarlet 
```

PX4 SITL build version:

v1.14.3 (with modified fixed-wing offboard mode in which PX4 receives roll/height/airspeed setpoints).

## Build

```bash
mkdir -p px4_sitl_ws/src
cd px4_sitl_ws/src
git clone https://gitee.com/bhswift/px4_sitl.git
cd ../
catkin_make install
```

## Usage

Source the bash script either in `devel/` or in `install/`.

```bash
source devel/setup.bash
# source install/setup.bash
```

Run the simulation:

```bash
roslaunch px4_sitl single_mavros_px4_gazebo_sitl.launch vehicle:=iris gazebo_gui:=true

### Instruction:
vehicle: iris, plane, standard_vtol # px4 sitl vehicle type
gazebo_gui: true, false # open gazebo UI or not
```

## Develop

For a modified PX4 source code, compile the PX4 SITL in the source repo :

```bash
cd ~/PX4-Autopilot
make px4_sitl gazebo-classic
```

and substitute the `build/px4_sitl_default/bin` folder:

```bash
cp -r ~/PX4-Autopilot/build/px4_sitl_default/bin ~/px4_sitl_ws/src/px4_sitl/build/px4_sitl_default/bin
```
