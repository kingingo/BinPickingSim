#! /usr/bin/env python
import os
import sys
import rospy
import random
import numpy as np
import signal
from tf2_geometry_msgs import PointStamped, do_transform_point
from gazebo_msgs.srv import SetModelState, SpawnModel, DeleteModel, GetModelState, GetModelStateRequest, BodyRequest, SetLightProperties
from gazebo_msgs.msg import ModelState, ContactsState
from geometry_msgs.msg import Pose, Quaternion, TransformStamped, Point, PoseStamped, Twist
from sensor_msgs.msg import PointCloud2
from sensor_msgs import point_cloud2
from utils import *
from std_srvs.srv import Empty, EmptyRequest
from datetime import datetime as dt
from datetime import timedelta as td
import tf2_ros
from tf import TransformListener
import subprocess
import yaml
import math
import pickle
import time
from std_msgs.msg import String, ColorRGBA
from gz_ray_label_plugin.msg import LabelPoint
from gz_ray_label_plugin.msg import LabelPoints
from gz_freeze_objects.msg import FreezeModels
from gz_dynamic_colors.msg import DColor

freeze_pub = None
catkin_path = '/home/felix/catkin_ws'
package_path = catkin_path+'/src/binpacking/'
received_points_ray = False
received_points = False
received_points_counter = 0
world_frame_name = 'map'
xpoint = []
ypoint = []
zpoint = [] 
listener = None
point_index = 0
pointcloud_sampled_down = False
point_index_list = None
world_chunks_size = None
world_chunks_diff = None
worldpoints = []
labelpoint = []
clabelpoint = []
rgbpoint = []
spawned_objects = []
collide_point = None
point_publisher = None
path = None
color_labeling = False
reset_gz_world = None
camera_frame = ''
boundingbox = []
color_codes = {
  'Banana': "255 225 20",
  'Apple': "229 0 0",
  'Orange': "249 115 6",
  'Stackingbox': "3 67 223",
  'Pear': "203 248 95",
  "Plum": "255 0 255",
  "Toothbrush": "252 252 252"
  }
object_color_codes = []

def spawn_xml(model_name, 
              modelxml, 
              px = None, 
              py = None, 
              pz = None, 
              yaw = None, roll = None, pitch = None, 
              qx = None, qy = None, qz = None, qw = None, 
              ax = None, ay = None, az = None,
              lx = None, ly = None, lz = None,
              is_sdf = True, 
              sleeptime = 0,
              add_to_list = True):
  global spawned_objects
  pose = Pose()
  twist = Twist()
  
  if px is not None and py is not None and pz is not None:
    pose.position.x = px
    pose.position.y = py
    pose.position.z = pz

  if roll is not None and pitch is not None and yaw is not None:
    qx, qy, qz, qw = euler_to_quaternion(roll, pitch, yaw)
    pose.orientation.x = qx
    pose.orientation.y = qy
    pose.orientation.z = qz
    pose.orientation.w = qw
  elif qx is not None and qy is not None and qz is not None and qw is not None:
    pose.orientation.x = qx
    pose.orientation.y = qy
    pose.orientation.z = qz
    pose.orientation.w = qw

  if ax is not None and ay is not None and az is not None:
    twist.angular.x = ax
    twist.angular.y = ay
    twist.angular.z = az

  if lx is not None and ly is not None and lz is not None:
    twist.linear.x = lx
    twist.linear.y = ly
    twist.linear.z = lz

  if is_sdf:
    spawn_sdf_model(
      model_name=model_name,
      model_xml=modelxml,
      robot_namespace='/foo.world',
      initial_pose=pose,
      reference_frame='map'
    )
  else:
    spawn_urdf_model(
      model_name=model_name,
      model_xml=modelxml,
      robot_namespace='/foo.world',
      initial_pose=pose,
      reference_frame='map'
    )
  if sleeptime > 0:
    rospy.sleep(sleeptime)

  if add_to_list:
    spawned_objects.append(model_name)
  log(model_name+' spawned')

def spawn(model_name, px = None, py = None, pz = None, is_sdf = True):
  spawn_xml(model_name, open(package_path+'/models/'+model_name+'.sdf', 'r').read(), px, py, pz, is_sdf)

def camera_set_pose(px = 0, py = 0, pz = 1.9, roll = 0, pitch = 1.61, yaw = 0):
  #change camera pose
  log("change camera pose")
  log("x/y/z: {}/{}/{}".format(px,py,pz))
  log("roll/pitch/yaw: {}/{}/{}".format(roll,pitch,yaw))

  q = euler_to_quaternion(roll, pitch, yaw)
  #log("quanternion x/y/z/w: {}/{}/{}/{}".format(q[0],q[1],q[2],q[3]))
  state_msg = ModelState()
  state_msg.model_name = 'kinect-plugin'
  state_msg.pose.position.x = px
  state_msg.pose.position.y = py
  state_msg.pose.position.z = pz
  state_msg.pose.orientation.x = q[0]
  state_msg.pose.orientation.y = q[1]
  state_msg.pose.orientation.z = q[2]
  state_msg.pose.orientation.w = q[3]

  try:
      resp = set_state( state_msg )
      log("camera pose changed")
  except rospy.ServiceException as e:
      log("service call failed: " + e)

