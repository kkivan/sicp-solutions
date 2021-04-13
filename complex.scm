#lang scheme

(require "dispatch-table.scm")

(provide make-complex-real-imag
         real
         imag)

(define (make-complex-real-imag real imag)
  (attach-tag 'complex (cons real imag)))
 
(define (real complex)
  (car complex))

(define (imag complex)
  (cdr complex))