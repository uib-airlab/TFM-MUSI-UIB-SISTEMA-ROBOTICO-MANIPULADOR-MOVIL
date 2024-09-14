#!/usr/bin/env python3

import rospy
from propio.srv import ProcessImage, ProcessImageRequest
import sys

import rospy
import numpy as np

from sensor_msgs.msg import Image, PointCloud2
from geometry_msgs.msg import PoseStamped
from grasping_msgs.msg import *
import moveit_commander

class RobotPickAndPlace:
    def __init__(self, robot_real=True):
        self.robot_real = robot_real
        self.pose_target = None
        self.no_objects = False

        if self.robot_real:
            self.ns = '/robot'
            self.robot_description = '/robot/robot_description'
        else:
            self.ns = ''
            self.robot_description = '/robot_description'

        self.init_moveit()

    def add_open_top_box(self,scene, center_position, box_dimensions, wall_thickness):
        """
        Add an open-top box to the planning scene with specified dimensions and wall thickness.

        Parameters:
        scene (PlanningSceneInterface): The planning scene interface to add objects.
        frame_id (str): The reference frame for the box.
        center_position (tuple): The (x, y, z) position of the center of the box.
        box_dimensions (tuple): The dimensions (length, width, height) of the box.
        wall_thickness (float): The thickness of the walls.
        """
        box_length, box_width, box_height = box_dimensions

        # Helper function to create and add a wall
        def add_wall(name, position, dimensions):
            wall_pose = PoseStamped()
            wall_pose.header.frame_id = center_position.header.frame_id
            wall_pose.pose.position.x = position[0]
            wall_pose.pose.position.y = position[1]
            wall_pose.pose.position.z = position[2]
            wall_pose.pose.orientation.w = 1.0
            scene.add_box(name, wall_pose, dimensions)
            
        # Define positions and dimensions for the four walls
        walls = [
            {"name": "wall1", "position": [center_position.pose.position.x, center_position.pose.position.y - box_width / 2 + wall_thickness / 2, center_position.pose.position.z], "dimensions": [box_length, wall_thickness, box_height]},
            {"name": "wall2", "position": [center_position.pose.position.x, center_position.pose.position.y + box_width / 2 - wall_thickness / 2, center_position.pose.position.z], "dimensions": [box_length, wall_thickness, box_height]},
            {"name": "wall3", "position": [center_position.pose.position.x - box_length / 2 + wall_thickness / 2, center_position.pose.position.y, center_position.pose.position.z], "dimensions": [wall_thickness, box_width, box_height]},
            {"name": "wall4", "position": [center_position.pose.position.x + box_length / 2 - wall_thickness / 2, center_position.pose.position.y, center_position.pose.position.z], "dimensions": [wall_thickness, box_width, box_height]},
        ]

        # Add the walls to the scene
        for wall in walls:
            add_wall(wall["name"], wall["position"], wall["dimensions"])

        # Ensure the planning scene is updated
        rospy.sleep(1)
    def init_moveit(self):
        moveit_commander.roscpp_initialize(sys.argv)
        self.scene = moveit_commander.PlanningSceneInterface(ns=self.ns,  synchronous=True)
        self.scene.clear()

        self.group_arm = moveit_commander.MoveGroupCommander("arm", robot_description=self.robot_description, ns=self.ns, wait_for_servers=25.0)
        self.group_gripper = moveit_commander.MoveGroupCommander("gripper", robot_description=self.robot_description, ns=self.ns, wait_for_servers=25.0)
        self.robot = moveit_commander.RobotCommander(robot_description=self.robot_description, ns=self.ns)
        self.group_arm.allow_replanning(True)
        self.group_gripper.allow_replanning(True)
        self.group_arm.set_goal_tolerance(0.001)

        self.pose=PoseStamped()
        self.pose.pose.position.x=-0.16
        self.pose.pose.position.y=0
        self.pose.pose.position.z=0.48
        self.pose.pose.orientation.w=1
        self.dimensionBox = [0.3, 0.5, 0.19]
        self.pose.header.frame_id=self.robot.get_planning_frame()
        self.wall_thickness=0.035
        self.add_open_top_box(self.scene, self.pose, self.dimensionBox,self.wall_thickness)
        self.display_trajectory_publisher = rospy.Publisher(
            '/move_group/display_planned_path',
            moveit_msgs.msg.DisplayTrajectory,
            queue_size=10
        )

    def get_joints_from_opening(self, distance):
        value = 1.3 - 6.8 * distance
        if  value > 1:
            print("----------------ERROR VALOR PINZA-------------------")
            return 1
        elif value<0:
            return 0
        return value

    def call_process_image_service(self):
        rospy.wait_for_service('process_image_service')
        try:
            process_image_proxy = rospy.ServiceProxy('process_image_service', ProcessImage)
            request = ProcessImageRequest()
            request.isFront = True
            response = process_image_proxy(request)
            if response.numberObjects==-1:
                print("No objects left in the scene")
                return
            if response.needsArm==False:
                self.pick_and_place_complete(response.pose, response.distance,response.numberObjects, response.dimensions)
            else:
                self.pick_and_place_up_position(response.pose)
                request.isFront = False
                response = process_image_proxy(request)
                self.pick_and_place_complete(response.pose, response.distance, response.numberObjects, response.dimensions)
                
        except rospy.ServiceException as e:
            rospy.logerr(f"Service call failed: {e}")
            

    def pick_and_place_up_position(self, pose_target):
        pose_target.position.z += 0.4
        print(pose_target) 
        self.group_arm.set_pose_target(pose_target)

        count = 0
        success = False
        while count < 2:
            print("Attempt: ", count)
            plan_success, plan1, planning_time, error_code = self.group_arm.plan()
            if plan_success:
                display_trajectory = moveit_msgs.msg.DisplayTrajectory()
                display_trajectory.trajectory_start = self.robot.get_current_state()
                display_trajectory.trajectory.append(plan1)
                self.display_trajectory_publisher.publish(display_trajectory)
                if 'q'==input("Planned"):
                    return
                self.group_arm.go(wait=True)
                success = True
                break
            else:
                print("Error code", error_code)
            count += 1
        if not success:
            return
        
        success = False
        while count < 2:
            print("Attempt: ", count)
            plan_success, plan1, planning_time, error_code = self.group_arm.plan()
            if plan_success:
                display_trajectory = moveit_msgs.msg.DisplayTrajectory()
                display_trajectory.trajectory_start = self.robot.get_current_state()
                display_trajectory.trajectory.append(plan1)
                self.display_trajectory_publisher.publish(display_trajectory)
                self.group_arm.go(wait=True)
                success = True
                break
            else:
                print("Error code", error_code)
            count += 1
        if not success:
            return
        print("Position Correct")

    def pick_and_place_complete(self, pose_target, distance,numberObjectsLeft, boxDimensions):
        if pose_target.position.z<0.07:
            print("Error distancia minima,", pose_target.position.z,"Estableciendo 0.07")
            pose_target.position.z=0.07
        pose_target.position.z += 0.22
        print(pose_target) 
        self.group_arm.set_pose_target(pose_target)

        count = 0
        success = False
        while count < 2:
            print("Attempt: ", count)
            plan_success, plan1, planning_time, error_code = self.group_arm.plan()
            if plan_success:
                display_trajectory = moveit_msgs.msg.DisplayTrajectory()
                display_trajectory.trajectory_start = self.robot.get_current_state()
                display_trajectory.trajectory.append(plan1)
                self.display_trajectory_publisher.publish(display_trajectory)
                if input("Start Moving") == "q":
                    return
                self.group_arm.go(wait=True)
                success = True
                break
            else:
                print("Error code", error_code)
            count += 1
        if not success:
            return

        success = False
        while count < 2:
            print("Attempt: ", count)
            plan_success, plan1, planning_time, error_code = self.group_arm.plan()
            if plan_success:
                display_trajectory = moveit_msgs.msg.DisplayTrajectory()
                display_trajectory.trajectory_start = self.robot.get_current_state()
                display_trajectory.trajectory.append(plan1)
                self.display_trajectory_publisher.publish(display_trajectory)
                self.group_arm.go(wait=True)
                success = True
                break
            else:
                print("Error code", error_code)
            count += 1
        if not success:
            return

        if input("Open Gripper") == "q":
            return
        count = 0
        while count < 2:
            print(count)
            self.group_gripper.set_named_target("open")
            if self.group_gripper.go(wait=True):
                break
            count += 1
        else:
            print("--------------No open-----------")

        if input("Approach") == "q":
            return
        count = 0
        pose_target.position.z -= 0.25
        print(pose_target)
        while count < 2:
            print(count)
            self.group_arm.set_pose_target(pose_target)
            if self.group_arm.go(wait=True):
                break
            count += 1
        else:
            return
            print("-------No approach---------------")

        if input("Close Gripper") == "q":
            return
        count = 0
        joints_dic = {}
        value = self.get_joints_from_opening(distance)
        print("Valor pinza cerrada: ", value)
        joints_dic['robot_j2n6s300_joint_finger_1'] = value
        joints_dic['robot_j2n6s300_joint_finger_2'] = value
        joints_dic['robot_j2n6s300_joint_finger_3'] = value
        while count < 2:
            self.group_gripper.set_joint_value_target(joints_dic)
            if self.group_gripper.go(wait=True):
                break
            count += 1
        else:
            print("-------No closed---------------")


        if input("Lift") == "q":
            return
        count = 0
        pose_target.position.z += 0.25
        print(pose_target)
        while count < 2:
            self.group_arm.set_pose_target(pose_target)
            if self.group_arm.go(wait=True):
                break
            count += 1
        else:
            print("-------No lift ---------------")


        touch_links = self.robot.get_link_names(group='gripper')

        touch_links.append("robot_j2n6s300_link_6")
        touch_links.append("robot_j2n6s300_link_5")

        touch_links.append("robot_j2n6s300_link_finger_tip_1")
        touch_links.append("robot_j2n6s300_link_finger_tip_2")
        touch_links.append("robot_j2n6s300_link_finger_tip_3")
        
        eef_link = self.group_arm.get_end_effector_link()
        touch_links.append(eef_link)
        print("Objects dimensions", boxDimensions.x, boxDimensions.y, boxDimensions.z,)

        pose=PoseStamped()
        pose.pose.position.x=0
        pose.pose.position.y=0
        pose.pose.position.z=boxDimensions.z/2-0.05
        pose.pose.orientation.w=1
        pose.header.frame_id=eef_link
        
        self.scene.attach_box(eef_link, "Grasped Object", pose=pose, 
                            size=(boxDimensions.x, boxDimensions.y, boxDimensions.z), touch_links=touch_links)
        rospy.sleep(1)  # Ensure the planning scene is ready before adding objects


        pose_target.position.x = -0.12
        pose_target.position.y = +0.03
        pose_target.position.z = 0.85


        pose_target.orientation.x = 0.8390030837434985
        pose_target.orientation.y = 0.3288533680278819
        pose_target.orientation.z = -0.31610850581930483
        pose_target.orientation.w = 0.2966558618236036



        if input("Go Home") == "q":
            return
        
        count = 0
        while count < 2:
            print(count)
            self.group_arm.set_pose_target(pose_target)
            if self.group_arm.go(wait=True):
                break
            count += 1
        else:
            print("--------------No Home-----------")

        self.scene.remove_world_object("Objects Box")

        if 0.55+boxDimensions.z<pose_target.position.z:
            pose_target.position.z = 0.55+boxDimensions.z
        if input("Let position") == "q":
            return
        count = 0
        while count < 2:
            self.group_arm.set_pose_target(pose_target)
            if self.group_arm.go(wait=True):
                break
            count += 1
        else:
            print("--------------No Let Position-----------")

        if input("Open Gripper") == "q":
            return
        count = 0
        while count < 2:
            print(count)
            self.group_gripper.set_named_target("open")
            if self.group_gripper.go(wait=True):
                break
            count += 1
        else:
            print("--------------No open-----------")

        self.scene.remove_attached_object("Grasped Object")
        self.scene.remove_world_object("Grasped Object")

        if input("Home position") == "q":
            return
        count = 0
        pose_target.position.z = 0.75
        while count < 2:
            self.group_arm.set_pose_target(pose_target)
            if self.group_arm.go(wait=True):
                break
            count += 1
        else:
            print("--------------No Let Position-----------")
            
        self.add_open_top_box(self.scene, self.pose, self.dimensionBox,self.wall_thickness)
        
        if numberObjectsLeft-1>0:
            self.call_process_image_service()

        return

def main():
    rospy.init_node('service_client_node')
    robot_pick_and_place = RobotPickAndPlace(robot_real=True)
    robot_pick_and_place.call_process_image_service()
    rospy.signal_shutdown("Pick And Place Acabado")
    rospy.spin()

if __name__ == '__main__':
    main()