
#lang scheme

(define (last-pair l)
  (if (null? (cdr l))
      l
      (last-pair (cdr l))))

(define l '(23 72 149 34))

(last-pair l)