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

let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class ProcessImageRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.isFront = null;
    }
    else {
      if (initObj.hasOwnProperty('isFront')) {
        this.isFront = initObj.isFront
      }
      else {
        this.isFront = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ProcessImageRequest
    // Serialize message field [isFront]
    bufferOffset = _serializer.bool(obj.isFront, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ProcessImageRequest
    let len;
    let data = new ProcessImageRequest(null);
    // Deserialize message field [isFront]
    data.isFront = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'propio/ProcessImageRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c3629fc6e9ff898d8cea360736afbdb7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # ProcessImage.srv
    bool isFront
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ProcessImageRequest(null);
    if (msg.isFront !== undefined) {
      resolved.isFront = msg.isFront;
    }
    else {
      resolved.isFront = false
    }

    return resolved;
    }
};

class ProcessImageResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.pose = null;
      this.distance = null;
      this.needsArm = null;
      this.numberObjects = null;
      this.dimensions = null;
    }
    else {
      if (initObj.hasOwnProperty('pose')) {
        this.pose = initObj.pose
      }
      else {
        this.pose = new geometry_msgs.msg.Pose();
      }
      if (initObj.hasOwnProperty('distance')) {
        this.distance = initObj.distance
      }
      else {
        this.distance = 0.0;
      }
      if (initObj.hasOwnProperty('needsArm')) {
        this.needsArm = initObj.needsArm
      }
      else {
        this.needsArm = false;
      }
      if (initObj.hasOwnProperty('numberObjects')) {
        this.numberObjects = initObj.numberObjects
      }
      else {
        this.numberObjects = 0;
      }
      if (initObj.hasOwnProperty('dimensions')) {
        this.dimensions = initObj.dimensions
      }
      else {
        this.dimensions = new geometry_msgs.msg.Vector3();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ProcessImageResponse
    // Serialize message field [pose]
    bufferOffset = geometry_msgs.msg.Pose.serialize(obj.pose, buffer, bufferOffset);
    // Serialize message field [distance]
    bufferOffset = _serializer.float64(obj.distance, buffer, bufferOffset);
    // Serialize message field [needsArm]
    bufferOffset = _serializer.bool(obj.needsArm, buffer, bufferOffset);
    // Serialize message field [numberObjects]
    bufferOffset = _serializer.int32(obj.numberObjects, buffer, bufferOffset);
    // Serialize message field [dimensions]
    bufferOffset = geometry_msgs.msg.Vector3.serialize(obj.dimensions, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ProcessImageResponse
    let len;
    let data = new ProcessImageResponse(null);
    // Deserialize message field [pose]
    data.pose = geometry_msgs.msg.Pose.deserialize(buffer, bufferOffset);
    // Deserialize message field [distance]
    data.distance = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [needsArm]
    data.needsArm = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [numberObjects]
    data.numberObjects = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [dimensions]
    data.dimensions = geometry_msgs.msg.Vector3.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 93;
  }

  static datatype() {
    // Returns string type for a service object
    return 'propio/ProcessImageResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '6360014842298dfa59757f88b3fec273';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    geometry_msgs/Pose pose
    float64 distance
    bool needsArm
    int32 numberObjects
    geometry_msgs/Vector3 dimensions 
    
    ================================================================================
    MSG: geometry_msgs/Pose
    # A representation of pose in free space, composed of position and orientation. 
    Point position
    Quaternion orientation
    
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    ================================================================================
    MSG: geometry_msgs/Quaternion
    # This represents an orientation in free space in quaternion form.
    
    float64 x
    float64 y
    float64 z
    float64 w
    
    ================================================================================
    MSG: geometry_msgs/Vector3
    # This represents a vector in free space. 
    # It is only meant to represent a direction. Therefore, it does not
    # make sense to apply a translation to it (e.g., when applying a 
    # generic rigid transformation to a Vector3, tf2 will only apply the
    # rotation). If you want your data to be translatable too, use the
    # geometry_msgs/Point message instead.
    
    float64 x
    float64 y
    float64 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ProcessImageResponse(null);
    if (msg.pose !== undefined) {
      resolved.pose = geometry_msgs.msg.Pose.Resolve(msg.pose)
    }
    else {
      resolved.pose = new geometry_msgs.msg.Pose()
    }

    if (msg.distance !== undefined) {
      resolved.distance = msg.distance;
    }
    else {
      resolved.distance = 0.0
    }

    if (msg.needsArm !== undefined) {
      resolved.needsArm = msg.needsArm;
    }
    else {
      resolved.needsArm = false
    }

    if (msg.numberObjects !== undefined) {
      resolved.numberObjects = msg.numberObjects;
    }
    else {
      resolved.numberObjects = 0
    }

    if (msg.dimensions !== undefined) {
      resolved.dimensions = geometry_msgs.msg.Vector3.Resolve(msg.dimensions)
    }
    else {
      resolved.dimensions = new geometry_msgs.msg.Vector3()
    }

    return resolved;
    }
};

module.exports = {
  Request: ProcessImageRequest,
  Response: ProcessImageResponse,
  md5sum() { return '37b472b910195c5295b6dd8ac539437e'; },
  datatype() { return 'propio/ProcessImage'; }
};
