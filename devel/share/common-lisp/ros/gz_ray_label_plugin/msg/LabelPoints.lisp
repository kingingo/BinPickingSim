; Auto-generated. Do not edit!


(cl:in-package gz_ray_label_plugin-msg)


;//! \htmlinclude LabelPoints.msg.html

(cl:defclass <LabelPoints> (roslisp-msg-protocol:ros-message)
  ((points
    :reader points
    :initarg :points
    :type (cl:vector gz_ray_label_plugin-msg:LabelPoint)
   :initform (cl:make-array 0 :element-type 'gz_ray_label_plugin-msg:LabelPoint :initial-element (cl:make-instance 'gz_ray_label_plugin-msg:LabelPoint)))
   (scaling
    :reader scaling
    :initarg :scaling
    :type cl:float
    :initform 0.0)
   (start_z
    :reader start_z
    :initarg :start_z
    :type cl:float
    :initform 0.0)
   (rating
    :reader rating
    :initarg :rating
    :type cl:integer
    :initform 0)
   (showMarker
    :reader showMarker
    :initarg :showMarker
    :type cl:boolean
    :initform cl:nil))
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

(cl:ensure-generic-function 'scaling-val :lambda-list '(m))
(cl:defmethod scaling-val ((m <LabelPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:scaling-val is deprecated.  Use gz_ray_label_plugin-msg:scaling instead.")
  (scaling m))

(cl:ensure-generic-function 'start_z-val :lambda-list '(m))
(cl:defmethod start_z-val ((m <LabelPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:start_z-val is deprecated.  Use gz_ray_label_plugin-msg:start_z instead.")
  (start_z m))

(cl:ensure-generic-function 'rating-val :lambda-list '(m))
(cl:defmethod rating-val ((m <LabelPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:rating-val is deprecated.  Use gz_ray_label_plugin-msg:rating instead.")
  (rating m))

(cl:ensure-generic-function 'showMarker-val :lambda-list '(m))
(cl:defmethod showMarker-val ((m <LabelPoints>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_ray_label_plugin-msg:showMarker-val is deprecated.  Use gz_ray_label_plugin-msg:showMarker instead.")
  (showMarker m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LabelPoints>) ostream)
  "Serializes a message object of type '<LabelPoints>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'points))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'points))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'scaling))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'start_z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'rating)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'showMarker) 1 0)) ostream)
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
    (cl:setf (cl:slot-value msg 'scaling) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'start_z) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'rating) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'showMarker) (cl:not (cl:zerop (cl:read-byte istream))))
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
  "d9b71de3dcafd53b25491b7d106c121a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LabelPoints)))
  "Returns md5sum for a message object of type 'LabelPoints"
  "d9b71de3dcafd53b25491b7d106c121a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LabelPoints>)))
  "Returns full string definition for message of type '<LabelPoints>"
  (cl:format cl:nil "LabelPoint[] points~%float32 scaling ~%float32 start_z ~%int32 rating ~%bool showMarker ~%================================================================================~%MSG: gz_ray_label_plugin/LabelPoint~%float32 x~%float32 y~%float32 z~%int32 index~%float64 dist~%string entityName~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LabelPoints)))
  "Returns full string definition for message of type 'LabelPoints"
  (cl:format cl:nil "LabelPoint[] points~%float32 scaling ~%float32 start_z ~%int32 rating ~%bool showMarker ~%================================================================================~%MSG: gz_ray_label_plugin/LabelPoint~%float32 x~%float32 y~%float32 z~%int32 index~%float64 dist~%string entityName~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LabelPoints>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LabelPoints>))
  "Converts a ROS message object to a list"
  (cl:list 'LabelPoints
    (cl:cons ':points (points msg))
    (cl:cons ':scaling (scaling msg))
    (cl:cons ':start_z (start_z msg))
    (cl:cons ':rating (rating msg))
    (cl:cons ':showMarker (showMarker msg))
))
