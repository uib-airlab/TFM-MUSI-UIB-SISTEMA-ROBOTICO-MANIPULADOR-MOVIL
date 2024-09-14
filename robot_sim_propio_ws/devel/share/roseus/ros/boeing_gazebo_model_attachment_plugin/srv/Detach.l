;; Auto-generated. Do not edit!


(when (boundp 'boeing_gazebo_model_attachment_plugin::Detach)
  (if (not (find-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN"))
    (make-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN"))
  (shadow 'Detach (find-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN")))
(unless (find-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN::DETACH")
  (make-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN::DETACH"))
(unless (find-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN::DETACHREQUEST")
  (make-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN::DETACHREQUEST"))
(unless (find-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN::DETACHRESPONSE")
  (make-package "BOEING_GAZEBO_MODEL_ATTACHMENT_PLUGIN::DETACHRESPONSE"))

(in-package "ROS")





(defclass boeing_gazebo_model_attachment_plugin::DetachRequest
  :super ros::object
  :slots (_joint_name _model_name_1 _model_name_2 ))

(defmethod boeing_gazebo_model_attachment_plugin::DetachRequest
  (:init
   (&key
    ((:joint_name __joint_name) "")
    ((:model_name_1 __model_name_1) "")
    ((:model_name_2 __model_name_2) "")
    )
   (send-super :init)
   (setq _joint_name (string __joint_name))
   (setq _model_name_1 (string __model_name_1))
   (setq _model_name_2 (string __model_name_2))
   self)
  (:joint_name
   (&optional __joint_name)
   (if __joint_name (setq _joint_name __joint_name)) _joint_name)
  (:model_name_1
   (&optional __model_name_1)
   (if __model_name_1 (setq _model_name_1 __model_name_1)) _model_name_1)
  (:model_name_2
   (&optional __model_name_2)
   (if __model_name_2 (setq _model_name_2 __model_name_2)) _model_name_2)
  (:serialization-length
   ()
   (+
    ;; string _joint_name
    4 (length _joint_name)
    ;; string _model_name_1
    4 (length _model_name_1)
    ;; string _model_name_2
    4 (length _model_name_2)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _joint_name
       (write-long (length _joint_name) s) (princ _joint_name s)
     ;; string _model_name_1
       (write-long (length _model_name_1) s) (princ _model_name_1 s)
     ;; string _model_name_2
       (write-long (length _model_name_2) s) (princ _model_name_2 s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _joint_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _joint_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _model_name_1
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _model_name_1 (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _model_name_2
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _model_name_2 (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass boeing_gazebo_model_attachment_plugin::DetachResponse
  :super ros::object
  :slots (_success _message ))

(defmethod boeing_gazebo_model_attachment_plugin::DetachResponse
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

(defclass boeing_gazebo_model_attachment_plugin::Detach
  :super ros::object
  :slots ())

(setf (get boeing_gazebo_model_attachment_plugin::Detach :md5sum-) "0a07b99010eab99684bb37117a445b93")
(setf (get boeing_gazebo_model_attachment_plugin::Detach :datatype-) "boeing_gazebo_model_attachment_plugin/Detach")
(setf (get boeing_gazebo_model_attachment_plugin::Detach :request) boeing_gazebo_model_attachment_plugin::DetachRequest)
(setf (get boeing_gazebo_model_attachment_plugin::Detach :response) boeing_gazebo_model_attachment_plugin::DetachResponse)

(defmethod boeing_gazebo_model_attachment_plugin::DetachRequest
  (:response () (instance boeing_gazebo_model_attachment_plugin::DetachResponse :init)))

(setf (get boeing_gazebo_model_attachment_plugin::DetachRequest :md5sum-) "0a07b99010eab99684bb37117a445b93")
(setf (get boeing_gazebo_model_attachment_plugin::DetachRequest :datatype-) "boeing_gazebo_model_attachment_plugin/DetachRequest")
(setf (get boeing_gazebo_model_attachment_plugin::DetachRequest :definition-)
      "string joint_name
string model_name_1
string model_name_2
---
bool success
string message


")

(setf (get boeing_gazebo_model_attachment_plugin::DetachResponse :md5sum-) "0a07b99010eab99684bb37117a445b93")
(setf (get boeing_gazebo_model_attachment_plugin::DetachResponse :datatype-) "boeing_gazebo_model_attachment_plugin/DetachResponse")
(setf (get boeing_gazebo_model_attachment_plugin::DetachResponse :definition-)
      "string joint_name
string model_name_1
string model_name_2
---
bool success
string message


")



(provide :boeing_gazebo_model_attachment_plugin/Detach "0a07b99010eab99684bb37117a445b93")


