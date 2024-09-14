;; Auto-generated. Do not edit!


(when (boundp 'robotnik_msgs::SimpleSystemStatus)
  (if (not (find-package "ROBOTNIK_MSGS"))
    (make-package "ROBOTNIK_MSGS"))
  (shadow 'SimpleSystemStatus (find-package "ROBOTNIK_MSGS")))
(unless (find-package "ROBOTNIK_MSGS::SIMPLESYSTEMSTATUS")
  (make-package "ROBOTNIK_MSGS::SIMPLESYSTEMSTATUS"))

(in-package "ROS")
;;//! \htmlinclude SimpleSystemStatus.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass robotnik_msgs::SimpleSystemStatus
  :super ros::object
  :slots (_disk_capacity _disk_usage _memory_capacity _memory_usage _cpu_usage _core_usage _cpu_temperature _core_temperatures _header ))

(defmethod robotnik_msgs::SimpleSystemStatus
  (:init
   (&key
    ((:disk_capacity __disk_capacity) 0.0)
    ((:disk_usage __disk_usage) 0.0)
    ((:memory_capacity __memory_capacity) 0.0)
    ((:memory_usage __memory_usage) 0.0)
    ((:cpu_usage __cpu_usage) 0.0)
    ((:core_usage __core_usage) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:cpu_temperature __cpu_temperature) 0.0)
    ((:core_temperatures __core_temperatures) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:header __header) (instance std_msgs::Header :init))
    )
   (send-super :init)
   (setq _disk_capacity (float __disk_capacity))
   (setq _disk_usage (float __disk_usage))
   (setq _memory_capacity (float __memory_capacity))
   (setq _memory_usage (float __memory_usage))
   (setq _cpu_usage (float __cpu_usage))
   (setq _core_usage __core_usage)
   (setq _cpu_temperature (float __cpu_temperature))
   (setq _core_temperatures __core_temperatures)
   (setq _header __header)
   self)
  (:disk_capacity
   (&optional __disk_capacity)
   (if __disk_capacity (setq _disk_capacity __disk_capacity)) _disk_capacity)
  (:disk_usage
   (&optional __disk_usage)
   (if __disk_usage (setq _disk_usage __disk_usage)) _disk_usage)
  (:memory_capacity
   (&optional __memory_capacity)
   (if __memory_capacity (setq _memory_capacity __memory_capacity)) _memory_capacity)
  (:memory_usage
   (&optional __memory_usage)
   (if __memory_usage (setq _memory_usage __memory_usage)) _memory_usage)
  (:cpu_usage
   (&optional __cpu_usage)
   (if __cpu_usage (setq _cpu_usage __cpu_usage)) _cpu_usage)
  (:core_usage
   (&optional __core_usage)
   (if __core_usage (setq _core_usage __core_usage)) _core_usage)
  (:cpu_temperature
   (&optional __cpu_temperature)
   (if __cpu_temperature (setq _cpu_temperature __cpu_temperature)) _cpu_temperature)
  (:core_temperatures
   (&optional __core_temperatures)
   (if __core_temperatures (setq _core_temperatures __core_temperatures)) _core_temperatures)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:serialization-length
   ()
   (+
    ;; float32 _disk_capacity
    4
    ;; float32 _disk_usage
    4
    ;; float32 _memory_capacity
    4
    ;; float32 _memory_usage
    4
    ;; float32 _cpu_usage
    4
    ;; float32[] _core_usage
    (* 4    (length _core_usage)) 4
    ;; float32 _cpu_temperature
    4
    ;; float32[] _core_temperatures
    (* 4    (length _core_temperatures)) 4
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _disk_capacity
       (sys::poke _disk_capacity (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _disk_usage
       (sys::poke _disk_usage (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _memory_capacity
       (sys::poke _memory_capacity (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _memory_usage
       (sys::poke _memory_usage (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _cpu_usage
       (sys::poke _cpu_usage (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _core_usage
     (write-long (length _core_usage) s)
     (dotimes (i (length _core_usage))
       (sys::poke (elt _core_usage i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _cpu_temperature
       (sys::poke _cpu_temperature (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _core_temperatures
     (write-long (length _core_temperatures) s)
     (dotimes (i (length _core_temperatures))
       (sys::poke (elt _core_temperatures i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _disk_capacity
     (setq _disk_capacity (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _disk_usage
     (setq _disk_usage (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _memory_capacity
     (setq _memory_capacity (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _memory_usage
     (setq _memory_usage (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _cpu_usage
     (setq _cpu_usage (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _core_usage
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _core_usage (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _core_usage i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _cpu_temperature
     (setq _cpu_temperature (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _core_temperatures
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _core_temperatures (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _core_temperatures i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;;
   self)
  )

(setf (get robotnik_msgs::SimpleSystemStatus :md5sum-) "297c535b6bb09ddac9c89e40f3d56868")
(setf (get robotnik_msgs::SimpleSystemStatus :datatype-) "robotnik_msgs/SimpleSystemStatus")
(setf (get robotnik_msgs::SimpleSystemStatus :definition-)
      "float32 disk_capacity
float32 disk_usage
float32 memory_capacity
float32 memory_usage
float32 cpu_usage
float32[] core_usage
float32 cpu_temperature
float32[] core_temperatures
Header header
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :robotnik_msgs/SimpleSystemStatus "297c535b6bb09ddac9c89e40f3d56868")


