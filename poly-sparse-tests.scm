#lang scheme

(require "modules/sicp/sicp.rkt")
(require "dispatch-table.scm")
(require "math.scm")
(require "poly.scm")
(require "scheme-number.scm")
(require "sparse-term-list.scm")

(install-polynomial-package)
(install-package-scheme-number)
(install-sparse-term-list-package)

(define (run-poly-tests)
  (list 
   (assert (variable (contents (make-poly 'x
                                          (make-sparse-term-list '((3 4)(1 2))))))
           'x)

   (assert (term-list (contents (make-poly 'x
                                           (make-sparse-term-list '((3 4)(1 2))))))
           '(sparse (3 4)(1 2)))

   (assert (add (make-poly 'x
                           (make-sparse-term-list '()))
                (make-poly 'x
                           (make-sparse-term-list '())))
           (make-poly 'x
                      (make-sparse-term-list '())))

   (assert (add (make-poly 'x
                           (make-sparse-term-list '((3 4) (1 2) )))
                (make-poly 'x
                           (make-sparse-term-list '((3 4) (2 2) ))))
           (make-poly 'x
                      (make-sparse-term-list '((3 8) (2 2) (1 2)))))

   (assert (add (make-poly 'x
                           (make-sparse-term-list '((4 0)(3 4)(1 2))))
                (make-poly 'x
                           (make-sparse-term-list '((3 4)(1 2)))))
           (make-poly 'x
                      (make-sparse-term-list '((3 8)(1 4)))))
   
   (assert (=zero? (make-poly 'x
                              (make-sparse-term-list '((3 0)(1 0)))))
           true)
   
   (assert (negate (make-poly 'x
                              (make-sparse-term-list '((3 4)(1 2)))))
           (make-poly 'x
                      (make-sparse-term-list '((3 -4)(1 -2)))))

   (assert (negate (make-sparse-term-list '()))
           (make-sparse-term-list '()))
                   
   (assert (make-poly 'x
                      (make-sparse-term-list '((3 0)(1 0))))
           (make-poly 'x
                      (make-sparse-term-list '())))

   (assert (sub (make-poly 'x
                           (make-sparse-term-list '((3 4)(1 2))))
                (make-poly 'x
                           (make-sparse-term-list '((3 4)(1 2)))))
           (make-poly 'x
                      (make-sparse-term-list '())))
   
   (assert (sub (make-poly 'x
                           (make-sparse-term-list '()))
                (make-poly 'x
                           (make-sparse-term-list '((3 4)(1 2)))))
           (make-poly 'x
                      (make-sparse-term-list '((3 -4)(1 -2)))))
  
  (assert (div (make-poly 'x
                          (make-sparse-term-list '((5 1)(0 -1))))
               (make-poly 'x
                          (make-sparse-term-list '((2 1)(0 -1)))))
          (list (make-poly 'x
                           (make-sparse-term-list '((3 1)(1 1))))
                (make-poly 'x
                           (make-sparse-term-list '((1 1) (0 -1))))))
  )
  )

(run-poly-tests)



