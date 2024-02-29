(flet ((f (n)
         (+ n 10)))
  (f 5))
 ; => 15 (4 bits, #xF, #o17, #b1111)

(flet ((f ()
         (format t "hello")))
  (f))
; hello => NIL

;; composition of once-declared functions with ~FLET~
(flet ((f (n)
         (+ n 10))
       (g (n)
         (- n 3)))
  (g (f 5)))
 ; => 12 (4 bits, #xC, #o14, #b1100)
