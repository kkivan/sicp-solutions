#lang sicp

(define (adjoin-set x set)
  (define (iter x left right)
    (cond ((null? right) (append left (list x)))
          ((= x (car right)) set)
          ((< x (car right)) (append left (list x) right))
          (else (iter x
                      (append left (list (car right)))
                      (cdr right)))))
  (iter x nil set))

(adjoin-set 0 '(1 3 7))
(adjoin-set 3 '(1 3 7))
(adjoin-set 5 '(1 3 7))
(adjoin-set 9 '(1 3 7))

