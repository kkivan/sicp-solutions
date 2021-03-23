#lang sicp

(define (make-vect x y)
  (cons x y))

(define (make-segment v1 v2)
  (list v1 v2))

(define (start-segment v)
  (car v))

(define (end-segment v)
  (cadr v))

(define s (make-segment (make-vect 1 1)
                        (make-vect 5 5)))

s
(start-segment s)
(end-segment s)