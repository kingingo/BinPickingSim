;; Auto-generated. Do not edit!


(when (boundp 'gz_ray_label_plugin::LabelPoint)
  (if (not (find-package "GZ_RAY_LABEL_PLUGIN"))
    (make-package "GZ_RAY_LABEL_PLUGIN"))
  (shadow 'LabelPoint (find-package "GZ_RAY_LABEL_PLUGIN")))
(unless (find-package "GZ_RAY_LABEL_PLUGIN::LABELPOINT")
  (make-package "GZ_RAY_LABEL_PLUGIN::LABELPOINT"))

(in-package "ROS")
;;//! \htmlinclude LabelPoint.msg.html


(defclass gz_ray_label_plugin::LabelPoint
  :super ros::object
  :slots (_x _y _z _index _dist _entityName ))

(defmethod gz_ray_label_plugin::LabelPoint
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:z __z) 0.0)
    ((:index __index) 0)
    ((:dist __dist) 0.0)
    ((:entityName __entityName) "")
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _z (float __z))
   (setq _index (round __index))
   (setq _dist (float __dist))
   (setq _entityName (string __entityName))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:z
   (&optional __z)
   (if __z (setq _z __z)) _z)
  (:index
   (&optional __index)
   (if __index (setq _index __index)) _index)
  (:dist
   (&optional __dist)
   (if __dist (setq _dist __dist)) _dist)
  (:entityName
   (&optional __entityName)
   (if __entityName (setq _entityName __entityName)) _entityName)
  (:serialization-length
   ()
   (+
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _z
    4
    ;; int32 _index
    4
    ;; float64 _dist
    8
    ;; string _entityName
    4 (length _entityName)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _z
       (sys::poke _z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _index
       (write-long _index s)
     ;; float64 _dist
       (sys::poke _dist (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string _entityName
       (write-long (length _entityName) s) (princ _entityName s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _z
     (setq _z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _index
     (setq _index (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _dist
     (setq _dist (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string _entityName
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _entityName (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get gz_ray_label_plugin::LabelPoint :md5sum-) "783017e7320afc18fa76fea37e80ac42")
(setf (get gz_ray_label_plugin::LabelPoint :datatype-) "gz_ray_label_plugin/LabelPoint")
(setf (get gz_ray_label_plugin::LabelPoint :definition-)
      "float32 x
float32 y
float32 z
int32 index
float64 dist
string entityName
")



(provide :gz_ray_label_plugin/LabelPoint "783017e7320afc18fa76fea37e80ac42")


