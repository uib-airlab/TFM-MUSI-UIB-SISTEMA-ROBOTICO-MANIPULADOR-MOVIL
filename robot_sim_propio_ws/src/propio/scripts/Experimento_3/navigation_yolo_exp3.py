#!/usr/bin/env python
# license removed for brevity


import rospy
import cv2
import numpy as np
import sensor_msgs.point_cloud2 as pc2
from cv_bridge import CvBridge
import tf2_ros
from tf2_sensor_msgs.tf2_sensor_msgs import do_transform_cloud
from geometry_msgs.msg import Pose, PoseStamped, Vector3
from propio.srv import ProcessImage, ProcessImageResponse, StartPickAndPlace, StartStopExplorer
from geometry_msgs.msg import PoseStamped, TransformStamped
from tf.transformations import quaternion_from_euler
from ultralytics import YOLO
from scipy import stats
from sklearn.decomposition import PCA
from scipy.spatial import ConvexHull
import matplotlib.pyplot as plt
import tf2_geometry_msgs
from moveit_python import *
from sensor_msgs.msg import Image, PointCloud2
from cv_bridge import CvBridge, CvBridgeError
import tf
import actionlib
from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal




robot_real=True

class Navigation:
    def __init__(self):
        rospy.init_node('navigation_node', anonymous=True)
        path='/home/miquel/robot_sim_propio_ws/src/propio/scripts/best_v15.pt'
        self.bridge = CvBridge()
        self.rgb_image_front = None
        self.point_matrix_front = None
        self.processing_front = False
        self.model=YOLO(path)
        self.save=True
        self.width = 640
        self.inExploring=False
        self.height = 480
        self.count=0
        # TF listener
        self.tf_buffer = tf2_ros.Buffer()
        self.tf_listener = tf.TransformListener(self.tf_buffer)
        # Service server to start the pick-and-place process
        self.client = actionlib.SimpleActionClient('move_base',MoveBaseAction)
        self.client.wait_for_server()
        if robot_real:
            self.cam_rgb_front=rospy.Subscriber("/camera_front/color/image_raw", Image, self.rgb_front_callback)
            self.cam_depth_front=rospy.Subscriber("/camera_front/depth/color/points", PointCloud2, self.point_cloud_front_callback)
        else:
            self.sub_front = rospy.Subscriber("/camera_front/depth/color/points", PointCloud2, self.point_cloud_front_callback)
            
    def rgb_front_callback(self, data):
        if self.processing_front == False:
            try:
                
                bridge = CvBridge()
                imagen = bridge.imgmsg_to_cv2(data, 'passthrough')
                self.rgb_image_front =cv2.resize(cv2.cvtColor(imagen, cv2.COLOR_BGR2RGB),(self.width, self.height))
            except CvBridgeError as e:
                rospy.logerr(f"Failed to convert RGB image: {e}")
    
    def call_process_pick_and_place_service(self):
        rospy.wait_for_service('start_pick_and_place')
        try:
            process_pick_place_response = rospy.ServiceProxy('start_pick_and_place', StartPickAndPlace)
            response = process_pick_place_response()
            if response.success is True:
                print("Object Getted Correctly")
                self.extract_objects_and_goal()
        except rospy.ServiceException as e:
            rospy.logerr(f"Service call failed: {e}")
            
    def call_process_explorer(self,start):
        rospy.wait_for_service('start_stop_explorer')
        try:
            process_explorer_response = rospy.ServiceProxy('start_stop_explorer', StartStopExplorer)
            response = process_explorer_response(start)
        except rospy.ServiceException as e:
            rospy.logerr(f"Service call failed: {e}")
        
        
    def point_cloud_front_callback(self, data):
        print("Point cloud recived")
        if self.processing_front==False:
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
                    
                    self.rgb_image_front = np.stack((r, g, b), axis=-1).reshape((self.height, self.width, 3)).astype(np.uint8)
                    self.point_matrix_front = point_array[:, :3].reshape((self.height, self.width, 3))
            else:
                # Extract RGB image from the point cloud
                points = list(pc2.read_points(data, field_names=("x", "y", "z", "rgb"), skip_nans=False))
                if len(points) == self.width * self.height:
                    print("Correct number of points")
                    point_array = np.array(points)
                    self.point_matrix_front = point_array[:, :3].reshape((self.height, self.width, 3))
            if self.inExploring:
                print("Extracting goals")
                self.extract_objects_and_goal()


    def extract_objects_and_goal(self):
        print("Extract new Goal")
        self.stop_exploration()
        while  self.point_matrix_front is None or self.rgb_image_front is None:
            pass
        self.processing_front = True
        
        results = self.model(self.rgb_image_front, show=False, conf=0.3, device="cpu")  # Run inference on the image
        annotated_frame = results[0].plot()

        if self.save:
            # Display the image with all detections
            name="EXP3/Navigation/Imagen con todos Yolo"+str(self.count)+".png"
            cv2.imwrite(name, annotated_frame)
            cv2.waitKey(1000)
            np.save('EXP3/Navigation/front_image' + str(self.count),self.point_matrix_front)
    
        boxes = results[0].boxes
        best_result = None
        nearestZDistance = float("inf")

        for box in boxes:
            cls = int(box.cls[0].item())
            name = results[0].names[cls]
            x1, y1, x2, y2 = map(int, box.xyxy[0])
            center_x = int(x1 + (x2 - x1) / 2)
            center_y = int(y1 + (y2 - y1) / 2)
            print("Object", name,", Distance:", self.point_matrix_front[center_y, center_x][2])
            if self.point_matrix_front[center_y, center_x][2] < nearestZDistance and self.point_matrix_front[center_y, center_x][2]>0:
                best_result = box
                nearestZDistance = self.point_matrix_front[center_y, center_x][2]
        if nearestZDistance<0.44:
            print("-------------Near enough--------------")
            self.pick_and_place()
            return
        
        if best_result:
            print("The closest object is",results[0].names[int(best_result.cls[0].item())],"at:", nearestZDistance)

            x1, y1, x2, y2 = map(int, best_result.xyxy[0])
            padding_pixels = 6
            annotated_image = self.rgb_image_front.copy()
            cv2.rectangle(annotated_image, (x1 + padding_pixels, y1 + padding_pixels), (x2 - padding_pixels, y2 - padding_pixels), (0, 255, 0), 2)

            if self.save:
                # Display the image with all detections
                name="EXP3/Navigation/Imagen con objeto a buscar"+str(self.count)+".png"
                cv2.imwrite(name, annotated_image)
                cv2.waitKey(1000)
            center_x = int(x1 + (x2 - x1) / 2)
            center_y = int(y1 + (y2 - y1) / 2)
            neighborhood_size = 10
            half_size = neighborhood_size // 2

            neighborhood = self.point_matrix_front[
                center_y - half_size:center_y + half_size + 1,
                center_x - half_size:center_x + half_size + 1
            ]

            mask = np.all(neighborhood != 0, axis=2)

            valid_points = neighborhood[mask]

            if valid_points.size > 0:
                print("Number of valid points in neighborhood:", valid_points.size)
                print("Discarded points in neighborhood: ", neighborhood.size-valid_points.size)
                mean_point = np.mean(valid_points, axis=0)
                print("X_mean", mean_point[0])
                print("Y_mean", mean_point[1])
                print("Z_mean", mean_point[2])
            else:
                print("No valid points in the neighborhood")
                self.exploration()
                return
            
            point_stamped = PoseStamped()
            point_stamped.pose.position.x = mean_point[0]
            point_stamped.pose.position.y = mean_point[1]
            #Aproximarse a 80cm desde la base 
            point_stamped.pose.position.z = mean_point[2]-0.785
            
            if robot_real:
                point_stamped.header.frame_id = "camera_front_color_optical_frame"
                tf_buffer = tf2_ros.Buffer()
                tf_listener = tf2_ros.TransformListener(tf_buffer)
                # Lookup the transform from robot_frame to map
                transform = tf_buffer.lookup_transform("map", "camera_front_color_optical_frame", rospy.Time(0), rospy.Duration(5.0))
                # Transform the goal point to the map frame
                goal_in_map_frame = tf2_geometry_msgs.do_transform_pose(point_stamped, transform)

            self.processing_front = False
            goal = MoveBaseGoal()
            goal.target_pose.header.frame_id = "map"
            goal.target_pose.header.stamp = rospy.Time.now()
            goal.target_pose.pose.position=goal_in_map_frame.pose.position
            transform = tf_buffer.lookup_transform("map", "robot_base_link", rospy.Time(0), rospy.Duration(5.0))
            print(transform)
            goal.target_pose.pose.orientation=transform.transform.rotation
            print(goal)
            self.client.send_goal(goal)
            wait = self.client.wait_for_result()
    
            if not wait:
                rospy.logerr("Action server not available!")
                rospy.signal_shutdown("Action server not available!")
            else:
                print(self.client.get_result())
                self.count+=1
                self.pick_and_place()
        else: 
            print("No object in the scene")
            print("------------TO DO EXPLORATION---------------")
            self.start_exploration()


    def start_exploration(self):
        print("Start Exploring")
        self.inExploring=True
        self.call_process_explorer(True)
    def stop_exploration(self):
        print("Stop Exploring")
        self.inExploring=False
        self.call_process_explorer(False)
    
    
    def pick_and_place(self):
        self.call_process_pick_and_place_service()

if __name__ == '__main__':
    navigation=Navigation()
    try:
        
        navigation.extract_objects_and_goal()
        rospy.spin()
    except rospy.ROSInterruptException:
        navigation.move_base.cancel_all_goals()
        rospy.loginfo("Navigation test finished.")
        
    
