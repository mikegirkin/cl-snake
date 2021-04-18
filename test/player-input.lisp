(defpackage #:tests/player-input
  (:use :cl
        :rove)
  (:local-nicknames (:gs :gamestate)
                    (:pi :player-input)))

(in-package :tests/player-input)

(defun make-test-state (direction)
  (gs:new-game-state :snake-dir direction))

(deftest direction-change
  (testing "can set it to up"
           (let ((game-state (make-test-state :d)))
             (pi:handle-key-down :scancode-up game-state)
             (ok (equal (gs:game-state-snake-dir game-state) :u))))

  (testing "can set it to down"
    (let ((game-state (make-test-state :u)))
      (pi:handle-key-down :scancode-down game-state)
      (ok (equal (gs:game-state-snake-dir game-state) :d))))

  (testing "can set it to left"
    (let ((game-state (make-test-state :u)))
      (pi:handle-key-down :scancode-left game-state)
      (ok (equal (gs:game-state-snake-dir game-state) :l))))

  (testing "can set it to right"
    (let ((game-state (make-test-state :u)))
      (pi:handle-key-down :scancode-right game-state)
      (ok (equal (gs:game-state-snake-dir game-state) :r)))))


