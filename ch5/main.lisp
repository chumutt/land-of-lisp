;;;; the wizard's adventure game

(defparameter *nodes* '((living-room (you are in the living room.
                                      a wizard is snoring loudly on the couch. cool.))
                        (garden (you are in a beautiful garden.
                                 there is a well in front of you.))
                        (attic (you are in the attic.
                                there is a giant welding torch in the corner.))))

(defparameter *edges* '((living-room (garden west door)
                         (attic upstairs ladder))
                        (garden (living-room east door))
                        (attic (living-room downstairs ladder))))

(defparameter *objects* '(whiskey bucket frog chain))

(defparameter *object-locations* '((whiskey living-room)
                                   (bucket living-room)
                                   (chain garden)
                                   (frog garden)))

(defparameter *location* 'living-room)

(defparameter *allowed-commands* '(look walk pickup inventory))

(defun help/commands (cmds)
  `(commands -
    ,(first cmds)
    ,(second cmds)
    ,(third cmds)
    ,(fourth cmds)))

(defun describe-path (edge)
  `(there is a ,(caddr edge) going ,(cadr edge) from here.))

(defun describe-location (location nodes)
  (cadr (assoc location nodes)))

(defun describe-paths (location edges)
  (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))

(defun objects-at (loc objs obj-locs)
  (labels ((at-loc-p (obj)
             (eq (cadr (assoc obj obj-locs)) loc)))
    (remove-if-not #'at-loc-p objs)))

(defun describe-objects (loc objs obj-loc)
  (labels ((describe-obj (obj)
             `(you see a ,obj on the floor.)))
    (apply #'append (mapcar #'describe-obj (objects-at loc objs obj-loc)))))

(defun look ()
  (append (describe-location *location* *nodes*)
          (describe-paths *location* *edges*)
          (describe-objects *location* *objects* *object-locations*)))

(defun walk (dir)
  (let ((next (find dir
                    (cdr (assoc *location* *edges*))
                    :key #'cadr)))
    (if next
        (progn (setf *location* (car next))
               (look))
        '(you cannot go that way.))))

(defun pickup (object)
  (cond ((member object
                 (objects-at *location* *objects* *object-locations*))
         (push (list object 'body) *object-locations*)
         `(you are now carrying the ,object))
        (t '(you cannot get that.))))

(defun inventory ()
  (cons 'items- (objects-at 'body *objects* *object-locations*)))

(defun tt (lst caps lit)
  (when lst
    (cond ((eq (car lst) #\space) (cons (car lst) (tt (cdr lst) caps lit)))
          ((member (car lst) '(#\! #\? #\.)) (cons (car lst) (tt (cdr lst) t lit)))
          ((eq (car lst) #\") (tt (cdr lst) caps (not lit)))
           (lit (cons (car lst) (tt (cdr lst) nil lit)))
          ((or caps lit) (cons (char-upcase (car lst)) (tt (cdr lst) nil lit)))
          (t (cons (char-downcase (car lst)) (tt (cdr lst) nil nil))))))

(defun game-print (lst)
  (princ (coerce (tt (coerce (string-trim "() "
                                         (prin1-to-string lst))
                             'list)
                     t
                     nil)
                 'string))
  (fresh-line))

(defun game-eval (sexp)
  (if (member (car sexp) *allowed-commands*)
      (eval sexp)
      '(i do not know that command.)))

(defun game-read ()
  "Add parentheses and quotes to user input. Does not have proper exception handling."
  (let ((cmd (read-from-string
              (concatenate 'string "(" (read-line) ")"))))
    (flet ((quote-it (x)
             (list 'quote x)))
      (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

(defun game-repl ()
  (loop
    (game-print
     (game-eval
      (game-read)))))

(defun main ()
  (game-print (help/commands *allowed-commands*))
  (game-repl))

(main)
