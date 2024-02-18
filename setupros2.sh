#!/bin/bash

sudo apt update && sudo apt install -y curl gnupg2 lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
#download ROS2
sudo apt update
curl -LJO https://github.com/ros2/ros2/releases/download/release-foxy-20230620/ros2-foxy-20230620-linux-focal-amd64.tar.bz2
mkdir -p ~/ros2_foxy
tar xf ros2-foxy-20230620-linux-focal-amd64.tar.bz2 --directory ~/ros2_foxy
#installing colcon
sudo apt install -y python3-colcon-common-extensions
#installing rosdep
sudo apt install -y python3-rosdep
#initializing rosdep
sudo rosdep init
rosdep update
rosdep install --from-paths ~/ros2_foxy/ros2-linux/share --ignore-src -y --skip-keys "cyclonedds fastcdr fastrtps rti-connext-dds-5.3.1 urdfdom_headers"
#installing argcomplete
sudo apt install -y python3-argcomplete
. ~/ros2_foxy/ros2-linux/setup.bash
#run ros2 talker and listener
ros2 run demo_nodes_py talker & ros2 run demo_nodes_py listener