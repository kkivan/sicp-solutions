#lang sicp

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame f)
  (car f))

(define (edge1-frame f)
  (cadr f))

(define (edge2-frame f)
  (cadr (cdr f)))

(define (make-vect x y)
  (cons x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cdr v))

(define f (make-frame (make-vect 0 0)
                      (make-vect 1 1)
                      (make-vect 0 4)))
(origin-frame f)
(edge1-frame f)
(edge2-frame f)