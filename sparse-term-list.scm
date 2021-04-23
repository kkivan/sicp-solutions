#lang scheme

(require "dispatch-table.scm")
(require "math.scm")
(require "term.scm")

(provide install-sparse-term-list-package
         make-sparse-term-list)

(define (make-sparse-term-list terms)
  (attach-tag 'sparse (filter (lambda (term)
                                (not (=zero? (coeff term))))
                              terms)))
         
(define (install-sparse-term-list-package)
  (put 'first-term '(sparse) (lambda (list)
                               (car list)))
  (put 'rest-terms '(sparse) (lambda (list)
                               (attach-tag 'sparse (cdr list))))
  )