#lang scheme

(require "dispatch-table.scm")
(require "modules/sicp/sicp.rkt")
(require "modules/sicp/rat.scm")
(require "complex.scm")

(define (equ? l r)
  (let ((result (apply-generic 'equ? l r)))
    (if (null? result)
        false
        result)))

(define (equal-complex? l r)
  (and (equ? (real l) (real r))
       (equ? (imag l) (imag r))))

(define (equal-rat? l r)
  (and (equ? (numer l) (numer r))
       (equ? (denom l) (denom r))))

(put 'equ? '(rat rat) equal-rat?)
(put 'equ? '(complex complex) equal-complex?)
(put 'equ? '(scheme-number scheme-number) =)

(assert (equal-rat? (cons 1 2)
                    (cons 1 2))
        true)

(assert (equal-rat? (cons 2 3)
                    (cons 1 2))
        false)

(assert (equal-complex? (cons 1 2)
                        (cons 1 2))
        true)

(assert (equal-complex? (cons 1 3)
                        (cons 1 2))
        false)

(assert (equ? (make-rat 2 3)
              (make-rat 1 2))
        false)

(assert (equ? (make-rat 1 2)
              (make-rat 1 2))
        true)

(put-coercion 'rat 'complex (lambda (rat)
                              (make-complex-real-imag rat 0)))

(put-coercion 'scheme-number 'rat (lambda (num) (make-rat num 1)))

(assert (coerce (list (make-rat 1 2)
                      (make-complex-real-imag 1 2)))
        (list (make-complex-real-imag (make-rat 1 2) 0)
              (make-complex-real-imag 1 2)))

(assert (equ? (make-rat 1 2)
              (make-complex-real-imag 1 2))
        false)

(assert (equ? (make-complex-real-imag 1 2)
              (make-rat 1 2))
        false)

(assert (equ? (make-rat 3 1)
              3)
        true)

(assert (raise 2)
        (make-rat 2 1))

(assert (raise (make-rat 2 1))
        (make-complex-real-imag (make-rat 2 1) 0))