def camera_subscribe_callback(data):
  global camera_frame, received_points_counter, received_points
  assert isinstance(data, PointCloud2)
  #if not received_points:
  if received_points_counter <= 0 or received_points:
    return

  received_points_counter -= 1
  if received_points_counter > 0:
    return

  camera_frame = data.header.frame_id
  points = point_cloud2.read_points(data, field_names=("x", "y", "z", "rgb"), skip_nans=True) 

  for point in points:
    xpoint.append(point[0])
    ypoint.append(point[1])
    zpoint.append(point[2])
    rgbpoint.append(point[3])
    clabelpoint.append(0)
    labelpoint.append(0)

  log("camera_subscribe_callback got data from frame {}".format(camera_frame))
  received_points=True

def get_model_color(modelname):
  global object_color_codes

  for i in range(len(object_color_codes)):
    model = object_color_codes[i]
    if modelname.lower() == model['name'].lower():
      return model['color']
  return 'Black'

def fill_color_label():
  global rgbpoint,object_color_codes
  length = len(rgbpoint)

  for i in range(len(object_color_codes)):
    model = object_color_codes[i]
    log("modelname:{} color:{} rgb:{}/{}/{} catId:{}".format(model['name'],model['color'], model['r'],model['g'],model['b'],model['catId']))

  log("Start color labeling...")
  for i in range(length):
    r = rgbpoint[i][0]
    g = rgbpoint[i][1]
    b = rgbpoint[i][2]

    clabelpoint[i] = get_label(r,g,b)

  log("Color labeling done :)")
          
def get_pose(object):
  state = get_state(object, '')
  return state.pose

def set_pose(object, x = None, y = None, z = None, qx = None, qy = None, qz = None, qw = None, ax = None, ay = None, az = None, lx = None, ly = None, lz = None):
  model_state = ModelState()

  # set the name of the object you want to move
  model_state.model_name = object

  if x is not None and y is not None and z is not None:
    # set the new pose of the object
    model_state.pose.position.x = x
    model_state.pose.position.y = y
    model_state.pose.position.z = z

  if ax is not None and ay is not None and az is not None:
    model_state.twist.angular.x = ax
    model_state.twist.angular.y = ay
    model_state.twist.angular.z = az

  if lx is not None and ly is not None and lz is not None:
    model_state.twist.linear.x = lx
    model_state.twist.linear.y = ly
    model_state.twist.linear.z = lz

  if qx is not None and qy is not None and qz is not None and qw is not None:
    # set the orientation of the object
    model_state.pose.orientation.x = qx
    model_state.pose.orientation.y = qy
    model_state.pose.orientation.z = qz
    model_state.pose.orientation.w = qw
  else:
    model_state.pose.orientation.x = 0.0
    model_state.pose.orientation.y = 0.0
    model_state.pose.orientation.z = 0.0
    model_state.pose.orientation.w = 0.0

  set_state(model_state)

def load_checkpoint(_path):
  global xpoint, ypoint, zpoint, worldpoints, labelpoint, rgbpoint, path, clabelpoint
  if os.path.isfile(_path + "/checkpoint.p"):
    log("find checkpoint file!")
    checkpoint = pickle.load(open(_path + "/checkpoint.p", 'rb'))

    if checkpoint is not None:
      xpoint = checkpoint['xpoint']
      ypoint = checkpoint['ypoint']
      zpoint = checkpoint['zpoint']
      worldpoints = checkpoint['worldpoints']
      labelpoint = checkpoint['labelpoint']
      if 'clabelpoint' in checkpoint:
        clabelpoint = checkpoint['clabelpoint']
      rgbpoint = checkpoint['rgbpoint']
      path = _path
      return checkpoint['objects']
  
  return False

def save_checkpoint():
  global xpoint, ypoint, zpoint, worldpoints, labelpoint, rgbpoint, clabelpoint
  objects = []

  for obj in spawned_objects:
    pose = get_pose(obj)
    objects.append({'name':obj, 'pose': pose})

  checkpoint = {
    'objects': objects,
    'xpoint': xpoint,
    'ypoint': ypoint,
    'zpoint': zpoint,
    'worldpoints': worldpoints,
    'labelpoint': labelpoint,
    'clabelpoint': clabelpoint,
    'rgbpoint': rgbpoint
  }

  pickle.dump(checkpoint, open(get_path() + "/checkpoint.p", 'wb'))
  log("checkpoint saved to {}".format(get_path()))

def subscribe_to_camera(skip_data = 4):
  global received_points_counter, rgbpoint, received_points
  clear_all_forces()
  #subscribe to camera 
  received_points_counter = skip_data
  received_points = False
  
  rospy.sleep(0.5)
  sub = rospy.Subscriber("/camera/depth/points", PointCloud2, camera_subscribe_callback)
  log("waiting for incoming points")
  while True:
    rospy.sleep(0.5)
    if received_points and received_points_counter <= 0:
      if len(rgbpoint) > 0:
        rgb = float_to_rgb(rgbpoint[0])

        if rgb[0] == 0 and rgb[1] == 0 and rgb[2] == 0:
          reset_world()
          received_points_counter = skip_data
          received_points = False
          log("RGB all black so take points again :)")
          continue
      break

  sub.unregister()
  log("done with sleeping... lets continue")
  log("Volume {}".format(len(xpoint)))
   
def get_path(format = 'ply', amount = 0):
  global path

  if path is not None:
    return path

  now = dt.now()
  _path = "{}/synthetic_data/{}/synthetic_pc_{}_a{}".format(catkin_path,format,now.strftime('%d-%m-%Y_%H-%M-%S'),amount)
  path = _path

  if not os.path.exists(_path):
    os.makedirs(_path)
  return _path

