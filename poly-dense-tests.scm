#lang scheme

(require "modules/sicp/sicp.rkt")
(require "dispatch-table.scm")
(require "math.scm")
(require "poly.scm")
(require "dense-term-list.scm")
(require "scheme-number.scm")
(require "term.scm")

(install-polynomial-package)
(install-package-scheme-number)
(install-dense-term-list-package)

(define (run-poly-tests)
  (list 
   (assert (variable (contents (make-poly 'x (make-dense-term-list '(4 0 2 0)))))
           'x)

   (assert (term-list (contents (make-poly 'x (make-dense-term-list '(4 0 2 0)))))
           (make-dense-term-list '(4 0 2 0)))
   
   (assert (add (make-poly 'x (make-dense-term-list '(0 4 0 2 0)))
                (make-poly 'x (make-dense-term-list '(4 0 2 0))))
           (make-poly 'x (make-dense-term-list '(0 8 0 4 0))))
   
   (assert (add (make-poly 'x (make-dense-term-list '(4 0 2 0)))
                (make-poly 'x (make-dense-term-list '(4 2 0 0))))
           (make-poly 'x (make-dense-term-list '(8 2 2 0))))

   (assert (=zero? (make-poly 'x (make-dense-term-list '(0 0 0 0))))
           true)
   
   (assert (negate (make-poly 'x (make-dense-term-list '(4 0 2 0))))
           (make-poly 'x (make-dense-term-list '(-4 0 -2 0))))

   (assert (sub (make-poly 'x (make-dense-term-list '(4 0 2 0)))
                (make-poly 'x (make-dense-term-list '(4 0 2 0))))
           (make-poly 'x (make-dense-term-list '(0 0 0 0))))

   (assert (sub (make-poly 'x (make-dense-term-list '()))
                (make-poly 'x (make-dense-term-list '(4 0 2 0))))
           (make-poly 'x (make-dense-term-list '(-4 0 -2 0))))
   
   (assert (div (make-poly 'x
                           (make-dense-term-list '(1 0 0 0 0 -1)))
                (make-poly 'x
                           (make-dense-term-list '(1 0 -1))))
           (list (make-poly 'x
                            (make-dense-term-list '(1 0 1 0)))
                            (make-poly 'x
                                       (make-dense-term-list '(1 -1))))))
   )
  

(define (run-adjoin-tests)
  (list
   (assert (adjoin-term (make-term 0 1)
                        (make-dense-term-list '(3 0 0 0)))
           (make-dense-term-list '(3 0 0 1)))

   (assert (adjoin-term (make-term 3 3)
                        (make-dense-term-list '(1 0)))
           (make-dense-term-list '(3 0 1 0)))
   
   (assert (adjoin-term (make-term 3 3)
                        (make-dense-term-list '(0)))
           (make-dense-term-list '(3 0 0 0)))
   (assert (adjoin-term (make-term 0 1)
                        (make-dense-term-list '(0)))
           (make-dense-term-list '(1)))

   (assert (adjoin-term (make-term 1 1)
                        (make-dense-term-list '(0)))
           (make-dense-term-list '(1 0)))

   (assert (adjoin-term (make-term 3 1)
                        (make-dense-term-list '(0)))
           (make-dense-term-list '(1 0 0 0)))

   (assert (adjoin-term (make-term 0 1)
                        (make-dense-term-list '(1 0 0 0)))
           (make-dense-term-list '(1 0 0 1)))

   ))
   
(run-poly-tests)
(run-adjoin-tests)
