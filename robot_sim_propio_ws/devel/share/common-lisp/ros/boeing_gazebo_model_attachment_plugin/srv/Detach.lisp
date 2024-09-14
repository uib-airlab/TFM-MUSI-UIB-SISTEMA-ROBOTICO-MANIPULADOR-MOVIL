; Auto-generated. Do not edit!


(cl:in-package boeing_gazebo_model_attachment_plugin-srv)


;//! \htmlinclude Detach-request.msg.html

(cl:defclass <Detach-request> (roslisp-msg-protocol:ros-message)
  ((joint_name
    :reader joint_name
    :initarg :joint_name
    :type cl:string
    :initform "")
   (model_name_1
    :reader model_name_1
    :initarg :model_name_1
    :type cl:string
    :initform "")
   (model_name_2
    :reader model_name_2
    :initarg :model_name_2
    :type cl:string
    :initform ""))
)

(cl:defclass Detach-request (<Detach-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Detach-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Detach-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name boeing_gazebo_model_attachment_plugin-srv:<Detach-request> is deprecated: use boeing_gazebo_model_attachment_plugin-srv:Detach-request instead.")))

(cl:ensure-generic-function 'joint_name-val :lambda-list '(m))
(cl:defmethod joint_name-val ((m <Detach-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader boeing_gazebo_model_attachment_plugin-srv:joint_name-val is deprecated.  Use boeing_gazebo_model_attachment_plugin-srv:joint_name instead.")
  (joint_name m))

(cl:ensure-generic-function 'model_name_1-val :lambda-list '(m))
(cl:defmethod model_name_1-val ((m <Detach-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader boeing_gazebo_model_attachment_plugin-srv:model_name_1-val is deprecated.  Use boeing_gazebo_model_attachment_plugin-srv:model_name_1 instead.")
  (model_name_1 m))

(cl:ensure-generic-function 'model_name_2-val :lambda-list '(m))
(cl:defmethod model_name_2-val ((m <Detach-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader boeing_gazebo_model_attachment_plugin-srv:model_name_2-val is deprecated.  Use boeing_gazebo_model_attachment_plugin-srv:model_name_2 instead.")
  (model_name_2 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Detach-request>) ostream)
  "Serializes a message object of type '<Detach-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'joint_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'joint_name))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'model_name_1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'model_name_1))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'model_name_2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'model_name_2))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Detach-request>) istream)
  "Deserializes a message object of type '<Detach-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'joint_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'joint_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'model_name_1) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'model_name_1) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'model_name_2) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'model_name_2) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Detach-request>)))
  "Returns string type for a service object of type '<Detach-request>"
  "boeing_gazebo_model_attachment_plugin/DetachRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Detach-request)))
  "Returns string type for a service object of type 'Detach-request"
  "boeing_gazebo_model_attachment_plugin/DetachRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Detach-request>)))
  "Returns md5sum for a message object of type '<Detach-request>"
  "0a07b99010eab99684bb37117a445b93")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Detach-request)))
  "Returns md5sum for a message object of type 'Detach-request"
  "0a07b99010eab99684bb37117a445b93")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Detach-request>)))
  "Returns full string definition for message of type '<Detach-request>"
  (cl:format cl:nil "string joint_name~%string model_name_1~%string model_name_2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Detach-request)))
  "Returns full string definition for message of type 'Detach-request"
  (cl:format cl:nil "string joint_name~%string model_name_1~%string model_name_2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Detach-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'joint_name))
     4 (cl:length (cl:slot-value msg 'model_name_1))
     4 (cl:length (cl:slot-value msg 'model_name_2))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Detach-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Detach-request
    (cl:cons ':joint_name (joint_name msg))
    (cl:cons ':model_name_1 (model_name_1 msg))
    (cl:cons ':model_name_2 (model_name_2 msg))
))
;//! \htmlinclude Detach-response.msg.html

(cl:defclass <Detach-response> (roslisp-msg-protocol:ros-message)
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

(cl:defclass Detach-response (<Detach-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Detach-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Detach-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name boeing_gazebo_model_attachment_plugin-srv:<Detach-response> is deprecated: use boeing_gazebo_model_attachment_plugin-srv:Detach-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <Detach-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader boeing_gazebo_model_attachment_plugin-srv:success-val is deprecated.  Use boeing_gazebo_model_attachment_plugin-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <Detach-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader boeing_gazebo_model_attachment_plugin-srv:message-val is deprecated.  Use boeing_gazebo_model_attachment_plugin-srv:message instead.")
  (message m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Detach-response>) ostream)
  "Serializes a message object of type '<Detach-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Detach-response>) istream)
  "Deserializes a message object of type '<Detach-response>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Detach-response>)))
  "Returns string type for a service object of type '<Detach-response>"
  "boeing_gazebo_model_attachment_plugin/DetachResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Detach-response)))
  "Returns string type for a service object of type 'Detach-response"
  "boeing_gazebo_model_attachment_plugin/DetachResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Detach-response>)))
  "Returns md5sum for a message object of type '<Detach-response>"
  "0a07b99010eab99684bb37117a445b93")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Detach-response)))
  "Returns md5sum for a message object of type 'Detach-response"
  "0a07b99010eab99684bb37117a445b93")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Detach-response>)))
  "Returns full string definition for message of type '<Detach-response>"
  (cl:format cl:nil "bool success~%string message~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Detach-response)))
  "Returns full string definition for message of type 'Detach-response"
  (cl:format cl:nil "bool success~%string message~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Detach-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Detach-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Detach-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Detach)))
  'Detach-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Detach)))
  'Detach-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Detach)))
  "Returns string type for a service object of type '<Detach>"
  "boeing_gazebo_model_attachment_plugin/Detach")