def clear_path():
  global path
  path = None

def reset_world(_clear_path = True):
  #clear lists
  del xpoint[:]
  del ypoint[:]
  del zpoint[:]
  del rgbpoint[:]
  del worldpoints[:]
  del clabelpoint[:]
  del labelpoint[:]
  if _clear_path:
    clear_path()

def get_label_color(label):
  for data in object_color_codes:
    if data['catId'] == int(label):
      return data['r'], data['g'], data['b']
  return 0, 0, 0

def write_pointcloud(format = 'ply', reset = True, prefix = '', color_by_label = False, with_label = True, RGB = True, world_points = False):
  global xpoint, ypoint, zpoint, labelpoint, clabelpoint, worldpoints, spawned_objects

  if not (format is 'ply' or format is 'txt'):
    log("file format {} not supported".format(format))
    return

  #create a .pkl file 
  volume = len(xpoint)
  log("create . file for {} points".format(format, volume))

  def wr(m):
    fid.write(str(m).encode('utf-8'))

  _amount = len(spawned_objects)
  path = get_path(amount = _amount)
  filename = '{}data{}_a{}.{}'.format(prefix,( '' if not pointcloud_sampled_down else '_min' ),_amount,format)
  filepath = path + '/' + filename
  log("write pointcloud to {}".format(filename))
  fid = open(filepath, 'wb')
  
  if format is 'ply':
    wr('ply\n')
    wr('format ascii 1.0\n')
    wr('element vertex %d\n' % volume)
    wr('property float x\n')
    wr('property float y\n')
    wr('property float z\n')
    if RGB:
      wr('property uchar red\n')
      wr('property uchar green\n')
      wr('property uchar blue\n')
    else:
      wr('property float color\n')

    if with_label:
      wr('property uchar label\n')
      if format is not 'txt':
        wr('property uchar clabel\n')
    wr('end_header\n')
  
  for i in range(volume):

    x = xpoint[i]
    y = ypoint[i]
    z = zpoint[i]

    if world_points:
      x = worldpoints[i][0]
      y = worldpoints[i][1]
      z = worldpoints[i][2]

    color = rgbpoint[i]
    if type(color) is list:
      r = color[0] 
      g = color[1] 
      b = color[2] 
    else:
      if RGB:
        rgb = float_to_rgb(color)
        r = rgb[0]
        g = rgb[1]
        b = rgb[2]
      else:
        if with_label:
          fid.write('{} {} {} {} {}\n'.format(x,y,z,color,label))
        else:
          fid.write('{} {} {} {}\n'.format(x,y,z,color))
        continue

    label = labelpoint[i]

    if format is 'ply':
      clabel = clabelpoint[i]

      if color_by_label:
        r, g, b = get_label_color(label)

      if with_label:
        fid.write('{} {} {} {} {} {} {} {}\n'.format(x,y,z,r,g,b,label,clabel))
      else:
        fid.write('{} {} {} {} {} {}\n'.format(x,y,z,r,g,b))
    elif format is 'txt':
      fid.write('{} {} {} {} {} {} {}\n'.format(x,y,z,r,g,b,label))
  fid.close()
  log("pointcloud saved to {}".format(filepath))
  if reset:
    reset_world()

def filter_points_by_colours():
  global xpoint, ypoint, zpoint, rgbpoint, labelpoint, clabelpoint
  _xpoint = []
  _ypoint = []
  _zpoint = []
  _rgbpoint = []
  _labelpoint = []
  _clabelpoint = []

  volume = len(xpoint)
  log("filter for important points, volume={}".format(volume))
  for i in range(volume):
    x = xpoint[i]
    y = ypoint[i]
    z = zpoint[i]
    rgb = rgbpoint[i]

    if not (type(rgb) == list):
      rgb = float_to_rgb(rgb)

    r = rgb[0]
    g = rgb[1]
    b = rgb[2]

    if r != 155 and g != 155 and b != 155:
      _xpoint.append(x)
      _ypoint.append(y)
      _zpoint.append(z)
      _labelpoint.append(labelpoint[i])
      _clabelpoint.append(clabelpoint[i])
      _rgbpoint.append(rgbpoint[i])
  log("{} points left".format(len(_xpoint)))
  xpoint = _xpoint
  ypoint = _ypoint
  zpoint = _zpoint
  labelpoint = _labelpoint
  clabelpoint = _clabelpoint
  rgbpoint = _rgbpoint


def filter_points_by_boundingbox():
  global xpoint, ypoint, zpoint, rgbpoint, labelpoint, clabelpoint, boundingbox, worldpoints
  _xpoint = []
  _ypoint = []
  _zpoint = []
  _worldpoints = []
  _rgbpoint = []
  _labelpoint = []
  _clabelpoint = []

  volume = len(xpoint)
  log("filter for important points, volume={}".format(volume))
  for i in range(volume):
    x = xpoint[i]
    y = ypoint[i]
    z = zpoint[i]

    wx = worldpoints[i][0]
    wy = worldpoints[i][1]
    wz = worldpoints[i][2]

    if boundingbox['x']['min'] < wx and boundingbox['x']['max'] > wx and boundingbox['y']['min'] < wy and boundingbox['y']['max'] > wy:
      _xpoint.append(x)
      _ypoint.append(y)
      _zpoint.append(z)
      _worldpoints.append([wx, wy, wz])
      _labelpoint.append(labelpoint[i])
      _clabelpoint.append(clabelpoint[i])
      _rgbpoint.append(rgbpoint[i])
  log("{} points left".format(len(_xpoint)))
  xpoint = _xpoint
  ypoint = _ypoint
  zpoint = _zpoint
  worldpoints = _worldpoints
  labelpoint = _labelpoint
  clabelpoint = _clabelpoint
  rgbpoint = _rgbpoint

