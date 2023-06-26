;; Auto-generated. Do not edit!


(when (boundp 'gz_dynamic_colors::DColor)
  (if (not (find-package "GZ_DYNAMIC_COLORS"))
    (make-package "GZ_DYNAMIC_COLORS"))
  (shadow 'DColor (find-package "GZ_DYNAMIC_COLORS")))
(unless (find-package "GZ_DYNAMIC_COLORS::DCOLOR")
  (make-package "GZ_DYNAMIC_COLORS::DCOLOR"))

(in-package "ROS")
;;//! \htmlinclude DColor.msg.html


(defclass gz_dynamic_colors::DColor
  :super ros::object
  :slots (_r _g _b _a ))

(defmethod gz_dynamic_colors::DColor
  (:init
   (&key
    ((:r __r) 0.0)
    ((:g __g) 0.0)
    ((:b __b) 0.0)
    ((:a __a) 0.0)
    )
   (send-super :init)
   (setq _r (float __r))
   (setq _g (float __g))
   (setq _b (float __b))
   (setq _a (float __a))
   self)
  (:r
   (&optional __r)
   (if __r (setq _r __r)) _r)
  (:g
   (&optional __g)
   (if __g (setq _g __g)) _g)
  (:b
   (&optional __b)
   (if __b (setq _b __b)) _b)
  (:a
   (&optional __a)
   (if __a (setq _a __a)) _a)
  (:serialization-length
   ()
   (+
    ;; float32 _r
    4
    ;; float32 _g
    4
    ;; float32 _b
    4
    ;; float32 _a
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _r
       (sys::poke _r (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _g
       (sys::poke _g (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _b
       (sys::poke _b (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _a
       (sys::poke _a (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _r
     (setq _r (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _g
     (setq _g (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _b
     (setq _b (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _a
     (setq _a (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get gz_dynamic_colors::DColor :md5sum-) "a29a96539573343b1310c73607334b00")
(setf (get gz_dynamic_colors::DColor :datatype-) "gz_dynamic_colors/DColor")
(setf (get gz_dynamic_colors::DColor :definition-)
      "float32 r
float32 g
float32 b
float32 a

")



(provide :gz_dynamic_colors/DColor "a29a96539573343b1310c73607334b00")


