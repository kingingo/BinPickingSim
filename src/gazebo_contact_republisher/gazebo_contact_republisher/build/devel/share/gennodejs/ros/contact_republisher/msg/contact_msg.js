// Auto-generated. Do not edit!

// (in-package contact_republisher.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class contact_msg {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.collision_1 = null;
      this.collision_2 = null;
      this.normal = null;
      this.position = null;
      this.depth = null;
    }
    else {
      if (initObj.hasOwnProperty('collision_1')) {
        this.collision_1 = initObj.collision_1
      }
      else {
        this.collision_1 = '';
      }
      if (initObj.hasOwnProperty('collision_2')) {
        this.collision_2 = initObj.collision_2
      }
      else {
        this.collision_2 = '';
      }
      if (initObj.hasOwnProperty('normal')) {
        this.normal = initObj.normal
      }
      else {
        this.normal = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('position')) {
        this.position = initObj.position
      }
      else {
        this.position = new Array(3).fill(0);
      }
      if (initObj.hasOwnProperty('depth')) {
        this.depth = initObj.depth
      }
      else {
        this.depth = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type contact_msg
    // Serialize message field [collision_1]
    bufferOffset = _serializer.string(obj.collision_1, buffer, bufferOffset);
    // Serialize message field [collision_2]
    bufferOffset = _serializer.string(obj.collision_2, buffer, bufferOffset);
    // Check that the constant length array field [normal] has the right length
    if (obj.normal.length !== 3) {
      throw new Error('Unable to serialize array field normal - length must be 3')
    }
    // Serialize message field [normal]
    bufferOffset = _arraySerializer.float32(obj.normal, buffer, bufferOffset, 3);
    // Check that the constant length array field [position] has the right length
    if (obj.position.length !== 3) {
      throw new Error('Unable to serialize array field position - length must be 3')
    }
    // Serialize message field [position]
    bufferOffset = _arraySerializer.float32(obj.position, buffer, bufferOffset, 3);
    // Serialize message field [depth]
    bufferOffset = _serializer.float32(obj.depth, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type contact_msg
    let len;
    let data = new contact_msg(null);
    // Deserialize message field [collision_1]
    data.collision_1 = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [collision_2]
    data.collision_2 = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [normal]
    data.normal = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [position]
    data.position = _arrayDeserializer.float32(buffer, bufferOffset, 3)
    // Deserialize message field [depth]
    data.depth = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.collision_1.length;
    length += object.collision_2.length;
    return length + 36;
  }

  static datatype() {
    // Returns string type for a message object
    return 'contact_republisher/contact_msg';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '49e516f92ecaa35a5d84ba7de7d39aa2';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string collision_1
    string collision_2
    float32[3] normal
    float32[3] position
    float32 depth
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new contact_msg(null);
    if (msg.collision_1 !== undefined) {
      resolved.collision_1 = msg.collision_1;
    }
    else {
      resolved.collision_1 = ''
    }

    if (msg.collision_2 !== undefined) {
      resolved.collision_2 = msg.collision_2;
    }
    else {
      resolved.collision_2 = ''
    }

    if (msg.normal !== undefined) {
      resolved.normal = msg.normal;
    }
    else {
      resolved.normal = new Array(3).fill(0)
    }

    if (msg.position !== undefined) {
      resolved.position = msg.position;
    }
    else {
      resolved.position = new Array(3).fill(0)
    }

    if (msg.depth !== undefined) {
      resolved.depth = msg.depth;
    }
    else {
      resolved.depth = 0.0
    }

    return resolved;
    }
};

module.exports = contact_msg;
