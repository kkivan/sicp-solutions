#lang scheme

(provide nil
         flatmap
         square
         assert
         fold-right
         repeated
         memq)

(define nil '())

(define (square x) (* x x))

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))
(define accumulate fold-right)

(define (repeated x n)
  (if (= n 0)
      nil
      (cons x (repeated x (- n 1)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

; tests
(provide assert)
(define (assert actual expected)  
  (if (equal? actual expected)
      'passed
      (list 'failed 'expected expected 'got actual)))

(provide print)
(define (print arg)
  (display arg)
  (newline))

(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

