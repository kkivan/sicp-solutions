#lang racket

(require "modules/sicp/sicp.rkt")
(require "evaluator.scm")

; or tests
(assert (evaluate '(or true false)) true)
(assert (evaluate '(or false false true)) true)
(assert (evaluate '(or false)) false)

; end tests
(assert (evaluate '(and true false)) false)
(assert (evaluate '(and true true false)) false)
(assert (evaluate '(and true)) true)
