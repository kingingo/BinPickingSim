
(cl:in-package :asdf)

(defsystem "contact_republisher-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "contact_msg" :depends-on ("_package_contact_msg"))
    (:file "_package_contact_msg" :depends-on ("_package"))
    (:file "contacts_msg" :depends-on ("_package_contacts_msg"))
    (:file "_package_contacts_msg" :depends-on ("_package"))
  ))