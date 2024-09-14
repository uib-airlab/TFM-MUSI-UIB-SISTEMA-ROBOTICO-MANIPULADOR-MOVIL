; Auto-generated. Do not edit!


(cl:in-package robotnik_msgs-msg)


;//! \htmlinclude SimpleSystemStatus.msg.html

(cl:defclass <SimpleSystemStatus> (roslisp-msg-protocol:ros-message)
  ((disk_capacity
    :reader disk_capacity
    :initarg :disk_capacity
    :type cl:float
    :initform 0.0)
   (disk_usage
    :reader disk_usage
    :initarg :disk_usage
    :type cl:float
    :initform 0.0)
   (memory_capacity
    :reader memory_capacity
    :initarg :memory_capacity
    :type cl:float
    :initform 0.0)
   (memory_usage
    :reader memory_usage
    :initarg :memory_usage
    :type cl:float
    :initform 0.0)
   (cpu_usage
    :reader cpu_usage
    :initarg :cpu_usage
    :type cl:float
    :initform 0.0)
   (core_usage
    :reader core_usage
    :initarg :core_usage
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (cpu_temperature
    :reader cpu_temperature
    :initarg :cpu_temperature
    :type cl:float
    :initform 0.0)
   (core_temperatures
    :reader core_temperatures
    :initarg :core_temperatures
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header)))
)

(cl:defclass SimpleSystemStatus (<SimpleSystemStatus>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SimpleSystemStatus>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SimpleSystemStatus)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robotnik_msgs-msg:<SimpleSystemStatus> is deprecated: use robotnik_msgs-msg:SimpleSystemStatus instead.")))

(cl:ensure-generic-function 'disk_capacity-val :lambda-list '(m))
(cl:defmethod disk_capacity-val ((m <SimpleSystemStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotnik_msgs-msg:disk_capacity-val is deprecated.  Use robotnik_msgs-msg:disk_capacity instead.")
  (disk_capacity m))

(cl:ensure-generic-function 'disk_usage-val :lambda-list '(m))
(cl:defmethod disk_usage-val ((m <SimpleSystemStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotnik_msgs-msg:disk_usage-val is deprecated.  Use robotnik_msgs-msg:disk_usage instead.")
  (disk_usage m))

(cl:ensure-generic-function 'memory_capacity-val :lambda-list '(m))
(cl:defmethod memory_capacity-val ((m <SimpleSystemStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotnik_msgs-msg:memory_capacity-val is deprecated.  Use robotnik_msgs-msg:memory_capacity instead.")
  (memory_capacity m))

(cl:ensure-generic-function 'memory_usage-val :lambda-list '(m))
(cl:defmethod memory_usage-val ((m <SimpleSystemStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotnik_msgs-msg:memory_usage-val is deprecated.  Use robotnik_msgs-msg:memory_usage instead.")
  (memory_usage m))

(cl:ensure-generic-function 'cpu_usage-val :lambda-list '(m))
(cl:defmethod cpu_usage-val ((m <SimpleSystemStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotnik_msgs-msg:cpu_usage-val is deprecated.  Use robotnik_msgs-msg:cpu_usage instead.")
  (cpu_usage m))

(cl:ensure-generic-function 'core_usage-val :lambda-list '(m))
(cl:defmethod core_usage-val ((m <SimpleSystemStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotnik_msgs-msg:core_usage-val is deprecated.  Use robotnik_msgs-msg:core_usage instead.")
  (core_usage m))

(cl:ensure-generic-function 'cpu_temperature-val :lambda-list '(m))
(cl:defmethod cpu_temperature-val ((m <SimpleSystemStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotnik_msgs-msg:cpu_temperature-val is deprecated.  Use robotnik_msgs-msg:cpu_temperature instead.")
  (cpu_temperature m))

(cl:ensure-generic-function 'core_temperatures-val :lambda-list '(m))
(cl:defmethod core_temperatures-val ((m <SimpleSystemStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotnik_msgs-msg:core_temperatures-val is deprecated.  Use robotnik_msgs-msg:core_temperatures instead.")
  (core_temperatures m))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <SimpleSystemStatus>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotnik_msgs-msg:header-val is deprecated.  Use robotnik_msgs-msg:header instead.")
  (header m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SimpleSystemStatus>) ostream)
  "Serializes a message object of type '<SimpleSystemStatus>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'disk_capacity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'disk_usage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'memory_capacity))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'memory_usage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'cpu_usage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'core_usage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'core_usage))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'cpu_temperature))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'core_temperatures))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'core_temperatures))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SimpleSystemStatus>) istream)
  "Deserializes a message object of type '<SimpleSystemStatus>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'disk_capacity) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'disk_usage) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'memory_capacity) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'memory_usage) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'cpu_usage) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'core_usage) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'core_usage)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'cpu_temperature) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'core_temperatures) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'core_temperatures)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SimpleSystemStatus>)))
  "Returns string type for a message object of type '<SimpleSystemStatus>"
  "robotnik_msgs/SimpleSystemStatus")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SimpleSystemStatus)))
  "Returns string type for a message object of type 'SimpleSystemStatus"
  "robotnik_msgs/SimpleSystemStatus")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SimpleSystemStatus>)))
  "Returns md5sum for a message object of type '<SimpleSystemStatus>"
  "297c535b6bb09ddac9c89e40f3d56868")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SimpleSystemStatus)))
  "Returns md5sum for a message object of type 'SimpleSystemStatus"
  "297c535b6bb09ddac9c89e40f3d56868")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SimpleSystemStatus>)))
  "Returns full string definition for message of type '<SimpleSystemStatus>"
  (cl:format cl:nil "float32 disk_capacity~%float32 disk_usage~%float32 memory_capacity~%float32 memory_usage~%float32 cpu_usage~%float32[] core_usage~%float32 cpu_temperature~%float32[] core_temperatures~%Header header~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SimpleSystemStatus)))
  "Returns full string definition for message of type 'SimpleSystemStatus"
  (cl:format cl:nil "float32 disk_capacity~%float32 disk_usage~%float32 memory_capacity~%float32 memory_usage~%float32 cpu_usage~%float32[] core_usage~%float32 cpu_temperature~%float32[] core_temperatures~%Header header~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SimpleSystemStatus>))
  (cl:+ 0
     4
     4
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'core_usage) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'core_temperatures) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SimpleSystemStatus>))
  "Converts a ROS message object to a list"
  (cl:list 'SimpleSystemStatus
    (cl:cons ':disk_capacity (disk_capacity msg))
    (cl:cons ':disk_usage (disk_usage msg))
    (cl:cons ':memory_capacity (memory_capacity msg))
    (cl:cons ':memory_usage (memory_usage msg))
    (cl:cons ':cpu_usage (cpu_usage msg))
    (cl:cons ':core_usage (core_usage msg))
    (cl:cons ':cpu_temperature (cpu_temperature msg))
    (cl:cons ':core_temperatures (core_temperatures msg))
    (cl:cons ':header (header msg))
))
