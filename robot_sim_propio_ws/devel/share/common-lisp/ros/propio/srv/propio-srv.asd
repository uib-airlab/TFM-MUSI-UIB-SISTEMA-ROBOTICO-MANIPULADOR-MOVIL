
(cl:in-package :asdf)

(defsystem "propio-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "AttachDetach" :depends-on ("_package_AttachDetach"))
    (:file "_package_AttachDetach" :depends-on ("_package"))
    (:file "ProcessImage" :depends-on ("_package_ProcessImage"))
    (:file "_package_ProcessImage" :depends-on ("_package"))
    (:file "StartPickAndPlace" :depends-on ("_package_StartPickAndPlace"))
    (:file "_package_StartPickAndPlace" :depends-on ("_package"))
    (:file "StartStopExplorer" :depends-on ("_package_StartStopExplorer"))
    (:file "_package_StartStopExplorer" :depends-on ("_package"))
  ))