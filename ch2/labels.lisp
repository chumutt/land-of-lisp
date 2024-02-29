(labels ((a (n)
           (+ n 5))
         (b (n)
           (+ (a n) 6)))
  (b 10))
 ; => 21 (5 bits, #x15, #o25, #b10101)

;; labels lets you call one local function form another and allows you to have a function call itself (recursion)
