(defpackage #:tests/gamestate
  (:use :cl
        :rove)
  (:local-nicknames (:gs :gamestate)))

(in-package :tests/gamestate)

(defun make-test-state ()
  (gamestate:new-game-state))

(deftest food-operations
  (testing "could make new food"
    (let ((state (make-test-state)))
      (gs:add-random-food state)
      (ok (equal 1 (length (gamestate:game-state-food state))))

      (gs:add-random-food state)
      (ok (equal 2 (length (gamestate:game-state-food state)))))))
