;; Auto-generated. Do not edit!


(when (boundp 'binpacking::LabelPoint)
  (if (not (find-package "BINPACKING"))
    (make-package "BINPACKING"))
  (shadow 'LabelPoint (find-package "BINPACKING")))
(unless (find-package "BINPACKING::LABELPOINT")
  (make-package "BINPACKING::LABELPOINT"))

(in-package "ROS")
;;//! \htmlinclude LabelPoint.msg.html


(defclass binpacking::LabelPoint
  :super ros::object
  :slots (_x _y _z _entityName ))

(defmethod binpacking::LabelPoint
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:z __z) 0.0)
    ((:entityName __entityName) "")
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _z (float __z))
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
   ;; string _entityName
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _entityName (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get binpacking::LabelPoint :md5sum-) "cb95b748ab6551f3b8cd89d3a8c541fc")
(setf (get binpacking::LabelPoint :datatype-) "binpacking/LabelPoint")
(setf (get binpacking::LabelPoint :definition-)
      "float32 x
float32 y
float32 z
string entityName
")



(provide :binpacking/LabelPoint "cb95b748ab6551f3b8cd89d3a8c541fc")


