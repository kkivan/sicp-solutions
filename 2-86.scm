#lang scheme

;Exercise 2.86: Suppose we want to handle complex numbers whose real parts, imaginary parts, magnitudes, and angles can be either ordinary numbers, rational numbers, or other numbers we might wish to add to the system. Describe and implement the changes to the system needed to accommodate this. You will have to define operations such as sine and cosine that are generic over ordinary numbers and rational numbers.

(require "dispatch-table.scm")
(require "modules/sicp/rat.scm")
(require "modules/sicp/sicp.rkt")

(define (make-complex-mag-ang mag ang)
  (attach-tag 'complex (cons mag
                             ang)))


(define (sine x)
  (apply-generic 'sine x))

(define (cosine x)
  (apply-generic 'cosine x))

(put 'sine '(scheme-number) sin)
(put 'cosine '(scheme-number) cos)

(put 'sine '(rat) (lambda (x) (sin (/ (numer x) (denom x)))))
(put 'cosine '(rat) (lambda (x) (cos (/ (numer x) (denom x)))))
 
(define (real complex)
  (cosine (car (contents complex))))

(define (imag complex)
  (sine (cdr (contents complex))))

(define (angle complex)
  (car complex))

(define (magnitude complex)
  (cadr complex))

(define a (make-complex-mag-ang (make-rat 1 2) 2))
(define b (make-complex-mag-ang 0.5 2))

(assert (real a)
        (real b))

(assert (imag a)
        (imag b))
