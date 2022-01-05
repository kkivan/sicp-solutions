#lang scheme

(require "streams.scm")

(define (expand num den radix)
  (cons-stream (quotient (* num radix) den)
               (expand (remainder (* num radix) den) den radix)))

(take (expand 1 4 10) 2) ; 1/4 or 0. (2 5)

