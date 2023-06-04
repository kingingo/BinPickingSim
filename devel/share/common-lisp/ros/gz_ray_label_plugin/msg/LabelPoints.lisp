; Auto-generated. Do not edit!


(cl:in-package gz_ray_label_plugin-msg)


;//! \htmlinclude LabelPoints.msg.html

(cl:defclass <LabelPoints> (roslisp-msg-protocol:ros-message)
  ((points
    :reader points
    :initarg :points
    :type (cl:vector gz_ray_label_plugin-msg:LabelPoint)
   :initform (cl:make-array 0 :element-type 'gz_ray_label_plugin-msg:LabelPoint :initial-element (cl:make-instance 'gz_ray_label_plugin-msg:LabelPoint))))
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
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LabelPoints>) ostream)
  "Serializes a message object of type '<LabelPoints>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'points))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'points))
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
  "9238b1dd4884b2c9c5ea319c5eeba180")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LabelPoints)))
  "Returns md5sum for a message object of type 'LabelPoints"
  "9238b1dd4884b2c9c5ea319c5eeba180")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LabelPoints>)))
  "Returns full string definition for message of type '<LabelPoints>"
  (cl:format cl:nil "LabelPoint[] points~%================================================================================~%MSG: gz_ray_label_plugin/LabelPoint~%float32 x~%float32 y~%float32 z~%int32 index~%float64 dist~%string entityName~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LabelPoints)))
  "Returns full string definition for message of type 'LabelPoints"
  (cl:format cl:nil "LabelPoint[] points~%================================================================================~%MSG: gz_ray_label_plugin/LabelPoint~%float32 x~%float32 y~%float32 z~%int32 index~%float64 dist~%string entityName~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LabelPoints>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LabelPoints>))
  "Converts a ROS message object to a list"
  (cl:list 'LabelPoints
    (cl:cons ':points (points msg))
))
