; Auto-generated. Do not edit!


(cl:in-package propio-srv)


;//! \htmlinclude StartStopExplorer-request.msg.html

(cl:defclass <StartStopExplorer-request> (roslisp-msg-protocol:ros-message)
  ((start
    :reader start
    :initarg :start
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass StartStopExplorer-request (<StartStopExplorer-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StartStopExplorer-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StartStopExplorer-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name propio-srv:<StartStopExplorer-request> is deprecated: use propio-srv:StartStopExplorer-request instead.")))

(cl:ensure-generic-function 'start-val :lambda-list '(m))
(cl:defmethod start-val ((m <StartStopExplorer-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader propio-srv:start-val is deprecated.  Use propio-srv:start instead.")
  (start m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StartStopExplorer-request>) ostream)
  "Serializes a message object of type '<StartStopExplorer-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'start) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StartStopExplorer-request>) istream)
  "Deserializes a message object of type '<StartStopExplorer-request>"
    (cl:setf (cl:slot-value msg 'start) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StartStopExplorer-request>)))
  "Returns string type for a service object of type '<StartStopExplorer-request>"
  "propio/StartStopExplorerRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StartStopExplorer-request)))
  "Returns string type for a service object of type 'StartStopExplorer-request"
  "propio/StartStopExplorerRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StartStopExplorer-request>)))
  "Returns md5sum for a message object of type '<StartStopExplorer-request>"
  "676aa7bfb3ec2071e814f2368dfd5fb5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StartStopExplorer-request)))
  "Returns md5sum for a message object of type 'StartStopExplorer-request"
  "676aa7bfb3ec2071e814f2368dfd5fb5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StartStopExplorer-request>)))
  "Returns full string definition for message of type '<StartStopExplorer-request>"
  (cl:format cl:nil "# StartStopExplorer.srv~%bool start~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StartStopExplorer-request)))
  "Returns full string definition for message of type 'StartStopExplorer-request"
  (cl:format cl:nil "# StartStopExplorer.srv~%bool start~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StartStopExplorer-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StartStopExplorer-request>))
  "Converts a ROS message object to a list"
  (cl:list 'StartStopExplorer-request
    (cl:cons ':start (start msg))
))
;//! \htmlinclude StartStopExplorer-response.msg.html

(cl:defclass <StartStopExplorer-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass StartStopExplorer-response (<StartStopExplorer-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <StartStopExplorer-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'StartStopExplorer-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name propio-srv:<StartStopExplorer-response> is deprecated: use propio-srv:StartStopExplorer-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <StartStopExplorer-response>) ostream)
  "Serializes a message object of type '<StartStopExplorer-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <StartStopExplorer-response>) istream)
  "Deserializes a message object of type '<StartStopExplorer-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<StartStopExplorer-response>)))
  "Returns string type for a service object of type '<StartStopExplorer-response>"
  "propio/StartStopExplorerResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StartStopExplorer-response)))
  "Returns string type for a service object of type 'StartStopExplorer-response"
  "propio/StartStopExplorerResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<StartStopExplorer-response>)))
  "Returns md5sum for a message object of type '<StartStopExplorer-response>"
  "676aa7bfb3ec2071e814f2368dfd5fb5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'StartStopExplorer-response)))
  "Returns md5sum for a message object of type 'StartStopExplorer-response"
  "676aa7bfb3ec2071e814f2368dfd5fb5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<StartStopExplorer-response>)))
  "Returns full string definition for message of type '<StartStopExplorer-response>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'StartStopExplorer-response)))
  "Returns full string definition for message of type 'StartStopExplorer-response"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <StartStopExplorer-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <StartStopExplorer-response>))
  "Converts a ROS message object to a list"
  (cl:list 'StartStopExplorer-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'StartStopExplorer)))
  'StartStopExplorer-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'StartStopExplorer)))
  'StartStopExplorer-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'StartStopExplorer)))
  "Returns string type for a service object of type '<StartStopExplorer>"
  "propio/StartStopExplorer")