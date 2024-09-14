#!/usr/bin/env python3

import rospy
import cv2
import numpy as np
import sensor_msgs.point_cloud2 as pc2
from sensor_msgs.msg import PointCloud2
from cv_bridge import CvBridge
import tf2_ros
from tf2_sensor_msgs.tf2_sensor_msgs import do_transform_cloud
from geometry_msgs.msg import Pose
from propio.srv import ProcessImage, ProcessImageResponse
from geometry_msgs.msg import PoseStamped, TransformStamped
from tf2_geometry_msgs.tf2_geometry_msgs import do_transform_pose
from tf.transformations import quaternion_from_euler

import argparse
import copy
import math
import sys

import rospy
import actionlib
import cv2
import numpy as np
from moveit_python import *
from moveit_python.geometry import rotate_pose_msg_by_euler_angles
from sensor_msgs.msg import Image, PointCloud2
from cv_bridge import CvBridge, CvBridgeError
import sensor_msgs.point_cloud2 as pc2
from geometry_msgs.msg import PoseStamped
import tf
from tf2_sensor_msgs.tf2_sensor_msgs import do_transform_cloud
from grasping_msgs.msg import *
import moveit_commander
import tf2_ros
from tf.transformations import quaternion_from_euler


robot_real=True

class PointCloudToImage:
    def __init__(self):
        # Initialize the node
        rospy.init_node('point_cloud_to_image', anonymous=True)

        self.pose_target=Pose
        self.bridge = CvBridge()
        self.rgb_image = None
        self.point_matrix = None
        self.width = 1280
        self.height = 720
        self.show = True

        # TF listener
        self.tf_buffer = tf2_ros.Buffer()
        self.tf_listener = tf.TransformListener(self.tf_buffer)

        # Subscribers
        self.sub = rospy.Subscriber("/camera_front/depth/color/points", PointCloud2, self.point_cloud_callback)

        # Service
        self.service = rospy.Service('process_image_service', ProcessImage, self.handle_process_image)

    def point_cloud_callback(self, data):
        print("Received point cloud")
        try:
            if not robot_real:
                
                tfBuffer = tf2_ros.Buffer()
                listener = tf2_ros.TransformListener(tfBuffer)
                transform = tfBuffer.lookup_transform("robot_front_rgbd_camera_color_optical_frame", "robot_front_rgbd_camera_depth_optical_frame", rospy.Time.now(), rospy.Duration(1))
                cloud_transformed = do_transform_cloud(data, transform)
                # Extract RGB image from the point cloud
                points = list(pc2.read_points(cloud_transformed, field_names=("x", "y", "z", "rgb"), skip_nans=False))

                if len(points) == self.width * self.height:
                    print("Correct number of points")
                    point_array = np.array(points)

                    # Extract RGB values
                    rgb_array = point_array[:, 3].astype(np.float32).view(np.uint32)
                    r = (rgb_array >> 16) & 0xFF
                    g = (rgb_array >> 8) & 0xFF
                    b = rgb_array & 0xFF
                    
                    self.rgb_image = np.stack((r, g, b), axis=-1).reshape((self.height, self.width, 3)).astype(np.uint8)
                    self.point_matrix = point_array[:, :3].reshape((self.height, self.width, 3))
            else:
                # Extract RGB image from the point cloud
                points = list(pc2.read_points(data, field_names=("x", "y", "z", "rgb"), skip_nans=False))

                if len(points) == self.width * self.height:
                    print("Correct number of points")
                    point_array = np.array(points)
                    # Extract RGB values
                    rgb_array = point_array[:, 3].astype(np.float32).view(np.uint32)
                    b = (rgb_array >> 16) & 0xFF
                    g = (rgb_array >> 8) & 0xFF
                    r = rgb_array & 0xFF
                    
                    self.rgb_image = np.stack((r, g, b), axis=-1).reshape((self.height, self.width, 3)).astype(np.uint8)
                    self.point_matrix = point_array[:, :3].reshape((self.height, self.width, 3))
        except (tf2_ros.LookupException, tf2_ros.ConnectivityException, tf2_ros.ExtrapolationException) as e:
            rospy.logerr(f"Transform failed: {e}")

    def handle_process_image(self, req):
        pose = self.process_image()
        return ProcessImageResponse(pose)

    def process_image(self):
        print("Inside process")
        if self.rgb_image is None or self.point_matrix is None:
            rospy.logerr("RGB Image", self.rgb_image is None)
            rospy.logerr("Point Matrix", self.point_matrix is None)
            return

        print("Starting process")


        # Resize RGB image to match depth image resolution
        resized_rgb_image = cv2.resize(self.rgb_image, (self.width, self.height))

        # Define color range for grey detection
        if not robot_real:
            lower_grey = np.array([70, 70, 70], dtype=np.uint8)
            upper_grey = np.array([110, 110, 110], dtype=np.uint8)
        else:
            lower_grey = np.array([40, 40, 40], dtype=np.uint8)
            upper_grey = np.array([90, 90, 90], dtype=np.uint8)

        # Create mask for grey color
        mask = cv2.inRange(resized_rgb_image, lower_grey, upper_grey)

        if self.show:
            print(lower_grey)
            print(upper_grey)
            
            cv2.imshow('RGB', resized_rgb_image)
            cv2.imshow('mask', mask)
            cv2.waitKey(1000)
        
        # Find contours
        contours, _ = cv2.findContours(mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

        if contours:
            largest_contour = max(contours, key=cv2.contourArea)
            x, y, w, h = cv2.boundingRect(largest_contour)

            center_x = x + w // 2
            center_y = y + h // 2

            cv2.rectangle(resized_rgb_image, (x, y), (x + w, y + h), (0, 255, 0), 2)
            cv2.circle(resized_rgb_image, (center_x, center_y), 5, (255, 0, 0), -1)
            if self.show:
                cv2.imshow('image', resized_rgb_image)
                cv2.waitKey(2000)
            
            z_mean = 0
            y_mean = 0
            x_mean = 0
            count = 0
            min_distance = float('inf')

            padding_pixels = 5
            for i in range(x + padding_pixels, x + w - padding_pixels):
                for j in range(y + padding_pixels, y + h - padding_pixels):
                    if self.point_matrix[j, i][2] > 0.1:
                        z_mean += self.point_matrix[j, i][2]
                        y_mean += self.point_matrix[j, i][1]
                        x_mean += self.point_matrix[j, i][0]
                        count += 1
                    if 0 < self.point_matrix[j, i][2] < 0.4:
                        if min_distance > self.point_matrix[j, i][2]:
                            min_distance = self.point_matrix[j, i][2]

            if count > 0:
                x_mean /= count
                y_mean /= count
                z_mean /= count
                
                point_stamped = PoseStamped()

                
                print("Mean X",x_mean)
                print("Mean Y",y_mean)
                print("Mean Z",z_mean)
            
                
                point = self.point_matrix[center_y, center_x]
                print("X_center", point[0])
                print("Y_center", point[1])
                print("Z_center", point[2])
                
                
                
                point_stamped.pose.position.x = point[0]
                point_stamped.pose.position.y = point[1]
                point_stamped.pose.position.z = point[2]
                
                point_stamped.pose.orientation.w = 1.0

                if robot_real:
                    point_stamped.header.frame_id = "camera_front_color_optical_frame"
                    self.tf_listener.waitForTransform("/robot_base_footprint", "camera_front_color_optical_frame", rospy.Time(0), rospy.Duration(4.0))
                    point_transformed = self.tf_listener.transformPose("/robot_base_footprint", point_stamped)
                    self.pose_target = point_transformed.pose
                else:
                    point_stamped.header.frame_id = "robot_front_rgbd_camera_color_optical_frame"
                    self.tf_listener.waitForTransform("/robot_base_footprint", "robot_front_rgbd_camera_color_optical_frame", rospy.Time(0), rospy.Duration(4.0))
                    
                    point_transformed = self.tf_listener.transformPose("/robot_base_footprint", point_stamped)

                    self.pose_target = point_transformed.pose
                    
                self.pose_target.orientation.x = 0.706827
                self.pose_target.orientation.y = 0.706827
                self.pose_target.orientation.z = 0
                self.pose_target.orientation.w = 0.0281249
                

                """
                print("3D X1 Point World",self.point_matrix[center_y][x+padding_pixels][0] )
                print("3D X2 Point World",self.point_matrix[center_y][x+w-padding_pixels][0] )
                print("3D Z1 Point World",self.point_matrix[center_y][x+padding_pixels][2])
                print("3D Z2 Point World",self.point_matrix[center_y][x+w-padding_pixels][2] )
                
                
                
                print(center_y)
                delta_x=self.point_matrix[center_y][x+padding_pixels][0]-self.point_matrix[center_y][x+w-padding_pixels][0]
                delta_z=self.point_matrix[center_y][x+padding_pixels][2]-self.point_matrix[center_y][x+w-padding_pixels][2]
                print("Delta X",delta_x)
                print("Delta Z",delta_z)
                alpha=np.arctan2(delta_z,delta_x)
                alpha+=np.pi/2
                print("Alpha en Z", alpha)
                q = quaternion_from_euler(-np.pi, 0, alpha)

                print(q)
                self.pose_target.orientation.x = q[0]
                self.pose_target.orientation.y = q[1]
                self.pose_target.orientation.z = q[2]
                self.pose_target.orientation.w = q[3]
                """
                print("Pose Target\n",self.pose_target)
                
            
            
                return self.pose_target

        return None

if __name__ == '__main__':
    PointCloudToImage()
    rospy.spin()
