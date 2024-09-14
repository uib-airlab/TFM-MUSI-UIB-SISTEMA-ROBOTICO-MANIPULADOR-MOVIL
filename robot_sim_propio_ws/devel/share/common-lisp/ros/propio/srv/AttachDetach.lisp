; Auto-generated. Do not edit!


(cl:in-package propio-srv)


;//! \htmlinclude AttachDetach-request.msg.html

(cl:defclass <AttachDetach-request> (roslisp-msg-protocol:ros-message)
  ((object_name
    :reader object_name
    :initarg :object_name
    :type cl:string
    :initform "")
   (attach
    :reader attach
    :initarg :attach
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass AttachDetach-request (<AttachDetach-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AttachDetach-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AttachDetach-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name propio-srv:<AttachDetach-request> is deprecated: use propio-srv:AttachDetach-request instead.")))

(cl:ensure-generic-function 'object_name-val :lambda-list '(m))
(cl:defmethod object_name-val ((m <AttachDetach-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader propio-srv:object_name-val is deprecated.  Use propio-srv:object_name instead.")
  (object_name m))

(cl:ensure-generic-function 'attach-val :lambda-list '(m))
(cl:defmethod attach-val ((m <AttachDetach-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader propio-srv:attach-val is deprecated.  Use propio-srv:attach instead.")
  (attach m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AttachDetach-request>) ostream)
  "Serializes a message object of type '<AttachDetach-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'object_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'object_name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'attach) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AttachDetach-request>) istream)
  "Deserializes a message object of type '<AttachDetach-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'object_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'object_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'attach) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AttachDetach-request>)))
  "Returns string type for a service object of type '<AttachDetach-request>"
  "propio/AttachDetachRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AttachDetach-request)))
  "Returns string type for a service object of type 'AttachDetach-request"
  "propio/AttachDetachRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AttachDetach-request>)))
  "Returns md5sum for a message object of type '<AttachDetach-request>"
  "1e9f418fc6a1ffcaf360d719404f78ea")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AttachDetach-request)))
  "Returns md5sum for a message object of type 'AttachDetach-request"
  "1e9f418fc6a1ffcaf360d719404f78ea")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AttachDetach-request>)))
  "Returns full string definition for message of type '<AttachDetach-request>"
  (cl:format cl:nil "string object_name~%bool attach~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AttachDetach-request)))
  "Returns full string definition for message of type 'AttachDetach-request"
  (cl:format cl:nil "string object_name~%bool attach~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AttachDetach-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'object_name))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AttachDetach-request>))
  "Converts a ROS message object to a list"
  (cl:list 'AttachDetach-request
    (cl:cons ':object_name (object_name msg))
    (cl:cons ':attach (attach msg))
))
;//! \htmlinclude AttachDetach-response.msg.html

(cl:defclass <AttachDetach-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (message
    :reader message
    :initarg :message
    :type cl:string
    :initform ""))
)

(cl:defclass AttachDetach-response (<AttachDetach-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AttachDetach-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AttachDetach-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name propio-srv:<AttachDetach-response> is deprecated: use propio-srv:AttachDetach-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <AttachDetach-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader propio-srv:success-val is deprecated.  Use propio-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <AttachDetach-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader propio-srv:message-val is deprecated.  Use propio-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AttachDetach-response>) ostream)
  "Serializes a message object of type '<AttachDetach-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AttachDetach-response>) istream)
  "Deserializes a message object of type '<AttachDetach-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AttachDetach-response>)))
  "Returns string type for a service object of type '<AttachDetach-response>"
  "propio/AttachDetachResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AttachDetach-response)))
  "Returns string type for a service object of type 'AttachDetach-response"
  "propio/AttachDetachResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AttachDetach-response>)))
  "Returns md5sum for a message object of type '<AttachDetach-response>"
  "1e9f418fc6a1ffcaf360d719404f78ea")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AttachDetach-response)))
  "Returns md5sum for a message object of type 'AttachDetach-response"
  "1e9f418fc6a1ffcaf360d719404f78ea")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AttachDetach-response>)))
  "Returns full string definition for message of type '<AttachDetach-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AttachDetach-response)))
  "Returns full string definition for message of type 'AttachDetach-response"
  (cl:format cl:nil "bool success~%string message~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AttachDetach-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AttachDetach-response>))
  "Converts a ROS message object to a list"
  (cl:list 'AttachDetach-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'AttachDetach)))
  'AttachDetach-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'AttachDetach)))
  'AttachDetach-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AttachDetach)))
  "Returns string type for a service object of type '<AttachDetach>"
  "propio/AttachDetach")