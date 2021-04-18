(defpackage #:hashtable
  (:use :cl)
  (:export #:make-hash))

(in-package :hashtable)

(defun make-hash (initial)
  "initial should be in a form of ((k1 v1) (k2 v2))"
  (let ((ht (make-hash-table)))
    (mapc (lambda (pair)
            (setf (gethash (car pair) ht) (cadr pair)))
          initial)
    ht))
