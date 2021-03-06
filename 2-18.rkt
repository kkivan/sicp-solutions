#lang scheme

(define (reverse l)
  (define (iter l r)
    (if (null? l)
        r
        (iter (cdr l) (cons (car l) r))))
  (iter l '()))

(define l '(1 2 3 4))
(reverse l)