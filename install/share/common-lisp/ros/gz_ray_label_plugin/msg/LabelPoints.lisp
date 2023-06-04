; Auto-generated. Do not edit!


(cl:in-package gz_ray_label_plugin-msg)


;//! \htmlinclude LabelPoints.msg.html

(cl:defclass <LabelPoints> (roslisp-msg-protocol:ros-message)
  ((points
    :reader points
    :initarg :points
    :type (cl:vector gz_ray_label_plugin-msg:LabelPoint)
   :initform (cl:make-array 0 :element-type 'gz_ray_label_plugin-msg:LabelPoint :initial-element (cl:make-instance 'gz_ray_label_plugin-msg:LabelPoint)))
   (px
    :reader px
    :initarg :px
    :type cl:float
    :initform 0.0)
   (py
    :reader py
    :initarg :py
    :type cl:float
    :initform 0.0)
   (pz
    :reader pz
    :initarg :pz
    :type cl:float
    :initform 0.0)
   (dx
    :reader dx
    :initarg :dx
    :type cl:float
    :initform 0.0)
   (dy
    :reader dy
    :initarg :dy
    :type cl:float
    :initform 0.0)
   (dz
    :reader dz
    :initarg :dz
    :type cl:float
    :initform 0.0))
)

(cl:defclass LabelPoints (<LabelPoints>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LabelPoints>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LabelPoints)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gz_ray_label_plugin-msg:<LabelPoints> is deprecated: use gz_ray_label_plugin-msg:LabelPoints instead.")))

(cl:ensure-generic-function 'points-val :lambda-list '(m))
(cl:defmethod points-val ((m <LabelPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:points-val is deprecated.  Use gz_ray_label_plugin-msg:points instead.")
  (points m))

(cl:ensure-generic-function 'px-val :lambda-list '(m))
(cl:defmethod px-val ((m <LabelPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:px-val is deprecated.  Use gz_ray_label_plugin-msg:px instead.")
  (px m))

(cl:ensure-generic-function 'py-val :lambda-list '(m))
(cl:defmethod py-val ((m <LabelPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:py-val is deprecated.  Use gz_ray_label_plugin-msg:py instead.")
  (py m))

(cl:ensure-generic-function 'pz-val :lambda-list '(m))
(cl:defmethod pz-val ((m <LabelPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:pz-val is deprecated.  Use gz_ray_label_plugin-msg:pz instead.")
  (pz m))

(cl:ensure-generic-function 'dx-val :lambda-list '(m))
(cl:defmethod dx-val ((m <LabelPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:dx-val is deprecated.  Use gz_ray_label_plugin-msg:dx instead.")
  (dx m))

(cl:ensure-generic-function 'dy-val :lambda-list '(m))
(cl:defmethod dy-val ((m <LabelPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:dy-val is deprecated.  Use gz_ray_label_plugin-msg:dy instead.")
  (dy m))

(cl:ensure-generic-function 'dz-val :lambda-list '(m))
(cl:defmethod dz-val ((m <LabelPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:dz-val is deprecated.  Use gz_ray_label_plugin-msg:dz instead.")
  (dz m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LabelPoints>) ostream)
  "Serializes a message object of type '<LabelPoints>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'points))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'points))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'px))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'py))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pz))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dx))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dy))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'dz))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LabelPoints>) istream)
  "Deserializes a message object of type '<LabelPoints>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'points) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'points)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'gz_ray_label_plugin-msg:LabelPoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'px) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'py) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pz) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dx) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dy) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'dz) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LabelPoints>)))
  "Returns string type for a message object of type '<LabelPoints>"
  "gz_ray_label_plugin/LabelPoints")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LabelPoints)))
  "Returns string type for a message object of type 'LabelPoints"
  "gz_ray_label_plugin/LabelPoints")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LabelPoints>)))
  "Returns md5sum for a message object of type '<LabelPoints>"
  "2ded0ab792e6fc382d669b9d328e650f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LabelPoints)))
  "Returns md5sum for a message object of type 'LabelPoints"
  "2ded0ab792e6fc382d669b9d328e650f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LabelPoints>)))
  "Returns full string definition for message of type '<LabelPoints>"
  (cl:format cl:nil "LabelPoint[] points~%float32 px~%float32 py~%float32 pz~%float32 dx~%float32 dy~%float32 dz~%================================================================================~%MSG: gz_ray_label_plugin/LabelPoint~%float32 x~%float32 y~%float32 z~%int32 index~%float64 dist~%string entityName~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LabelPoints)))
  "Returns full string definition for message of type 'LabelPoints"
  (cl:format cl:nil "LabelPoint[] points~%float32 px~%float32 py~%float32 pz~%float32 dx~%float32 dy~%float32 dz~%================================================================================~%MSG: gz_ray_label_plugin/LabelPoint~%float32 x~%float32 y~%float32 z~%int32 index~%float64 dist~%string entityName~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LabelPoints>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LabelPoints>))
  "Converts a ROS message object to a list"
  (cl:list 'LabelPoints
    (cl:cons ':points (points msg))
    (cl:cons ':px (px msg))
    (cl:cons ':py (py msg))
    (cl:cons ':pz (pz msg))
    (cl:cons ':dx (dx msg))
    (cl:cons ':dy (dy msg))
    (cl:cons ':dz (dz msg))
))
