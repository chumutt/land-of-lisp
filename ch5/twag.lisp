;;; the wizard's adventure game

(load "game-repl.lisp")

(defparameter *nodes* '((living-room (you are in the living room.
                                      a wizard is snoring loudly on the couch.))
                        (garden (you are in a beautiful garden.
                                 there is a well in front of you.))
                        (attic (you are in the attic.
                                there is a giant welding torch in the corner.))))
(assoc 'garden *nodes*)
 ; => (GARDEN (YOU ARE IN A BEAUTIFUL GARDEN. THERE IS A WELL IN FRONT OF YOU.))

(defparameter *edges* '((living-room (garden west door)
                         (attic upstairs ladder))
                        (garden (living-room east door))
                        (attic (living-room downstairs ladder))))

(defun describe-path (edge)
  `(there is a ,(caddr edge) going ,(cadr edge) from here.))

(describe-path '(garden west door))
 ; => (THERE IS A DOOR GOING WEST FROM HERE.)
 ;
(defun describe-paths (location edges)
  (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))
 ; => DESCRIBE-PATHS
 ;
(describe-paths 'living-room *edges*)
 ; => (THERE IS A DOOR GOING WEST FROM HERE. THERE IS A LADDER GOING UPSTAIRS FROM
 ; HERE.)
