# TFM-MUSI-UIB-SISTEMA-ROBOTICO-MANIPULADOR-MOVIL
Trabajo de Fin de Master en Sistemas Inteligentes. Desarrollo de un sistema robótico para la detección y recogida de objetos mediante un manipulador móvil autónomo. Miquel Sitges Nicolau UIB

## Install and create a virtual environment:
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

## Download the repository
```
cd YOUR_ROS_SPACE
mkdir summit_xl_manipulator
cd summit_xl_manipulator
git clone https://github.com/uib-airlab/TFM-MUSI-UIB-SISTEMA-ROBOTICO-MANIPULADOR-MOVIL.git

```
