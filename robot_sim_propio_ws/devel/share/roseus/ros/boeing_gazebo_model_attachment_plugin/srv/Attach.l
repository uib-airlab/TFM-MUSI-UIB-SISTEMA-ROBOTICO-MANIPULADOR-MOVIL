;; Auto-generated. Do not edit!


(when (boundp 'boeing_gazebo_model_attachment_plugin::Attach)
  (if (not (find-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN"))
    (make-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN"))
  (shadow 'Attach (find-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN")))
(unless (find-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN::ATTACH")
  (make-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN::ATTACH"))
(unless (find-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN::ATTACHREQUEST")
  (make-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN::ATTACHREQUEST"))
(unless (find-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN::ATTACHRESPONSE")
  (make-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN::ATTACHRESPONSE"))

(in-package "ROS")





(defclass boeing_gazebo_model_attachment_plugin::AttachRequest
  :super ros::object
  :slots (_joint_name _model_name_1 _link_name_1 _model_name_2 _link_name_2 ))

(defmethod boeing_gazebo_model_attachment_plugin::AttachRequest
  (:init
   (&key
    ((:joint_name __joint_name) "")
    ((:model_name_1 __model_name_1) "")
    ((:link_name_1 __link_name_1) "")
    ((:model_name_2 __model_name_2) "")
    ((:link_name_2 __link_name_2) "")
    )
   (send-super :init)
   (setq _joint_name (string __joint_name))
   (setq _model_name_1 (string __model_name_1))
   (setq _link_name_1 (string __link_name_1))
   (setq _model_name_2 (string __model_name_2))
   (setq _link_name_2 (string __link_name_2))
   self)
  (:joint_name
   (&optional __joint_name)
   (if __joint_name (setq _joint_name __joint_name)) _joint_name)
  (:model_name_1
   (&optional __model_name_1)
   (if __model_name_1 (setq _model_name_1 __model_name_1)) _model_name_1)
  (:link_name_1
   (&optional __link_name_1)
   (if __link_name_1 (setq _link_name_1 __link_name_1)) _link_name_1)
  (:model_name_2
   (&optional __model_name_2)
   (if __model_name_2 (setq _model_name_2 __model_name_2)) _model_name_2)
  (:link_name_2
   (&optional __link_name_2)
   (if __link_name_2 (setq _link_name_2 __link_name_2)) _link_name_2)
  (:serialization-length
   ()
   (+
    ;; string _joint_name
    4 (length _joint_name)
    ;; string _model_name_1
    4 (length _model_name_1)
    ;; string _link_name_1
    4 (length _link_name_1)
    ;; string _model_name_2
    4 (length _model_name_2)
    ;; string _link_name_2
    4 (length _link_name_2)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _joint_name
       (write-long (length _joint_name) s) (princ _joint_name s)
     ;; string _model_name_1
       (write-long (length _model_name_1) s) (princ _model_name_1 s)
     ;; string _link_name_1
       (write-long (length _link_name_1) s) (princ _link_name_1 s)
     ;; string _model_name_2
       (write-long (length _model_name_2) s) (princ _model_name_2 s)
     ;; string _link_name_2
       (write-long (length _link_name_2) s) (princ _link_name_2 s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _joint_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _joint_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _model_name_1
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _model_name_1 (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _link_name_1
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _link_name_1 (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _model_name_2
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _model_name_2 (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _link_name_2
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _link_name_2 (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass boeing_gazebo_model_attachment_plugin::AttachResponse
  :super ros::object
  :slots (_success _message ))

(defmethod boeing_gazebo_model_attachment_plugin::AttachResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:message __message) "")
    )
   (send-super :init)
   (setq _success __success)
   (setq _message (string __message))
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; string _message
    4 (length _message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass boeing_gazebo_model_attachment_plugin::Attach
  :super ros::object
  :slots ())

(setf (get boeing_gazebo_model_attachment_plugin::Attach :md5sum-) "2586cf82c17da3ea82111514d10d4265")
(setf (get boeing_gazebo_model_attachment_plugin::Attach :datatype-) "boeing_gazebo_model_attachment_plugin/Attach")
(setf (get boeing_gazebo_model_attachment_plugin::Attach :request) boeing_gazebo_model_attachment_plugin::AttachRequest)
(setf (get boeing_gazebo_model_attachment_plugin::Attach :response) boeing_gazebo_model_attachment_plugin::AttachResponse)

(defmethod boeing_gazebo_model_attachment_plugin::AttachRequest
  (:response () (instance boeing_gazebo_model_attachment_plugin::AttachResponse :init)))

(setf (get boeing_gazebo_model_attachment_plugin::AttachRequest :md5sum-) "2586cf82c17da3ea82111514d10d4265")
(setf (get boeing_gazebo_model_attachment_plugin::AttachRequest :datatype-) "boeing_gazebo_model_attachment_plugin/AttachRequest")
(setf (get boeing_gazebo_model_attachment_plugin::AttachRequest :definition-)
      "string joint_name
string model_name_1
string link_name_1
string model_name_2
string link_name_2
---
bool success
string message


")

(setf (get boeing_gazebo_model_attachment_plugin::AttachResponse :md5sum-) "2586cf82c17da3ea82111514d10d4265")
(setf (get boeing_gazebo_model_attachment_plugin::AttachResponse :datatype-) "boeing_gazebo_model_attachment_plugin/AttachResponse")
(setf (get boeing_gazebo_model_attachment_plugin::AttachResponse :definition-)
      "string joint_name
string model_name_1
string link_name_1
string model_name_2
string link_name_2
---
bool success
string message


")



(provide :boeing_gazebo_model_attachment_plugin/Attach "2586cf82c17da3ea82111514d10d4265")


