// Auto-generated. Do not edit!

// (in-package propio.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class AttachDetachRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.object_name = null;
      this.attach = null;
    }
    else {
      if (initObj.hasOwnProperty('object_name')) {
        this.object_name = initObj.object_name
      }
      else {
        this.object_name = '';
      }
      if (initObj.hasOwnProperty('attach')) {
        this.attach = initObj.attach
      }
      else {
        this.attach = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AttachDetachRequest
    // Serialize message field [object_name]
    bufferOffset = _serializer.string(obj.object_name, buffer, bufferOffset);
    // Serialize message field [attach]
    bufferOffset = _serializer.bool(obj.attach, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AttachDetachRequest
    let len;
    let data = new AttachDetachRequest(null);
    // Deserialize message field [object_name]
    data.object_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [attach]
    data.attach = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.object_name);
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'propio/AttachDetachRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ddf8e9385b72b362c71494321439b3d3';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string object_name
    bool attach
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AttachDetachRequest(null);
    if (msg.object_name !== undefined) {
      resolved.object_name = msg.object_name;
    }
    else {
      resolved.object_name = ''
    }

    if (msg.attach !== undefined) {
      resolved.attach = msg.attach;
    }
    else {
      resolved.attach = false
    }

    return resolved;
    }
};

class AttachDetachResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
      this.message = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
      if (initObj.hasOwnProperty('message')) {
        this.message = initObj.message
      }
      else {
        this.message = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AttachDetachResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AttachDetachResponse
    let len;
    let data = new AttachDetachResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [message]
    data.message = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.message);
    return length + 5;
  }

  static datatype() {
    // Returns string type for a service object
    return 'propio/AttachDetachResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '937c9679a518e3a18d831e57125ea522';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool success
    string message
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AttachDetachResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    if (msg.message !== undefined) {
      resolved.message = msg.message;
    }
    else {
      resolved.message = ''
    }

    return resolved;
    }
};

module.exports = {
  Request: AttachDetachRequest,
  Response: AttachDetachResponse,
  md5sum() { return '1e9f418fc6a1ffcaf360d719404f78ea'; },
  datatype() { return 'propio/AttachDetach'; }
};
