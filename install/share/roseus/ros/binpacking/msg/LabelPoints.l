;; Auto-generated. Do not edit!


(when (boundp 'binpacking::LabelPoints)
  (if (not (find-package "BINPACKING"))
    (make-package "BINPACKING"))
  (shadow 'LabelPoints (find-package "BINPACKING")))
(unless (find-package "BINPACKING::LABELPOINTS")
  (make-package "BINPACKING::LABELPOINTS"))

(in-package "ROS")
;;//! \htmlinclude LabelPoints.msg.html


(defclass binpacking::LabelPoints
  :super ros::object
  :slots (_points ))

(defmethod binpacking::LabelPoints
  (:init
   (&key
    ((:points __points) (let (r) (dotimes (i 0) (push (instance binpacking::LabelPoint :init) r)) r))
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
    ;; binpacking/LabelPoint[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; binpacking/LabelPoint[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; binpacking/LabelPoint[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance binpacking::LabelPoint :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get binpacking::LabelPoints :md5sum-) "a2a82d81b27b9b480fb075f2d96f64cd")
(setf (get binpacking::LabelPoints :datatype-) "binpacking/LabelPoints")
(setf (get binpacking::LabelPoints :definition-)
      "LabelPoint[] points
================================================================================
MSG: binpacking/LabelPoint
float32 x
float32 y
float32 z
string entityName
")



(provide :binpacking/LabelPoints "a2a82d81b27b9b480fb075f2d96f64cd")