def delete_object(obj):
    global delete_model
    try:
      log("delete obj {}".format(obj))
      delete_model(str(obj))
    except rospy.ServiceException as e:
        rospy.logerr("Service call failed: " + str(e))

def get_label(r,g,b):
  global object_color_codes
  min_diff = 1000
  min_catId = 0

  for i in range(len(object_color_codes)):
    obj = object_color_codes[i]
    delta_e = deltaE_diff([r,g,b], [obj['r'], obj['g'], obj['b']])

    if delta_e < min_diff:
      min_diff = delta_e
      min_catId = obj['catId']

  return min_catId

def delete_spawned_objects():
  for obj in spawned_objects:
    delete_object(obj)
  #clear list
  del spawned_objects[:]

def joint_xml(model_name, px = 0, py = 0, pz = 0, pitch = 0, roll = 0, yaw = 0):
  qx, qy, qz, qw = euler_to_quaternion(roll, pitch, yaw)
  return """
  <joint name='{model_name}_model_joint' type='fixed'>
      <pose>{px} {py} {pz} {qx} {qy} {qz} {qw}</pose>
      <parent>map</parent>
      <child>{model_name}_link</child>
    </joint>
  """.format(model_name = model_name, px = px, py = py, pz = pz, qx = qx, qy = qy, qz = qz, qw = qw)

def _get_xml(model_name, color = 'Yellow', joint = False, static = False, catId = 0, version = '', color_a = 1.0):
  return get_xml(model_name, '/' + model_name + '/', model_name, color, joint=joint, static=static, catId=catId, version = version, color_a = color_a)

def get_xml(model_name, path, file_name, color = 'Yellow', joint = False, static = False, catId = 0, version = '', color_a = 1.0):
  global object_color_codes 
  xml = open(package_path + '/models/'+path+file_name+'.sdf', 'r').read()
  rgb = color_codes[color].strip().split(' ')
  r = int(rgb[0])
  g = int(rgb[1])
  b = int(rgb[2])

  found = False
  if catId >= 0:
    for i in range(len(object_color_codes)):
      obj = object_color_codes[i]

      if obj['name'] == model_name:
        found = True
        break
  else:
    found = True
  
  if not found:
    object_color_codes.append({'name':model_name, 'r':r, 'g':g, 'b':b,'color':color, 'catId':catId})

  return xml.format(model_name=model_name, version = version, color = '', color_r = r, color_g = g, color_b = b, color_a = color_a, joint = '' if not joint else joint, static = 'false' if not static else 'true')

def set_model_colours():
  global object_color_codes 
  log("set_model_colours")
  for i in range(len(object_color_codes)):
    model = object_color_codes[i]['name']
    pub =  rospy.Publisher("/{}_color".format(model), DColor, queue_size = 2)
    r = object_color_codes[i]['r']
    g = object_color_codes[i]['g']
    b = object_color_codes[i]['b']

    color = DColor()
    color.r = float(r/255)
    color.g = float(g/255)
    color.b = float(b/255)
    color.a = float(1)
    log("pub to /{}_color".format(model))
    pub.publish(color)
    rospy_sleep(1)
    log("sets colours to publisher /{}_color".format(model))
    pub.unregister()

def send_world_frame(x, y, z,frame_id = "ray_frame", child_frame = "map", roll = 0, pitch = 0, yaw = 0, rx = None, ry = None, rz = None, rw = None):
  rot = euler_to_quaternion(roll, pitch, yaw)

  if rx is None or ry is None or rz is None or rw is None:
    rx = rot[0]
    ry = rot[1]
    rz = rot[2]
    rw = rot[3]

  log("Translation x/y/z -> {}/{}/{} {}/{}/{}/{}".format(x,y,z, rx, ry, rz, rw))
  world_transform = TransformStamped()
  
  world_transform.header.stamp = rospy.Time.now()
  world_transform.header.frame_id = frame_id
  world_transform.child_frame_id = child_frame
  world_transform.transform.translation.x = x
  world_transform.transform.translation.y = y
  world_transform.transform.translation.z = z
  world_transform.transform.rotation.x = rx
  world_transform.transform.rotation.y = ry
  world_transform.transform.rotation.z = rz
  world_transform.transform.rotation.w = rw
  tf_broadcaster.sendTransform(world_transform)
  log("created transformation between from {} to {} (parent->child)".format(frame_id, child_frame))

