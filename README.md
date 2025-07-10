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
Before use, it has to be changed the path to the detection model in the file ```.../summit_xl_manipulator/robot_sim_propio_ws/src/propio/scripts/Experimento_1/captura_objetos_exp1.py``` to the real path in the companion PC.

#### In the summit PC:
Execute the launch files to turn on the RealSense cameras, in two different consoles launch:
##### Console 1:
```
roslaunch realsense2_camera rs_camera.launch enable_pointcloud:=true camera:=camera_front serial_no:=049122251210 align_depth:=true ordered_pc:=true color_width:=640 color_height:=480 color_fps:=15 depth_width:=640 depth_height:=480 depth_fps:=15
```
##### Console 2:
```
roslaunch realsense2_camera rs_camera.launch enable_pointcloud:=True camera:=camera_arm serial_no:=819612072790 align_depth:=true ordered_pc:=true color_width:=640 color_height:=480 color_fps:=15 depth_width:=640 depth_height:=480 depth_fps:=15
```

#### In the companion PC:
Execute the launch in one console:
```
roslaunch propio RobotEXP1yEXP2.launch
```

#### In the virtaul environments (in the companion PC):
Two consoles are required, one for the object detection and the other for the pick and place execution.
##### Console 1 (object detection):
```
workon [env_name]
cd /<path_to_workspace>
source devel/setup.bash
export PYTHONPATH=/home/<user_name>/.virtualenvs/<env_name>/lib/python3.8/site-packages:$PYTHONPATH
export PYTHONPATH=$PYTHONPATH:/usr/lib/python3/dist-packages/
python3 src/propio/scripts/Experimento_1/captura_objetos_exp1.py
```
##### Console 2 (pick and place):
Once the code is running you must press intro in every stage of the pick and place.
```
workon [env_name]
cd /<path_to_workspace>
source devel/setup.bash
export PYTHONPATH=/home/<user_name>/.virtualenvs/<env_name>/lib/python3.8/site-packages:$PYTHONPATH
export PYTHONPATH=$PYTHONPATH:/usr/lib/python3/dist-packages/
python3 src/propio/scripts/Experimento_1/pick_and_place_exp1.py
```


### Experiment 3
Detection of objects, navigation to objects and pick & place.
Before use, it has to be changed the path to the detection model in the file ```.../summit_xl_manipulator/robot_sim_propio_ws/src/propio/scripts/Experimento_1/captura_objetos_exp1.py``` to the real path in the companion PC.

#### In the summit PC:
Execute the launch files to turn on the RealSense cameras, in two different consoles launch:
##### Console 1:
```
roslaunch realsense2_camera rs_camera.launch enable_pointcloud:=true camera:=camera_front serial_no:=049122251210 align_depth:=true ordered_pc:=true color_width:=640 color_height:=480 color_fps:=15 depth_width:=640 depth_height:=480 depth_fps:=15
```
##### Console 2:
```
roslaunch realsense2_camera rs_camera.launch enable_pointcloud:=True camera:=camera_arm serial_no:=819612072790 align_depth:=true ordered_pc:=true color_width:=640 color_height:=480 color_fps:=15 depth_width:=640 depth_height:=480 depth_fps:=15
```

#### In the companion PC:
Execute the launch in one console:
```
roslaunch propio RobotEXP3.launch
```

#### In the virtaul environments (in the companion PC):
Two consoles are required, one for the object detection and the other for the pick and place execution.
##### Console 1 (navigation):
```
workon [env_name]
cd /<path_to_workspace>
source devel/setup.bash
export PYTHONPATH=/home/<user_name>/.virtualenvs/<env_name>/lib/python3.8/site-packages:$PYTHONPATH
export PYTHONPATH=$PYTHONPATH:/usr/lib/python3/dist-packages/
python3 src/propio/scripts/Experimento_3/navigation_yolo_exp3.py
```
##### Console 2 (object detection):
```
workon [env_name]
cd /<path_to_workspace>
source devel/setup.bash
export PYTHONPATH=/home/<user_name>/.virtualenvs/<env_name>/lib/python3.8/site-packages:$PYTHONPATH
export PYTHONPATH=$PYTHONPATH:/usr/lib/python3/dist-packages/
python3 src/propio/scripts/Experimento_3/captura_objetos_exp3.py
```
##### Console 3 (pick and place):
Once the code is running you must press intro in every stage of the pick and place.
```
workon [env_name]
cd /<path_to_workspace>
source devel/setup.bash
export PYTHONPATH=/home/<user_name>/.virtualenvs/<env_name>/lib/python3.8/site-packages:$PYTHONPATH
export PYTHONPATH=$PYTHONPATH:/usr/lib/python3/dist-packages/
python3 src/propio/scripts/Experimento_3/pick_and_place_exp3.py
```





