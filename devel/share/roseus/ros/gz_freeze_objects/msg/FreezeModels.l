;; Auto-generated. Do not edit!


(when (boundp 'gz_freeze_objects::FreezeModels)
  (if (not (find-package "GZ_FREEZE_OBJECTS"))
    (make-package "GZ_FREEZE_OBJECTS"))
  (shadow 'FreezeModels (find-package "GZ_FREEZE_OBJECTS")))
(unless (find-package "GZ_FREEZE_OBJECTS::FREEZEMODELS")
  (make-package "GZ_FREEZE_OBJECTS::FREEZEMODELS"))

(in-package "ROS")
;;//! \htmlinclude FreezeModels.msg.html


(defclass gz_freeze_objects::FreezeModels
  :super ros::object
  :slots (_freeze _models ))

(defmethod gz_freeze_objects::FreezeModels
  (:init
   (&key
    ((:freeze __freeze) nil)
    ((:models __models) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _freeze __freeze)
   (setq _models __models)
   self)
  (:freeze
   (&optional __freeze)
   (if __freeze (setq _freeze __freeze)) _freeze)
  (:models
   (&optional __models)
   (if __models (setq _models __models)) _models)
  (:serialization-length
   ()
   (+
    ;; bool _freeze
    1
    ;; string[] _models
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _models)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _freeze
       (if _freeze (write-byte -1 s) (write-byte 0 s))
     ;; string[] _models
     (write-long (length _models) s)
     (dolist (elem _models)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _freeze
     (setq _freeze (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string[] _models
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _models (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _models i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(setf (get gz_freeze_objects::FreezeModels :md5sum-) "dd3c2b51be5bf4747de89ce8cafd1599")
(setf (get gz_freeze_objects::FreezeModels :datatype-) "gz_freeze_objects/FreezeModels")
(setf (get gz_freeze_objects::FreezeModels :definition-)
      "bool freeze
string[] models
")



(provide :gz_freeze_objects/FreezeModels "dd3c2b51be5bf4747de89ce8cafd1599")


