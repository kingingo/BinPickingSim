
import struct
import rospy
import numpy as np
#import open3d as o3d
from geometry_msgs.msg import PoseStamped
import math
from colorama import Fore
import ctypes
from datetime import datetime as dt
from datetime import timedelta as td
from colormath.color_objects import sRGBColor, LabColor
from colormath.color_diff import delta_e_cie1976
from colormath.color_conversions import convert_color
'''
from pytransform3d import transformations as pt
from pytransform3d import rotations as pr
from pytransform3d.trajectories import transforms_from_pqs
from pytransform3d.transform_manager import TransformManager

def transform2(x,y,z, cam_pos = [0,0,0], cam_rot = {'roll':0,'pitch':0,'yaw':0}):
  qx, qy, qz, qw = euler_to_quaternion(cam_rot['roll'], cam_rot['pitch'], cam_rot['yaw'])
  p = pt.transform_from_pq([cam_pos[0], cam_pos[1], cam_pos[2], qw, qx, qy, qz])
  p = pt.invert_transform(p)

  x,y,z,s = pt.transform(p,[x,y,z,1])
  return x,y,z
'''
def deltaE_diff(c1, c2):
    # Reference color.
    color1 = sRGBColor(c1[0],c1[1],c1[2], True)
    # Color to be compared to the reference.
    color2 = sRGBColor(c2[0],c2[1],c2[2], True)
    
    lab1 = convert_color(color1, LabColor)
    lab2 = convert_color(color2, LabColor)
    # This is your delta E value as a float.
    delta_e = delta_e_cie1976(lab1, lab2)
    
    return delta_e

def collision_point_sdf(radius = 0.01):
  return """
  <?xml version='1.0'?>
  <sdf version="1.4">
    <model name="point">
      <static>true</static>
      <self_collide>1</self_collide>
      <link name="link">
        <collision name="point_collision">
          <geometry>
            <sphere>
              <radius>{r}</radius>
            </sphere>
          </geometry>
          <surface>
            <contact>
              <collide_without_contact>true</collide_without_contact>
              <collide_without_contact_bitmask>1</collide_without_contact_bitmask>
            </contact>
          </surface>
        </collision>
        <visual name="visual">
          <geometry>
            <sphere>
              <radius>{r}</radius>
            </sphere>
          </geometry>
          <material><script><name>Gazebo/Yellow</name></script></material>
        </visual>
        <sensor name='my_contact' type='contact'>
          <update_rate>50.0</update_rate>
          <always_on>1</always_on>
          <contact>
            <collision>point_collision</collision>
          </contact>
        </sensor>
      </link>
    </model>
  </sdf>
  """.format(r=radius)

def float_to_rgb(float_rgb):
    s = struct.pack('>f', float_rgb)
    i = struct.unpack('>l', s)[0]
    pack = ctypes.c_uint32(i).value
			
    r = (pack & 0x00FF0000) >> 16
    g = (pack & 0x0000FF00) >> 8
    b = (pack & 0x000000FF)
			
    color = [r,g,b]
			
    return color

def euler_to_quaternion(roll, pitch, yaw):
    qx = np.sin(roll/2) * np.cos(pitch/2) * np.cos(yaw/2) - np.cos(roll/2) * np.sin(pitch/2) * np.sin(yaw/2)
    qy = np.cos(roll/2) * np.sin(pitch/2) * np.cos(yaw/2) + np.sin(roll/2) * np.cos(pitch/2) * np.sin(yaw/2)
    qz = np.cos(roll/2) * np.cos(pitch/2) * np.sin(yaw/2) - np.sin(roll/2) * np.sin(pitch/2) * np.cos(yaw/2)
    qw = np.cos(roll/2) * np.cos(pitch/2) * np.cos(yaw/2) + np.sin(roll/2) * np.sin(pitch/2) * np.sin(yaw/2)
    return [qx, qy, qz, qw]

   
def log(msg):
  now = dt.now()
  print(Fore.MAGENTA + "["+now.strftime("%H:%M:%S")+"] " + msg + Fore.WHITE)