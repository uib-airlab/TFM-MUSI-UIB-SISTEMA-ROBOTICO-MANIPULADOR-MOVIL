;; Auto-generated. Do not edit!


(when (boundp 'propio::StartStopExplorer)
  (if (not (find-package "PROPIO"))
    (make-package "PROPIO"))
  (shadow 'StartStopExplorer (find-package "PROPIO")))
(unless (find-package "PROPIO::STARTSTOPEXPLORER")
  (make-package "PROPIO::STARTSTOPEXPLORER"))
(unless (find-package "PROPIO::STARTSTOPEXPLORERREQUEST")
  (make-package "PROPIO::STARTSTOPEXPLORERREQUEST"))
(unless (find-package "PROPIO::STARTSTOPEXPLORERRESPONSE")
  (make-package "PROPIO::STARTSTOPEXPLORERRESPONSE"))

(in-package "ROS")





(defclass propio::StartStopExplorerRequest
  :super ros::object
  :slots (_start ))

(defmethod propio::StartStopExplorerRequest
  (:init
   (&key
    ((:start __start) nil)
    )
   (send-super :init)
   (setq _start __start)
   self)
  (:start
   (&optional (__start :null))
   (if (not (eq __start :null)) (setq _start __start)) _start)
  (:serialization-length
   ()
   (+
    ;; bool _start
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _start
       (if _start (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _start
     (setq _start (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass propio::StartStopExplorerResponse
  :super ros::object
  :slots ())

(defmethod propio::StartStopExplorerResponse
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

(defclass propio::StartStopExplorer
  :super ros::object
  :slots ())

(setf (get propio::StartStopExplorer :md5sum-) "676aa7bfb3ec2071e814f2368dfd5fb5")
(setf (get propio::StartStopExplorer :datatype-) "propio/StartStopExplorer")
(setf (get propio::StartStopExplorer :request) propio::StartStopExplorerRequest)
(setf (get propio::StartStopExplorer :response) propio::StartStopExplorerResponse)

(defmethod propio::StartStopExplorerRequest
  (:response () (instance propio::StartStopExplorerResponse :init)))

(setf (get propio::StartStopExplorerRequest :md5sum-) "676aa7bfb3ec2071e814f2368dfd5fb5")
(setf (get propio::StartStopExplorerRequest :datatype-) "propio/StartStopExplorerRequest")
(setf (get propio::StartStopExplorerRequest :definition-)
      "# StartStopExplorer.srv
bool start
---

")

(setf (get propio::StartStopExplorerResponse :md5sum-) "676aa7bfb3ec2071e814f2368dfd5fb5")
(setf (get propio::StartStopExplorerResponse :datatype-) "propio/StartStopExplorerResponse")
(setf (get propio::StartStopExplorerResponse :definition-)
      "# StartStopExplorer.srv
bool start
---

")



(provide :propio/StartStopExplorer "676aa7bfb3ec2071e814f2368dfd5fb5")


