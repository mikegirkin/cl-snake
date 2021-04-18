(defpackage #:gamestate
  (:use :cl)
  (:export #:game-state
           #:new-game-state
           #:game-state-food
           #:game-state-snake-pos
           #:game-state-score
           #:game-state-snake-dir))

(in-package :gamestate)

(defstruct (game-state
            (:constructor new-game-state
                (&key (food nil)
                   (snake-pos (list '(10 10) '(10 11) '(10 12)))
                   (snake-dir :u)
                   (tick-ms 0)
                   (score 0))))
  food snake-pos snake-dir tick-ms score)

