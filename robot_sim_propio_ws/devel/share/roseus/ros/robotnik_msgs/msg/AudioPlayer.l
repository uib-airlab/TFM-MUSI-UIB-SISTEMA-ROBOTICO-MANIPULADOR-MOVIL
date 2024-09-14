;; Auto-generated. Do not edit!


(when (boundp 'robotnik_msgs::AudioPlayer)
  (if (not (find-package "ROBOTNIK_MSGS"))
    (make-package "ROBOTNIK_MSGS"))
  (shadow 'AudioPlayer (find-package "ROBOTNIK_MSGS")))
(unless (find-package "ROBOTNIK_MSGS::AUDIOPLAYER")
  (make-package "ROBOTNIK_MSGS::AUDIOPLAYER"))

(in-package "ROS")
;;//! \htmlinclude AudioPlayer.msg.html


(defclass robotnik_msgs::AudioPlayer
  :super ros::object
  :slots (_elapsed_time _total_time _name _is_playing ))

(defmethod robotnik_msgs::AudioPlayer
  (:init
   (&key
    ((:elapsed_time __elapsed_time) 0.0)
    ((:total_time __total_time) 0.0)
    ((:name __name) "")
    ((:is_playing __is_playing) nil)
    )
   (send-super :init)
   (setq _elapsed_time (float __elapsed_time))
   (setq _total_time (float __total_time))
   (setq _name (string __name))
   (setq _is_playing __is_playing)
   self)
  (:elapsed_time
   (&optional __elapsed_time)
   (if __elapsed_time (setq _elapsed_time __elapsed_time)) _elapsed_time)
  (:total_time
   (&optional __total_time)
   (if __total_time (setq _total_time __total_time)) _total_time)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:is_playing
   (&optional (__is_playing :null))
   (if (not (eq __is_playing :null)) (setq _is_playing __is_playing)) _is_playing)
  (:serialization-length
   ()
   (+
    ;; float32 _elapsed_time
    4
    ;; float32 _total_time
    4
    ;; string _name
    4 (length _name)
    ;; bool _is_playing
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _elapsed_time
       (sys::poke _elapsed_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _total_time
       (sys::poke _total_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; bool _is_playing
       (if _is_playing (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _elapsed_time
     (setq _elapsed_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _total_time
     (setq _total_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _is_playing
     (setq _is_playing (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get robotnik_msgs::AudioPlayer :md5sum-) "e2121538143cf0a41ccf4c74bc5d25ca")
(setf (get robotnik_msgs::AudioPlayer :datatype-) "robotnik_msgs/AudioPlayer")
(setf (get robotnik_msgs::AudioPlayer :definition-)
      "float32 elapsed_time
float32 total_time
string name
bool is_playing
")



(provide :robotnik_msgs/AudioPlayer "e2121538143cf0a41ccf4c74bc5d25ca")


