(defsystem "snake"
  :depends-on (:sdl2
               :sdl2-image
               :sdl2-ttf
               :swank
               :bordeaux-threads)
  :components ((:file "src/main")))
