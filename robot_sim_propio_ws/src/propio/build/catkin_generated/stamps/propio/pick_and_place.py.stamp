#!/usr/bin/env python3

import rospy
from propio.srv import ProcessImage, ProcessImageRequest

import argparse

import sys

import rospy
import actionlib

import numpy as np
from moveit_python import *

from sensor_msgs.msg import Image, PointCloud2
from cv_bridge import CvBridge, CvBridgeError
from geometry_msgs.msg import PoseStamped
import tf

from grasping_msgs.msg import *
import moveit_commander


robot_real = True



pose_target=None

if robot_real:
    ns = '/robot'
    robot_description='/robot/robot_description'
else:
    ns = ''
    robot_description='/robot_description'
    

def get_joints_from_opening(distance):
    if distance>0.1 or distance<0.02:
        print("----------------ERROR DISTANCIAS-------------------")
    value=1.3-9*distance
    if value<0 or value>1:
        print("----------------ERROR VALOR PINZA-------------------")
        return 0
    return value


def call_process_image_service():
    rospy.wait_for_service('process_image_service')
    try:
        process_image_proxy = rospy.ServiceProxy('process_image_service', ProcessImage)
        request = ProcessImageRequest()

        response = process_image_proxy(request)
    
        return response.pose,response.distance  # Access the pose field in the response

    except rospy.ServiceException as e:
        rospy.logerr(f"Service call failed: {e}")

def pick_and_place(pose_target, distance):
    moveit_commander.roscpp_initialize(sys.argv)
    parser = argparse.ArgumentParser(description="Simple demo of pick and place")
    parser.add_argument("--objects", help="Just do object perception", action="store_true")
    parser.add_argument("--all", help="Just do object perception, but insert all objects", action="store_true")
    parser.add_argument("--once", help="Run once.", action="store_true")
    parser.add_argument("--ready", help="Move the arm to the ready position.", action="store_true")
    parser.add_argument("--plan", help="Only do planning, no execution", action="store_true")
    parser.add_argument("--x", help="Recommended x offset, how far out an object should roughly be.", type=float, default=0.5)
    args, unknown = parser.parse_known_args()

    scene = PlanningSceneInterface("robot_base_footprint", ns=ns)

    display_trajectory_publisher = rospy.Publisher(
        '/move_group/display_planned_path',
        moveit_msgs.msg.DisplayTrajectory,
        queue_size=10
    )

    ####MOVE INTERFACE

    rospy.loginfo("PostTrajectory")
    
    group = moveit_commander.MoveGroupCommander("arm",robot_description=robot_description,ns=ns,wait_for_servers=25.0)

    rospy.loginfo("Comanders Arm")
    group_gripper = moveit_commander.MoveGroupCommander("gripper",robot_description=robot_description,ns=ns,wait_for_servers=25.0)

    rospy.loginfo("Comanders Gripper")

    if input("Target")=="q":
        return
    print(pose_target)
    # Move to target pose
    pose_target.position.z+=0.2
    #pose_target.position.x+=0.02
    #pose_target.position.y+=-0.05
    print(pose_target) 
    group.set_pose_target(pose_target)
    count = 0
    success = False
    robot = moveit_commander.RobotCommander(robot_description=robot_description,ns=ns)
    
    while count < 2:
        print("Attempt: ", count)
        plan_success, plan1, planning_time, error_code = group.plan()
        
        if plan_success:
            display_trajectory = moveit_msgs.msg.DisplayTrajectory()
            display_trajectory.trajectory_start = robot.get_current_state()
            display_trajectory.trajectory.append(plan1)
            display_trajectory_publisher.publish(display_trajectory)
            input("Planned")
            group.go(wait=True)
            success = True
            break
        else:
            print("Error code", error_code)
        count += 1
    if not success:
        return
    

    if input("Final Approach")=="q":
        return
    success=False
    while count < 2:
        print("Attempt: ", count)
        plan_success, plan1, planning_time, error_code = group.plan()
        
        if plan_success:
            display_trajectory = moveit_msgs.msg.DisplayTrajectory()
            display_trajectory.trajectory_start = robot.get_current_state()
            display_trajectory.trajectory.append(plan1)
            display_trajectory_publisher.publish(display_trajectory)
            #input("Planned")
            group.go(wait=True)
            success = True
            break
        else:
            print("Error code", error_code)
        count += 1
    if not success:
        return
    


    # Open gripper
    if input("Open Gripper")=="q":
        return
    count = 0
    while count < 5:
        print(count)
        group_gripper.set_named_target("open")
        if group_gripper.go(wait=True):
            break
        count += 1
    else:
        print("--------------No open-----------")

    # Approach
    input("Approach")
    count = 0
    pose_target.position.z -= 0.15
    print(pose_target)
    while count < 5:
        print(count)
        group.set_pose_target(pose_target)
        if group.go(wait=True):
            break
        count += 1
    else:
        print("-------No approach---------------")


    # Close gripper
    input("Close gripper")
    count = 0
    joints_dic={}
    value=get_joints_from_opening(distance)
    print("Valor pinza cerrada: ", value)
    joints_dic['robot_j2n6s300_joint_finger_1'] = value
    joints_dic['robot_j2n6s300_joint_finger_2'] = value
    joints_dic['robot_j2n6s300_joint_finger_3'] = value
    while count < 8:
        group_gripper.set_joint_value_target(joints_dic)
        if group_gripper.go(wait=True):
            break
        count += 1
    else:
        print("-------No closed---------------")

    # Lift
    input("Lift")
    count = 0
    pose_target.position.z += 0.2
    print(pose_target)
    while count < 2:
        group.set_pose_target(pose_target)
        if group.go(wait=True):
            break
        count += 1
    else:
        print("-------No lift ---------------")
    input("End")
    return



if __name__ == '__main__':
    rospy.init_node('service_client_node')
    pose,distance = call_process_image_service()
    print(pose)
    print(distance)
    if pose != None:
        rospy.loginfo(f"Received pose: {pose}")
        pick_and_place(pose, distance)
        rospy.signal_shutdown("Pick And Place Acabado")
        
    rospy.spin()
