(defpackage #:gamestate
  (:use :cl)
  (:export #:game-state
           #:new-game-state
           #:game-state-food
           #:game-state-snake-pos
           #:game-state-score
           #:game-state-snake-dir
           #:game-state-tick-ms
           #:game-stage-field-size
           #:move-snake
           #:add-random-food))

(in-package :gamestate)

(defstruct (game-state
            (:constructor new-game-state
                (&key
                   (field-size '(30 30))
                   (food (list '(20 11) '(12 17)))
                   (snake-pos (list '(10 10) '(10 11) '(10 12)))
                   (snake-dir :u)
                   (tick-ms 0)
                   (score 0))))
  field-size food snake-pos snake-dir tick-ms score)

(defun calc-new-snake-pos (state)
  (let* ((direction (game-state-snake-dir state))
         (current-pos (game-state-snake-pos state))
         (head-x (first (first current-pos)))
         (head-y (nth 1 (first current-pos))))
    (cond
      ((equal direction :u)
       (cons (list head-x (- head-y 1)) (butlast current-pos)))
      ((equal direction :d)
       (cons (list head-x (+ head-y 1)) (butlast current-pos)))
      ((equal direction :l)
       (cons (list (- head-x 1) head-y) (butlast current-pos)))
      ((equal direction :r)
       (cons (list (+ head-x 1) head-y) (butlast current-pos))))))

(defun move-snake (state)
  (let* ((new-snake-pos (calc-new-snake-pos state)))
    (setf (game-state-snake-pos state) new-snake-pos)))

(defun add-random-food (state)
  (destructuring-bind (w h) (game-state-field-size state)
    (let* ((x (random w))
           (y (random h))
           (new-food (cons (list x y) (game-state-food state))))
      (setf (game-state-food state) new-food))))
