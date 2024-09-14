;; Auto-generated. Do not edit!


(when (boundp 'propio::ProcessImage)
  (if (not (find-package "PROPIO"))
    (make-package "PROPIO"))
  (shadow 'ProcessImage (find-package "PROPIO")))
(unless (find-package "PROPIO::PROCESSIMAGE")
  (make-package "PROPIO::PROCESSIMAGE"))
(unless (find-package "PROPIO::PROCESSIMAGEREQUEST")
  (make-package "PROPIO::PROCESSIMAGEREQUEST"))
(unless (find-package "PROPIO::PROCESSIMAGERESPONSE")
  (make-package "PROPIO::PROCESSIMAGERESPONSE"))

(in-package "ROS")



(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass propio::ProcessImageRequest
  :super ros::object
  :slots (_isFront ))

(defmethod propio::ProcessImageRequest
  (:init
   (&key
    ((:isFront __isFront) nil)
    )
   (send-super :init)
   (setq _isFront __isFront)
   self)
  (:isFront
   (&optional (__isFront :null))
   (if (not (eq __isFront :null)) (setq _isFront __isFront)) _isFront)
  (:serialization-length
   ()
   (+
    ;; bool _isFront
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _isFront
       (if _isFront (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _isFront
     (setq _isFront (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass propio::ProcessImageResponse
  :super ros::object
  :slots (_pose _distance _needsArm _numberObjects _dimensions ))

(defmethod propio::ProcessImageResponse
  (:init
   (&key
    ((:pose __pose) (instance geometry_msgs::Pose :init))
    ((:distance __distance) 0.0)
    ((:needsArm __needsArm) nil)
    ((:numberObjects __numberObjects) 0)
    ((:dimensions __dimensions) (instance geometry_msgs::Vector3 :init))
    )
   (send-super :init)
   (setq _pose __pose)
   (setq _distance (float __distance))
   (setq _needsArm __needsArm)
   (setq _numberObjects (round __numberObjects))
   (setq _dimensions __dimensions)
   self)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:distance
   (&optional __distance)
   (if __distance (setq _distance __distance)) _distance)
  (:needsArm
   (&optional (__needsArm :null))
   (if (not (eq __needsArm :null)) (setq _needsArm __needsArm)) _needsArm)
  (:numberObjects
   (&optional __numberObjects)
   (if __numberObjects (setq _numberObjects __numberObjects)) _numberObjects)
  (:dimensions
   (&rest __dimensions)
   (if (keywordp (car __dimensions))
       (send* _dimensions __dimensions)
     (progn
       (if __dimensions (setq _dimensions (car __dimensions)))
       _dimensions)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Pose _pose
    (send _pose :serialization-length)
    ;; float64 _distance
    8
    ;; bool _needsArm
    1
    ;; int32 _numberObjects
    4
    ;; geometry_msgs/Vector3 _dimensions
    (send _dimensions :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Pose _pose
       (send _pose :serialize s)
     ;; float64 _distance
       (sys::poke _distance (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; bool _needsArm
       (if _needsArm (write-byte -1 s) (write-byte 0 s))
     ;; int32 _numberObjects
       (write-long _numberObjects s)
     ;; geometry_msgs/Vector3 _dimensions
       (send _dimensions :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Pose _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;; float64 _distance
     (setq _distance (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; bool _needsArm
     (setq _needsArm (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int32 _numberObjects
     (setq _numberObjects (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Vector3 _dimensions
     (send _dimensions :deserialize buf ptr-) (incf ptr- (send _dimensions :serialization-length))
   ;;
   self)
  )

(defclass propio::ProcessImage
  :super ros::object
  :slots ())

(setf (get propio::ProcessImage :md5sum-) "37b472b910195c5295b6dd8ac539437e")
(setf (get propio::ProcessImage :datatype-) "propio/ProcessImage")
(setf (get propio::ProcessImage :request) propio::ProcessImageRequest)
(setf (get propio::ProcessImage :response) propio::ProcessImageResponse)

(defmethod propio::ProcessImageRequest
  (:response () (instance propio::ProcessImageResponse :init)))

(setf (get propio::ProcessImageRequest :md5sum-) "37b472b910195c5295b6dd8ac539437e")
(setf (get propio::ProcessImageRequest :datatype-) "propio/ProcessImageRequest")
(setf (get propio::ProcessImageRequest :definition-)
      "# ProcessImage.srv
bool isFront
---
geometry_msgs/Pose pose
float64 distance
bool needsArm
int32 numberObjects
geometry_msgs/Vector3 dimensions 

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
")

(setf (get propio::ProcessImageResponse :md5sum-) "37b472b910195c5295b6dd8ac539437e")
(setf (get propio::ProcessImageResponse :datatype-) "propio/ProcessImageResponse")
(setf (get propio::ProcessImageResponse :definition-)
      "# ProcessImage.srv
bool isFront
---
geometry_msgs/Pose pose
float64 distance
bool needsArm
int32 numberObjects
geometry_msgs/Vector3 dimensions 

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
")



(provide :propio/ProcessImage "37b472b910195c5295b6dd8ac539437e")


