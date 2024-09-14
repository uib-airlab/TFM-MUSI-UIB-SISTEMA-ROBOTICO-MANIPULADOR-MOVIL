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

import matplotlib.pyplot as plt

from scipy.spatial import ConvexHull

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

        self.pose_target=Pose()
        self.bridge = CvBridge()
        self.rgb_image = None
        self.point_matrix = None
        self.width = 1280
        self.height = 720
        self.show = True
        self.show_convex=False
        self.processing=False
        self.Box=True

        # TF listener
        self.tf_buffer = tf2_ros.Buffer()
        self.tf_listener = tf.TransformListener(self.tf_buffer)

        if robot_real:
            self.cam_rgb=rospy.Subscriber("/camera_front/color/image_raw", Image, self.rgb_callback)
            self.cam_depth=rospy.Subscriber("/camera_front/depth/color/points", PointCloud2, self.point_cloud_callback)

        else:
            self.sub = rospy.Subscriber("/camera_front/depth/color/points", PointCloud2, self.point_cloud_callback)

        # Service
        self.service = rospy.Service('process_image_service', ProcessImage, self.handle_process_image)

    def rgb_callback(self, data):
        try:
            
            bridge = CvBridge()
            imagen = bridge.imgmsg_to_cv2(data, 'passthrough')
            self.rgb_image =cv2.resize(cv2.cvtColor(imagen, cv2.COLOR_BGR2RGB),(self.width, self.height))
        except CvBridgeError as e:
            rospy.logerr(f"Failed to convert RGB image: {e}")

    def point_cloud_callback(self, data):
        if self.processing==False:
            print("Received point cloud and saved")

            if robot_real==False:
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
                    self.point_matrix = point_array[:, :3].reshape((self.height, self.width, 3))
            """input("Nueva Prueba")
            self.process_image()"""
        
        else:
            print("Received point cloud and not used because in processing")

    def handle_process_image(self, req):
        print("Starting to process")
        self.processing=True
        pose = self.process_image()
        return ProcessImageResponse(pose)

    def process_image(self):
        print("Inside process")
        if self.rgb_image is None or self.point_matrix is None:
            rospy.logerr("RGB Image", self.rgb_image is None)
            rospy.logerr("Point Matrix", self.point_matrix is None)
            return
        
        print("Starting process")
        
        z_mean = 0
        y_mean = 0
        x_mean = 0
        count = 0

        if self.Box:
            # Define color range for grey detection
            if not robot_real:
                lower_grey = np.array([70, 70, 70], dtype=np.uint8)
                upper_grey = np.array([110, 110, 110], dtype=np.uint8)
            else:
                lower_grey = np.array([20, 60, 20], dtype=np.uint8)
                upper_grey = np.array([120, 120, 120], dtype=np.uint8)


            # Create mask for grey color
            mask = cv2.inRange(self.rgb_image, lower_grey, upper_grey)

            if self.show:
                print(lower_grey)
                print(upper_grey)
                cv2.destroyAllWindows()
                cv2.waitKey(1000)
                cv2.imshow('RGB', self.rgb_image)
                cv2.imshow('mask', mask)
                cv2.waitKey(1000)
            
            # Find contours
            contours, _ = cv2.findContours(mask, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

            

            if contours:
                largest_contour = max(contours, key=cv2.contourArea)
                x, y, w, h = cv2.boundingRect(largest_contour)

                center_x = x + w // 2
                center_y = y + h // 2

                cv2.rectangle(self.rgb_image, (x, y), (x + w, y + h), (0, 255, 0), 2)
                cv2.circle(self.rgb_image, (center_x, center_y), 5, (255, 0, 0), -1)
                if self.show:
                    cv2.imshow('image', self.rgb_image)
                    cv2.waitKey(1000)
                    
                min_distance = float('inf')

                points_for_hull = []
                
                padding_pixels = 5
                for i in range(x + padding_pixels, x + w - padding_pixels):
                    for j in range(y + padding_pixels, y + h - padding_pixels):
                        if self.point_matrix[j, i][2] > 0.1 and self.point_matrix[j,i][2]<4:
                            z_mean += self.point_matrix[j, i][2]
                            y_mean += self.point_matrix[j, i][1]
                            x_mean += self.point_matrix[j, i][0]
                            count += 1
                            points_for_hull.append([self.point_matrix[j, i][0], self.point_matrix[j, i][1], self.point_matrix[j, i][2]])
                        if 0 < self.point_matrix[j, i][2] < 0.4:
                            if min_distance > self.point_matrix[j, i][2]:
                                min_distance = self.point_matrix[j, i][2]
        else:
            
                        # Define color range for grey detection
            if not robot_real:
                lower_grey = np.array([0, 0, 100], dtype=np.uint8)
                upper_grey = np.array([40, 40, 250], dtype=np.uint8)
            else:
                lower_grey = np.array([20, 60, 20], dtype=np.uint8)
                upper_grey = np.array([120, 200, 120], dtype=np.uint8)
                
            
            # Create mask for grey color
            mask = cv2.inRange(self.rgb_image, lower_grey, upper_grey)

            if self.show:
                print(lower_grey)
                print(upper_grey)
                cv2.destroyAllWindows()
                cv2.waitKey(1000)
                cv2.imshow('RGB', self.rgb_image)
                cv2.imshow('mask', mask)
                cv2.waitKey(10000)
            print("POST SHOW")
            # Find contours (in this case, circles)
            # Apply Hough transform on the blurred image. 
            circles = cv2.HoughCircles(mask,  
                            cv2.HOUGH_GRADIENT, 1, 20, param1 = 50, 
                        param2 = 50, minRadius = 1, maxRadius = 100) 

            if circles is not None:
                circles = np.uint16(np.around(circles))

                for circle in circles[0, :]:
                    center_x, center_y = circle[0], circle[1]
                    radius = circle[2]

                    # Draw the circle on the image
                    cv2.circle(self.rgb_image, (center_x, center_y), radius, (0, 255, 0), 2)
                    cv2.circle(self.rgb_image, (center_x, center_y), 2, (0, 0, 255), 3)

                if self.show:
                        cv2.imshow('image', self.rgb_image)
                        cv2.waitKey(1000)
                min_distance = float('inf')

                points_for_hull = []

                circle_center_x = center_x  
                circle_center_y = center_y  
                circle_radius = radius  

                search_radius = int(circle_radius * 2)  # Expand the search radius if needed
                search_x_min = max(0, circle_center_x - search_radius)
                search_x_max = min(self.width, circle_center_x + search_radius)
                search_y_min = max(0, circle_center_y - search_radius)
                search_y_max = min(self.height, circle_center_y + search_radius)

                for i in range(search_x_min, search_x_max):
                    for j in range(search_y_min, search_y_max):
                        # Calculate distance from the center of the circle
                        distance_from_center = np.sqrt((i - circle_center_x) ** 2 + (j - circle_center_y) ** 2)

                        if distance_from_center <= circle_radius:
                            if self.point_matrix[j, i][2] > 0.1 and self.point_matrix[j, i][2] < 4:
                                z_mean += self.point_matrix[j, i][2]
                                y_mean += self.point_matrix[j, i][1]
                                x_mean += self.point_matrix[j, i][0]
                                count += 1
                                points_for_hull.append([self.point_matrix[j, i][0], self.point_matrix[j, i][1], self.point_matrix[j, i][2]])
                            if 0 < self.point_matrix[j, i][2] < 0.4:
                                if min_distance > self.point_matrix[j, i][2]:
                                    min_distance = self.point_matrix[j, i][2]
            else:   
                print("---------NO CIRCLES--------------------")
                return

        
        if count > 0:
            if self.show_convex:
                hull = ConvexHull(points_for_hull)
                points_for_hull = np.array(points_for_hull)

                fig = plt.figure()
                ax = fig.add_subplot(111, projection='3d')
                
                ax.set_box_aspect([np.ptp(points_for_hull[:,0]), np.ptp(points_for_hull[:,1]), np.ptp(points_for_hull[:,2])])
                
                ax.scatter(points_for_hull[:,0], points_for_hull[:,1], points_for_hull[:,2], marker='o')

                for simplex in hull.simplices:
                    ax.plot(points_for_hull[simplex, 0], points_for_hull[simplex, 1], points_for_hull[simplex, 2], 'r-')

                ax.set_xlabel('X Label')
                ax.set_ylabel('Y Label')
                ax.set_zlabel('Z Label')

                plt.show()

            
            x_mean /= count
            y_mean /= count
            z_mean /= count
            
            point_stamped = PoseStamped()

            print("Mean X", x_mean)
            print("Mean Y", y_mean)
            print("Mean Z", z_mean)
        
            point = self.point_matrix[center_y, center_x]
            print("X_center", point[0])
            print("Y_center", point[1])
            print("Z_center", point[2])

            self.processing=False

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

            print("Pose Target\n", self.pose_target)
            self.processing=False
            return self.pose_target
        self.processing=False
        
        return None

if __name__ == '__main__':
    p=PointCloudToImage()
    rospy.spin()
