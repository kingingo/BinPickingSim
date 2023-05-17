;; Auto-generated. Do not edit!


(when (boundp 'contact_republisher::contact_msg)
  (if (not (find-package "CONTACT_REPUBLISHER"))
    (make-package "CONTACT_REPUBLISHER"))
  (shadow 'contact_msg (find-package "CONTACT_REPUBLISHER")))
(unless (find-package "CONTACT_REPUBLISHER::CONTACT_MSG")
  (make-package "CONTACT_REPUBLISHER::CONTACT_MSG"))

(in-package "ROS")
;;//! \htmlinclude contact_msg.msg.html


(defclass contact_republisher::contact_msg
  :super ros::object
  :slots (_collision_1 _collision_2 _normal _position _depth ))

(defmethod contact_republisher::contact_msg
  (:init
   (&key
    ((:collision_1 __collision_1) "")
    ((:collision_2 __collision_2) "")
    ((:normal __normal) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:position __position) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:depth __depth) 0.0)
    )
   (send-super :init)
   (setq _collision_1 (string __collision_1))
   (setq _collision_2 (string __collision_2))
   (setq _normal __normal)
   (setq _position __position)
   (setq _depth (float __depth))
   self)
  (:collision_1
   (&optional __collision_1)
   (if __collision_1 (setq _collision_1 __collision_1)) _collision_1)
  (:collision_2
   (&optional __collision_2)
   (if __collision_2 (setq _collision_2 __collision_2)) _collision_2)
  (:normal
   (&optional __normal)
   (if __normal (setq _normal __normal)) _normal)
  (:position
   (&optional __position)
   (if __position (setq _position __position)) _position)
  (:depth
   (&optional __depth)
   (if __depth (setq _depth __depth)) _depth)
  (:serialization-length
   ()
   (+
    ;; string _collision_1
    4 (length _collision_1)
    ;; string _collision_2
    4 (length _collision_2)
    ;; float32[3] _normal
    (* 4    3)
    ;; float32[3] _position
    (* 4    3)
    ;; float32 _depth
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _collision_1
       (write-long (length _collision_1) s) (princ _collision_1 s)
     ;; string _collision_2
       (write-long (length _collision_2) s) (princ _collision_2 s)
     ;; float32[3] _normal
     (dotimes (i 3)
       (sys::poke (elt _normal i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _position
     (dotimes (i 3)
       (sys::poke (elt _position i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _depth
       (sys::poke _depth (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _collision_1
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _collision_1 (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _collision_2
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _collision_2 (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32[3] _normal
   (dotimes (i (length _normal))
     (setf (elt _normal i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _position
   (dotimes (i (length _position))
     (setf (elt _position i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32 _depth
     (setq _depth (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get contact_republisher::contact_msg :md5sum-) "49e516f92ecaa35a5d84ba7de7d39aa2")
(setf (get contact_republisher::contact_msg :datatype-) "contact_republisher/contact_msg")
(setf (get contact_republisher::contact_msg :definition-)
      "string collision_1
string collision_2
float32[3] normal
float32[3] position
float32 depth
")



(provide :contact_republisher/contact_msg "49e516f92ecaa35a5d84ba7de7d39aa2")


