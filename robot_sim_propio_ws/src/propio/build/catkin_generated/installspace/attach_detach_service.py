#!/usr/bin/env python3

import rospy
from geometry_msgs.msg import Pose
from propio.srv import AttachDetach, AttachDetachResponse
from gazebo_msgs.srv import GetLinkState, SetModelState, SetModelStateRequest

class GripperFollower:
    def __init__(self):
        rospy.init_node('gripper_follower', anonymous=True)

        self.attached = False
        self.object_name = ""
        self.gripper_model_name = "robot"  # Update this to match your robot's model name in Gazebo
        self.gripper_link_name = "robot_j2s6s300_link_finger_3"  # Update this to match your gripper's link name in Gazebo

        # Service to attach/detach the object
        self.attach_detach_service = rospy.Service('/attach_detach', AttachDetach, self.handle_attach_detach)

        # Gazebo service clients
        rospy.wait_for_service('/gazebo/get_link_state')
        rospy.wait_for_service('/gazebo/set_model_state')
        self.get_link_state_srv = rospy.ServiceProxy('/gazebo/get_link_state', GetLinkState)
        self.set_model_state_srv = rospy.ServiceProxy('/gazebo/set_model_state', SetModelState)

    def handle_attach_detach(self, req):
        self.object_name = req.object_name
        self.attached = req.attach
        response_message = f"Object {self.object_name} attached" if self.attached else f"Object {self.object_name} detached"
        return AttachDetachResponse(success=True, message=response_message)

    def get_gripper_pose(self):
        try:
            link_state = self.get_link_state_srv(self.gripper_model_name + "::" + self.gripper_link_name, "world")
            return link_state.link_state.pose
        except rospy.ServiceException as e:
            rospy.logerr("Service call failed: %s" % e)
            return None

    def run(self):
        rate = rospy.Rate(10)  # 10 Hz
        while not rospy.is_shutdown():
            if self.attached and self.object_name:
                gripper_pose = self.get_gripper_pose()
                if gripper_pose:
                    # Update the object's pose to match the gripper's pose
                    object_state = SetModelStateRequest()
                    object_state.model_state.model_name = self.object_name
                    object_state.model_state.pose = gripper_pose
                    object_state.model_state.reference_frame = "world"
                    
                    try:
                        self.set_model_state_srv(object_state)
                    except rospy.ServiceException as e:
                        rospy.logerr("Service call failed: %s" % e)
            rate.sleep()

if __name__ == '__main__':
    gripper_follower = GripperFollower()
    gripper_follower.run()
