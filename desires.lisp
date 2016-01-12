(defun make-desire (desire reason action-plan progressed-today?)
  (list :desire desire :reason reason :action-plan action-plan :progressed-today? progressed-today?))

(defvar *db* nil)

(defun add-record (desire)
  (push desire *db*))

(defun dump-db ()
  (dolist (desire *db*)
    (format t "~{~a:~10t~a~%~}~%" desire)))

(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun add-record-prompt ()
  (format t "Lets add a desire~%")
  (make-desire
    (prompt-read "What is your desire?")
    (prompt-read "Why do you desire this?")
    (or (parse-integer (prompt-read "What is your action plan to achieve this?") :junk-allowed t) 0)
    (y-or-n-p (prompt-read "Have you made progress today on achieving this desire? [y/n]"))))
  
