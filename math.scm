#lang scheme

(require "dispatch-table.scm")
(require "modules/sicp/sicp.rkt")

(provide add
         sub
         div
         mul
         =zero?
         negate)

(define (add x y)
  (apply-generic 'add x y))

(define (sub x y)
  (apply-generic 'sub x y))

(define (div x y)
  (apply-generic 'div x y))

(define (mul x y)
  (apply-generic 'mul x y))

(define (=zero? x)
  (apply-generic '=zero? x))

(define (negate x)
  (apply-generic 'negate x))