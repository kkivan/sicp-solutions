#lang scheme

;a. What happens if apply-generic is called with two arguments of type scheme-number or two arguments of type complex for an operation that is not found in the table for those types?
;–––
;It goes into recursive loop
;
;What happens if we call exp with two complex numbers as ar-
;guments?
;–––
;Error would be thrown as there is no exp opeartor for complex numbers and complex numbers cannot be downcasted to scheme-number
;
;b. It will work with out same type coercion since coercion is done after we didn't hit the original table

;;c.

(require "modules/sicp/sicp.rkt")
(require "dispatch-table.scm")
(require "modules/sicp/rat.scm")

(define (** base exponent)
  (fold-right mul 1 (repeated base exponent)))

(define (exp x y) (apply-generic 'exp x y))
(define (mul a b) (apply-generic 'mul a b))

(put 'exp '(scheme-number scheme-number) **)
(put 'mul '(scheme-number scheme-number) *)

(put-coercion 'scheme-number 'rat (lambda (n)
                                    (make-rat n 1)))

(put 'mul '(rat rat) (lambda (l r)
                       (make-rat (mul (numer l) (numer r))
                                 (mul (denom l) (denom r)))))

(define (make-complex-real-imag real imag)
  (attach-tag 'complex (cons real imag)))

(assert (mul 5 3)
        15)

(assert (exp 2 4)
        16)