def spawn_objects(xmls, is_sdf = True, start_id = 0, dx = 0, dy = 0, dz = 0):
  global boundingbox
  #xmls = ['banana':xml]
  #settings = [{'name':'banana', 'catId':2}]
  settings = []
  for i in range(len(xmls)):
    xmls[i]['counter'] = 0
    settings = settings + [i] * xmls[i]['amount']

  random.shuffle(settings)

  for i in settings:
    name = xmls[i]['name']
    catId = xmls[i]['catId']

    length = len(xmls[i]['xml'])
    if length > 1:
      xml = xmls[i]['xml'][random.randint(0,length-1)]
    else:
      xml = xmls[i]['xml'][0]

    id = xmls[i]['counter']
    xmls[i]['counter']=xmls[i]['counter']+1

    px = random.uniform(boundingbox['x']['min'] + dx, boundingbox['x']['max'] - dx)
    py = random.uniform(boundingbox['y']['min'] + dy, boundingbox['y']['max'] - dy)
    pz = random.uniform(boundingbox['z']['min'] + dz, boundingbox['z']['max'] - dz)

    model_name = '{}_{}_{}'.format(catId,start_id+id+2,name)
    spawn_xml(model_name, xml, px, py, pz, is_sdf, 0)

def calc_camera_location(x = 0,y = 0,z = 1.9, bx = 0, by = 0, bz = 0):
  camera_pos = np.array([x,y,z])
  box_pos = np.array([bx,by,bz])

  camera_to_target = box_pos - camera_pos
  yaw = np.arctan2(camera_to_target[1],camera_to_target[0])
  pitch = np.arctan2(-camera_to_target[2], np.sqrt(camera_to_target[0]**2 + camera_to_target[1]**2))
  roll = np.arctan2(camera_to_target[0], camera_to_target[1])
  log("yaw:{}, pitch:{} und roll:{}".format(yaw,pitch, roll))

  q = euler_to_quaternion(roll, pitch, yaw)
  log("quanternion x/y/z/w: {}/{}/{}/{}".format(q[0],q[1],q[2],q[3]))
  return {'x':camera_pos[0], 'y':camera_pos[1], 'z':camera_pos[2], 'yaw': yaw, 'pitch': pitch, 'roll': roll}

def convert_rgb():
  global rgbpoint
  _rgb = []

  log("convert rgb colors...")

  vol = len(rgbpoint)
  for i in range(vol):
    _rgb.append(float_to_rgb(rgbpoint[i]))

  rgbpoint = _rgb
  log("convert rgb done :)")

def clear_all_forces():
  for obj in spawned_objects:
    clear_body_wrench(obj)
  log("cleaned all forces!")

def sample_down_pointcloud():
  global xpoint, ypoint, zpoint, labelpoint, clabelpoint, rgbpoint, pointcloud_sampled_down
  log("sample down pointcloud...")
  pointcloud_sampled_down = True
  length = len(xpoint)
  pcd = o3d.geometry.PointCloud()

  pcd.points = o3d.utility.Vector3dVector(np.asarray(np.stack((xpoint, ypoint, zpoint), axis=-1)))
  pcd.colors = o3d.utility.Vector3dVector(np.asarray(np.vstack((rgbpoint, rgbpoint, rgbpoint)).T))
  downsampled_pcd = pcd.voxel_down_sample(voxel_size=0.015)
  cl, ind = downsampled_pcd.remove_statistical_outlier(nb_neighbors=20, std_ratio=2.0)
  filtered_pcd = downsampled_pcd.select_down_sample(ind)

  vol = len(filtered_pcd.points)
  del xpoint[:]
  del ypoint[:]
  del zpoint[:]
  del rgbpoint[:]
  for i in range(vol):
     point = filtered_pcd.points[i]
     color = filtered_pcd.colors[i]

     rgbpoint.append(color[0])
     xpoint.append(point[0])
     ypoint.append(point[1])
     zpoint.append(point[2])

  clabelpoint = [0] * vol
  labelpoint = [0] * vol
  print("from {} to {} datapoints".format(length, vol))
  transform_points()

#Transfrom camera point to world point
def transform_cp_to_wp(x, y, z):
  global camera_frame, listener, world_frame_name
  
  world_name = world_frame_name
  p1 = PoseStamped()
  p1.header.stamp = rospy.Time(0)
  p1.header.frame_id = camera_frame
  p1.pose.position.x = x
  p1.pose.position.y = y
  p1.pose.position.z = z
  p1.pose.orientation.x = 0.0
  p1.pose.orientation.y =  0.0
  p1.pose.orientation.z = 0.0
  p1.pose.orientation.w =  1.0
  p2 = listener.transformPose(world_name, p1)

  return [p2.pose.position.x, p2.pose.position.y, p2.pose.position.z]

def transform_points():
  global worldpoints, xpoint, ypoint, zpoint, camera_frame
  worldpoints = []

  volume = len(xpoint)
  log("Transform points from '{}' frame to 'map' frame, volume = {}".format(camera_frame,volume))
  nott = 0
  for i in range(volume):
      x = xpoint[i]
      y = ypoint[i]
      z = zpoint[i]

      _x, _y, _z = transform_cp_to_wp(x,y,z)

      if _x == x and _y == y and _z == z:
        nott+=1
      worldpoints.append([_x, _y, _z])

  if nott > 0:
    log("not transformed {} {}".format(nott, volume))
  log("transform done: points={}, worldpoints={}".format(len(xpoint), len(worldpoints)))

def rospy_sleep(seconds, nseconds = 0):
  duration = rospy.Duration(seconds,nseconds)
  rospy.sleep(duration)

def reset_simulation():
    rospy.wait_for_service('/gazebo/reset_simulation')
    try:
        reset_simulation_service = rospy.ServiceProxy('/gazebo/reset_simulation', Empty)
        reset_simulation_service()
    except rospy.ServiceException as e:
        rospy.logerr("Service call failed: " + str(e))

