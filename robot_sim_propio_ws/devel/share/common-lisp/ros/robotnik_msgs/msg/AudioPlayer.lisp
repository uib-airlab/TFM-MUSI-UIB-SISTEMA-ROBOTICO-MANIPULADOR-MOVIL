; Auto-generated. Do not edit!


(cl:in-package robotnik_msgs-msg)


;//! \htmlinclude AudioPlayer.msg.html

(cl:defclass <AudioPlayer> (roslisp-msg-protocol:ros-message)
  ((elapsed_time
    :reader elapsed_time
    :initarg :elapsed_time
    :type cl:float
    :initform 0.0)
   (total_time
    :reader total_time
    :initarg :total_time
    :type cl:float
    :initform 0.0)
   (name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (is_playing
    :reader is_playing
    :initarg :is_playing
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass AudioPlayer (<AudioPlayer>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AudioPlayer>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AudioPlayer)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name robotnik_msgs-msg:<AudioPlayer> is deprecated: use robotnik_msgs-msg:AudioPlayer instead.")))

(cl:ensure-generic-function 'elapsed_time-val :lambda-list '(m))
(cl:defmethod elapsed_time-val ((m <AudioPlayer>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotnik_msgs-msg:elapsed_time-val is deprecated.  Use robotnik_msgs-msg:elapsed_time instead.")
  (elapsed_time m))

(cl:ensure-generic-function 'total_time-val :lambda-list '(m))
(cl:defmethod total_time-val ((m <AudioPlayer>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotnik_msgs-msg:total_time-val is deprecated.  Use robotnik_msgs-msg:total_time instead.")
  (total_time m))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <AudioPlayer>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotnik_msgs-msg:name-val is deprecated.  Use robotnik_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'is_playing-val :lambda-list '(m))
(cl:defmethod is_playing-val ((m <AudioPlayer>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader robotnik_msgs-msg:is_playing-val is deprecated.  Use robotnik_msgs-msg:is_playing instead.")
  (is_playing m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AudioPlayer>) ostream)
  "Serializes a message object of type '<AudioPlayer>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'elapsed_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'total_time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_playing) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AudioPlayer>) istream)
  "Deserializes a message object of type '<AudioPlayer>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'elapsed_time) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'total_time) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'is_playing) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AudioPlayer>)))
  "Returns string type for a message object of type '<AudioPlayer>"
  "robotnik_msgs/AudioPlayer")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AudioPlayer)))
  "Returns string type for a message object of type 'AudioPlayer"
  "robotnik_msgs/AudioPlayer")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AudioPlayer>)))
  "Returns md5sum for a message object of type '<AudioPlayer>"
  "e2121538143cf0a41ccf4c74bc5d25ca")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AudioPlayer)))
  "Returns md5sum for a message object of type 'AudioPlayer"
  "e2121538143cf0a41ccf4c74bc5d25ca")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AudioPlayer>)))
  "Returns full string definition for message of type '<AudioPlayer>"
  (cl:format cl:nil "float32 elapsed_time~%float32 total_time~%string name~%bool is_playing~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AudioPlayer)))
  "Returns full string definition for message of type 'AudioPlayer"
  (cl:format cl:nil "float32 elapsed_time~%float32 total_time~%string name~%bool is_playing~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AudioPlayer>))
  (cl:+ 0
     4
     4
     4 (cl:length (cl:slot-value msg 'name))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AudioPlayer>))
  "Converts a ROS message object to a list"
  (cl:list 'AudioPlayer
    (cl:cons ':elapsed_time (elapsed_time msg))
    (cl:cons ':total_time (total_time msg))
    (cl:cons ':name (name msg))
    (cl:cons ':is_playing (is_playing msg))
))
