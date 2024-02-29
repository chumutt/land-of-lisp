(defparameter *small* 1)
 ; => *SMALL*

(defparameter *big* 100)
 ; => *BIG*

(defun guess-my-number ()
  (ash (+ *small* *big*) -1))
 ; => GUESS-MY-NUMBER

(defun smaller ()
  (setf *big* (1- (guess-my-number)))
  (guess-my-number))
 ; => SMALLER

(defun bigger ()
  (setf *small* (1+ (guess-my-number)))
  (guess-my-number))
 ; => BIGGER

;; my number is 42
(guess-my-number)
 ; => 50 (6 bits, #x32, #o62, #b110010)
(smaller)
 ; => 25 (5 bits, #x19, #o31, #b11001)
(bigger)
 ; => 37 (6 bits, #x25, #o45, #b100101)
(bigger)
 ; => 43 (6 bits, #x2B, #o53, #b101011)
(smaller)
 ; => 40 (6 bits, #x28, #o50, #b101000)
(bigger)
 ; => 41 (6 bits, #x29, #o51, #b101001)
(bigger)
 ; => 42 (6 bits, #x2A, #o52, #b101010)
