
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

def float_to_rgb(float_rgb):
    s = struct.pack('>f', float_rgb)
    i = struct.unpack('>l', s)[0]
    pack = ctypes.c_uint32(i).value
			
    r = (pack & 0x00FF0000) >> 16
    g = (pack & 0x0000FF00) >> 8
    b = (pack & 0x000000FF)
			
    color = [r,g,b]
			
    return color

def get_label(rgb):
  if rgb[2] == 192:
    return 1
  return 0

def euler_to_quaternion(roll, pitch, yaw):
    qx = np.sin(roll/2) * np.cos(pitch/2) * np.cos(yaw/2) - np.cos(roll/2) * np.sin(pitch/2) * np.sin(yaw/2)
    qy = np.cos(roll/2) * np.sin(pitch/2) * np.cos(yaw/2) + np.sin(roll/2) * np.cos(pitch/2) * np.sin(yaw/2)
    qz = np.cos(roll/2) * np.cos(pitch/2) * np.sin(yaw/2) - np.sin(roll/2) * np.sin(pitch/2) * np.cos(yaw/2)
    qw = np.cos(roll/2) * np.cos(pitch/2) * np.cos(yaw/2) + np.sin(roll/2) * np.sin(pitch/2) * np.sin(yaw/2)
    return [qx, qy, qz, qw]

def chunkIt(seq, num = 10):
    avg = math.ceil(len(seq) / float(num))
    out = []
    last = 0.0

    while last < len(seq):
        out.append(seq[int(last):int(last + avg)])
        last += avg

    return out

def max(world_chunks):
  global world_chunks_size

  for i in range(len(world_chunks)):
    length = len(world_chunks[i])
    if world_chunks_size is None:
      world_chunks_size = length
    else:
      if world_chunks_size < length:
        world_chunks_size = length
  
  log("world_chunks_size({})".format(world_chunks_size))
   
def log(msg):
  now = dt.now()
  print(Fore.MAGENTA + "["+now.strftime("%H:%M:%S")+"] " + msg + Fore.WHITE)