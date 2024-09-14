// Auto-generated. Do not edit!

// (in-package robotnik_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class SimpleSystemStatus {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.disk_capacity = null;
      this.disk_usage = null;
      this.memory_capacity = null;
      this.memory_usage = null;
      this.cpu_usage = null;
      this.core_usage = null;
      this.cpu_temperature = null;
      this.core_temperatures = null;
      this.header = null;
    }
    else {
      if (initObj.hasOwnProperty('disk_capacity')) {
        this.disk_capacity = initObj.disk_capacity
      }
      else {
        this.disk_capacity = 0.0;
      }
      if (initObj.hasOwnProperty('disk_usage')) {
        this.disk_usage = initObj.disk_usage
      }
      else {
        this.disk_usage = 0.0;
      }
      if (initObj.hasOwnProperty('memory_capacity')) {
        this.memory_capacity = initObj.memory_capacity
      }
      else {
        this.memory_capacity = 0.0;
      }
      if (initObj.hasOwnProperty('memory_usage')) {
        this.memory_usage = initObj.memory_usage
      }
      else {
        this.memory_usage = 0.0;
      }
      if (initObj.hasOwnProperty('cpu_usage')) {
        this.cpu_usage = initObj.cpu_usage
      }
      else {
        this.cpu_usage = 0.0;
      }
      if (initObj.hasOwnProperty('core_usage')) {
        this.core_usage = initObj.core_usage
      }
      else {
        this.core_usage = [];
      }
      if (initObj.hasOwnProperty('cpu_temperature')) {
        this.cpu_temperature = initObj.cpu_temperature
      }
      else {
        this.cpu_temperature = 0.0;
      }
      if (initObj.hasOwnProperty('core_temperatures')) {
        this.core_temperatures = initObj.core_temperatures
      }
      else {
        this.core_temperatures = [];
      }
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SimpleSystemStatus
    // Serialize message field [disk_capacity]
    bufferOffset = _serializer.float32(obj.disk_capacity, buffer, bufferOffset);
    // Serialize message field [disk_usage]
    bufferOffset = _serializer.float32(obj.disk_usage, buffer, bufferOffset);
    // Serialize message field [memory_capacity]
    bufferOffset = _serializer.float32(obj.memory_capacity, buffer, bufferOffset);
    // Serialize message field [memory_usage]
    bufferOffset = _serializer.float32(obj.memory_usage, buffer, bufferOffset);
    // Serialize message field [cpu_usage]
    bufferOffset = _serializer.float32(obj.cpu_usage, buffer, bufferOffset);
    // Serialize message field [core_usage]
    bufferOffset = _arraySerializer.float32(obj.core_usage, buffer, bufferOffset, null);
    // Serialize message field [cpu_temperature]
    bufferOffset = _serializer.float32(obj.cpu_temperature, buffer, bufferOffset);
    // Serialize message field [core_temperatures]
    bufferOffset = _arraySerializer.float32(obj.core_temperatures, buffer, bufferOffset, null);
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SimpleSystemStatus
    let len;
    let data = new SimpleSystemStatus(null);
    // Deserialize message field [disk_capacity]
    data.disk_capacity = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [disk_usage]
    data.disk_usage = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [memory_capacity]
    data.memory_capacity = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [memory_usage]
    data.memory_usage = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cpu_usage]
    data.cpu_usage = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [core_usage]
    data.core_usage = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [cpu_temperature]
    data.cpu_temperature = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [core_temperatures]
    data.core_temperatures = _arrayDeserializer.float32(buffer, bufferOffset, null)
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.core_usage.length;
    length += 4 * object.core_temperatures.length;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'robotnik_msgs/SimpleSystemStatus';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '297c535b6bb09ddac9c89e40f3d56868';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    float32 disk_capacity
    float32 disk_usage
    float32 memory_capacity
    float32 memory_usage
    float32 cpu_usage
    float32[] core_usage
    float32 cpu_temperature
    float32[] core_temperatures
    Header header
    ================================================================================
    MSG: std_msgs/Header
    # Standard metadata for higher-level stamped data types.
    # This is generally used to communicate timestamped data 
    # in a particular coordinate frame.
    # 
    # sequence ID: consecutively increasing ID 
    uint32 seq
    #Two-integer timestamp that is expressed as:
    # * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
    # * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
    # time-handling sugar is provided by the client library
    time stamp
    #Frame this data is associated with
    string frame_id
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SimpleSystemStatus(null);
    if (msg.disk_capacity !== undefined) {
      resolved.disk_capacity = msg.disk_capacity;
    }
    else {
      resolved.disk_capacity = 0.0
    }

    if (msg.disk_usage !== undefined) {
      resolved.disk_usage = msg.disk_usage;
    }
    else {
      resolved.disk_usage = 0.0
    }

    if (msg.memory_capacity !== undefined) {
      resolved.memory_capacity = msg.memory_capacity;
    }
    else {
      resolved.memory_capacity = 0.0
    }

    if (msg.memory_usage !== undefined) {
      resolved.memory_usage = msg.memory_usage;
    }
    else {
      resolved.memory_usage = 0.0
    }

    if (msg.cpu_usage !== undefined) {
      resolved.cpu_usage = msg.cpu_usage;
    }
    else {
      resolved.cpu_usage = 0.0
    }

    if (msg.core_usage !== undefined) {
      resolved.core_usage = msg.core_usage;
    }
    else {
      resolved.core_usage = []
    }

    if (msg.cpu_temperature !== undefined) {
      resolved.cpu_temperature = msg.cpu_temperature;
    }
    else {
      resolved.cpu_temperature = 0.0
    }

    if (msg.core_temperatures !== undefined) {
      resolved.core_temperatures = msg.core_temperatures;
    }
    else {
      resolved.core_temperatures = []
    }

    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    return resolved;
    }
};

module.exports = SimpleSystemStatus;
