
(cl:in-package :asdf)

(defsystem "gz_dynamic_colors-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "DColor" :depends-on ("_package_DColor"))
    (:file "_package_DColor" :depends-on ("_package"))
  ))