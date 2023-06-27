#! /usr/bin/env python
import os
import rospy
from gazebo_msgs.srv import SetModelState, GetModelState
from gazebo_msgs.msg import ModelState
from geometry_msgs.msg import Pose, Twist
from datetime import datetime as dt
from colorama import Fore
from gz_freeze_objects.msg import FreezeModels

freezed_models = []

def get_pose(object):
  state = get_state(object, '')

  return state.pose

def freeze_callback(data):
  freeze = data.freeze

  if freeze:
    models = data.models

    arr = []

    for i in range(len(models)):
        model = models[i]
        pose = get_pose(model)
        model_state = ModelState()
        model_state.twist = Twist()
        model_state.twist.angular.x = 0
        model_state.twist.angular.y = 0
        model_state.twist.angular.z = 0
        model_state.twist.linear.x = 0
        model_state.twist.linear.y = 0
        model_state.twist.linear.z = 0
        model_state.pose = pose
        model_state.model_name = model
        freezed_models.append({'model':model, 'state':model_state})
        log("freeze {}".format(model))
  else:
    models = data.models

    if not models:
      del freezed_models[:]
      log("clear freeze list")
    else:
      for i in range(len(models)):
        for j in range(len(freezed_models)):
          if freezed_models[j]['model'] == models[i]:
            freezed_models.remove(freezed_models[j])
            log("remove model {} from freeze list".format(models[i]))
            break

def log(msg):
  now = dt.now()
  print(Fore.BLUE + "["+now.strftime("%H:%M:%S")+"] " + msg + Fore.WHITE)

if __name__ == '__main__':
    rospy.init_node("gz_freeze_objects")
    rospy.wait_for_service('/gazebo/get_model_state')
    pub = rospy.Publisher('/gazebo/set_model_state', ModelState, queue_size=1)
    get_state = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)
    sub = rospy.Subscriber("freeze", FreezeModels, freeze_callback)

    log("GZ freeze models loaded")
    rate = rospy.Rate(1000)
    while not rospy.is_shutdown():
        if freezed_models:
          for i in range(len(freezed_models)):
            try:
              data = freezed_models[i]
              try:
                pub.publish(data['state'])
              except:
                print("An exception occurred")
                freezed_models.remove(data)
            except IndexError as e:
              print("An exception occurred: {}".format(e))
              break
        rate.sleep()
              
