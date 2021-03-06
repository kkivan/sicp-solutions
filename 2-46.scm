#lang sicp

(define (make-vect x y)
  (cons x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cdr v))

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1)
                (xcor-vect v2))
             (+ (ycor-vect v1)
                (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1)
                (xcor-vect v2))
             (- (ycor-vect v1)
                (ycor-vect v2))))

(define (scale-vect v scale)
  (make-vect (* scale (xcor-vect v))
             (* scale (ycor-vect v))))

(define oneone (make-vect 1 1))

(add-vect oneone
          oneone)
(sub-vect oneone
          oneone)
(scale-vect (make-vect 1 1) 10)

