; Auto-generated. Do not edit!


(cl:in-package contact_republisher-msg)


;//! \htmlinclude contact_msg.msg.html

(cl:defclass <contact_msg> (roslisp-msg-protocol:ros-message)
  ((collision_1
    :reader collision_1
    :initarg :collision_1
    :type cl:string
    :initform "")
   (collision_2
    :reader collision_2
    :initarg :collision_2
    :type cl:string
    :initform "")
   (normal
    :reader normal
    :initarg :normal
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (position
    :reader position
    :initarg :position
    :type (cl:vector cl:float)
   :initform (cl:make-array 3 :element-type 'cl:float :initial-element 0.0))
   (depth
    :reader depth
    :initarg :depth
    :type cl:float
    :initform 0.0))
)

(cl:defclass contact_msg (<contact_msg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <contact_msg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'contact_msg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name contact_republisher-msg:<contact_msg> is deprecated: use contact_republisher-msg:contact_msg instead.")))

(cl:ensure-generic-function 'collision_1-val :lambda-list '(m))
(cl:defmethod collision_1-val ((m <contact_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader contact_republisher-msg:collision_1-val is deprecated.  Use contact_republisher-msg:collision_1 instead.")
  (collision_1 m))

(cl:ensure-generic-function 'collision_2-val :lambda-list '(m))
(cl:defmethod collision_2-val ((m <contact_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader contact_republisher-msg:collision_2-val is deprecated.  Use contact_republisher-msg:collision_2 instead.")
  (collision_2 m))

(cl:ensure-generic-function 'normal-val :lambda-list '(m))
(cl:defmethod normal-val ((m <contact_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader contact_republisher-msg:normal-val is deprecated.  Use contact_republisher-msg:normal instead.")
  (normal m))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <contact_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader contact_republisher-msg:position-val is deprecated.  Use contact_republisher-msg:position instead.")
  (position m))

(cl:ensure-generic-function 'depth-val :lambda-list '(m))
(cl:defmethod depth-val ((m <contact_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader contact_republisher-msg:depth-val is deprecated.  Use contact_republisher-msg:depth instead.")
  (depth m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <contact_msg>) ostream)
  "Serializes a message object of type '<contact_msg>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'collision_1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'collision_1))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'collision_2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'collision_2))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'normal))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'position))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'depth))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <contact_msg>) istream)
  "Deserializes a message object of type '<contact_msg>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'collision_1) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'collision_1) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'collision_2) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'collision_2) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:setf (cl:slot-value msg 'normal) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'normal)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
  (cl:setf (cl:slot-value msg 'position) (cl:make-array 3))
  (cl:let ((vals (cl:slot-value msg 'position)))
    (cl:dotimes (i 3)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'depth) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<contact_msg>)))
  "Returns string type for a message object of type '<contact_msg>"
  "contact_republisher/contact_msg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'contact_msg)))
  "Returns string type for a message object of type 'contact_msg"
  "contact_republisher/contact_msg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<contact_msg>)))
  "Returns md5sum for a message object of type '<contact_msg>"
  "49e516f92ecaa35a5d84ba7de7d39aa2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'contact_msg)))
  "Returns md5sum for a message object of type 'contact_msg"
  "49e516f92ecaa35a5d84ba7de7d39aa2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<contact_msg>)))
  "Returns full string definition for message of type '<contact_msg>"
  (cl:format cl:nil "string collision_1~%string collision_2~%float32[3] normal~%float32[3] position~%float32 depth~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'contact_msg)))
  "Returns full string definition for message of type 'contact_msg"
  (cl:format cl:nil "string collision_1~%string collision_2~%float32[3] normal~%float32[3] position~%float32 depth~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <contact_msg>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'collision_1))
     4 (cl:length (cl:slot-value msg 'collision_2))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'normal) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'position) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <contact_msg>))
  "Converts a ROS message object to a list"
  (cl:list 'contact_msg
    (cl:cons ':collision_1 (collision_1 msg))
    (cl:cons ':collision_2 (collision_2 msg))
    (cl:cons ':normal (normal msg))
    (cl:cons ':position (position msg))
    (cl:cons ':depth (depth msg))
))
