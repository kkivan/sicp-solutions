#lang scheme

(require "dispatch-table.scm")
(require "math.scm")
(require "term.scm")

(provide install-dense-term-list-package
         make-dense-term-list)

(define (make-dense-term-list terms)
  (attach-tag 'dense terms))

(define (install-dense-term-list-package)
  
  (define (first-term-dense term-list)
    (make-term (length (cdr term-list)) (car term-list)))

  (define (adjoin-term-dense term term-list)
    (if (null? term-list)
        (list (coeff term)) 
        (let ((o1 (order term))
              (o2 (order (first-term-dense term-list)))
              (first (first-term-dense term-list))
              (rest (cdr term-list)))
          (cond ((> o1 o2) (cons (coeff term) (adjoin-term-dense (make-term (- o1 1)
                                                                            0)
                                                                 term-list)))
                ((= o1 o2) (cons (add (coeff term)
                                      (coeff first))
                                 rest))
                ((< o1 o2) (adjoin-term-dense first
                                              (adjoin-term-dense term rest)))))))

  (put 'first-term '(dense) first-term-dense)
  
  (put 'rest-terms '(dense) (lambda (term-list)
                              (attach-tag 'dense (cdr term-list))))
  
  (put 'adjoin-term '(dense) adjoin-term-dense)

  (put 'negate '(dense)
       (lambda (term-list)
         (attach-tag 'dense (map (lambda (coeff)
                                   (negate coeff)) term-list))))
  )