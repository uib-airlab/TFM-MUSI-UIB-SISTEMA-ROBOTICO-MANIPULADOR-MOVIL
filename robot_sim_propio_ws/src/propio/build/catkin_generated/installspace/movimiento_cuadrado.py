#!/usr/bin/env python3
# license removed for brevity
import rospy
from std_msgs.msg import String
from geometry_msgs.msg import Twist
from nav_msgs.msg import Odometry
from tf.transformations import euler_from_quaternion
from numpy import sqrt

class Mover:
    def __init__(self):
        self.msg_pose=Odometry()
        self.rate=rospy.Rate(10)
        self.pub = rospy.Publisher('/robotnik_base_control/cmd_vel',Twist , queue_size=10)
        rospy.Subscriber('/robotnik_base_control/odom', Odometry ,self.compute_distance_angle)
        self.delta_distance=0
        self.previous_distance_x=0
        self.previous_distance_y=0
        self.delta_yaw=0
        self.previous_yaw=0
        

    def move_forward(self,distance):
        msg_twist=Twist()
        rospy.loginfo("Outside loop")
        target_distance=self.delta_distance+distance
        rospy.loginfo(f"Target distance: {target_distance}")
        while self.delta_distance<target_distance:
            rospy.loginfo(f"Actual distance {self.delta_distance}")
            msg_twist.linear.x=0.5
            self.pub.publish(msg_twist)
            self.rate.sleep()
        msg_twist.linear.x=0
        self.pub.publish(msg_twist)


    def compute_distance_angle(self,data):
        delta_x=abs(data.pose.pose.position.x-self.previous_distance_x)
        self.previous_distance_x=data.pose.pose.position.x
        delta_y=abs(data.pose.pose.position.y-self.previous_distance_y)
        self.previous_distance_y=data.pose.pose.position.y

        self.delta_distance+=(delta_x+delta_y)

        data_quat=data.pose.pose.orientation
        orientation_list = [data_quat.x, data_quat.y, data_quat.z, data_quat.w]
        (roll, pitch, yaw) = euler_from_quaternion (orientation_list)
        self.delta_yaw += abs(yaw-self.previous_yaw)
        self.previous_yaw=yaw

    def turn_left(self,angle):
        msg_twist=Twist()
        target_yaw=angle+self.delta_yaw
        rospy.loginfo(f"Target yaw: {target_yaw}")
        while self.delta_yaw<target_yaw:
            rospy.loginfo(f"Actual yaw {self.delta_yaw}")
            msg_twist.angular.z=1
            self.pub.publish(msg_twist)
            self.rate.sleep()
        msg_twist.angular.z=0
        self.pub.publish(msg_twist)


def diff_drive():
    rospy.init_node('diff_drive', anonymous=True)
    mover=Mover()
    distance=0.5
    angle=1.57
    rospy.logwarn("Start")
    mover.move_forward(distance)
    mover.turn_left(angle)
    rospy.logwarn("First corner")
    mover.move_forward(distance)
    mover.turn_left(angle)
    rospy.logwarn("Second corner")
    mover.move_forward(distance)
    mover.turn_left(angle)
    rospy.logwarn("Third corner")
    mover.move_forward(distance)
    mover.turn_left(angle)
    rospy.logwarn("End")
        

if __name__ == '__main__':
    try:
        diff_drive()
    except rospy.ROSInterruptException:
        pass#!/usr/bin/env python
# license removed for brevity
import rospy
from std_msgs.msg import String
from geometry_msgs.msg import Twist
from nav_msgs.msg import Odometry
from tf.transformations import euler_from_quaternion
from numpy import sqrt

class Mover:
    def __init__(self):
        self.msg_pose=Odometry()
        self.rate=rospy.Rate(10)
        self.pub = rospy.Publisher('/robot/robotnik_base_control/cmd_vel',Twist , queue_size=10)
        rospy.Subscriber('/robot/robotnik_base_control/odom', Odometry ,self.compute_distance_angle)
        self.delta_distance=0
        self.previous_distance_x=0
        self.previous_distance_y=0
        self.delta_yaw=0
        self.previous_yaw=0
        

    def move_forward(self,distance):
        msg_twist=Twist()
        rospy.loginfo("Outside loop")
        target_distance=self.delta_distance+distance
        rospy.loginfo(f"Target distance: {target_distance}")
        while self.delta_distance<target_distance:
            rospy.loginfo(f"Actual distance {self.delta_distance}")
            msg_twist.linear.x=0.5
            self.pub.publish(msg_twist)
            self.rate.sleep()
        msg_twist.linear.x=0
        self.pub.publish(msg_twist)


    def compute_distance_angle(self,data):
        delta_x=abs(data.pose.pose.position.x-self.previous_distance_x)
        self.previous_distance_x=data.pose.pose.position.x
        delta_y=abs(data.pose.pose.position.y-self.previous_distance_y)
        self.previous_distance_y=data.pose.pose.position.y

        self.delta_distance+=(delta_x+delta_y)

        data_quat=data.pose.pose.orientation
        orientation_list = [data_quat.x, data_quat.y, data_quat.z, data_quat.w]
        (roll, pitch, yaw) = euler_from_quaternion (orientation_list)
        self.delta_yaw += abs(yaw-self.previous_yaw)
        self.previous_yaw=yaw

    def turn_left(self,angle):
        msg_twist=Twist()
        target_yaw=angle+self.delta_yaw
        rospy.loginfo(f"Target yaw: {target_yaw}")
        while self.delta_yaw<target_yaw:
            rospy.loginfo(f"Actual yaw {self.delta_yaw}")
            msg_twist.angular.z=1
            self.pub.publish(msg_twist)
            self.rate.sleep()
        msg_twist.angular.z=0
        self.pub.publish(msg_twist)


def diff_drive():
    rospy.init_node('diff_drive', anonymous=True)
    mover=Mover()
    distance=0.5
    angle=1.57
    rospy.logwarn("Start")
    mover.move_forward(distance)
    mover.turn_left(angle)
    rospy.logwarn("First corner")
    mover.move_forward(distance)
    mover.turn_left(angle)
    rospy.logwarn("Second corner")
    mover.move_forward(distance)
    mover.turn_left(angle)
    rospy.logwarn("Third corner")
    mover.move_forward(distance)
    mover.turn_left(angle)
    rospy.logwarn("End")
        

if __name__ == '__main__':
    try:
        diff_drive()

    except rospy.ROSInterruptException:
        pass