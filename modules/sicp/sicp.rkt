#lang scheme

(provide nil
         flatmap
         assert)

(define nil '())

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))
(define accumulate fold-right)

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

; tests
(provide assert)
(define (assert actual expected)  
  (if (equal? actual expected)
      'passed
      actual))
