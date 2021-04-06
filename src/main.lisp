(defpackage #:snake
  (:use :common-lisp)
  (:export #:main
           #:start
           #:game-state
           #:make-game-state
           #:game-state-food
           #:game-state-snake-pos
           #:game-state-score))

(in-package :snake)

(defstruct game-state
  food
  snake-pos
  score)

(defparameter *screen-width* 640)
(defparameter *screen-height* 480)

(defparameter *rect-color* '(255 0 100 255))

(defvar red )

(defun render-rect (renderer)
  (apply #'sdl2:set-render-draw-color (cons renderer *rect-color*))
  (sdl2:render-fill-rect renderer (sdl2:make-rect 50 50 50 70)))

(defun test-a ()
  (write "test called"))

(defun main(&key (delay 20))
  (sdl2:with-init (:everything)
    (sdl2:with-window (window :title "SDL2 Window" :flags '(:shown))
      (sdl2:with-renderer (renderer window :flags '(:accelerated))
        (sdl2:with-event-loop (:method :poll)
          (:initialize ()
                       (slynk-mrepl:send-prompt))
          (:keyup
           (:keysym keysym)
           (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-escape)
             (sdl2:push-event :quit)))
          (:idle
           ()
           (render-rect renderer)
           (sdl2:render-present renderer)
           (with-simple-restart (abort "Abort this game REPL evaluation")
             (slynk:process-requests t))
           (sdl2:delay delay)
           )
          (:quit () t))))))

(defun start ()
  (sdl2:make-this-thread-main #'main))
