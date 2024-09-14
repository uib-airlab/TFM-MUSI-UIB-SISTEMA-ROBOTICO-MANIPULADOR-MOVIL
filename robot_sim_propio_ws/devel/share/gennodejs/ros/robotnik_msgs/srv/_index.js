
"use strict";

let set_modbus_register_bit = require('./set_modbus_register_bit.js')
let set_named_digital_output = require('./set_named_digital_output.js')
let ResetFromSubState = require('./ResetFromSubState.js')
let QueryAlarms = require('./QueryAlarms.js')
let SetString = require('./SetString.js')
let set_digital_output = require('./set_digital_output.js')
let set_mode = require('./set_mode.js')
let get_mode = require('./get_mode.js')
let set_analog_output = require('./set_analog_output.js')
let LoggerQuery = require('./LoggerQuery.js')
let SetInt16 = require('./SetInt16.js')
let Record = require('./Record.js')
let home = require('./home.js')
let SetMotorMode = require('./SetMotorMode.js')
let set_modbus_register = require('./set_modbus_register.js')
let set_CartesianEuler_pose = require('./set_CartesianEuler_pose.js')
let SetNamedDigitalOutput = require('./SetNamedDigitalOutput.js')
let get_modbus_register = require('./get_modbus_register.js')
let SetLaserMode = require('./SetLaserMode.js')
let SetEncoderTurns = require('./SetEncoderTurns.js')
let GetMotorsHeadingOffset = require('./GetMotorsHeadingOffset.js')
let set_float_value = require('./set_float_value.js')
let GetPOI = require('./GetPOI.js')
let ack_alarm = require('./ack_alarm.js')
let axis_record = require('./axis_record.js')
let SetTransform = require('./SetTransform.js')
let GetPTZ = require('./GetPTZ.js')
let SetElevator = require('./SetElevator.js')
let enable_disable = require('./enable_disable.js')
let set_height = require('./set_height.js')
let set_odometry = require('./set_odometry.js')
let SetCurrent = require('./SetCurrent.js')
let SetMotorStatus = require('./SetMotorStatus.js')
let get_digital_input = require('./get_digital_input.js')
let GetBool = require('./GetBool.js')
let get_alarms = require('./get_alarms.js')
let InsertTask = require('./InsertTask.js')
let set_ptz = require('./set_ptz.js')
let SetMotorPID = require('./SetMotorPID.js')
let SetBuzzer = require('./SetBuzzer.js')
let SetByte = require('./SetByte.js')

module.exports = {
  set_modbus_register_bit: set_modbus_register_bit,
  set_named_digital_output: set_named_digital_output,
  ResetFromSubState: ResetFromSubState,
  QueryAlarms: QueryAlarms,
  SetString: SetString,
  set_digital_output: set_digital_output,
  set_mode: set_mode,
  get_mode: get_mode,
  set_analog_output: set_analog_output,
  LoggerQuery: LoggerQuery,
  SetInt16: SetInt16,
  Record: Record,
  home: home,
  SetMotorMode: SetMotorMode,
  set_modbus_register: set_modbus_register,
  set_CartesianEuler_pose: set_CartesianEuler_pose,
  SetNamedDigitalOutput: SetNamedDigitalOutput,
  get_modbus_register: get_modbus_register,
  SetLaserMode: SetLaserMode,
  SetEncoderTurns: SetEncoderTurns,
  GetMotorsHeadingOffset: GetMotorsHeadingOffset,
  set_float_value: set_float_value,
  GetPOI: GetPOI,
  ack_alarm: ack_alarm,
  axis_record: axis_record,
  SetTransform: SetTransform,
  GetPTZ: GetPTZ,
  SetElevator: SetElevator,
  enable_disable: enable_disable,
  set_height: set_height,
  set_odometry: set_odometry,
  SetCurrent: SetCurrent,
  SetMotorStatus: SetMotorStatus,
  get_digital_input: get_digital_input,
  GetBool: GetBool,
  get_alarms: get_alarms,
  InsertTask: InsertTask,
  set_ptz: set_ptz,
  SetMotorPID: SetMotorPID,
  SetBuzzer: SetBuzzer,
  SetByte: SetByte,
};
