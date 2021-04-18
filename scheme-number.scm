#lang scheme

(require "dispatch-table.scm")

(provide install-package-scheme-number)

(define (install-package-scheme-number)
  (put 'add (list 'scheme-number 'scheme-number) +)
  (put 'sub (list 'scheme-number 'scheme-number) -)
  (put 'div (list 'scheme-number 'scheme-number) /)
  (put 'mul (list 'scheme-number 'scheme-number) *)
  (put '=zero? (list 'scheme-number 'scheme-number) (lambda (x) (= x 0))))
