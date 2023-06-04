; Auto-generated. Do not edit!


(cl:in-package gz_freeze_objects-msg)


;//! \htmlinclude FreezeModels.msg.html

(cl:defclass <FreezeModels> (roslisp-msg-protocol:ros-message)
  ((freeze
    :reader freeze
    :initarg :freeze
    :type cl:boolean
    :initform cl:nil)
   (models
    :reader models
    :initarg :models
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass FreezeModels (<FreezeModels>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <FreezeModels>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'FreezeModels)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name gz_freeze_objects-msg:<FreezeModels> is deprecated: use gz_freeze_objects-msg:FreezeModels instead.")))

(cl:ensure-generic-function 'freeze-val :lambda-list '(m))
(cl:defmethod freeze-val ((m <FreezeModels>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_freeze_objects-msg:freeze-val is deprecated.  Use gz_freeze_objects-msg:freeze instead.")
  (freeze m))

(cl:ensure-generic-function 'models-val :lambda-list '(m))
(cl:defmethod models-val ((m <FreezeModels>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader gz_freeze_objects-msg:models-val is deprecated.  Use gz_freeze_objects-msg:models instead.")
  (models m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <FreezeModels>) ostream)
  "Serializes a message object of type '<FreezeModels>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'freeze) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'models))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'models))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <FreezeModels>) istream)
  "Deserializes a message object of type '<FreezeModels>"
    (cl:setf (cl:slot-value msg 'freeze) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'models) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'models)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<FreezeModels>)))
  "Returns string type for a message object of type '<FreezeModels>"
  "gz_freeze_objects/FreezeModels")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'FreezeModels)))
  "Returns string type for a message object of type 'FreezeModels"
  "gz_freeze_objects/FreezeModels")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<FreezeModels>)))
  "Returns md5sum for a message object of type '<FreezeModels>"
  "dd3c2b51be5bf4747de89ce8cafd1599")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'FreezeModels)))
  "Returns md5sum for a message object of type 'FreezeModels"
  "dd3c2b51be5bf4747de89ce8cafd1599")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<FreezeModels>)))
  "Returns full string definition for message of type '<FreezeModels>"
  (cl:format cl:nil "bool freeze~%string[] models~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'FreezeModels)))
  "Returns full string definition for message of type 'FreezeModels"
  (cl:format cl:nil "bool freeze~%string[] models~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <FreezeModels>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'models) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <FreezeModels>))
  "Converts a ROS message object to a list"
  (cl:list 'FreezeModels
    (cl:cons ':freeze (freeze msg))
    (cl:cons ':models (models msg))
))
