#lang sicp

(define (adjoin-set x set) 
   (cond ((null? set) (list x)) 
         ((= x (car set)) set) 
         ((< x (car set)) (cons x set)) 
         (else (cons (car set) (adjoin-set x (cdr set))))))

(adjoin-set 0 '(1 3 7))
(adjoin-set 3 '(1 3 7))
(adjoin-set 5 '(1 3 7))
(adjoin-set 9 '(1 3 7))

