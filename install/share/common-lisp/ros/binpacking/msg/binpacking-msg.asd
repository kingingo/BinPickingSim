
(cl:in-package :asdf)

(defsystem "binpacking-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "LabelPoint" :depends-on ("_package_LabelPoint"))
    (:file "_package_LabelPoint" :depends-on ("_package"))
    (:file "LabelPoints" :depends-on ("_package_LabelPoints"))
    (:file "_package_LabelPoints" :depends-on ("_package"))
  ))