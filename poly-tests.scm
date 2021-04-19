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
   (assert (variable (contents (make-poly 'x '((3 4)(1 2)))))
           'x)

   (assert (term-list (contents (make-poly 'x '((3 4)(1 2)))))
           '((3 4)(1 2)))

   (assert (add (make-poly 'x '((4 0)(3 4)(1 2)))
                (make-poly 'x '((3 4)(1 2))))
           (make-poly 'x '((3 8)(1 4))))
   
   (assert (add (make-poly 'x '((3 4) (1 2) ))
                (make-poly 'x '((3 4) (2 2) )))
           (make-poly 'x '((3 8) (2 2) (1 2))))

   (assert (=zero? (make-poly 'x '((3 0)(1 0))))
           true)
   
   (assert (negate (make-poly 'x '((3 4)(1 2))))
           (make-poly 'x '((3 -4)(1 -2))))

   (assert (make-poly 'x '((3 0)(1 0)))
           (make-poly 'x '()))

   (assert (sub (make-poly 'x '((3 4)(1 2)))
                (make-poly 'x '((3 4)(1 2))))
           (make-poly 'x '()))

    (assert (sub (make-poly 'x '())
                (make-poly 'x '((3 4)(1 2))))
           (make-poly 'x '((3 -4)(1 -2))))
   
   )
  )


(run-poly-tests)

