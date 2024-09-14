// Auto-generated. Do not edit!

// (in-package robotnik_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class AudioPlayer {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.elapsed_time = null;
      this.total_time = null;
      this.name = null;
      this.is_playing = null;
    }
    else {
      if (initObj.hasOwnProperty('elapsed_time')) {
        this.elapsed_time = initObj.elapsed_time
      }
      else {
        this.elapsed_time = 0.0;
      }
      if (initObj.hasOwnProperty('total_time')) {
        this.total_time = initObj.total_time
      }
      else {
        this.total_time = 0.0;
      }
      if (initObj.hasOwnProperty('name')) {
        this.name = initObj.name
      }
      else {
        this.name = '';
      }
      if (initObj.hasOwnProperty('is_playing')) {
        this.is_playing = initObj.is_playing
      }
      else {
        this.is_playing = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type AudioPlayer
    // Serialize message field [elapsed_time]
    bufferOffset = _serializer.float32(obj.elapsed_time, buffer, bufferOffset);
    // Serialize message field [total_time]
    bufferOffset = _serializer.float32(obj.total_time, buffer, bufferOffset);
    // Serialize message field [name]
    bufferOffset = _serializer.string(obj.name, buffer, bufferOffset);
    // Serialize message field [is_playing]
    bufferOffset = _serializer.bool(obj.is_playing, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type AudioPlayer
    let len;
    let data = new AudioPlayer(null);
    // Deserialize message field [elapsed_time]
    data.elapsed_time = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [total_time]
    data.total_time = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [name]
    data.name = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [is_playing]
    data.is_playing = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.name);
    return length + 13;
  }

  static datatype() {
    // Returns string type for a message object
    return 'robotnik_msgs/AudioPlayer';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e2121538143cf0a41ccf4c74bc5d25ca';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 elapsed_time
    float32 total_time
    string name
    bool is_playing
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new AudioPlayer(null);
    if (msg.elapsed_time !== undefined) {
      resolved.elapsed_time = msg.elapsed_time;
    }
    else {
      resolved.elapsed_time = 0.0
    }

    if (msg.total_time !== undefined) {
      resolved.total_time = msg.total_time;
    }
    else {
      resolved.total_time = 0.0
    }

    if (msg.name !== undefined) {
      resolved.name = msg.name;
    }
    else {
      resolved.name = ''
    }

    if (msg.is_playing !== undefined) {
      resolved.is_playing = msg.is_playing;
    }
    else {
      resolved.is_playing = false
    }

    return resolved;
    }
};

module.exports = AudioPlayer;
