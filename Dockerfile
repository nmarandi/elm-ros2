FROM osrf/ros:foxy-desktop

COPY ./ros2_ws /app/ros2_ws
WORKDIR /app/ros2_ws
ENV ROS_DISTRO=foxy
ENV ROS_LOG_DIR=/app/ros2_ws/log
CMD ["/bin/bash", "-c", "source /opt/ros/foxy/setup.bash && colcon build --symlink-install && source install/setup.bash && ros2 run py_pubsub talker & source install/setup.bash && ros2 run py_pubsub listener"]

