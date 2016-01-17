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
  (make-desire
    (prompt-read "What is your desire?")
    (prompt-read "Why do you desire this?")
    (prompt-read "What is your action plan to achieve this?")
    (y-or-n-p  "Have you made progress today on achieving this desire? [y/n]")))

(defun add-desires ()
  (loop (add-record (add-record-prompt))
     (if (not (y-or-n-p  "Would you like to add another desire [y/n]")) (return))))
  
(defun save-db (filename)
  (with-open-file (out filename
                   :direction :output
                   :if-exists :supersede)
    (with-standard-io-syntax
      (print *db* out))))

(defun load-db (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *db* (read in)))))

(defun select-by-desire (desire)
  (remove-if-not
   #'(lambda (thing) (equal (getf thing :desire) desire))
   *db*))
