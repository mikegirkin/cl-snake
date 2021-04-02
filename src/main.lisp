(defpackage #:snake
  (:use :common-lisp)
  (:export :main))

(in-package :snake)

(defparameter *screen-width* 640)
(defparameter *screen-height* 480)

(defvar red )

(defun main(&key (delay 2000))
  (sdl2:with-init (:video)
    (sdl2:with-window (window :title "SDL2 Window" :w *screen-width* :h *screen-height*)
      (let ((screen-surface (sdl2:get-window-surface window)))
        (sdl2:fill-rect screen-surface
                        nil
                        (sdl2:map-rgb (sdl2:surface-format screen-surface) 120 255 255))
        (draw-rect screen-surface)
        (sdl2:update-window window)
        (sdl2:with-event-loop (:method :poll)
          (:quit () t)
          (:idle ()
                 (sdl2:delay delay)))))))

(defun draw-rect (surface)
  (sdl2:fill-rect surface
                  (sdl2:make-rect 50 50 50 50)
                  (sdl2:map-rgb (sdl2:surface-format surface) 200 0 0)))
