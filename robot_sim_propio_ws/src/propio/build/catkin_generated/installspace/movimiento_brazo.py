#!/usr/bin/env python3

import sys
import copy
import rospy
import moveit_commander
import moveit_msgs.msg
import geometry_msgs.msg

moveit_commander.roscpp_initialize(sys.argv)
rospy.init_node('move_group_python_interface_tutorial', anonymous=True)

robot = moveit_commander.RobotCommander()
scene = moveit_commander.PlanningSceneInterface()    
group = moveit_commander.MoveGroupCommander("arm")
display_trajectory_publisher = rospy.Publisher('/move_group/display_planned_path', moveit_msgs.msg.DisplayTrajectory, queue_size=1)

pose_target = geometry_msgs.msg.Pose()
pose_target.orientation.w = 1.3
pose_target.position.x = 1
pose_target.position.y = 1
pose_target.position.z = 1.2
#group.set_pose_target(pose_target)

planning_frame = group.get_planning_frame()
print ("============ Reference frame:",planning_frame)

group_gripper=moveit_commander.MoveGroupCommander("gripper")
planning_frame = group_gripper.get_planning_frame()
print ("============ Reference frame:",planning_frame)

# We can also print the name of the end-effector link for this group:
eef_link = group.get_end_effector_link()
print ("============ End effector: %s", eef_link)

eef_link = group_gripper.get_end_effector_link()
print ("============ End effector: %s", eef_link)

print ("============ End effector POSE: %s", group.get_current_pose().pose)
# We can get a list of all the groups in the robot:
group_names = robot.get_group_names()
print ("============ Robot Groups:", robot.get_group_names())

# Sometimes for debugging it is useful to print the entire state of the
# robot:
print ("============ Printing robot state")
print (robot.get_current_state())

print ("============ Printing robot pose")
print (robot.get_current_state())


#plan1 = group.plan()

#rospy.sleep(5)




#moveit_commander.roscpp_shutdown()
