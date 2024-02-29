(load "game-print.lisp")
(load "game-eval.lisp")
(load "game-read.lisp")

(defun game-repl ()
  (loop (game-print (game-eval (game-read)))))
