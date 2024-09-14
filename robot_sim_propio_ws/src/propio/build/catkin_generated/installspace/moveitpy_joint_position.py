#!/usr/bin/env python3

import rospy
from moveit_python import MoveGroupInterface
from moveit_msgs.msg import MoveItErrorCodes

rospy.init_node('moveit_python_tutorial', anonymous=True)

move_group = MoveGroupInterface("arm", frame="robot_base_footprint")

joints = ["robot_j2s6s300_joint_1", "robot_j2s6s300_joint_2", "robot_j2s6s300_joint_3",
                  "robot_j2s6s300_joint_4", "robot_j2s6s300_joint_5", "robot_j2s6s300_joint_6"]

pose = [2,3,1,
        1,1,1]

while not rospy.is_shutdown():

    result = move_group.moveToJointPosition(joints, pose, 0.02)
    if result:

        if result.error_code.val == MoveItErrorCodes.SUCCESS:
            rospy.loginfo("Trajectory successfully executed!")
        else:
            rospy.logerr("Arm goal in state: %s",
                            move_group.get_move_action().get_state())
    else:
        rospy.logerr("MoveIt failure! No result returned.")

move_group.get_move_action().cancel_all_goals()