;; Auto-generated. Do not edit!


(when (boundp 'propio::StartPickAndPlace)
  (if (not (find-package "PROPIO"))
    (make-package "PROPIO"))
  (shadow 'StartPickAndPlace (find-package "PROPIO")))
(unless (find-package "PROPIO::STARTPICKANDPLACE")
  (make-package "PROPIO::STARTPICKANDPLACE"))
(unless (find-package "PROPIO::STARTPICKANDPLACEREQUEST")
  (make-package "PROPIO::STARTPICKANDPLACEREQUEST"))
(unless (find-package "PROPIO::STARTPICKANDPLACERESPONSE")
  (make-package "PROPIO::STARTPICKANDPLACERESPONSE"))

(in-package "ROS")





(defclass propio::StartPickAndPlaceRequest
  :super ros::object
  :slots ())

(defmethod propio::StartPickAndPlaceRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass propio::StartPickAndPlaceResponse
  :super ros::object
  :slots (_success ))

(defmethod propio::StartPickAndPlaceResponse
  (:init
   (&key
    ((:success __success) nil)
    )
   (send-super :init)
   (setq _success __success)
   self)
  (:success
   (&optional (__success :null))
   (if (not (eq __success :null)) (setq _success __success)) _success)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass propio::StartPickAndPlace
  :super ros::object
  :slots ())

(setf (get propio::StartPickAndPlace :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get propio::StartPickAndPlace :datatype-) "propio/StartPickAndPlace")
(setf (get propio::StartPickAndPlace :request) propio::StartPickAndPlaceRequest)
(setf (get propio::StartPickAndPlace :response) propio::StartPickAndPlaceResponse)

(defmethod propio::StartPickAndPlaceRequest
  (:response () (instance propio::StartPickAndPlaceResponse :init)))

(setf (get propio::StartPickAndPlaceRequest :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get propio::StartPickAndPlaceRequest :datatype-) "propio/StartPickAndPlaceRequest")
(setf (get propio::StartPickAndPlaceRequest :definition-)
      "# StartPickAndPlace.srv
---
bool success

")

(setf (get propio::StartPickAndPlaceResponse :md5sum-) "358e233cde0c8a8bcfea4ce193f8fc15")
(setf (get propio::StartPickAndPlaceResponse :datatype-) "propio/StartPickAndPlaceResponse")
(setf (get propio::StartPickAndPlaceResponse :definition-)
      "# StartPickAndPlace.srv
---
bool success

")



(provide :propio/StartPickAndPlace "358e233cde0c8a8bcfea4ce193f8fc15")


