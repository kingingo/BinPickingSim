# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from contact_republisher/contact_msg.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class contact_msg(genpy.Message):
  _md5sum = "49e516f92ecaa35a5d84ba7de7d39aa2"
  _type = "contact_republisher/contact_msg"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """string collision_1
string collision_2
float32[3] normal
float32[3] position
float32 depth"""
  __slots__ = ['collision_1','collision_2','normal','position','depth']
  _slot_types = ['string','string','float32[3]','float32[3]','float32']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       collision_1,collision_2,normal,position,depth

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(contact_msg, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.collision_1 is None:
        self.collision_1 = ''
      if self.collision_2 is None:
        self.collision_2 = ''
      if self.normal is None:
        self.normal = [0.] * 3
      if self.position is None:
        self.position = [0.] * 3
      if self.depth is None:
        self.depth = 0.
    else:
      self.collision_1 = ''
      self.collision_2 = ''
      self.normal = [0.] * 3
      self.position = [0.] * 3
      self.depth = 0.

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self.collision_1
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self.collision_2
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      buff.write(_get_struct_3f().pack(*self.normal))
      buff.write(_get_struct_3f().pack(*self.position))
      _x = self.depth
      buff.write(_get_struct_f().pack(_x))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.collision_1 = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.collision_1 = str[start:end]
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.collision_2 = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.collision_2 = str[start:end]
      start = end
      end += 12
      self.normal = _get_struct_3f().unpack(str[start:end])
      start = end
      end += 12
      self.position = _get_struct_3f().unpack(str[start:end])
      start = end
      end += 4
      (self.depth,) = _get_struct_f().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self.collision_1
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self.collision_2
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      buff.write(self.normal.tostring())
      buff.write(self.position.tostring())
      _x = self.depth
      buff.write(_get_struct_f().pack(_x))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.collision_1 = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.collision_1 = str[start:end]
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.collision_2 = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.collision_2 = str[start:end]
      start = end
      end += 12
      self.normal = numpy.frombuffer(str[start:end], dtype=numpy.float32, count=3)
      start = end
      end += 12
      self.position = numpy.frombuffer(str[start:end], dtype=numpy.float32, count=3)
      start = end
      end += 4
      (self.depth,) = _get_struct_f().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_3f = None
def _get_struct_3f():
    global _struct_3f
    if _struct_3f is None:
        _struct_3f = struct.Struct("<3f")
    return _struct_3f
_struct_f = None
def _get_struct_f():
    global _struct_f
    if _struct_f is None:
        _struct_f = struct.Struct("<f")
    return _struct_f
