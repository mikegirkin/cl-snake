(defsystem "snake"
  :depends-on (:alexandria
               :sdl2
               :sdl2-image
               :sdl2-ttf
               :swank
               :bordeaux-threads)
  :pathname "src"
  :serial t
  :components ((:file "hashtable")
               (:file "gamestate")
               (:file "player-input")
               (:file "main"))
  :in-order-to ((test-op (test-op :snake/test))))

(defsystem :snake/test
  :depends-on (:snake
               :rove)
  :pathname "test"
  :components ((:file "main")
               (:file "player-input"))
  :perform (test-op (op c) (symbol-call :rove '#:run c)))
