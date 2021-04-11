#lang scheme

(require "dispatch-table.scm")
(require "modules/sicp/sicp.rkt")

(define (equ? l r)
  (let ((result (apply-generic 'equ? l r)))
    (if (null? result)
        false
        result)))
  
(define (num rat)
  (car rat))

(define (denom rat)
  (cdr rat))

(define (real complex)
  (car complex))

(define (imag complex)
  (cdr complex))

(define (equal-complex? l r)
  (and (= (real l) (real r))
       (= (imag l) (imag r))))

(assert (equal-complex? (cons 1 2)
                        (cons 1 2))
        true)

(assert (equal-complex? (cons 1 3)
                        (cons 1 2))
        false)

(define (equal-rat? l r)
  (and (= (num l) (num r))
       (= (denom l) (denom r))))

(put 'equ? '(rat rat) equal-rat?)
(put 'equ? '(complex complex) equal-complex?)

(define (make-rat num den)
  (attach-tag '(rat) (cons num den)))

(assert (equal-rat? (cons 1 2)
                    (cons 1 2))
        true)

(assert (equal-rat? (cons 2 3)
                    (cons 1 2))
        false)

(define (make-complex-real-imag real imag)
  (attach-tag '(complex) (cons real imag)))

(assert (equ? (make-rat 2 3)
              (make-rat 1 2))
        false)

(assert (equ? (make-rat 1 2)
              (make-rat 1 2))
        true)

(assert (equ? (make-rat 1 2)
              (make-complex-real-imag 1 2))
        false)
