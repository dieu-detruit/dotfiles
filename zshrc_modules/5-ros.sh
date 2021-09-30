# ros
rosenv () {
    if [ $1 = "noetic" ]; then
        echo "source /opt/ros/noetic/setup.zsh" > $HOME/.cache/ros.sh
        echo "rosenv was set to noetic"
    elif [ $1 = "foxy" ]; then
        echo "source $HOME/tools/ros2_foxy/ros2-linux/setup.zsh" > $HOME/.cache/ros.sh
        echo "rosenv was set to foxy"
    else
        echo "Usage: rosenv [noetic | foxy]"
    fi
}
source $HOME/.cache/ros.sh
