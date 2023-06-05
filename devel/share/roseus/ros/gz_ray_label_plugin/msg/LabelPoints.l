;; Auto-generated. Do not edit!


(when (boundp 'gz_ray_label_plugin::LabelPoints)
  (if (not (find-package "GZ_RAY_LABEL_PLUGIN"))
    (make-package "GZ_RAY_LABEL_PLUGIN"))
  (shadow 'LabelPoints (find-package "GZ_RAY_LABEL_PLUGIN")))
(unless (find-package "GZ_RAY_LABEL_PLUGIN::LABELPOINTS")
  (make-package "GZ_RAY_LABEL_PLUGIN::LABELPOINTS"))

(in-package "ROS")
;;//! \htmlinclude LabelPoints.msg.html


(intern "*SCALING*" (find-package "GZ_RAY_LABEL_PLUGIN::LABELPOINTS"))
(shadow '*SCALING* (find-package "GZ_RAY_LABEL_PLUGIN::LABELPOINTS"))
(defconstant gz_ray_label_plugin::LabelPoints::*SCALING* 0.15)
(intern "*START_Z*" (find-package "GZ_RAY_LABEL_PLUGIN::LABELPOINTS"))
(shadow '*START_Z* (find-package "GZ_RAY_LABEL_PLUGIN::LABELPOINTS"))
(defconstant gz_ray_label_plugin::LabelPoints::*START_Z* 0.5)
(intern "*RATING*" (find-package "GZ_RAY_LABEL_PLUGIN::LABELPOINTS"))
(shadow '*RATING* (find-package "GZ_RAY_LABEL_PLUGIN::LABELPOINTS"))
(defconstant gz_ray_label_plugin::LabelPoints::*RATING* 800)
(intern "*SHOWMARKER*" (find-package "GZ_RAY_LABEL_PLUGIN::LABELPOINTS"))
(shadow '*SHOWMARKER* (find-package "GZ_RAY_LABEL_PLUGIN::LABELPOINTS"))
(defconstant gz_ray_label_plugin::LabelPoints::*SHOWMARKER* nil)
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

(setf (get gz_ray_label_plugin::LabelPoints :md5sum-) "8df55850541ba2b90a87120a4b1cc925")
(setf (get gz_ray_label_plugin::LabelPoints :datatype-) "gz_ray_label_plugin/LabelPoints")
(setf (get gz_ray_label_plugin::LabelPoints :definition-)
      "LabelPoint[] points
float32 scaling = 0.15
float32 start_z = 0.5
int32 rating = 800
bool showMarker = 0
================================================================================
MSG: gz_ray_label_plugin/LabelPoint
float32 x
float32 y
float32 z
int32 index
float64 dist
string entityName
")



(provide :gz_ray_label_plugin/LabelPoints "8df55850541ba2b90a87120a4b1cc925")


