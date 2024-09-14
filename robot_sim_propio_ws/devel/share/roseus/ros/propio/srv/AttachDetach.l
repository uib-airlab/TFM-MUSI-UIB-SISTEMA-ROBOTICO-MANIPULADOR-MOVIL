;; Auto-generated. Do not edit!


(when (boundp 'propio::AttachDetach)
  (if (not (find-package "PROPIO"))
    (make-package "PROPIO"))
  (shadow 'AttachDetach (find-package "PROPIO")))
(unless (find-package "PROPIO::ATTACHDETACH")
  (make-package "PROPIO::ATTACHDETACH"))
(unless (find-package "PROPIO::ATTACHDETACHREQUEST")
  (make-package "PROPIO::ATTACHDETACHREQUEST"))
(unless (find-package "PROPIO::ATTACHDETACHRESPONSE")
  (make-package "PROPIO::ATTACHDETACHRESPONSE"))

(in-package "ROS")





(defclass propio::AttachDetachRequest
  :super ros::object
  :slots (_object_name _attach ))

(defmethod propio::AttachDetachRequest
  (:init
   (&key
    ((:object_name __object_name) "")
    ((:attach __attach) nil)
    )
   (send-super :init)
   (setq _object_name (string __object_name))
   (setq _attach __attach)
   self)
  (:object_name
   (&optional __object_name)
   (if __object_name (setq _object_name __object_name)) _object_name)
  (:attach
   (&optional (__attach :null))
   (if (not (eq __attach :null)) (setq _attach __attach)) _attach)
  (:serialization-length
   ()
   (+
    ;; string _object_name
    4 (length _object_name)
    ;; bool _attach
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _object_name
       (write-long (length _object_name) s) (princ _object_name s)
     ;; bool _attach
       (if _attach (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _object_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _object_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _attach
     (setq _attach (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass propio::AttachDetachResponse
  :super ros::object
  :slots (_success _message ))

(defmethod propio::AttachDetachResponse
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

(defclass propio::AttachDetach
  :super ros::object
  :slots ())

(setf (get propio::AttachDetach :md5sum-) "1e9f418fc6a1ffcaf360d719404f78ea")
(setf (get propio::AttachDetach :datatype-) "propio/AttachDetach")
(setf (get propio::AttachDetach :request) propio::AttachDetachRequest)
(setf (get propio::AttachDetach :response) propio::AttachDetachResponse)

(defmethod propio::AttachDetachRequest
  (:response () (instance propio::AttachDetachResponse :init)))

(setf (get propio::AttachDetachRequest :md5sum-) "1e9f418fc6a1ffcaf360d719404f78ea")
(setf (get propio::AttachDetachRequest :datatype-) "propio/AttachDetachRequest")
(setf (get propio::AttachDetachRequest :definition-)
      "string object_name
bool attach
---
bool success
string message

")

(setf (get propio::AttachDetachResponse :md5sum-) "1e9f418fc6a1ffcaf360d719404f78ea")
(setf (get propio::AttachDetachResponse :datatype-) "propio/AttachDetachResponse")
(setf (get propio::AttachDetachResponse :definition-)
      "string object_name
bool attach
---
bool success
string message

")



(provide :propio/AttachDetach "1e9f418fc6a1ffcaf360d719404f78ea")


