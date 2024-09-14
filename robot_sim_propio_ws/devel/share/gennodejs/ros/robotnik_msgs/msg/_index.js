
"use strict";

let Data = require('./Data.js');
let ElevatorAction = require('./ElevatorAction.js');
let StringArray = require('./StringArray.js');
let MotorReferenceValue = require('./MotorReferenceValue.js');
let Interfaces = require('./Interfaces.js');
let WatchdogStatus = require('./WatchdogStatus.js');
let ptz = require('./ptz.js');
let SafetyModuleStatus = require('./SafetyModuleStatus.js');
let OdomCalibrationStatus = require('./OdomCalibrationStatus.js');
let named_input_output = require('./named_input_output.js');
let named_inputs_outputs = require('./named_inputs_outputs.js');
let RecordStatus = require('./RecordStatus.js');
let PantiltStatus = require('./PantiltStatus.js');
let BatteryDockingStatusStamped = require('./BatteryDockingStatusStamped.js');
let Registers = require('./Registers.js');
let alarmsmonitor = require('./alarmsmonitor.js');
let Cartesian_Euler_pose = require('./Cartesian_Euler_pose.js');
let PantiltStatusStamped = require('./PantiltStatusStamped.js');
let alarmmonitor = require('./alarmmonitor.js');
let BoolArray = require('./BoolArray.js');
let StringStamped = require('./StringStamped.js');
let LaserMode = require('./LaserMode.js');
let RobotnikMotorsStatus = require('./RobotnikMotorsStatus.js');
let AudioPlayer = require('./AudioPlayer.js');
let encoders = require('./encoders.js');
let MotorStatus = require('./MotorStatus.js');
let MotorReferenceValueArray = require('./MotorReferenceValueArray.js');
let Pose2DArray = require('./Pose2DArray.js');
let PresenceSensor = require('./PresenceSensor.js');
let OdomCalibrationStatusStamped = require('./OdomCalibrationStatusStamped.js');
let BatteryStatusStamped = require('./BatteryStatusStamped.js');
let State = require('./State.js');
let MotorCurrent = require('./MotorCurrent.js');
let inputs_outputs = require('./inputs_outputs.js');
let ReturnMessage = require('./ReturnMessage.js');
let Logger = require('./Logger.js');
let PresenceSensorArray = require('./PresenceSensorArray.js');
let InverterStatus = require('./InverterStatus.js');
let SimpleSystemStatus = require('./SimpleSystemStatus.js');
let Register = require('./Register.js');
let BatteryStatus = require('./BatteryStatus.js');
let MotorPID = require('./MotorPID.js');
let AlarmSensor = require('./AlarmSensor.js');
let LaserStatus = require('./LaserStatus.js');
let QueryAlarm = require('./QueryAlarm.js');
let MotorHeadingOffset = require('./MotorHeadingOffset.js');
let MotorsStatusDifferential = require('./MotorsStatusDifferential.js');
let ArmStatus = require('./ArmStatus.js');
let WatchdogStatusArray = require('./WatchdogStatusArray.js');
let MotorsStatus = require('./MotorsStatus.js');
let OdomManualCalibrationStatus = require('./OdomManualCalibrationStatus.js');
let ElevatorStatus = require('./ElevatorStatus.js');
let Axis = require('./Axis.js');
let Pose2DStamped = require('./Pose2DStamped.js');
let SubState = require('./SubState.js');
let Alarms = require('./Alarms.js');
let BatteryDockingStatus = require('./BatteryDockingStatus.js');
let OdomManualCalibrationStatusStamped = require('./OdomManualCalibrationStatusStamped.js');
let SetElevatorAction = require('./SetElevatorAction.js');
let SetElevatorActionResult = require('./SetElevatorActionResult.js');
let SetElevatorGoal = require('./SetElevatorGoal.js');
let SetElevatorActionFeedback = require('./SetElevatorActionFeedback.js');
let SetElevatorFeedback = require('./SetElevatorFeedback.js');
let SetElevatorResult = require('./SetElevatorResult.js');
let SetElevatorActionGoal = require('./SetElevatorActionGoal.js');

module.exports = {
  Data: Data,
  ElevatorAction: ElevatorAction,
  StringArray: StringArray,
  MotorReferenceValue: MotorReferenceValue,
  Interfaces: Interfaces,
  WatchdogStatus: WatchdogStatus,
  ptz: ptz,
  SafetyModuleStatus: SafetyModuleStatus,
  OdomCalibrationStatus: OdomCalibrationStatus,
  named_input_output: named_input_output,
  named_inputs_outputs: named_inputs_outputs,
  RecordStatus: RecordStatus,
  PantiltStatus: PantiltStatus,
  BatteryDockingStatusStamped: BatteryDockingStatusStamped,
  Registers: Registers,
  alarmsmonitor: alarmsmonitor,
  Cartesian_Euler_pose: Cartesian_Euler_pose,
  PantiltStatusStamped: PantiltStatusStamped,
  alarmmonitor: alarmmonitor,
  BoolArray: BoolArray,
  StringStamped: StringStamped,
  LaserMode: LaserMode,
  RobotnikMotorsStatus: RobotnikMotorsStatus,
  AudioPlayer: AudioPlayer,
  encoders: encoders,
  MotorStatus: MotorStatus,
  MotorReferenceValueArray: MotorReferenceValueArray,
  Pose2DArray: Pose2DArray,
  PresenceSensor: PresenceSensor,
  OdomCalibrationStatusStamped: OdomCalibrationStatusStamped,
  BatteryStatusStamped: BatteryStatusStamped,
  State: State,
  MotorCurrent: MotorCurrent,
  inputs_outputs: inputs_outputs,
  ReturnMessage: ReturnMessage,
  Logger: Logger,
  PresenceSensorArray: PresenceSensorArray,
  InverterStatus: InverterStatus,
  SimpleSystemStatus: SimpleSystemStatus,
  Register: Register,
  BatteryStatus: BatteryStatus,
  MotorPID: MotorPID,
  AlarmSensor: AlarmSensor,
  LaserStatus: LaserStatus,
  QueryAlarm: QueryAlarm,
  MotorHeadingOffset: MotorHeadingOffset,
  MotorsStatusDifferential: MotorsStatusDifferential,
  ArmStatus: ArmStatus,
  WatchdogStatusArray: WatchdogStatusArray,
  MotorsStatus: MotorsStatus,
  OdomManualCalibrationStatus: OdomManualCalibrationStatus,
  ElevatorStatus: ElevatorStatus,
  Axis: Axis,
  Pose2DStamped: Pose2DStamped,
  SubState: SubState,
  Alarms: Alarms,
  BatteryDockingStatus: BatteryDockingStatus,
  OdomManualCalibrationStatusStamped: OdomManualCalibrationStatusStamped,
  SetElevatorAction: SetElevatorAction,
  SetElevatorActionResult: SetElevatorActionResult,
  SetElevatorGoal: SetElevatorGoal,
  SetElevatorActionFeedback: SetElevatorActionFeedback,
  SetElevatorFeedback: SetElevatorFeedback,
  SetElevatorResult: SetElevatorResult,
  SetElevatorActionGoal: SetElevatorActionGoal,
};
