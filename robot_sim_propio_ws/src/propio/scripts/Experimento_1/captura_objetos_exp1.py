#!/usr/bin/env python3

import rospy
import cv2
import numpy as np
import sensor_msgs.point_cloud2 as pc2
from cv_bridge import CvBridge
import tf2_ros
from tf2_sensor_msgs.tf2_sensor_msgs import do_transform_cloud
from geometry_msgs.msg import Pose, PoseStamped, Vector3
from propio.srv import ProcessImage, ProcessImageResponse
from geometry_msgs.msg import PoseStamped
from tf.transformations import quaternion_from_euler
from ultralytics import YOLO
from scipy import stats
from sklearn.decomposition import PCA
from scipy.spatial import ConvexHull
import matplotlib.pyplot as plt
from moveit_python import *
from sensor_msgs.msg import Image, PointCloud2
from cv_bridge import CvBridge, CvBridgeError
import tf
from grasping_msgs.msg import *
import matplotlib
import time
matplotlib.use('Agg')


robot_real=True


class PointCloudToImage:
    def __init__(self):
        # Initialize the node
        rospy.init_node('point_cloud_to_image', anonymous=True)
        path='/home/miquel/robot_sim_propio_ws/src/propio/scripts/best_v15.pt'
        plt.ion()  # Enable interactive mode
        self.last_update=False
        self.model=YOLO(path)
        self.pose_target=Pose()
        self.bridge = CvBridge()
        self.rgb_image_front = None
        self.point_matrix_front = None
        self.rgb_image_arm = None
        self.point_matrix_arm = None
        self.width = 640
        self.height = 480
        self.save = False
        self.numberObjects=0
        self.processing_front=False
        self.processing_arm=False
        self.box_dimensions=Vector3()
        self.count=0

        # TF listener
        self.tf_buffer = tf2_ros.Buffer()
        self.tf_listener = tf.TransformListener(self.tf_buffer)

        if robot_real:
            self.cam_rgb_front=rospy.Subscriber("/camera_front/color/image_raw", Image, self.rgb_front_callback)
            self.cam_depth_front=rospy.Subscriber("/camera_front/depth/color/points", PointCloud2, self.point_cloud_front_callback)
            self.cam_rgb_arm=rospy.Subscriber("/camera_arm/color/image_raw", Image, self.rgb_arm_callback)
            self.cam_depth_arm=rospy.Subscriber("/camera_arm/depth/color/points", PointCloud2, self.point_cloud_arm_callback)
        else:
            self.sub_front = rospy.Subscriber("/camera_front/depth/color/points", PointCloud2, self.point_cloud_front_callback)
            self.sub_arm = rospy.Subscriber("/camera_arm/depth/color/points", PointCloud2, self.point_cloud_arm_callback)

        # Service
        self.service = rospy.Service('process_image_service', ProcessImage, self.handle_process_image)
        
    def rgb_arm_callback(self, data):
        if self.processing_arm==False:
            try:
                bridge = CvBridge()
                imagen = bridge.imgmsg_to_cv2(data, 'passthrough')
                self.rgb_image_arm =cv2.resize(cv2.cvtColor(imagen, cv2.COLOR_BGR2RGB),(self.width, self.height))
            except CvBridgeError as e:
                rospy.logerr(f"Failed to convert RGB image: {e}")
            
    def rgb_front_callback(self, data):
        if self.processing_front==False:
            try:
                
                bridge = CvBridge()
                imagen = bridge.imgmsg_to_cv2(data, 'passthrough')
                self.rgb_image_front =cv2.resize(cv2.cvtColor(imagen, cv2.COLOR_BGR2RGB),(self.width, self.height))
            except CvBridgeError as e:
                rospy.logerr(f"Failed to convert RGB image: {e}")

    def point_cloud_arm_callback(self, data):
        if self.processing_arm==False:
            if robot_real==False:
                tfBuffer = tf2_ros.Buffer()
                listener = tf2_ros.TransformListener(tfBuffer)
                transform = tfBuffer.lookup_transform("robot_arm_rgbd_camera_color_optical_frame", "robot_arm_rgbd_camera_depth_optical_frame", rospy.Time.now(), rospy.Duration(1))
                cloud_transformed = do_transform_cloud(data, transform)
                # Extract RGB image from the point cloud
                points = list(pc2.read_points(cloud_transformed, field_names=("x", "y", "z", "rgb"), skip_nans=False))
                if len(points) == 1080 * self.height:
                    point_array = np.array(points)

                    # Extract RGB values
                    rgb_array = point_array[:, 3].astype(np.float32).view(np.uint32)
                    r = (rgb_array >> 16) & 0xFF
                    g = (rgb_array >> 8) & 0xFF
                    b = rgb_array & 0xFF
                    
                    self.rgb_image_arm = np.stack((r, g, b), axis=-1).reshape((self.height, self.width, 3)).astype(np.uint8)
                    self.point_matrix_arm = point_array[:, :3].reshape((self.height, self.width, 3))
                    self.last_update=True
            else:
                # Extract RGB image from the point cloud
                points = list(pc2.read_points(data, field_names=("x", "y", "z", "rgb"), skip_nans=False))
                if len(points) == 640 * 480:
                    point_array = np.array(points)
                    self.point_matrix_arm = point_array[:, :3].reshape((480, 640, 3))
                    self.last_update=True
        else:
            print("Received point cloud and not used because in processing")

    def point_cloud_front_callback(self, data):
        if self.processing_front==False:
            if robot_real==False:
                tfBuffer = tf2_ros.Buffer()
                listener = tf2_ros.TransformListener(tfBuffer)
                transform = tfBuffer.lookup_transform("robot_front_rgbd_camera_color_optical_frame", "robot_front_rgbd_camera_depth_optical_frame", rospy.Time.now(), rospy.Duration(1))
                cloud_transformed = do_transform_cloud(data, transform)
                # Extract RGB image from the point cloud
                points = list(pc2.read_points(cloud_transformed, field_names=("x", "y", "z", "rgb"), skip_nans=False))

                if len(points) == self.width * self.height:
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
                    point_array = np.array(points)
                    self.point_matrix_front = point_array[:, :3].reshape((self.height, self.width, 3))
        else:
            print("Received point cloud and not used because in processing")

    def handle_process_image(self, req):
        print("Starting to process")
        if req.isFront:
            pose,distance,needsArm,numberObjects = self.process_front_image()
        else:
            pose,distance,needsArm,numberObjects = self.process_arm_image()
            
        return ProcessImageResponse(pose,distance,needsArm,numberObjects, self.box_dimensions)

    def process_arm_image(self):
        self.last_update=False
        self.count-=1
        print("Processing arm image")
        while self.point_matrix_arm is None or self.last_update is False:
            pass
        if self.save:
            fig = plt.figure()
            ax = fig.add_subplot(111, projection='3d')
            ax.legend()
            ax.set_xlabel('$X$', fontsize=20)
            ax.set_ylabel('$Y$')
            ax.set_box_aspect([np.ptp(self.point_matrix_arm[:,0]), np.ptp(self.point_matrix_arm[:,1]), np.ptp(self.point_matrix_arm[:,2])])
            ax.scatter(self.point_matrix_arm[:,0], self.point_matrix_arm[:,1], self.point_matrix_arm[:,2], marker='o')
            fig.savefig('EXP1/Arm/Original3d_arm' + str(self.count)+ '.png')
            np.save('EXP1/Arm/Original3d_arm' + str(self.count), self.point_matrix_arm)
        self.processing_arm=True
        objects_points=[]
        good_count=0


        mask = (self.point_matrix_arm[:, :, 2] > 0.1) & (self.point_matrix_arm[:, :, 2] < 0.53)
        objects_points = self.point_matrix_arm[mask]
        std_z = stats.median_absolute_deviation(objects_points[:,2])
        median_z = np.mean(objects_points[:,2], axis=0)
        print("Mediana", median_z)
        print("Desviacione estandard", std_z)

        # Filter points based on mode and standard deviation 3 STD
        objects_points = objects_points[(objects_points[:,2] >= median_z -3*std_z) & (objects_points[:,2] <=median_z + 3*std_z)]
        good_count = objects_points.shape[0]
        if self.save:
            fig = plt.figure()
            ax = fig.add_subplot(111, projection='3d')
            ax.legend()

            ax.set_xlabel('$X$', fontsize=20)
            ax.set_ylabel('$Y$')
            ax.set_box_aspect([np.ptp(objects_points[:,0]), np.ptp(objects_points[:,1]), np.ptp(objects_points[:,2])])
            ax.scatter(objects_points[:,0], objects_points[:,1], objects_points[:,2], marker='o')
            fig.savefig('EXP1/Arm/Filtered3d_arm' + str(self.count)+ '.png')
            np.save('EXP1/Arm/Filtered3d_arm' + str(self.count),objects_points)
                    
        if good_count>0:
            objects_points = np.array(objects_points)
            means=np.mean(objects_points,axis=0)
            pca = PCA(n_components=2)
            points_2d = pca.fit_transform(objects_points)
            points_2d+=means[0:2]
            hull = ConvexHull(points_2d)
            hull_points = points_2d[hull.vertices]
            min_x, min_y = np.min(hull_points, axis=0)
            max_x, max_y = np.max(hull_points, axis=0)
            rectangle = np.array([
                [min_x, min_y],
                [max_x, min_y],
                [max_x, max_y],
                [min_x, max_y],
                [min_x, min_y] 
            ])

            graspable_dim = max_y-min_y
            distance=graspable_dim
            
            center_point=[(max_x+min_x)/2, (max_y+min_y)/2,np.mean(objects_points,axis=0)[2]]
            if self.save:
                fig = plt.figure()
                ax = fig.add_subplot()
                ax.legend()
                ax.axis('equal')
                ax.set_xlabel('$X$', fontsize=20)
                ax.set_ylabel('$Y$')
                plt.plot(rectangle[:, 0], rectangle[:, 1], 'r-', label='Bounding Box')
                ax.scatter(center_point[0], center_point[1], marker='o')
                fig.savefig('EXP1/Arm/2dRectangle_arm'+ str(self.count)+ '.png')
                np.save('EXP1/Arm/2dRectangle_arm'+ str(self.count),rectangle)
                
            point_stamped = PoseStamped()
            profundidad=0.13
            point_stamped.pose.position.x = center_point[0]
            point_stamped.pose.position.y = center_point[1]
            point_stamped.pose.position.z = center_point[2] + profundidad
            
            if robot_real:
                point_stamped.header.frame_id = "camera_arm_color_optical_frame"
                self.tf_listener.waitForTransform("/robot_base_footprint", "camera_arm_color_optical_frame", rospy.Time(0), rospy.Duration(4.0))
                point_transformed = self.tf_listener.transformPose("/robot_base_footprint", point_stamped)
                self.pose_target = point_transformed.pose
            else:
                point_stamped.header.frame_id = "robot_front_rgbd_camera_color_optical_frame"
                self.tf_listener.waitForTransform("/robot_base_footprint", "robot_front_rgbd_camera_color_optical_frame", rospy.Time(0), rospy.Duration(4.0))
                point_transformed = self.tf_listener.transformPose("/robot_base_footprint", point_stamped)
                
            
            self.processing_arm=False
            
            components = pca.components_
            principal_axes = components.T
            
            main_axis = principal_axes[:, 0]
            def calculate_angle(vector1, vector2):
                unit_vector1 = vector1 / np.linalg.norm(vector1)
                unit_vector2 = vector2 / np.linalg.norm(vector2)
                dot_product = np.dot(unit_vector1, unit_vector2)
                angle = np.arccos(dot_product)
                return angle

            z_axis = np.array([1, 0, 0])
            theta = calculate_angle(main_axis, z_axis)
            theta=-theta

            print("Principal Components (Eigenvectors):")
            print(components)
            print("Main Axis Orientation (First Principal Component):", main_axis)
            print(f"Angle with Z-axis: {np.degrees(theta):.2f} degrees")
            if theta<0:
                theta+=np.pi

            q = quaternion_from_euler(np.pi, 0, theta)
            self.pose_target.orientation.x = q[0]
            self.pose_target.orientation.y = q[1]
            self.pose_target.orientation.z = q[2]
            self.pose_target.orientation.w = q[3]
            needsArm=False
            
            self.count+=1
            print("Finish Processing Arm")
            return self.pose_target, distance, needsArm, self.numberObjects
        self.processing_arm=False
        print("Ningun punto valido en el intervalo buscado")
        return None,None,None,-1


    def process_front_image(self):
        print("Inside front process")
        while self.rgb_image_front is None or self.point_matrix_front is None:
            pass
        start_time = time.time() 
        self.processing_front = True
        z_mean = 0
        y_mean = 0
        x_mean = 0 

        results = self.model(self.rgb_image_front, show=False, conf=0.45, device="cpu")  # Run inference on the image
        annotated_frame = results[0].plot()

        if self.save:
            # Display the image with all detections
            name="EXP1/Front/Imagen con todos Yolo Objeto" + str(self.count)+ ".png"
            cv2.imwrite(name, annotated_frame)
            cv2.waitKey(1000)

        boxes = results[0].boxes
        best_result = None
        nearestZDistance = float("inf")
        self.numberObjects = 0

        for box in boxes:
            x1, y1, x2, y2 = map(int, box.xyxy[0])
            center_x = int(x1 + (x2 - x1) / 2)
            center_y = int(y1 + (y2 - y1) / 2)
            self.numberObjects += 1
            obj_dist=self.point_matrix_front[center_y, center_x][2]
            if obj_dist< nearestZDistance and obj_dist>0:
                best_result = box
                nearestZDistance = obj_dist
        print(self.numberObjects)
        print("The closest object is at:", nearestZDistance)

        if best_result:
            x1, y1, x2, y2 = map(int, best_result.xyxy[0])
            padding_pixels = 6
            annotated_image = self.rgb_image_front.copy()
            cv2.rectangle(annotated_image, (x1 + padding_pixels, y1 + padding_pixels), (x2 - padding_pixels, y2 - padding_pixels), (0, 255, 0), 2)

            center_x = x1 + (x2 - x1) // 2
            center_y = y1 + (y2 - y1) // 2

            objects_points = []

            # Define the slice range
            x_range = slice(x1 + padding_pixels, x2 - padding_pixels)
            y_range = slice(y1 + padding_pixels, y2 - padding_pixels)

            # Extract the relevant section of the point matrix
            sub_matrix = self.point_matrix_front[y_range, x_range]

            # Apply boolean indexing to filter points
            mask = (sub_matrix[:, :, 2] > 0.2) & (sub_matrix[:, :, 2] < 1.5)
            objects_points = sub_matrix[mask]
            means = np.mean(objects_points, axis=0)
            x_mean, y_mean, z_mean = means

            # Calculate mode and standard deviation
            z_values = objects_points[:, 2]
            
            std_z = stats.median_absolute_deviation(z_values)
            median_z = np.mean(z_values, axis=0)
            print("Mediana", median_z)
            print("Desviacione estandard", std_z)

            point_stamped = PoseStamped()

            print("Mean X", x_mean)
            print("Mean Y", y_mean)
            print("Mean Z", z_mean)

            # Filter points based on mode and standard deviation 3 STD
            filtered_points = objects_points[(z_values >= median_z -3*std_z) & (z_values <=median_z + 3*std_z)]
            
            if self.save:
                fig = plt.figure()
                ax = fig.add_subplot(111, projection='3d')
                ax.legend()
                ax.set_xlabel('$X$', fontsize=20)
                ax.set_ylabel('$Y$')
                ax.set_box_aspect([np.ptp(objects_points[:,0]), np.ptp(objects_points[:,1]), np.ptp(objects_points[:,2])])
                ax.scatter(objects_points[:,0], objects_points[:,1], objects_points[:,2], marker='o')
                fig.savefig('EXP1/Front/NoFiltered3d_front' + str(self.count)+ '.png')
                np.save('EXP1/Front/NoFiltered3d_front' + str(self.count),objects_points)
                
                fig = plt.figure()
                ax = fig.add_subplot(111, projection='3d')
                ax.legend()
                ax.set_xlabel('$X$', fontsize=20)
                ax.set_ylabel('$Y$')
                ax.set_box_aspect([np.ptp(filtered_points[:,0]), np.ptp(filtered_points[:,1]), np.ptp(filtered_points[:,2])])
                ax.scatter(filtered_points[:,0], filtered_points[:,1], filtered_points[:,2], marker='o')
                fig.savefig('EXP1/Front/Filtered3d_front' + str(self.count)+ '.png')
                np.save('EXP1/Front/Filtered3d_front' + str(self.count),filtered_points)
                
            #filtered_points=objects_points
            max_dim = np.max(filtered_points, axis=0)
            min_dim = np.min(filtered_points, axis=0)
            x_dim = max_dim[0] - min_dim[0]
            y_dim = max_dim[1] - min_dim[1]
            z_dim = max_dim[2] - min_dim[2]
            

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
                return

            self.processing_front = False
            point_stamped.pose.position.x = mean_point[0]

            if min_dim[1] + 0.1 < max_dim[1]:
                print("Objeto suficientemente alto")
                point_stamped.pose.position.y = min_dim[1] + 0.055
            else:
                print("----------------------Objeto poco alto--------------------------------------")
                point_stamped.pose.position.y = max_dim[1] - 0.03

            distances = (self.point_matrix_front[..., 0] - point_stamped.pose.position.x)**2 + (self.point_matrix_front[..., 1] - point_stamped.pose.position.y)**2 + (self.point_matrix_front[..., 2] - mean_point[2])**2
            min_index = np.unravel_index(np.argmin(distances), distances.shape)

            points_along_x_graspable_axis = []
            for point in filtered_points:
                if np.abs(point[1] - point_stamped.pose.position.y) < 0.04:
                    points_along_x_graspable_axis.append(point)

            graspable_dim = np.max(points_along_x_graspable_axis, axis=0) - np.min(points_along_x_graspable_axis, axis=0)

            self.box_dimensions.x=x_dim
            self.box_dimensions.z=y_dim
            self.box_dimensions.y=z_dim

            if graspable_dim[0] < 0.12 and graspable_dim[0] > 0.01:
                rot_z = -np.pi / 2
                profundidad = 0.015
                needsArm = False
                distance = graspable_dim[0]
                if self.save:
                    annotated_image = cv2.circle(annotated_image, (center_x, center_y), radius=5, color=(0, 0, 255), thickness=-1)
                    annotated_image = cv2.circle(annotated_image, (min_index[1], min_index[0]), radius=5, color=(0, 255, 0), thickness=-1)
                    name="EXP1/Front/Imagen con Mejor Anotacion Y Gripper" + str(self.count)+ ".png"
                    cv2.imwrite(name, annotated_image)
                    cv2.waitKey(1000)
                
            else:
                print("-------------------------Error with x dimension, trying with y-----------------------------")
                rot_z = +np.pi / 2 - 0.4
                distance = 0.07
                profundidad = -0.13
                needsArm = True
                if self.save:
                    annotated_image = cv2.circle(annotated_image, (center_x, center_y), radius=5, color=(0, 0, 255), thickness=-1)
                    annotated_image = cv2.circle(annotated_image, (min_index[1], min_index[0]), radius=5, color=(0, 255, 0), thickness=-1)
                    name="EXP1/Front/Imagen con Mejor Anotacion Y Centro" + str(self.count)+ ".png"
                    cv2.imwrite(name, annotated_image)
                    cv2.waitKey(1000)

            if self.save:
                annotated_image = cv2.circle(annotated_image, (center_x, center_y), radius=5, color=(0, 0, 255), thickness=-1)
                annotated_image = cv2.circle(annotated_image, (min_index[1], min_index[0]), radius=5, color=(0, 255, 0), thickness=-1)
                name="EXP1/Front/Imagen con Mejor Anotacion Y Gripper" + str(self.count)+ ".png"
                cv2.imwrite(name, annotated_image)
                cv2.waitKey(1000)

            point_stamped.pose.position.z = mean_point[2] + profundidad
            
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

            q = quaternion_from_euler(np.pi, 0, rot_z)

            self.pose_target.orientation.x = q[0]
            self.pose_target.orientation.y = q[1]
            self.pose_target.orientation.z = q[2]
            self.pose_target.orientation.w = q[3]
            
            print("Final Rot on Z", rot_z)
            print("Final distance to open gripper: ", distance)
            print("Final Pose Target\n", self.pose_target)
            self.processing_front = False

            end_time = time.time()  
            elapsed_time = end_time - start_time  
            rospy.logwarn("Elapsed time "+ str(elapsed_time))
            
            # Save the elapsed time to a text file
            # with open("EXP1/Front/execution_times.txt", "a") as file:  
            #    file.write(f"Count: {str(self.count)}, Time: {str(elapsed_time)} seconds\n") 
            print("Finish Processing Front")
            self.count+=1
            return self.pose_target, distance, needsArm, self.numberObjects
        self.processing_front = False
        return None,None,None,-1


if __name__ == '__main__':
    p=PointCloudToImage()
    rospy.spin()
