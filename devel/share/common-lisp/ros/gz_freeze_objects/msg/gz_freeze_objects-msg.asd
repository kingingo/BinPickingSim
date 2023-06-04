
(cl:in-package :asdf)

(defsystem "gz_freeze_objects-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "FreezeModels" :depends-on ("_package_FreezeModels"))
    (:file "_package_FreezeModels" :depends-on ("_package"))
  ))