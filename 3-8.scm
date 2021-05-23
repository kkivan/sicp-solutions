#lang scheme

(require "modules/sicp/sicp.rkt")

(define state 1)

(define (f x)
  (set! state (* state x))
  state)

(assert (+ (f 0) (f 1))
        0)

(set! state 1)

(assert (+ (f 1) (f 0))
        1)