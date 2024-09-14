; Auto-generated. Do not edit!


(cl:in-package propio-srv)


;//! \htmlinclude ProcessImage-request.msg.html

(cl:defclass <ProcessImage-request> (roslisp-msg-protocol:ros-message)
  ((isFront
    :reader isFront
    :initarg :isFront
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass ProcessImage-request (<ProcessImage-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ProcessImage-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ProcessImage-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name propio-srv:<ProcessImage-request> is deprecated: use propio-srv:ProcessImage-request instead.")))

(cl:ensure-generic-function 'isFront-val :lambda-list '(m))
(cl:defmethod isFront-val ((m <ProcessImage-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader propio-srv:isFront-val is deprecated.  Use propio-srv:isFront instead.")
  (isFront m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ProcessImage-request>) ostream)
  "Serializes a message object of type '<ProcessImage-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'isFront) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ProcessImage-request>) istream)
  "Deserializes a message object of type '<ProcessImage-request>"
    (cl:setf (cl:slot-value msg 'isFront) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ProcessImage-request>)))
  "Returns string type for a service object of type '<ProcessImage-request>"
  "propio/ProcessImageRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ProcessImage-request)))
  "Returns string type for a service object of type 'ProcessImage-request"
  "propio/ProcessImageRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ProcessImage-request>)))
  "Returns md5sum for a message object of type '<ProcessImage-request>"
  "37b472b910195c5295b6dd8ac539437e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ProcessImage-request)))
  "Returns md5sum for a message object of type 'ProcessImage-request"
  "37b472b910195c5295b6dd8ac539437e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ProcessImage-request>)))
  "Returns full string definition for message of type '<ProcessImage-request>"
  (cl:format cl:nil "# ProcessImage.srv~%bool isFront~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ProcessImage-request)))
  "Returns full string definition for message of type 'ProcessImage-request"
  (cl:format cl:nil "# ProcessImage.srv~%bool isFront~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ProcessImage-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ProcessImage-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ProcessImage-request
    (cl:cons ':isFront (isFront msg))
))
;//! \htmlinclude ProcessImage-response.msg.html

(cl:defclass <ProcessImage-response> (roslisp-msg-protocol:ros-message)
  ((pose
    :reader pose
    :initarg :pose
    :type geometry_msgs-msg:Pose
    :initform (cl:make-instance 'geometry_msgs-msg:Pose))
   (distance
    :reader distance
    :initarg :distance
    :type cl:float
    :initform 0.0)
   (needsArm
    :reader needsArm
    :initarg :needsArm
    :type cl:boolean
    :initform cl:nil)
   (numberObjects
    :reader numberObjects
    :initarg :numberObjects
    :type cl:integer
    :initform 0)
   (dimensions
    :reader dimensions
    :initarg :dimensions
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3)))
)

(cl:defclass ProcessImage-response (<ProcessImage-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ProcessImage-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ProcessImage-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name propio-srv:<ProcessImage-response> is deprecated: use propio-srv:ProcessImage-response instead.")))

(cl:ensure-generic-function 'pose-val :lambda-list '(m))
(cl:defmethod pose-val ((m <ProcessImage-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader propio-srv:pose-val is deprecated.  Use propio-srv:pose instead.")
  (pose m))

(cl:ensure-generic-function 'distance-val :lambda-list '(m))
(cl:defmethod distance-val ((m <ProcessImage-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader propio-srv:distance-val is deprecated.  Use propio-srv:distance instead.")
  (distance m))

(cl:ensure-generic-function 'needsArm-val :lambda-list '(m))
(cl:defmethod needsArm-val ((m <ProcessImage-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader propio-srv:needsArm-val is deprecated.  Use propio-srv:needsArm instead.")
  (needsArm m))

(cl:ensure-generic-function 'numberObjects-val :lambda-list '(m))
(cl:defmethod numberObjects-val ((m <ProcessImage-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader propio-srv:numberObjects-val is deprecated.  Use propio-srv:numberObjects instead.")
  (numberObjects m))

(cl:ensure-generic-function 'dimensions-val :lambda-list '(m))
(cl:defmethod dimensions-val ((m <ProcessImage-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader propio-srv:dimensions-val is deprecated.  Use propio-srv:dimensions instead.")
  (dimensions m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ProcessImage-response>) ostream)
  "Serializes a message object of type '<ProcessImage-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pose) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'needsArm) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'numberObjects)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'dimensions) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ProcessImage-response>) istream)
  "Deserializes a message object of type '<ProcessImage-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pose) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'distance) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:slot-value msg 'needsArm) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'numberObjects) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'dimensions) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ProcessImage-response>)))
  "Returns string type for a service object of type '<ProcessImage-response>"
  "propio/ProcessImageResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ProcessImage-response)))
  "Returns string type for a service object of type 'ProcessImage-response"
  "propio/ProcessImageResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ProcessImage-response>)))
  "Returns md5sum for a message object of type '<ProcessImage-response>"
  "37b472b910195c5295b6dd8ac539437e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ProcessImage-response)))
  "Returns md5sum for a message object of type 'ProcessImage-response"
  "37b472b910195c5295b6dd8ac539437e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ProcessImage-response>)))
  "Returns full string definition for message of type '<ProcessImage-response>"
  (cl:format cl:nil "geometry_msgs/Pose pose~%float64 distance~%bool needsArm~%int32 numberObjects~%geometry_msgs/Vector3 dimensions ~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ProcessImage-response)))
  "Returns full string definition for message of type 'ProcessImage-response"
  (cl:format cl:nil "geometry_msgs/Pose pose~%float64 distance~%bool needsArm~%int32 numberObjects~%geometry_msgs/Vector3 dimensions ~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ProcessImage-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pose))
     8
     1
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'dimensions))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ProcessImage-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ProcessImage-response
    (cl:cons ':pose (pose msg))
    (cl:cons ':distance (distance msg))
    (cl:cons ':needsArm (needsArm msg))
    (cl:cons ':numberObjects (numberObjects msg))
    (cl:cons ':dimensions (dimensions msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ProcessImage)))
  'ProcessImage-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ProcessImage)))
  'ProcessImage-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ProcessImage)))
  "Returns string type for a service object of type '<ProcessImage>"
  "propio/ProcessImage")