def kill_sim():
  #os.system('killall -9 gzserver gzclient screen')
  os.system("ps -ef | grep 'ros' | grep -v grep | awk '{print $2}' | xargs -r kill -9")

def callback_ray_labeled_points(data):
  global labelpoint, received_points_ray, worldpoints
  if received_points_ray:
    return
  log("Got labeled data: {}".format(len(data.points)))

  count_map = [0] * (len(object_color_codes)+1)
  kinect_plugin = 0
  none = 0
  ground_plane = 0
  length = len(data.points)
  for i in range(length):
    point = data.points[i]
    entity = point.entityName
    index = point.index

    if 'None' in entity:
      none+=1
    elif 'ground_plane' in entity:
      ground_plane+=1
    elif 'kinect-plugin' in entity:
      kinect_plugin+=1
    elif entity != 'None' and '_' in entity:
      try:
        id = int(entity.split("_")[0])
        count_map[id] = count_map[id] + 1
        labelpoint[index] = id
      except:
        labelpoint[index] = 0
        count_map[0] = count_map[0] + 1

  for i in range(len(count_map)):
    log("catId: {} found {}".format(i, count_map[i]))
  log("kinect_plugin found {}".format(kinect_plugin))
  log("none found {}".format(none))
  log("ground_plane found {}".format(ground_plane))
  received_points_ray = True

def label_points_by_ray():
  global worldpoints, received_points_ray, xpoint, ypoint, zpoint
  received_points_ray = False

  pub = rospy.Publisher('/ray/points', LabelPoints, queue_size = 10)
  sub = rospy.Subscriber("/ray/labeled/points", LabelPoints, callback_ray_labeled_points)
  cloud = LabelPoints()
  cloud.scaling = 0.03
  cloud.start_z = 0.5
  cloud.rating = 3000
  cloud.showMarker = False

  length = len(worldpoints)
  for i in range(length):
    point = LabelPoint()
    point.x = worldpoints[i][0]
    point.y = worldpoints[i][1]
    point.z = worldpoints[i][2]
    point.index = i
    cloud.points.append(point)

  rospy.sleep(1)
  pub.publish(cloud)
  log("waiting for labeled points")
  while not rospy.is_shutdown():
    rospy.sleep(1)
    if received_points_ray:
      log("got")
      break

  log("labeling points done :)")
  sub.unregister()
  pub.unregister()

def compare_labels():
  global clabelpoint, labelpoint,world_frame_name

  length = len(labelpoint)
  clength = len(clabelpoint)
  count_map = [0] * (len(object_color_codes)+1)
  for i in range(length):
    id = labelpoint[i]
    cid = clabelpoint[i]

    if cid == id:
      count_map[id] += 1

  log("clabelpoint vol: {}".format(clength))
  log("labelpoint vol: {}".format(length))
  for i in range(len(count_map)):
    log("catId: {} found euqal {}".format(i, count_map[i]))

def unfreeze(models = []):
  global freeze_pub

  msg = FreezeModels()
  msg.freeze = False
  
  if not models:
    for i in range(len(models)):
      msg.models.append(models[i])

  freeze_pub.publish(msg)

  

def freeze():
  global freeze_pub
  msg = FreezeModels()
  msg.freeze = True
  
  for i in range(len(spawned_objects)):
    msg.models.append(spawned_objects[i])

  freeze_pub.publish(msg)

def measureBoxSize():
  global xpoint, ypoint, zpoint, boundingbox

  log("measure box size...")
  subscribe_to_camera()
  filter_points_by_colours()

  boundingbox = {
    'x': {'min': sys.float_info.max, 'max':sys.float_info.min},
    'y': {'min': sys.float_info.max, 'max':sys.float_info.min},
    'z': {'min': sys.float_info.max, 'max':sys.float_info.min},
  }
  
  for i in range(len(xpoint)):
    x = xpoint[i]
    y = ypoint[i]
    z = zpoint[i]

    if boundingbox['x']['min'] > x:
      boundingbox['x']['min'] = x
    elif boundingbox['x']['max'] < x:
      boundingbox['x']['max'] = x

    if boundingbox['y']['min'] > y:
      boundingbox['y']['min'] = y
    elif boundingbox['y']['max'] < y:
      boundingbox['y']['max'] = y

    if boundingbox['z']['min'] > z:
      boundingbox['z']['min'] = z
    elif boundingbox['z']['max'] < z:
      boundingbox['z']['max'] = z

  _maxx, _maxy, _maxz = transform_cp_to_wp(boundingbox['x']['min'],boundingbox['y']['min'],boundingbox['z']['min'])
  _minx, _miny, _minz = transform_cp_to_wp(boundingbox['x']['max'],boundingbox['y']['max'],boundingbox['z']['max'])

  boundingbox['x']['min'] = _minx
  boundingbox['y']['min'] = _miny
  boundingbox['z']['min'] = _minz
  boundingbox['x']['max'] = _maxx
  boundingbox['y']['max'] = _maxy
  boundingbox['z']['max'] = _maxz

  for axis in boundingbox:
    log("axis:{} min:{} max:{}".format(axis, boundingbox[axis]['min'], boundingbox[axis]['max']))
  reset_world()
  log("boundingbox measured.")
  '''
  xml = get_xml('box', '/box/', 'box', 'Red', catId=-1)
  spawn_xml('xmin_ymin_box', xml, px = boundingbox['x']['min'], py = boundingbox['y']['min'], pz = boundingbox['z']['max'])
  spawn_xml('xmin_ymax_box', xml, px = boundingbox['x']['min'], py = boundingbox['y']['max'], pz = boundingbox['z']['max'])
  spawn_xml('xmax_ymin_box', xml, px = boundingbox['x']['max'], py = boundingbox['y']['min'], pz = boundingbox['z']['max'])
  spawn_xml('xmax_ymax_box', xml, px = boundingbox['x']['max'], py = boundingbox['y']['max'], pz = boundingbox['z']['max'])
  rospy.spin()
  '''

