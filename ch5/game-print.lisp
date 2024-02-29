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
