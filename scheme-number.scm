#lang scheme

(require "dispatch-table.scm")

(provide install-package-scheme-number)

(define (install-package-scheme-number)
  (put 'add '(scheme-number scheme-number) +)
  
  (put 'sub '(scheme-number scheme-number) -)
  
  (put 'div '(scheme-number scheme-number) /)
  
  (put 'mul '(scheme-number scheme-number) *)
  
  (put '=zero? '(scheme-number) (lambda (x) (= x 0))))
