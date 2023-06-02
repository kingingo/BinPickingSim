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
  :slots (_points ))

(defmethod gz_ray_label_plugin::LabelPoints
  (:init
   (&key
    ((:points __points) (let (r) (dotimes (i 0) (push (instance gz_ray_label_plugin::LabelPoint :init) r)) r))
    )
   (send-super :init)
   (setq _points __points)
   self)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:serialization-length
   ()
   (+
    ;; gz_ray_label_plugin/LabelPoint[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
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
   ;;
   self)
  )

(setf (get gz_ray_label_plugin::LabelPoints :md5sum-) "a2a82d81b27b9b480fb075f2d96f64cd")
(setf (get gz_ray_label_plugin::LabelPoints :datatype-) "gz_ray_label_plugin/LabelPoints")
(setf (get gz_ray_label_plugin::LabelPoints :definition-)
      "LabelPoint[] points
================================================================================
MSG: gz_ray_label_plugin/LabelPoint
float32 x
float32 y
float32 z
string entityName
")



(provide :gz_ray_label_plugin/LabelPoints "a2a82d81b27b9b480fb075f2d96f64cd")


