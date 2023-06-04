#! /usr/bin/env python
import os
import rospy
import random
import numpy as np
import signal
from tf2_geometry_msgs import PointStamped, do_transform_point
from gazebo_msgs.srv import SetModelState, SpawnModel, DeleteModel, GetModelState, GetModelStateRequest, BodyRequest
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
from std_msgs.msg import String
from gz_ray_label_plugin.msg import LabelPoint
from gz_ray_label_plugin.msg import LabelPoints
from gz_freeze_objects.msg import FreezeModels

freeze_pub = None
catkin_path = '/home/felix/catkin_ws'
package_path = catkin_path+'/src/binpacking/'
received_points_ray = False
received_points = False
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
bbox_px = [-0.30, 0.30]
bbox_py = [-0.45,0.45]
bbox_pz = [0.3, 0.5]
color_codes = {
  'Yellow': "255 225 20",
  'Red': "229 0 0",
  'Orange': "249 115 6",
  'Blue': "3 67 223",
  'Brown': "101 55 0",
  'Pear': "203 248 95",
  "Purple": "255 0 255"
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
  global camera_frame, received_points
  assert isinstance(data, PointCloud2)
  if received_points:
    return

  camera_frame = data.header.frame_id
  """
  cloud = ros_to_pcl(data)

  # Filter the point cloud to remove NaNs and outliers
  cloud = o3d.geometry.voxel_downsample(cloud, 0.01)
  cloud = o3d.geometry.passthrough_filter(cloud, 'z', 0.1, 5.0)
  cloud = o3d.geometry.statistical_outlier_filter(cloud)
  cloud = o3d.geometry.radius_outlier_filter(cloud, 0.05, 10)

  for field in data.fields:
    log("fieldname {} {} ".format(field.name, field.datatype))
  """
  """
  points_rgb = point_cloud2.read_points(data, skip_nans=True, field_names=("x", "y", "z", "rgb"))

  # Convert ROS point cloud message to numpy array
  pc = np.array(list(points_rgb))

  # Convert numpy array to Open3D point cloud object
  pcd = o3d.geometry.PointCloud()
  pcd.points = o3d.utility.Vector3dVector(pc[:, 0:3])

  rgb_float = np.asarray(pc[:, 3], dtype=np.float32)
  pcd.colors = o3d.utility.Vector3dVector(np.asarray(np.vstack((rgb_float, rgb_float, rgb_float)).T))

  # Voxel downsampling
  #
  downsampled_pcd = pcd.voxel_down_sample(voxel_size=0.05)
  
  # Statistical outlier removal
  #cl, ind = downsampled_pcd.remove_statistical_outlier(nb_neighbors=20, std_ratio=2.0)

  # Remove the outlier points from the downsampled point cloud
  #filtered_pcd = downsampled_pcd.select_down_sample(ind)

  #filtered_pc2 = pc2.create_cloud_xyzrgbcreate_cloud_xyz32(data.header, np.asarray(filtered_pcd.points), np.asarray(filtered_pcd.colors) * 255.0)
  vol = len(pcd.points)

  for i in range(vol):
     point = pcd.points[i]
     color = pcd.colors[i][0]

     rgb = float32_to_rgb(color)
     rgbpoint.append(rgb)
     xpoint.append(point[0])
     ypoint.append(point[1])
     zpoint.append(point[2])
     #log("x/y/z: {}/{}/{} {}/{}/{}".format(point[0],point[1],point[2],rgb[0],rgb[1],rgb[2]))
  """
  points = point_cloud2.read_points(data, field_names=("x", "y", "z", "rgb"), skip_nans=True) 

  for point in points:
    x = point[0]
    y = point[1]
    z = point[2]

    rgbpoint.append(point[3])
    xpoint.append(x)
    ypoint.append(y)
    zpoint.append(z)

    clabelpoint.append(0)
    labelpoint.append(0)

    #log("x/y/z: {}/{}/{} rgb:{}/{}/{}".format(x,y,z,rgb[0], rgb[1], rgb[2]))
  received_points = True
  log("camera_subscribe_callback got data from frame {}".format(camera_frame))

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

def stop_moving(object):
  set_pose(object, ax = 0, ay = 0, az = 0, lx = 0, ly = 0, lz = 0)
  log("stop moving {}".format(object))

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


def respawn_objects(_static = True):
  global spawned_objects
  objs = []

  log("log object locations")
  for obj in spawned_objects:
    pose = get_pose(obj)
    pos = pose.position
    orientation = pose.orientation
    twist = pose.twist
    objs.append( 
      {'name':obj, 
       'x': pos.x, 
       'y': pos.y, 
       'z': pos.z, 
       'qx': orientation.x, 
       'qy': orientation.y, 
       'qz': orientation.x, 
       'qw': orientation.w
       } 
    )
    log('object {} loaded'.format(obj))

  delete_spawned_objects()
  for data in objs:
    obj = data['name']
    px = data['x']
    py = data['y']
    pz = data['z']
    qx = data['qx']
    qy = data['qy']
    qz = data['qz']
    qw = data['qw']

    str_split = obj.split("_")
    model = str_split[len(str_split)-1]
    model = model.lower()

    color = get_model_color(model)
    xml = get_xml(obj, '/'+model+'/', model, color, static = _static)
    spawn_xml(obj, xml, is_sdf = True)
    spawned_objects.append(obj)
    set_pose(obj, x=px, y=py, z = pz, qx = qx, qy = qy, qz = qz, qw = qw)
    log('{} respawned'.format(obj))

def get_index_from_point(name1, name2):
  id = 0
  if 'point' in name1:
    id = int(name1.split("_")[0])
  else:
    id = int(name2.split("_")[0])

  return id

def collision_callback(contacts):
  global point_index, labelpoint, point_index_list, world_chunks_size, world_chunks_diff
  use_point_index = True

  if point_index_list is not None:
    use_point_index = False

  try:
    #Is it already labeled?
    if use_point_index:
      if labelpoint[point_index] > 0:
        return
  except IndexError as e:
      print("point_index={}, len(labelpoint)={} {}".format(point_index, len(labelpoint), e))
      return

  states = contacts.states

  for state in states:
    #if state.collision1_name and state.collision2_name:
    #    log("collision {} - {}".format(state.collision1_name, state.collision2_name))

    if 'point' in state.collision1_name or 'point' in state.collision2_name:
      if not use_point_index:
        list_index = get_index_from_point(state.collision1_name, state.collision2_name ) 
        
        if point_index_list[list_index] == -1:
          return
        
        length = len(point_index_list)-1
        if length == list_index and (length - world_chunks_diff) <= point_index_list[list_index]:
          return

        label_index = (list_index * world_chunks_size) + point_index_list[list_index]

      #log("collision {} - {}".format(state.collision1_name, state.collision2_name))
      if not state.collision1_name == 'ground_plane::link::collision' and not state.collision2_name == 'ground_plane::link::collision':
        if state.collision1_name.startswith('stackingbox') or state.collision2_name.startswith('stackingbox'):
          if use_point_index:
            labelpoint[point_index] = 1
          else:
            labelpoint[label_index] = 1
          #log("labeled index={} stackingbox".format(point_index))
        else:
          id = 0
          if 'point' in state.collision2_name:
            id = int(state.collision1_name.split("_")[0])
          else:
            id = int(state.collision2_name.split("_")[0])

          if use_point_index:
            labelpoint[point_index] = id
          else:
            labelpoint[label_index] = id
          #log("labeled index={} id={}".format(point_index, id))

def test_collide(object, index, x,y,z, sleeptime = 0.001, set_point_index = True):
  global point_index

  if set_point_index:
    point_index = index
  set_pose(object, x, y, z)

  if sleeptime > 0:
    rospy.sleep(sleeptime)

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

"""
Alle Listen werden auf world_chunks_size erhoeht
eigentlich wird nur die letzte liste erhoeht
"""
def even_chunks_list(world_chunks):
  global world_chunks_size, world_chunks_diff

  max(world_chunks)
  for i in range(len(world_chunks)):
    length = len(world_chunks[i])

    if length < world_chunks_size:
      world_chunks_diff = (world_chunks_size - length)
      for j in range( (world_chunks_size - length) ):
        world_chunks[i].append(None)

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

def track_collisions():
  global point_index_list, worldpoints, clabelpoint
  #respawn objects to static so that they dont move by collisions
  #pause_physics(EmptyRequest())
  clear_all_forces()
  log("subscribe physics/contacts for collisions")
  sub = rospy.Subscriber("contacts", ContactsState, collision_callback)
  log("start points")

  point_amount = 10
  world_chunks = chunkIt(worldpoints, point_amount)
  even_chunks_list(world_chunks)
  point_index_list = [0] * len(world_chunks)

  log("world_chunks({})".format(len(world_chunks)))
  log("point_index_list({})".format(len(point_index_list)))
  for i in range(len(world_chunks)):
    spawn_xml('{}_point'.format(i), collision_point_sdf(),1, 1, 1, True, 0)

  done = False
  world_size = len(world_chunks[0])
  while not done:
    for i in range(len(world_chunks)):
      point_index = point_index_list[i]

      if point_index == -1:
        continue

      if len(world_chunks[i]) <= point_index or world_chunks[i][point_index] is None:
        point_index_list[i] = -1
        continue

      point_index_list[i]+=1

      x = world_chunks[i][point_index][0]
      y = world_chunks[i][point_index][1]
      z = world_chunks[i][point_index][2]

      original_index = (i * world_size) + point_index
      #if clabelpoint[original_index] == 0:
      #  continue

      if (point_index % 500) == 0:
        log("process-{}: {}/{}".format(i,point_index,len(world_chunks[i])))

      test_collide("{}_point".format(i), point_index, x, y, z, 0, False)
    rospy.sleep(0.005)

    done = True
    for i in range(len(point_index_list)):
      if point_index_list[i] > -1:
        done = False
        break

  
  for i in range(len(world_chunks)):
    log("delete {}. {}".format(i, point_index_list[i]))
    delete_object('{}_point'.format(i))
  """

  spawn_xml('point', collision_point_sdf(),1, 1, 1, True)
  volume = len(worldpoints)
  point_index_list = None
  for i in range(volume):
    if (i % 500) == 0:
      log("process: {}/{}".format(i,volume))

    x = worldpoints[i][0]
    y = worldpoints[i][1]
    z = worldpoints[i][2]

    #if clabelpoint[i] == 0:
    #  continue

    test_collide('point', i, x, y, z, 0.01)
  delete_object('point')
  """

  sub.unregister()

def subscribe_to_camera():
  global received_points,rgbpoint
  #respawn_objects()
  clear_all_forces()
  #subscribe to camera 
  received_points = False
  sub = rospy.Subscriber("/camera/depth/points", PointCloud2, camera_subscribe_callback)
  log("waiting for incoming points")
  while True:
    rospy.sleep(0.1)
    if received_points:

      if len(rgbpoint) > 0:
        rgb = float_to_rgb(rgbpoint[0])

        if rgb[0] == 0 and rgb[1] == 0 and rgb[2] == 0:
          reset_world()
          received_points = False
          log("RGB all black so take points again :)")
          continue
      break

  sub.unregister()
  log("done with sleeping... lets continue")
  log("Volume {}".format(len(xpoint)))
   
def get_path(format = 'ply'):
  global path

  if path is not None:
    return path

  now = dt.now()
  _path = catkin_path + '/synthetic_data/'+format+'/synthetic_pc_'+now.strftime('%d-%m-%Y_%H-%M-%S')
  path = _path

  if not os.path.exists(_path):
    os.makedirs(_path)
  return _path

def clear_path():
  global path
  path = None

def reset_world():
  #clear lists
  del xpoint[:]
  del ypoint[:]
  del zpoint[:]
  del rgbpoint[:]
  del worldpoints[:]
  del clabelpoint[:]
  del labelpoint[:]
  clear_path()

def write_pointcloud(format = 'ply', reset = True, prefix = '', colored_file = True, with_label = True, RGB = True, world_points = False):
  global xpoint, ypoint, zpoint, labelpoint, clabelpoint, worldpoints

  if not (format is 'ply' or format is 'txt'):
    log("file format {} not supported".format(format))
    return

  #create a .pkl file 
  volume = len(xpoint)
  log("create . file for {} points".format(format, volume))

  def wr(m):
    fid.write(str(m).encode('utf-8'))

  path = get_path()
  filename = prefix + 'data'+( '' if not pointcloud_sampled_down else '_min' )+'.'+format
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


def filter_points(x_min = 0, x_max = 0, y_min = 0, y_max = 0):
  global xpoint, ypoint, zpoint, rgbpoint, labelpoint, clabelpoint, bbox_px, bbox_py, worldpoints
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

    if x_min < wx and x_max > wx and y_min < wy and y_max > wy:
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
    log("delete obj {}".format(obj))
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

def _get_xml(model_name, color = 'Yellow', joint = False, static = False, catId = 0):
  return get_xml(model_name, '/' + model_name + '/', model_name, color, joint=joint, static=static, catId=catId)

def get_xml(model_name, path, file_name, color = 'Yellow', joint = False, static = False, catId = 0):
  global object_color_codes 
  xml = open(package_path + '/models/'+path+file_name+'.sdf', 'r').read()

  found = False
  for i in range(len(object_color_codes)):
    obj = object_color_codes[i]

    if obj['name'] == model_name:
      found = True
      break
  
  if not found:
    rgb = color_codes[color].strip().split(' ')
    r = int(rgb[0])
    g = int(rgb[1])
    b = int(rgb[2])
    log("Add {} with {}/{}/{} catId={}".format(model_name, r, g, b, catId))
    object_color_codes.append({'name':model_name, 'r':r, 'g':g, 'b':b,'color':color, 'catId':catId})

  return xml.format(model_name=model_name, color = color, joint = '' if not joint else joint, static = 'false' if not static else 'true')


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

def spawn_objects(xmls, is_sdf = True, start_id = 0):
  global bbox_px, bbox_py, bbox_pz
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
    xml = xmls[i]['xml']
    id = xmls[i]['counter']
    xmls[i]['counter']=xmls[i]['counter']+1

    px = random.uniform(bbox_px[0]+0.1, bbox_px[1]-0.1)
    py = random.uniform(bbox_py[0]+0.1, bbox_py[1]-0.1)
    pz = random.uniform(bbox_pz[0], bbox_pz[1])

    model_name = '{}_{}_{}'.format(catId,start_id+id+2,name)
    spawn_xml(model_name, xml, px, py, pz, is_sdf, 0)
    spawned_objects.append(model_name)

def calc_distance(x = 0,y = 0,z = 1.8, bx = 0, by = 0, bz = 0):
  camera_pos = np.array([x,y,z])
  box_pos = np.array([bx,by,bz])
  camera_to_target = box_pos - camera_pos

  return math.sqrt(math.pow(camera_to_target[0],2) + math.pow(camera_to_target[1], 2) + math.pow(camera_to_target[2], 2))

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
  log("done :)")

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
  global labelpoint, received_points_ray,worldpoints
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

    #log("{}/{}/{} dist:{} entity: {}".format(point.x, point.y, point.z, point.dist, entity))
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

  #pos = calc_camera_location()
  #camera_set_pose(pos['x'], pos['y'], 4, pos['roll'], pos['pitch'], pos['yaw'])

  pub = rospy.Publisher('/ray/points', LabelPoints, queue_size = 10)
  sub = rospy.Subscriber("/ray/labeled/points", LabelPoints, callback_ray_labeled_points)
  cloud = LabelPoints()
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
  #camera_set_pose(pos['x'], pos['y'], pos['z'], pos['roll'], pos['pitch'], pos['yaw'])

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

def unfreeze():
  global freeze_pub
  msg = FreezeModels()
  msg.freeze = False
  freeze_pub.publish(msg)

def freeze():
  global freeze_pub
  msg = FreezeModels()
  msg.freeze = True
  
  for i in range(len(spawned_objects)):
    msg.models.append(spawned_objects[i])

  freeze_pub.publish(msg)

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
  xml = _get_xml('stackingbox', 'Blue', catId=1)
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

  banana_xml = get_xml('banana', '/banana/', 'banana', 'Yellow', catId=2)
  apple_xml = get_xml('apple', '/apple/', 'apple', 'Red', catId=3)
  orange_xml = get_xml('orange', '/orange/', 'orange', 'Orange', catId=4)
  pear_xml = get_xml('pear', '/pear/', 'pear', 'Pear', catId=5)
  plum_xml = get_xml('plum', '/plum/', 'plum', 'Purple', catId=6)
  sleeptime = 3

  '''
  xmls = [
    {'name':'banana','catId':2, 'xml':banana_xml, 'amount':3},
    {'name':'apple','catId':3, 'xml':apple_xml, 'amount':3},
    {'name':'orange','catId':4, 'xml':orange_xml, 'amount':3},
    {'name':'pear','catId':5, 'xml':pear_xml, 'amount':3}
  ]
  '''

  xmls = [
    {'name':'banana','catId':2, 'xml':banana_xml, 'amount':5 + random.randint(5,15)},
    {'name':'apple','catId':3, 'xml':apple_xml, 'amount':5 + random.randint(5,15)},
    {'name':'orange','catId':4, 'xml':orange_xml, 'amount':5 + random.randint(5,15)},
    {'name':'pear','catId':5, 'xml':pear_xml, 'amount':5 + random.randint(5,15)},
    {'name':'plum','catId':6, 'xml':plum_xml, 'amount':5 + random.randint(5,15)}
  ]
  start_time = time.time()
  #spawn objects in box
  
  spawn_objects(xmls)
  
  #spawn_xml('3_apple', apple_xml, px = 0, py = 0, pz = 0, ax = 0, ay = 0, az = 0, lx = 0, ly = 0, lz = 0)
  #spawn_xml('2_banana', banana_xml, px = 0.2, py = 0.1, pz = 0, ax = 0, ay = 0, az = 0, lx = 0, ly = 0, lz = 0)
  log("wait {} seconds".format(sleeptime))
  rospy_sleep(sleeptime)
  log("done sleeping lets start")
  freeze()
  
  #clear_all_forces()
  #respawn_objects()
  #subscribe to camera and gather pointsg
  subscribe_to_camera()
  write_pointcloud(reset = False, prefix = '0_', colored_file= False, with_label= False) 
  filter_points_by_colours()
  transform_points()
  #filter_points(bbox_px[0]+0.02,bbox_px[1]+0.2, bbox_py[0]-0.2, bbox_py[1]+0.2)
  save_checkpoint()
  write_pointcloud(reset = False, prefix = '1_', colored_file= False, with_label= False, world_points=True) 
  write_pointcloud(reset = False, prefix = '2_', colored_file= False, with_label= False) 
  #sample_down_pointcloud()
  convert_rgb()
  label_points_by_ray()
  fill_color_label()
  compare_labels()
  #track_collisions()
  #storage training data
  write_pointcloud()
  #delete all spawned objects
  unfreeze()
  #delete_spawned_objects()
  diff_time = time.time() - start_time
  log("the round took {}".format(td(seconds = diff_time)))
  kill_sim()