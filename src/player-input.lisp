(defpackage :player-input
  (:use :cl)
  (:local-nicknames (:a :alexandria)
                    (:gs :gamestate))
  (:export #:handle-key-down))

(in-package :player-input)

(defun handle-up (game-state)
  (setf (gs:game-state-snake-dir game-state) :u))

(defun handle-down (game-state)
  (setf (gs:game-state-snake-dir game-state) :d))

(defun handle-right (game-state)
  (setf (gs:game-state-snake-dir game-state) :r))

(defun handle-left (game-state)
  (setf (gs:game-state-snake-dir game-state) :l))

(defun handle-escape (game-state)
  (sdl2:push-event :quit))

(defparameter handlers
  (a:alist-hash-table (list (cons :scancode-escape #'handle-escape)
                            (cons :scancode-up #'handle-up)
                            (cons :scancode-down #'handle-down)
                            (cons :scancode-left #'handle-left)
                            (cons :scancode-right #'handle-right))))

(defun handle-key-down (scancode game-state)
  (let ((handler (gethash scancode handlers nil)))
    (if handler (funcall handler game-state))))

