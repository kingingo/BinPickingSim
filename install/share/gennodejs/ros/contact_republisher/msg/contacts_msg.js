// Auto-generated. Do not edit!

// (in-package contact_republisher.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let contact_msg = require('./contact_msg.js');

//-----------------------------------------------------------

class contacts_msg {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.contacts = null;
    }
    else {
      if (initObj.hasOwnProperty('contacts')) {
        this.contacts = initObj.contacts
      }
      else {
        this.contacts = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type contacts_msg
    // Serialize message field [contacts]
    // Serialize the length for message field [contacts]
    bufferOffset = _serializer.uint32(obj.contacts.length, buffer, bufferOffset);
    obj.contacts.forEach((val) => {
      bufferOffset = contact_msg.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type contacts_msg
    let len;
    let data = new contacts_msg(null);
    // Deserialize message field [contacts]
    // Deserialize array length for message field [contacts]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.contacts = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.contacts[i] = contact_msg.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.contacts.forEach((val) => {
      length += contact_msg.getMessageSize(val);
    });
    return length + 4;
  }

  static datatype() {
    // Returns string type for a message object
    return 'contact_republisher/contacts_msg';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '86961c1410790d81e56871bf92da4561';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    contact_msg[] contacts
    ================================================================================
    MSG: contact_republisher/contact_msg
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
    const resolved = new contacts_msg(null);
    if (msg.contacts !== undefined) {
      resolved.contacts = new Array(msg.contacts.length);
      for (let i = 0; i < resolved.contacts.length; ++i) {
        resolved.contacts[i] = contact_msg.Resolve(msg.contacts[i]);
      }
    }
    else {
      resolved.contacts = []
    }

    return resolved;
    }
};

module.exports = contacts_msg;
