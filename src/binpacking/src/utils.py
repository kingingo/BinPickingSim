
import struct
import rospy
import numpy as np
import open3d as o3d
from geometry_msgs.msg import PoseStamped
import math
from colorama import Fore
import ctypes
from datetime import datetime as dt
from datetime import timedelta as td
from colormath.color_objects import sRGBColor, LabColor
from colormath.color_diff import delta_e_cie1976
from colormath.color_conversions import convert_color

def rotation_matrix(yaw_rad, pitch_rad, roll_rad):
    # Compute trigonometric values
    cos_yaw = np.cos(yaw_rad)
    sin_yaw = np.sin(yaw_rad)
    cos_pitch = np.cos(pitch_rad)
    sin_pitch = np.sin(pitch_rad)
    cos_roll = np.cos(roll_rad)
    sin_roll = np.sin(roll_rad)

    # Compute rotation matrix elements
    r11 = cos_yaw * cos_pitch
    r12 = cos_yaw * sin_pitch * sin_roll - sin_yaw * cos_roll
    r13 = cos_yaw * sin_pitch * cos_roll + sin_yaw * sin_roll

    r21 = sin_yaw * cos_pitch
    r22 = sin_yaw * sin_pitch * sin_roll + cos_yaw * cos_roll
    r23 = sin_yaw * sin_pitch * cos_roll - cos_yaw * sin_roll

    r31 = -sin_pitch
    r32 = cos_pitch * sin_roll
    r33 = cos_pitch * cos_roll

    # Create rotation matrix
    rotation_matrix = np.array([[r11, r12, r13],
                                [r21, r22, r23],
                                [r31, r32, r33]])
    return rotation_matrix

def transform1(x,y,z, tx, ty, tz, pitch, yaw, roll):
  # Camera's position vector in the world frame
  T_cw = np.array([tx, ty, tz])

  # Camera's orientation matrix in the world frame
  R_cw = rotation_matrix(yaw, pitch, roll)  # Obtain the rotation matrix representing the camera's orientation

  # Homogeneous representation of the point
  P_c_homogeneous = np.array([x, y, z])

  # Transformation to the world frame
  P_w = np.dot(R_cw, P_c_homogeneous) + T_cw

  # Transformed point in the world frame
  x_w = P_w[0]
  y_w = P_w[1]
  z_w = P_w[2]

  return x_w, y_w, z_w

def transfrom(x,y,z, tx, ty, tz, pitch, yaw, roll):
   # Original 3D point
  P = np.array([x-tx, y-ty, z-tz])

  # Rotation matrices
  R_pitch = np.array([[1, 0, 0],
                      [0, np.cos(pitch), -np.sin(pitch)],
                      [0, np.sin(pitch), np.cos(pitch)]])

  R_yaw = np.array([[np.cos(yaw), 0, np.sin(yaw)],
                    [0, 1, 0],
                    [-np.sin(yaw), 0, np.cos(yaw)]])

  R_roll = np.array([[np.cos(roll), -np.sin(roll), 0],
                    [np.sin(roll), np.cos(roll), 0],
                    [0, 0, 1]])

  # Transformation
  P_prime = np.dot(R_roll, np.dot(R_yaw, np.dot(R_pitch, P)))

  # Transformed point
  transformed_x, transformed_y, transformed_z = P_prime

  return transformed_x, transformed_y, transformed_z

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
  #print(Fore.MAGENTA + "["+now.strftime("%H:%M:%S")+"] " + msg + Fore.WHITE)