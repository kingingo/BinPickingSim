;; Auto-generated. Do not edit!


(when (boundp 'contact_republisher::contacts_msg)
  (if (not (find-package "CONTACT_REPUBLISHER"))
    (make-package "CONTACT_REPUBLISHER"))
  (shadow 'contacts_msg (find-package "CONTACT_REPUBLISHER")))
(unless (find-package "CONTACT_REPUBLISHER::CONTACTS_MSG")
  (make-package "CONTACT_REPUBLISHER::CONTACTS_MSG"))

(in-package "ROS")
;;//! \htmlinclude contacts_msg.msg.html


(defclass contact_republisher::contacts_msg
  :super ros::object
  :slots (_contacts ))

(defmethod contact_republisher::contacts_msg
  (:init
   (&key
    ((:contacts __contacts) (let (r) (dotimes (i 0) (push (instance contact_republisher::contact_msg :init) r)) r))
    )
   (send-super :init)
   (setq _contacts __contacts)
   self)
  (:contacts
   (&rest __contacts)
   (if (keywordp (car __contacts))
       (send* _contacts __contacts)
     (progn
       (if __contacts (setq _contacts (car __contacts)))
       _contacts)))
  (:serialization-length
   ()
   (+
    ;; contact_republisher/contact_msg[] _contacts
    (apply #'+ (send-all _contacts :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; contact_republisher/contact_msg[] _contacts
     (write-long (length _contacts) s)
     (dolist (elem _contacts)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; contact_republisher/contact_msg[] _contacts
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _contacts (let (r) (dotimes (i n) (push (instance contact_republisher::contact_msg :init) r)) r))
     (dolist (elem- _contacts)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get contact_republisher::contacts_msg :md5sum-) "86961c1410790d81e56871bf92da4561")
(setf (get contact_republisher::contacts_msg :datatype-) "contact_republisher/contacts_msg")
(setf (get contact_republisher::contacts_msg :definition-)
      "contact_msg[] contacts
================================================================================
MSG: contact_republisher/contact_msg
string collision_1
string collision_2
float32[3] normal
float32[3] position
float32 depth
")



(provide :contact_republisher/contacts_msg "86961c1410790d81e56871bf92da4561")


