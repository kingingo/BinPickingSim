; Auto-generated. Do not edit!


(cl:in-package contact_republisher-msg)


;//! \htmlinclude contacts_msg.msg.html

(cl:defclass <contacts_msg> (roslisp-msg-protocol:ros-message)
  ((contacts
    :reader contacts
    :initarg :contacts
    :type (cl:vector contact_republisher-msg:contact_msg)
   :initform (cl:make-array 0 :element-type 'contact_republisher-msg:contact_msg :initial-element (cl:make-instance 'contact_republisher-msg:contact_msg))))
)

(cl:defclass contacts_msg (<contacts_msg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <contacts_msg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'contacts_msg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name contact_republisher-msg:<contacts_msg> is deprecated: use contact_republisher-msg:contacts_msg instead.")))

(cl:ensure-generic-function 'contacts-val :lambda-list '(m))
(cl:defmethod contacts-val ((m <contacts_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader contact_republisher-msg:contacts-val is deprecated.  Use contact_republisher-msg:contacts instead.")
  (contacts m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <contacts_msg>) ostream)
  "Serializes a message object of type '<contacts_msg>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'contacts))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'contacts))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <contacts_msg>) istream)
  "Deserializes a message object of type '<contacts_msg>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'contacts) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'contacts)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'contact_republisher-msg:contact_msg))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<contacts_msg>)))
  "Returns string type for a message object of type '<contacts_msg>"
  "contact_republisher/contacts_msg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'contacts_msg)))
  "Returns string type for a message object of type 'contacts_msg"
  "contact_republisher/contacts_msg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<contacts_msg>)))
  "Returns md5sum for a message object of type '<contacts_msg>"
  "86961c1410790d81e56871bf92da4561")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'contacts_msg)))
  "Returns md5sum for a message object of type 'contacts_msg"
  "86961c1410790d81e56871bf92da4561")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<contacts_msg>)))
  "Returns full string definition for message of type '<contacts_msg>"
  (cl:format cl:nil "contact_msg[] contacts~%================================================================================~%MSG: contact_republisher/contact_msg~%string collision_1~%string collision_2~%float32[3] normal~%float32[3] position~%float32 depth~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'contacts_msg)))
  "Returns full string definition for message of type 'contacts_msg"
  (cl:format cl:nil "contact_msg[] contacts~%================================================================================~%MSG: contact_republisher/contact_msg~%string collision_1~%string collision_2~%float32[3] normal~%float32[3] position~%float32 depth~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <contacts_msg>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'contacts) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <contacts_msg>))
  "Converts a ROS message object to a list"
  (cl:list 'contacts_msg
    (cl:cons ':contacts (contacts msg))
))
