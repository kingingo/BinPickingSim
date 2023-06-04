// Auto-generated. Do not edit!

// (in-package gz_freeze_objects.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class FreezeModels {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.freeze = null;
      this.models = null;
    }
    else {
      if (initObj.hasOwnProperty('freeze')) {
        this.freeze = initObj.freeze
      }
      else {
        this.freeze = false;
      }
      if (initObj.hasOwnProperty('models')) {
        this.models = initObj.models
      }
      else {
        this.models = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type FreezeModels
    // Serialize message field [freeze]
    bufferOffset = _serializer.bool(obj.freeze, buffer, bufferOffset);
    // Serialize message field [models]
    bufferOffset = _arraySerializer.string(obj.models, buffer, bufferOffset, null);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type FreezeModels
    let len;
    let data = new FreezeModels(null);
    // Deserialize message field [freeze]
    data.freeze = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [models]
    data.models = _arrayDeserializer.string(buffer, bufferOffset, null)
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.models.forEach((val) => {
      length += 4 + val.length;
    });
    return length + 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'gz_freeze_objects/FreezeModels';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'dd3c2b51be5bf4747de89ce8cafd1599';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool freeze
    string[] models
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new FreezeModels(null);
    if (msg.freeze !== undefined) {
      resolved.freeze = msg.freeze;
    }
    else {
      resolved.freeze = false
    }

    if (msg.models !== undefined) {
      resolved.models = msg.models;
    }
    else {
      resolved.models = []
    }

    return resolved;
    }
};

module.exports = FreezeModels;