def remove_falling_out_obj():
  global boundingbox
  
  remove = []
  for obj in spawned_objects:
    pose = get_pose(obj)

    if boundingbox['x']['min'] > pose.position.x \
      or boundingbox['x']['max'] < pose.position.x \
      or boundingbox['y']['min'] > pose.position.y \
      or boundingbox['y']['max'] < pose.position.y:
      remove.append(obj)

  for obj in remove:
    delete_object(obj)
    spawned_objects.remove(obj)

def scan_szene():
  subscribe_to_camera()
  filter_points_by_colours()
  transform_points()
  filter_points_by_boundingbox()
  convert_rgb()
  label_points_by_ray()
  fill_color_label()
  compare_labels()

def test_cases():
  banana_xml = get_xml('banana', '/banana/', 'banana', 'Banana', catId=2)
  apple_xml = get_xml('apple', '/apple/', 'apple', 'Apple', catId=3)
  orange_xml = get_xml('orange', '/orange/', 'orange', 'Orange', catId=4)
  pear_xml = get_xml('pear', '/pear/', 'pear', 'Pear', catId=5)
  plum_xml = get_xml('plum', '/plum/', 'plum', 'Plum', catId=6)

  start_time = time.time()
  xmls = [
    {'name':'banana','catId':2, 'xml':[banana_xml], 'amount':10 + random.randint(1,10)},
    {'name':'apple','catId':3, 'xml':[apple_xml], 'amount':10 + random.randint(1,10)},
    {'name':'orange','catId':4, 'xml':[orange_xml], 'amount':10 + random.randint(1,10)},
    {'name':'pear','catId':5, 'xml':[pear_xml], 'amount':10 + random.randint(1,10)},
    {'name':'plum','catId':6, 'xml':[plum_xml], 'amount':10 + random.randint(1,10)}
  ]
  #spawn objects in box
  spawn_objects(xmls, dx = 0.05, dy = 0.05, dz = 0.01)

  '''
  xml_toothbrush = get_xml('hammer', '/hammer/', 'model', 'Toothbrush', catId=7)
  for i in range(2):
    px = random.uniform(boundingbox['x']['min'] + 0.05, boundingbox['x']['max'] - 0.05)
    py = random.uniform(boundingbox['y']['min'] + 0.05, boundingbox['y']['max'] - 0.05)
    pz = random.uniform(boundingbox['z']['min'] + 0.01, boundingbox['z']['max'] - 0.01)
    spawn_xml('7_{}_hamma'.format(i), xml_toothbrush, px = px, py = py, pz = pz)
  '''
  rospy_sleep(1)
  log("done sleeping lets start")
  remove_falling_out_obj()
  freeze()

  rospy_sleep(0.5)
  scan_szene()
  #storage training data
  write_pointcloud(reset = False, prefix = '1_coloured_', color_by_label=True) 
  write_pointcloud(reset = False, prefix = '1_labeled_')
  reset_world(_clear_path = False)

  #Remove one object best case one of the TOP
  for i in range(2):
    remove_obj = None
    remove_pos = None
    z_pose = -1
    for obj in spawned_objects:
      pose = get_pose(obj)

      if pose.position.z > z_pose:
        remove_pos = pose.position
        remove_obj = obj

    log("Remove model {} pos: {}/{}/{}".format(remove_obj,remove_pos.x, remove_pos.y, remove_pos.z))
    unfreeze([remove_obj])
    delete_model(remove_obj)

  scan_szene()
  write_pointcloud(reset = False, prefix = '2_coloured_', color_by_label=True) 
  write_pointcloud(reset = False, prefix = '2_labeled_')

  unfreeze()
  rospy.sleep(0.5)
  delete_spawned_objects()
  diff_time = time.time() - start_time
  log("the round took {}".format(td(seconds = diff_time)))

