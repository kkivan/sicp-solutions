#lang scheme

(define (make-accumulator a)
  (let ((amount a))
    (lambda (i)
             (set! amount (+ amount i))
      amount)))

(define A (make-accumulator 5))

(A 10)