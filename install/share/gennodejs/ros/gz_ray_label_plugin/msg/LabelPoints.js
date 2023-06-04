// Auto-generated. Do not edit!

// (in-package gz_ray_label_plugin.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let LabelPoint = require('./LabelPoint.js');

//-----------------------------------------------------------

class LabelPoints {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.points = null;
      this.px = null;
      this.py = null;
      this.pz = null;
      this.dx = null;
      this.dy = null;
      this.dz = null;
    }
    else {
      if (initObj.hasOwnProperty('points')) {
        this.points = initObj.points
      }
      else {
        this.points = [];
      }
      if (initObj.hasOwnProperty('px')) {
        this.px = initObj.px
      }
      else {
        this.px = 0.0;
      }
      if (initObj.hasOwnProperty('py')) {
        this.py = initObj.py
      }
      else {
        this.py = 0.0;
      }
      if (initObj.hasOwnProperty('pz')) {
        this.pz = initObj.pz
      }
      else {
        this.pz = 0.0;
      }
      if (initObj.hasOwnProperty('dx')) {
        this.dx = initObj.dx
      }
      else {
        this.dx = 0.0;
      }
      if (initObj.hasOwnProperty('dy')) {
        this.dy = initObj.dy
      }
      else {
        this.dy = 0.0;
      }
      if (initObj.hasOwnProperty('dz')) {
        this.dz = initObj.dz
      }
      else {
        this.dz = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type LabelPoints
    // Serialize message field [points]
    // Serialize the length for message field [points]
    bufferOffset = _serializer.uint32(obj.points.length, buffer, bufferOffset);
    obj.points.forEach((val) => {
      bufferOffset = LabelPoint.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [px]
    bufferOffset = _serializer.float32(obj.px, buffer, bufferOffset);
    // Serialize message field [py]
    bufferOffset = _serializer.float32(obj.py, buffer, bufferOffset);
    // Serialize message field [pz]
    bufferOffset = _serializer.float32(obj.pz, buffer, bufferOffset);
    // Serialize message field [dx]
    bufferOffset = _serializer.float32(obj.dx, buffer, bufferOffset);
    // Serialize message field [dy]
    bufferOffset = _serializer.float32(obj.dy, buffer, bufferOffset);
    // Serialize message field [dz]
    bufferOffset = _serializer.float32(obj.dz, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type LabelPoints
    let len;
    let data = new LabelPoints(null);
    // Deserialize message field [points]
    // Deserialize array length for message field [points]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.points[i] = LabelPoint.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [px]
    data.px = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [py]
    data.py = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pz]
    data.pz = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dx]
    data.dx = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dy]
    data.dy = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [dz]
    data.dz = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.points.forEach((val) => {
      length += LabelPoint.getMessageSize(val);
    });
    return length + 28;
  }

  static datatype() {
    // Returns string type for a message object
    return 'gz_ray_label_plugin/LabelPoints';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2ded0ab792e6fc382d669b9d328e650f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    LabelPoint[] points
    float32 px
    float32 py
    float32 pz
    float32 dx
    float32 dy
    float32 dz
    ================================================================================
    MSG: gz_ray_label_plugin/LabelPoint
    float32 x
    float32 y
    float32 z
    int32 index
    float64 dist
    string entityName
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new LabelPoints(null);
    if (msg.points !== undefined) {
      resolved.points = new Array(msg.points.length);
      for (let i = 0; i < resolved.points.length; ++i) {
        resolved.points[i] = LabelPoint.Resolve(msg.points[i]);
      }
    }
    else {
      resolved.points = []
    }

    if (msg.px !== undefined) {
      resolved.px = msg.px;
    }
    else {
      resolved.px = 0.0
    }

    if (msg.py !== undefined) {
      resolved.py = msg.py;
    }
    else {
      resolved.py = 0.0
    }

    if (msg.pz !== undefined) {
      resolved.pz = msg.pz;
    }
    else {
      resolved.pz = 0.0
    }

    if (msg.dx !== undefined) {
      resolved.dx = msg.dx;
    }
    else {
      resolved.dx = 0.0
    }

    if (msg.dy !== undefined) {
      resolved.dy = msg.dy;
    }
    else {
      resolved.dy = 0.0
    }

    if (msg.dz !== undefined) {
      resolved.dz = msg.dz;
    }
    else {
      resolved.dz = 0.0
    }

    return resolved;
    }
};

module.exports = LabelPoints;
