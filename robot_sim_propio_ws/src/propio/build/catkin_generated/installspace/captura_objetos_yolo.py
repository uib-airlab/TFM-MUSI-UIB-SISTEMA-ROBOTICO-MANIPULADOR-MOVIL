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
from ultralytics import YOLO


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
        
        else:
            print("Received point cloud and not used because in processing")

    def handle_process_image(self, req):
        print("Starting to process")
        self.processing=True
        pose,distance = self.process_image()
        return ProcessImageResponse(pose,distance)

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

        path='/home/miquel/robot_sim_propio_ws/src/propio/scripts/best_M100_WasteAug.pt'

        model=YOLO(path)
        results = model(self.rgb_image,show=False, conf=0.15)  # Run inference on the image
        annotated_frame = results[0].plot()
        cv2.imshow("Imagen con todos Yolo", annotated_frame)
        cv2.waitKey(10000)
        boxes=results[0].boxes
        best_result=None
        best_conf=0
        for box in boxes:
            if box.conf>best_conf:
                best_result=box
                best_conf=box.conf

        if best_result:
            x1, y1, x2, y2 = map(int, best_result.xyxy[0])
            padding_pixels = 7
            annotated_image = self.rgb_image.copy()
            cv2.rectangle(annotated_image, (x1+padding_pixels, y1+padding_pixels), (x2-padding_pixels, y2-padding_pixels), (0, 255, 0), 2)
                        
            center_x=int(x1+(x2-x1)/2)
            center_y=int(y1+(y2-y1)/2)
            
            points_for_hull = []
            count_correct=0
            count_outliers=0
            
            for i in range(x1 + padding_pixels, x2 - padding_pixels):
                for j in range(y1 + padding_pixels, y2 - padding_pixels):
                    if self.point_matrix[j, i][2] > 0.3 and self.point_matrix[j,i][2]<1:
                        z_mean += self.point_matrix[j, i][2]
                        y_mean += self.point_matrix[j, i][1]
                        x_mean += self.point_matrix[j, i][0]
                        count_correct += 1
                        points_for_hull.append([self.point_matrix[j, i][0], self.point_matrix[j, i][1], self.point_matrix[j, i][2]])
                    else:
                        count_outliers+=1
                        
            points_for_hull = np.array(points_for_hull)
            max_dim=np.max(points_for_hull,axis=0)
            min_dim=np.min(points_for_hull,axis=0)
            x_dim=max_dim[0]-min_dim[0]
            y_dim=max_dim[1]-min_dim[1]
            z_dim=max_dim[2]-min_dim[2]
            print("X image dimension: ",x_dim )
            print("Y image dimension: ",y_dim)
            print("Z image dimension: ", z_dim)

            print("x_max", max_dim[0])
            print("x_min", min_dim[0])           
            
            print("y_max", max_dim[1])
            print("y_min", min_dim[1])
            
            if x_dim<0.1 and x_dim>0.01:
                rot_z=-np.pi/2
                distance = x_dim
                profundidad=0.045
            else:
                print("-------------------------Error with x dimension, trying with y-----------------------------")
                #Arbitrary distance and rotation
                rot_z=0
                distance = 0.08
                profundidad=0.02
            
            print("Ratio corrects/totals:", count_correct/(count_correct+count_outliers))
        
            if self.show_convex:
                hull = ConvexHull(points_for_hull)
                points_for_hull = np.array(points_for_hull)

                fig = plt.figure()
                ax = fig.add_subplot(111, projection='3d')
                
                ax.set_box_aspect([np.ptp(points_for_hull[:,0]), np.ptp(points_for_hull[:,1]), np.ptp(points_for_hull[:,2])])
                
                #ax.scatter(points_for_hull[:,0], points_for_hull[:,1], points_for_hull[:,2], marker='o')

                for simplex in hull.simplices:
                    ax.plot(points_for_hull[simplex, 0], points_for_hull[simplex, 1], points_for_hull[simplex, 2], 'r-')

                ax.set_xlabel('X Label')
                ax.set_ylabel('Y Label')
                ax.set_zlabel('Z Label')
                plt.savefig("convex_hull.png")
                plt.show(block=True)
            
            x_mean /= count_correct
            y_mean /= count_correct
            z_mean /= count_correct
            
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
            
            if min_dim[1]+0.1<max_dim[1]:
                print("Objeto suficientemente alto")
                point_stamped.pose.position.y = min_dim[1]+0.09
            else:
                print("----------------------Objeto poco alto--------------------------------------")
                point_stamped.pose.position.y = max_dim[1]-0.05
                
            print("Y",point_stamped.pose.position.y)
            distances = (self.point_matrix[..., 0] - point_stamped.pose.position.x)**2 + (self.point_matrix[..., 1] - point_stamped.pose.position.y)**2 + (self.point_matrix[..., 2] - point[2])**2 
            
            # Find the index of the minimum distance
            min_index = np.unravel_index(np.argmin(distances), distances.shape)
            print("Min indices", min_index)
            
            # Make  pixels red on center of mass
            annotated_image = cv2.circle(annotated_image, (center_x,center_y), radius=5, color=(0, 0, 255), thickness=-1)
            # Make  pixels blue on grapping points
            annotated_image = cv2.circle(annotated_image, (min_index[1], min_index[0]), radius=5, color=(0,255, 0), thickness=-1)
            
            # Display the image with OpenCV
            cv2.imshow('Imagen con Mejor Anotacion Y Gripper', annotated_image)
            cv2.waitKey(1000)
            
            #Para el desfase entre el centro y el end-effector
            point_stamped.pose.position.z = point[2]+profundidad
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
                
            print("Final Rot on Z", rot_z)
            print("Final distance to open gripper: ", distance)
            q = quaternion_from_euler(np.pi, 0, rot_z)
            
            self.pose_target.orientation.x = q[0]
            self.pose_target.orientation.y = q[1]
            self.pose_target.orientation.z = q[2]
            self.pose_target.orientation.w = q[3]

            print("Pose Target\n", self.pose_target)
            self.processing=False
            
            return self.pose_target, distance
        self.processing=False
        return None

if __name__ == '__main__':
    p=PointCloudToImage()
    rospy.spin()
