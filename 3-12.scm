#lang scheme

(define (append! x y)
     (set-cdr! (last-pair x) y)
     x)

(define (last-pair x)
     (if (null? (cdr x))
         x
         (last-pair (cdr x))))

Consider the interaction
   (define x (list ’a ’b))
   (define y (list ’c ’d))
   (define z (append x y))
   z
(a b c d)
(cdr x)
;〈response〉(b)
(define w (append! x y)) w
(a b c d)
(cdr x)
;〈response〉(b c d)