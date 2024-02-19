#!/bin/bash

sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
sudo apt install ros-foxy-ros-base python3-argcomplete
#installing colcon
sudo apt install -y python3-colcon-common-extensions
#installing rosdep
sudo apt install -y python3-rosdep
sudo apt-get install ros-$ROS_DISTRO-demo-nodes-py
#initializing rosdep
sudo rosdep init
rosdep update
source /opt/ros/foxy/setup.bash
#run ros2 talker and listener
ros2 run demo_nodes_py talker & ros2 run demo_nodes_py listener
