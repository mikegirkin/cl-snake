(defpackage #:gamestate
  (:use :cl)
  (:export #:game-state
           #:new-game-state
           #:game-state-food
           #:game-state-snake-pos
           #:game-state-score
           #:game-state-snake-dir
           #:game-state-tick-ms
           #:move-snake))

(in-package :gamestate)

(defstruct (game-state
            (:constructor new-game-state
                (&key (food nil)
                   (snake-pos (list '(10 10) '(10 11) '(10 12)))
                   (snake-dir :u)
                   (tick-ms 0)
                   (score 0))))
  food snake-pos snake-dir tick-ms score)

(defun calc-new-snake-pos (game-state)
  (let* ((direction (game-state-snake-dir game-state))
         (current-pos (game-state-snake-pos game-state))
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

(defun move-snake (game-state)
  (let* ((new-snake-pos (calc-new-snake-pos game-state)))
    (setf (game-state-snake-pos game-state) new-snake-pos)))
