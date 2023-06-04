;; Auto-generated. Do not edit!


(when (boundp 'gz_ray_label_plugin::LabelPoints)
  (if (not (find-package "GZ_RAY_LABEL_PLUGIN"))
    (make-package "GZ_RAY_LABEL_PLUGIN"))
  (shadow 'LabelPoints (find-package "GZ_RAY_LABEL_PLUGIN")))
(unless (find-package "GZ_RAY_LABEL_PLUGIN::LABELPOINTS")
  (make-package "GZ_RAY_LABEL_PLUGIN::LABELPOINTS"))

(in-package "ROS")
;;//! \htmlinclude LabelPoints.msg.html


(defclass gz_ray_label_plugin::LabelPoints
  :super ros::object
  :slots (_points _px _py _pz _dx _dy _dz ))

(defmethod gz_ray_label_plugin::LabelPoints
  (:init
   (&key
    ((:points __points) (let (r) (dotimes (i 0) (push (instance gz_ray_label_plugin::LabelPoint :init) r)) r))
    ((:px __px) 0.0)
    ((:py __py) 0.0)
    ((:pz __pz) 0.0)
    ((:dx __dx) 0.0)
    ((:dy __dy) 0.0)
    ((:dz __dz) 0.0)
    )
   (send-super :init)
   (setq _points __points)
   (setq _px (float __px))
   (setq _py (float __py))
   (setq _pz (float __pz))
   (setq _dx (float __dx))
   (setq _dy (float __dy))
   (setq _dz (float __dz))
   self)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:px
   (&optional __px)
   (if __px (setq _px __px)) _px)
  (:py
   (&optional __py)
   (if __py (setq _py __py)) _py)
  (:pz
   (&optional __pz)
   (if __pz (setq _pz __pz)) _pz)
  (:dx
   (&optional __dx)
   (if __dx (setq _dx __dx)) _dx)
  (:dy
   (&optional __dy)
   (if __dy (setq _dy __dy)) _dy)
  (:dz
   (&optional __dz)
   (if __dz (setq _dz __dz)) _dz)
  (:serialization-length
   ()
   (+
    ;; gz_ray_label_plugin/LabelPoint[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ;; float32 _px
    4
    ;; float32 _py
    4
    ;; float32 _pz
    4
    ;; float32 _dx
    4
    ;; float32 _dy
    4
    ;; float32 _dz
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; gz_ray_label_plugin/LabelPoint[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;; float32 _px
       (sys::poke _px (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _py
       (sys::poke _py (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pz
       (sys::poke _pz (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dx
       (sys::poke _dx (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dy
       (sys::poke _dy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _dz
       (sys::poke _dz (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; gz_ray_label_plugin/LabelPoint[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance gz_ray_label_plugin::LabelPoint :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; float32 _px
     (setq _px (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _py
     (setq _py (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pz
     (setq _pz (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dx
     (setq _dx (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dy
     (setq _dy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _dz
     (setq _dz (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get gz_ray_label_plugin::LabelPoints :md5sum-) "2ded0ab792e6fc382d669b9d328e650f")
(setf (get gz_ray_label_plugin::LabelPoints :datatype-) "gz_ray_label_plugin/LabelPoints")
(setf (get gz_ray_label_plugin::LabelPoints :definition-)
      "LabelPoint[] points
float32 px
float32 py
float32 pz
float32 dx
float32 dy
float32 dz
================================================================================
MSG: gz_ray_label_plugin/LabelPoint
float32 x
float32 y
float32 z
int32 index
float64 dist
string entityName
")



(provide :gz_ray_label_plugin/LabelPoints "2ded0ab792e6fc382d669b9d328e650f")


