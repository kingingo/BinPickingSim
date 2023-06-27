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
  :slots (_points _scaling _start_z _rating _showMarker ))

(defmethod gz_ray_label_plugin::LabelPoints
  (:init
   (&key
    ((:points __points) (let (r) (dotimes (i 0) (push (instance gz_ray_label_plugin::LabelPoint :init) r)) r))
    ((:scaling __scaling) 0.0)
    ((:start_z __start_z) 0.0)
    ((:rating __rating) 0)
    ((:showMarker __showMarker) nil)
    )
   (send-super :init)
   (setq _points __points)
   (setq _scaling (float __scaling))
   (setq _start_z (float __start_z))
   (setq _rating (round __rating))
   (setq _showMarker __showMarker)
   self)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:scaling
   (&optional __scaling)
   (if __scaling (setq _scaling __scaling)) _scaling)
  (:start_z
   (&optional __start_z)
   (if __start_z (setq _start_z __start_z)) _start_z)
  (:rating
   (&optional __rating)
   (if __rating (setq _rating __rating)) _rating)
  (:showMarker
   (&optional __showMarker)
   (if __showMarker (setq _showMarker __showMarker)) _showMarker)
  (:serialization-length
   ()
   (+
    ;; gz_ray_label_plugin/LabelPoint[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ;; float32 _scaling
    4
    ;; float32 _start_z
    4
    ;; int32 _rating
    4
    ;; bool _showMarker
    1
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
     ;; float32 _scaling
       (sys::poke _scaling (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _start_z
       (sys::poke _start_z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _rating
       (write-long _rating s)
     ;; bool _showMarker
       (if _showMarker (write-byte -1 s) (write-byte 0 s))
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
   ;; float32 _scaling
     (setq _scaling (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _start_z
     (setq _start_z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _rating
     (setq _rating (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _showMarker
     (setq _showMarker (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get gz_ray_label_plugin::LabelPoints :md5sum-) "d9b71de3dcafd53b25491b7d106c121a")
(setf (get gz_ray_label_plugin::LabelPoints :datatype-) "gz_ray_label_plugin/LabelPoints")
(setf (get gz_ray_label_plugin::LabelPoints :definition-)
      "LabelPoint[] points
float32 scaling 
float32 start_z 
int32 rating 
bool showMarker 
================================================================================
MSG: gz_ray_label_plugin/LabelPoint
float32 x
float32 y
float32 z
int32 index
float64 dist
string entityName
")



(provide :gz_ray_label_plugin/LabelPoints "d9b71de3dcafd53b25491b7d106c121a")


