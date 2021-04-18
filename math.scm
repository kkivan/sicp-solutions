#lang scheme

(require "dispatch-table.scm")
(require "modules/sicp/sicp.rkt")

(provide add
         sub
         div
         mul)

(define (add x y)
  (apply-generic 'add x y))

(define (sub x y)
  (apply-generic 'sub x y))

(define (div x y)
  (apply-generic 'div x y))

(define (mul x y)
  (apply-generic 'mul x y))