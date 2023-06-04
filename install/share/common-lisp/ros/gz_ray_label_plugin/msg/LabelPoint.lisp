; Auto-generated. Do not edit!


(cl:in-package gz_ray_label_plugin-msg)


;//! \htmlinclude LabelPoint.msg.html

(cl:defclass <LabelPoint> (roslisp-msg-protocol:ros-message)
  ((x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (z
    :reader z
    :initarg :z
    :type cl:float
    :initform 0.0)
   (index
    :reader index
    :initarg :index
    :type cl:integer
    :initform 0)
   (dist
    :reader dist
    :initarg :dist
    :type cl:float
    :initform 0.0)
   (entityName
    :reader entityName
    :initarg :entityName
    :type cl:string
    :initform ""))
)

(cl:defclass LabelPoint (<LabelPoint>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LabelPoint>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LabelPoint)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gz_ray_label_plugin-msg:<LabelPoint> is deprecated: use gz_ray_label_plugin-msg:LabelPoint instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <LabelPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:x-val is deprecated.  Use gz_ray_label_plugin-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <LabelPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:y-val is deprecated.  Use gz_ray_label_plugin-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'z-val :lambda-list '(m))
(cl:defmethod z-val ((m <LabelPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:z-val is deprecated.  Use gz_ray_label_plugin-msg:z instead.")
  (z m))

(cl:ensure-generic-function 'index-val :lambda-list '(m))
(cl:defmethod index-val ((m <LabelPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:index-val is deprecated.  Use gz_ray_label_plugin-msg:index instead.")
  (index m))

(cl:ensure-generic-function 'dist-val :lambda-list '(m))
(cl:defmethod dist-val ((m <LabelPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:dist-val is deprecated.  Use gz_ray_label_plugin-msg:dist instead.")
  (dist m))

(cl:ensure-generic-function 'entityName-val :lambda-list '(m))
(cl:defmethod entityName-val ((m <LabelPoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:entityName-val is deprecated.  Use gz_ray_label_plugin-msg:entityName instead.")
  (entityName m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LabelPoint>) ostream)
  "Serializes a message object of type '<LabelPoint>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'index)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'dist))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'entityName))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'entityName))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LabelPoint>) istream)
  "Deserializes a message object of type '<LabelPoint>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'z) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'index) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dist) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'entityName) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'entityName) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LabelPoint>)))
  "Returns string type for a message object of type '<LabelPoint>"
  "gz_ray_label_plugin/LabelPoint")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LabelPoint)))
  "Returns string type for a message object of type 'LabelPoint"
  "gz_ray_label_plugin/LabelPoint")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LabelPoint>)))
  "Returns md5sum for a message object of type '<LabelPoint>"
  "783017e7320afc18fa76fea37e80ac42")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LabelPoint)))
  "Returns md5sum for a message object of type 'LabelPoint"
  "783017e7320afc18fa76fea37e80ac42")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LabelPoint>)))
  "Returns full string definition for message of type '<LabelPoint>"
  (cl:format cl:nil "float32 x~%float32 y~%float32 z~%int32 index~%float64 dist~%string entityName~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LabelPoint)))
  "Returns full string definition for message of type 'LabelPoint"
  (cl:format cl:nil "float32 x~%float32 y~%float32 z~%int32 index~%float64 dist~%string entityName~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LabelPoint>))
  (cl:+ 0
     4
     4
     4
     4
     8
     4 (cl:length (cl:slot-value msg 'entityName))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LabelPoint>))
  "Converts a ROS message object to a list"
  (cl:list 'LabelPoint
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':z (z msg))
    (cl:cons ':index (index msg))
    (cl:cons ':dist (dist msg))
    (cl:cons ':entityName (entityName msg))
))
