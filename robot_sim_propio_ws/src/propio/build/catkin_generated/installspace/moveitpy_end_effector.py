#!/usr/bin/env python3

import rospy
from moveit_python import MoveGroupInterface
from moveit_msgs.msg import MoveItErrorCodes
from geometry_msgs.msg import PoseStamped, Pose, Point, Quaternion
import moveit_commander
rospy.init_node('moveit_python_tutorial', anonymous=True)

move_group=moveit_commander.MoveGroupCommander("arm")



move_group_py = MoveGroupInterface("arm", frame="robot_base_footprint")

gripper_frame = 'robot_j2s6s300_link_6'

gripper_poses = [move_group.get_current_pose().pose,
                Pose(Point(0.7,0,0.78), Quaternion(1,0,0,0.7))]

gripper_pose_stamped = PoseStamped()
gripper_pose_stamped.header.frame_id = 'robot_base_footprint'

while not rospy.is_shutdown():
    for pose in gripper_poses:
        gripper_pose_stamped.header.stamp = rospy.Time.now()

        gripper_pose_stamped.pose = pose

        result = move_group_py.moveToPose(gripper_pose_stamped, gripper_frame)

        if result:

            if result.error_code.val == MoveItErrorCodes.SUCCESS:
                rospy.loginfo("Trajectory successfully executed!")
            else:
                rospy.logerr("Arm goal in state: %s",
                                move_group_py.get_move_action().get_state())
        else:
            rospy.logerr("MoveIt failure! No result returned.")
            

move_group_py.get_move_action().cancel_all_goals()
