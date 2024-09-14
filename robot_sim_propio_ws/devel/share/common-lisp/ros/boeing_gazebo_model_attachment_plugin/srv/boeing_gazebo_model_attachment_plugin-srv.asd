
(cl:in-package :asdf)

(defsystem "boeing_gazebo_model_attachment_plugin-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Attach" :depends-on ("_package_Attach"))
    (:file "_package_Attach" :depends-on ("_package"))
    (:file "Detach" :depends-on ("_package_Detach"))
    (:file "_package_Detach" :depends-on ("_package"))
  ))