; Auto-generated. Do not edit!


(cl:in-package gz_dynamic_colors-msg)


;//! \htmlinclude DColor.msg.html

(cl:defclass <DColor> (roslisp-msg-protocol:ros-message)
  ((r
    :reader r
    :initarg :r
    :type cl:float
    :initform 0.0)
   (g
    :reader g
    :initarg :g
    :type cl:float
    :initform 0.0)
   (b
    :reader b
    :initarg :b
    :type cl:float
    :initform 0.0)
   (a
    :reader a
    :initarg :a
    :type cl:float
    :initform 0.0))
)

(cl:defclass DColor (<DColor>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DColor>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DColor)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gz_dynamic_colors-msg:<DColor> is deprecated: use gz_dynamic_colors-msg:DColor instead.")))

(cl:ensure-generic-function 'r-val :lambda-list '(m))
(cl:defmethod r-val ((m <DColor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_dynamic_colors-msg:r-val is deprecated.  Use gz_dynamic_colors-msg:r instead.")
  (r m))

(cl:ensure-generic-function 'g-val :lambda-list '(m))
(cl:defmethod g-val ((m <DColor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_dynamic_colors-msg:g-val is deprecated.  Use gz_dynamic_colors-msg:g instead.")
  (g m))

(cl:ensure-generic-function 'b-val :lambda-list '(m))
(cl:defmethod b-val ((m <DColor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_dynamic_colors-msg:b-val is deprecated.  Use gz_dynamic_colors-msg:b instead.")
  (b m))

(cl:ensure-generic-function 'a-val :lambda-list '(m))
(cl:defmethod a-val ((m <DColor>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_dynamic_colors-msg:a-val is deprecated.  Use gz_dynamic_colors-msg:a instead.")
  (a m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DColor>) ostream)
  "Serializes a message object of type '<DColor>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'r))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'g))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'b))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'a))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DColor>) istream)
  "Deserializes a message object of type '<DColor>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'r) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'g) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'b) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'a) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DColor>)))
  "Returns string type for a message object of type '<DColor>"
  "gz_dynamic_colors/DColor")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DColor)))
  "Returns string type for a message object of type 'DColor"
  "gz_dynamic_colors/DColor")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DColor>)))
  "Returns md5sum for a message object of type '<DColor>"
  "a29a96539573343b1310c73607334b00")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DColor)))
  "Returns md5sum for a message object of type 'DColor"
  "a29a96539573343b1310c73607334b00")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DColor>)))
  "Returns full string definition for message of type '<DColor>"
  (cl:format cl:nil "float32 r~%float32 g~%float32 b~%float32 a~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DColor)))
  "Returns full string definition for message of type 'DColor"
  (cl:format cl:nil "float32 r~%float32 g~%float32 b~%float32 a~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DColor>))
  (cl:+ 0
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DColor>))
  "Converts a ROS message object to a list"
  (cl:list 'DColor
    (cl:cons ':r (r msg))
    (cl:cons ':g (g msg))
    (cl:cons ':b (b msg))
    (cl:cons ':a (a msg))
))
