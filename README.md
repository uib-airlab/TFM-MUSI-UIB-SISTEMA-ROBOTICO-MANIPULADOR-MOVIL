# TFM-MUSI-UIB-SISTEMA-ROBOTICO-MANIPULADOR-MOVIL
Trabajo de Fin de Master en Sistemas Inteligentes. Desarrollo de un sistema robótico para la detección y recogida de objetos mediante un manipulador móvil autónomo. Miquel Sitges Nicolau UIB

## Installation:

### Dependencies:
```
sudo apt install ros-noetic-robot-localization
sudo apt install ros-noetic-mavros
sudo apt install ros-noetic-gmapping
sudo apt install ros-noetic-navigation
sudo apt install ros-noetic-velocity-controllers
sudo apt install ros-noetic-twist-mux
sudo apt install ros-noetic-moveit
sudo apt install ros-noetic-tf2-sensor-msgs
sudo apt install ros-noetic-grasping-msgs
sudo apt install ros-noetic-moveit-python
```
### Download and build the repository:
```
cd YOUR_ROS_SPACE
git clone https://github.com/uib-airlab/summit_xl_manipulator.git
cd YOUR_ROS_SPACE/summit_xl_manipulator/robot_sim_propio_ws
catkin_make
```

## Install and create a virtual environment:
### Installation and working on
Install: 1.1 to 1.4
Create, work on and exit: 1.5 to 1.7
```
    1. create virtual environment
        1.1 sudo pip3 install virtualenv
        1.2 sudo pip3 install virtualenvwrapper
        1.3 nano ~/.bashrc (copy these lines there):
          export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
          export WORKON_HOME=$HOME/.virtualenvs
          source /usr/local/bin/virtualenvwrapper.sh
        1.4 source ~/.bashrc
        1.5 mkvirtualenv [env_name]
        1.6 workon [env_name]: activate the virtual env
        1.7 deactivate: exit
```
### Install python dependencies of the repository (in the virtual environment):
```
workon [env_name]
sudo apt install python3-pip
pip install ultralytics
pip install rospkg
pip install pyassimp
pip install scypy==1.8.1
```


## How to use:
### Experiment 1
Detection of objects and pick & place.

#### In the summit PC:




