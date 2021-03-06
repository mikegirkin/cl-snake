(defpackage #:snake
  (:use :cl)
  (:local-nicknames (:hs :hashtable)
                    (:a :alexandria)
                    (:pi :player-input)
                    (:gs :gamestate))
  (:export #:main
           #:start
           #:resolve-color))

(in-package :snake)

(defparameter *screen-width* 640)
(defparameter *screen-height* 480)

(defparameter *rect-color* '(255 0 100 255))

(defparameter *colors* (hs:make-hash (list (list :red (list 255 0 0 255))
                                           (list :blue (list 0 255 0 255))
                                           (list :green (list 0 0 255 255))
                                           (list :cyan (list 0 255 255 255)))))

(defun resolve-color (color)
  "color: either color literal defined in *colors* or (r g b a)"
  (cond ((symbolp color) (gethash color *colors* nil))
        ((listp color) color)
        (t nil)))

(defparameter *snake-color* :cyan)
(defparameter *food-color* :green)
(defparameter *field-size* '(30 30)) ;; w h
(defparameter *cell-size* '(10 10)) ;; w h
(defparameter *tick-time* 500) ;;miliseconds to move snake
(defparameter *food-appear-time* 1200) ;;milliseconds to generate new food

(defun render-rect (renderer x y w h color)
  (apply #'sdl2:set-render-draw-color (cons renderer (resolve-color color)))
  (sdl2:render-fill-rect renderer (sdl2:make-rect x y w h)))

(defun render-snake (renderer game-state)
  (dolist (n (gs:game-state-snake-pos game-state))
    (let ((x (+ 1 (* (car n) (car *cell-size*))))
          (y (+ 1 (* (cadr n) (cadr *cell-size*))))
          (w (- (car *cell-size*) 2))
          (h (- (cadr *cell-size*) 2)))
      (render-rect renderer x y w h *snake-color*))))

(defun render-food (renderer game-state)
  (dolist (food-position (gs:game-state-food game-state))
    (let ((x (+ 1 (* (car food-position) (car *cell-size*))))
          (y (+ 1 (* (cadr food-position) (cadr *cell-size*))))
          (w (- (car *cell-size*) 2))
          (h (- (cadr *cell-size*) 2)))
      ;;(format t "~d ~d ~d ~d \r\n" x y w h)
      (render-rect renderer x y w h *food-color*))))

(defun render-game (renderer game-state)
  (sdl2:set-render-draw-color renderer 0 0 0 255)
  (sdl2:render-clear renderer)
  (render-snake renderer game-state)
  (render-food renderer game-state)
  (sdl2:render-present renderer))

(defun update-game-time (game-state)
  (let* ((ticks-now (get-internal-real-time))
         (ticks-before (gs:game-state-tick-ms game-state)))
    (when (> (abs (- ticks-now ticks-before)) *tick-time*)
      (setf (gs:game-state-tick-ms game-state) ticks-now)
      (gs:move-snake game-state))))

(defun main(&key (delay 20))
  (let ((game-state (gs:new-game-state)))
    (slynk-mrepl:send-prompt)
    (sdl2:with-init (:everything)
      (sdl2:with-window (window :title "SDL2 Window" :flags '(:shown))
        (sdl2:with-renderer (renderer window :flags '(:accelerated))
          (sdl2:with-event-loop (:method :poll)
            (:keydown
             (:keysym keysym)
             (pi:handle-key-down (sdl2:scancode keysym) game-state))
            (:idle
             ()
             (update-game-time game-state)
             (render-game renderer game-state)
             (with-simple-restart (abort "Abort this game REPL evaluation")
               (slynk:process-requests t))
             (sdl2:delay delay)
             )
            (:quit () t)))))))

(defun start ()
  (sdl2:make-this-thread-main #'main))
