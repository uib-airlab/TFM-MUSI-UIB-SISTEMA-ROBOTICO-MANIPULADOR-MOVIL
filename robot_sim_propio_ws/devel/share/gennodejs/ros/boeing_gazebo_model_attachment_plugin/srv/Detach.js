// Auto-generated. Do not edit!

// (in-package boeing_gazebo_model_attachment_plugin.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class DetachRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.joint_name = null;
      this.model_name_1 = null;
      this.model_name_2 = null;
    }
    else {
      if (initObj.hasOwnProperty('joint_name')) {
        this.joint_name = initObj.joint_name
      }
      else {
        this.joint_name = '';
      }
      if (initObj.hasOwnProperty('model_name_1')) {
        this.model_name_1 = initObj.model_name_1
      }
      else {
        this.model_name_1 = '';
      }
      if (initObj.hasOwnProperty('model_name_2')) {
        this.model_name_2 = initObj.model_name_2
      }
      else {
        this.model_name_2 = '';
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type DetachRequest
    // Serialize message field [joint_name]
    bufferOffset = _serializer.string(obj.joint_name, buffer, bufferOffset);
    // Serialize message field [model_name_1]
    bufferOffset = _serializer.string(obj.model_name_1, buffer, bufferOffset);
    // Serialize message field [model_name_2]
    bufferOffset = _serializer.string(obj.model_name_2, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DetachRequest
    let len;
    let data = new DetachRequest(null);
    // Deserialize message field [joint_name]
    data.joint_name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [model_name_1]
    data.model_name_1 = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [model_name_2]
    data.model_name_2 = _deserializer.string(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.joint_name);
    length += _getByteLength(object.model_name_1);
    length += _getByteLength(object.model_name_2);
    return length + 12;
  }

  static datatype() {
    // Returns string type for a service object
    return 'boeing_gazebo_model_attachment_plugin/DetachRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '11ada2739d4d4a28b54f2b6269ce953b';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    string joint_name
    string model_name_1
    string model_name_2
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new DetachRequest(null);
    if (msg.joint_name !== undefined) {
      resolved.joint_name = msg.joint_name;
    }
    else {
      resolved.joint_name = ''
    }

    if (msg.model_name_1 !== undefined) {
      resolved.model_name_1 = msg.model_name_1;
    }
    else {
      resolved.model_name_1 = ''
    }

    if (msg.model_name_2 !== undefined) {
      resolved.model_name_2 = msg.model_name_2;
    }
    else {
      resolved.model_name_2 = ''
    }

    return resolved;
    }
};

class DetachResponse {
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
    // Serializes a message object of type DetachResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type DetachResponse
    let len;
    let data = new DetachResponse(null);
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
    return 'boeing_gazebo_model_attachment_plugin/DetachResponse';
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
    const resolved = new DetachResponse(null);
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
  Request: DetachRequest,
  Response: DetachResponse,
  md5sum() { return '0a07b99010eab99684bb37117a445b93'; },
  datatype() { return 'boeing_gazebo_model_attachment_plugin/Detach'; }
};
