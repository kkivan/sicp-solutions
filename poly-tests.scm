#lang scheme

(require "modules/sicp/sicp.rkt")
(require "dispatch-table.scm")
(require "math.scm")
(require "poly.scm")
(require "scheme-number.scm")

(install-polynomial-package)
(install-package-scheme-number)

(define (run-poly-tests)
  (list 
   (assert (variable (contents (make-poly 'x '((1 2) (3 4)))))
           'x)

   (assert (term-list (contents (make-poly 'x '((1 2) (3 4)))))
           '((1 2) (3 4)))

   (assert (add (make-poly 'x '((1 2) (3 4)))
                (make-poly 'x '((1 2) (3 4))))
           (make-poly 'x '((1 4) (3 8))))
   
   (assert (add (make-poly 'x '((1 2) (3 4)))
                (make-poly 'x '((2 2) (3 4))))
           (make-poly 'x '((1 2) (2 2) (3 8))))

   (assert (=zero? (make-poly 'x '((1 0) (3 0))))
           true)
   
   (assert (negate (make-poly 'x '((1 2) (3 4))))
           (make-poly 'x '((1 -2) (3 -4))))

   (assert (make-poly 'x '((1 0) (3 0)))
            (make-poly 'x '()))

   (assert (sub (make-poly 'x '((1 2) (3 4)))
                (make-poly 'x '((1 2) (3 4))))
           (make-poly 'x '()))
   
           )
   )


  (run-poly-tests)

  