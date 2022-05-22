#lang racket

(require "modules/sicp/sicp.rkt")
(require "evaluator.scm")

(define (assert-eval exp expected)

  (assert (evaluate exp) expected))
; or tests
(assert-eval '(or true false) true)
(assert-eval '(or false false true) true)
(assert-eval '(or false) false)

; end tests
(assert-eval '(and true false) false)
(assert-eval '(and true true false) false)
(assert-eval '(and true) true)

; basic math
(assert-eval '(+ 1 1) 2)
(assert-eval '(* 2 2) 4)

; nested exps
(assert-eval '(+ (+ 1 1) 1) 3)

; define var
(assert-eval '(define a 3) 'ok)
(assert-eval '(define b 9) 'ok)
(assert-eval '(+ a 3) 6)
(assert-eval '(+ a b) 12)

; mutation
(assert-eval '(define c 10) 'ok)
(assert-eval '(set! c 11) 'ok)
(assert-eval '(+ c 0) 11)

; recursion
(assert-eval '(define (fib n)
                (cond ((= n 0) 0) ((= n 1) 1)
                      (else (+ (fib (- n 1)) (fib (- n 2)))))) 'ok)

(assert-eval '(fib 0) 0)
(assert-eval '(fib 1) 1)
(assert-eval '(fib 10) 55)

; lambda
(assert-eval '((lambda (c b) (+ c b)) 3 4) 7)

; let expression
(assert-eval '(let ((c 3)(b 4)) (+ c b)) 7)

