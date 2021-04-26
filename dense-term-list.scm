#lang scheme

(require "dispatch-table.scm")
(require "math.scm")
(require "term.scm")

(provide install-dense-term-list-package
         make-dense-term-list)

(define (make-dense-term-list terms)
  (attach-tag 'dense terms))

(define (install-dense-term-list-package)
  (put 'first-term '(dense) (lambda (list)
                              (make-term (length (cdr list)) (car list))))
  
  (put 'rest-terms '(dense) (lambda (list)
                              (attach-tag 'dense (cdr list))))

  (put 'adjoin-term '(dense)
       (lambda (term term-list)
         (cons (coeff term) term-list)))
  
  (put 'negate '(dense)
       (lambda (list)
         (attach-tag 'dense (map (lambda (coeff)
                                   (- 0 coeff)) list))))
  )