if __name__ == '__main__':
  global delete_model, spawn_sdf_model, spawn_urdf_model, set_state, get_state

  jump_to_checkpoint = False
  log("init python script...")
  rospy.init_node("binpacking")

  if rospy.has_param('/binpacking/checkpoint'):
    checkpoint_path = rospy.get_param('/binpacking/checkpoint') 
    log("checkpoint_path:{}".format(checkpoint_path))

    if os.path.exists(catkin_path + '/synthetic_data/ply/'+checkpoint_path):
      jump_to_checkpoint = load_checkpoint(catkin_path + '/synthetic_data/ply/'+checkpoint_path)
      log("jump_to_checkpoint: {}".format(jump_to_checkpoint))

    if type(jump_to_checkpoint) == list:
      log("checkpoint loaded")
    else:
      log("Couldn't find checkpoint")
     
  log("wait for services...")
  rospy.wait_for_service('/gazebo/spawn_sdf_model')
  rospy.wait_for_service('/gazebo/spawn_urdf_model')
  rospy.wait_for_service("/gazebo/delete_model")
  rospy.wait_for_service('/gazebo/set_model_state')
  rospy.wait_for_service('/gazebo/get_model_state')
  rospy.wait_for_service('/gazebo/clear_body_wrenches')

  delete_model = rospy.ServiceProxy("/gazebo/delete_model", DeleteModel)
  spawn_sdf_model = rospy.ServiceProxy('/gazebo/spawn_sdf_model', SpawnModel)
  spawn_urdf_model = rospy.ServiceProxy('/gazebo/spawn_urdf_model', SpawnModel)
  set_state = rospy.ServiceProxy('/gazebo/set_model_state', SetModelState)
  get_state = rospy.ServiceProxy('/gazebo/get_model_state', GetModelState)
  pause_physics = rospy.ServiceProxy('/gazebo/pause_physics', Empty)
  unpause_physics = rospy.ServiceProxy('/gazebo/unpause_physics', Empty)
  clear_body_wrench = rospy.ServiceProxy('gazebo/clear_body_wrenches', BodyRequest)
  freeze_pub = rospy.Publisher('freeze', FreezeModels, queue_size = 1)
  
  #set camera on right position
  #pos = calc_camera_location()
  #camera_set_pose(pos['x'], pos['y'], pos['z'], pos['roll'], pos['pitch'], pos['yaw'])

  #spawn stackingbox
  xml = _get_xml(model_name = 'stackingbox', color = 'Stackingbox', catId=1)
  spawn_xml('1_stackingbox', xml, add_to_list=False)
  #init transform function from cp to wp
  tf_buffer = tf2_ros.Buffer()
  tf_listener = tf2_ros.TransformListener(tf_buffer)
  listener = TransformListener()

  #pcl_ros::transformPointCloud(destination_frame,from_cloud,to_cloud,TransformListener)
  #Add world frame
  tf_broadcaster = tf2_ros.StaticTransformBroadcaster()
  world_frame_name = 'map' #ray_frame
  #send_world_frame(0, 0, 0, rx=-0.499999999463, ry=0.499999999463,rz=-0.499976836603, rw=0.500023163397)
  #get bounding box
  measureBoxSize()

  if type(jump_to_checkpoint) == list:
    log("load object for checkpoint")

    """
    for data in jump_to_checkpoint:
      pose = data['pose']
      model_name = data['name']
      xml = get_xml(model_name, '', model_name.split("_")[1], 'Blue')
      spawn_xml(model_name, xml, pose.x, pose.y, pose.z, True)
      spawned_objects.append(model_name)
    
    track_collisions()
    """

    write_pointcloud()
    delete_spawned_objects()
    log("done with checkpoint :)")


  test_cases()

  rospy.spin() 

  banana_xml = get_xml('banana', '/banana/', 'banana', 'Banana', catId=2)
  apple_xml = get_xml('apple', '/apple/', 'apple', 'Apple', catId=3)
  orange_xml = get_xml('orange', '/orange/', 'orange', 'Orange', catId=4)
  pear_xml = get_xml('pear', '/pear/', 'pear', 'Pear', catId=5)
  plum_xml = get_xml('plum', '/plum/', 'plum', 'Plum', catId=6)
  plum2_xml = get_xml('plum', '/plum/', 'plum', 'Plum', catId=6, version = '2')
  sleeptime = 3
  
  for i in range(1000):
    start_time = time.time()
    xmls = [
      {'name':'banana','catId':2, 'xml':[banana_xml], 'amount':10 + random.randint(1,50)},
      {'name':'apple','catId':3, 'xml':[apple_xml], 'amount':10 + random.randint(1,50)},
      {'name':'orange','catId':4, 'xml':[orange_xml], 'amount':10 + random.randint(1,50)},
      {'name':'pear','catId':5, 'xml':[pear_xml], 'amount':10 + random.randint(1,50)},
      {'name':'plum','catId':6, 'xml':[plum_xml, plum2_xml], 'amount':10 + random.randint(1,50)}
    ]
    #spawn objects in box
    spawn_objects(xmls, dx = 0.05, dy = 0.05, dz = 0.01)
    #spawn_xml('3_apple', apple_xml, px = 0, py = 0, pz = 0, ax = 0, ay = 0, az = 0, lx = 0, ly = 0, lz = 0)
    #spawn_xml('2_banana', banana_xml, px = 0.2, py = 0.1, pz = 0, ax = 0, ay = 0, az = 0, lx = 0, ly = 0, lz = 0)
    log("wait {} seconds".format(sleeptime))
    rospy_sleep(sleeptime)
    log("done sleeping lets start")
    remove_falling_out_obj()
    freeze()
    rospy_sleep(0.5)
    #subscribe to camera and gather pointsg
    subscribe_to_camera()
    write_pointcloud(reset = False, prefix = '0_', with_label= False) 
    filter_points_by_colours()
    transform_points()
    save_checkpoint()
    write_pointcloud(reset = False, prefix = '1_', with_label= False, world_points=True) 
    write_pointcloud(reset = False, prefix = '2_', with_label= False) 
    #sample_down_pointcloud()
    filter_points_by_boundingbox()
    convert_rgb()
    label_points_by_ray()
    fill_color_label()
    compare_labels()
    #storage training data
    write_pointcloud(reset = False, prefix = 'coloured_', color_by_label=True) 
    write_pointcloud()
    unfreeze()
    rospy.sleep(0.5)
    delete_spawned_objects()
    diff_time = time.time() - start_time
    log("the round took {}".format(td(seconds = diff_time)))
    #kill_sim()