#lang scheme

(require "modules/sicp/sicp.rkt")
(require "dispatch-table.scm")
(require "2-57.scm")

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        (else
         ((get 'deriv (operator exp))
          (operands exp)
          var))))

(define (deriv-sum exp var)
   (make-sum (deriv (addend exp) var)
             (deriv (augend exp) var)))

(define (deriv-product exp var)
   (make-sum
    (make-product (multiplier exp)
                  (deriv (multiplicand exp) var))
    (make-product (deriv (multiplier exp) var)
                  (multiplicand exp))))

(define (deriv-exp exp var)
   (make-product  
    (exponent exp) 
    (make-exponentiation (base exp) 
                         (make-sum (exponent exp) -1))))

(define (operator exp) (car exp))
(define (operands exp) exp)

; a. number and variable are not tagged with type
; variable is a symbol but whether it's a type or not depends on the another argument

; b.

(put 'deriv '+ deriv-sum)
(put 'deriv '* deriv-product)

(assert (deriv '(* x y (+ x 3)) 'x)
        '(+ (* x y) (* y (+ x 3))))
 
(assert (deriv '(+ y x) 'x)
        1)

; c.
(put 'deriv '** deriv-exp)

(assert (deriv '(** x 3) 'x)
        '(* 3 (** x 2)))

; d. Only change to get procedure to swap aruments is required 
