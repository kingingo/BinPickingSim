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
      this.scaling = null;
      this.start_z = null;
      this.rating = null;
      this.showMarker = null;
    }
    else {
      if (initObj.hasOwnProperty('points')) {
        this.points = initObj.points
      }
      else {
        this.points = [];
      }
      if (initObj.hasOwnProperty('scaling')) {
        this.scaling = initObj.scaling
      }
      else {
        this.scaling = 0.0;
      }
      if (initObj.hasOwnProperty('start_z')) {
        this.start_z = initObj.start_z
      }
      else {
        this.start_z = 0.0;
      }
      if (initObj.hasOwnProperty('rating')) {
        this.rating = initObj.rating
      }
      else {
        this.rating = 0;
      }
      if (initObj.hasOwnProperty('showMarker')) {
        this.showMarker = initObj.showMarker
      }
      else {
        this.showMarker = false;
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
    // Serialize message field [scaling]
    bufferOffset = _serializer.float32(obj.scaling, buffer, bufferOffset);
    // Serialize message field [start_z]
    bufferOffset = _serializer.float32(obj.start_z, buffer, bufferOffset);
    // Serialize message field [rating]
    bufferOffset = _serializer.int32(obj.rating, buffer, bufferOffset);
    // Serialize message field [showMarker]
    bufferOffset = _serializer.bool(obj.showMarker, buffer, bufferOffset);
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
    // Deserialize message field [scaling]
    data.scaling = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [start_z]
    data.start_z = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [rating]
    data.rating = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [showMarker]
    data.showMarker = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.points.forEach((val) => {
      length += LabelPoint.getMessageSize(val);
    });
    return length + 17;
  }

  static datatype() {
    // Returns string type for a message object
    return 'gz_ray_label_plugin/LabelPoints';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd9b71de3dcafd53b25491b7d106c121a';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    LabelPoint[] points
    float32 scaling 
    float32 start_z 
    int32 rating 
    bool showMarker 
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

    if (msg.scaling !== undefined) {
      resolved.scaling = msg.scaling;
    }
    else {
      resolved.scaling = 0.0
    }

    if (msg.start_z !== undefined) {
      resolved.start_z = msg.start_z;
    }
    else {
      resolved.start_z = 0.0
    }

    if (msg.rating !== undefined) {
      resolved.rating = msg.rating;
    }
    else {
      resolved.rating = 0
    }

    if (msg.showMarker !== undefined) {
      resolved.showMarker = msg.showMarker;
    }
    else {
      resolved.showMarker = false
    }

    return resolved;
    }
};

module.exports = LabelPoints;
