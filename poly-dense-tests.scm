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
   (assert (variable (contents (make-poly 'x '(4 0 2 0))))
           'x)

   (assert (term-list (contents (make-poly 'x '(4 0 2 0))))
           '(4 0 2 0))

   (assert (add (make-poly 'x '(0 4 0 2 0))
                (make-poly 'x '(4 0 2 0)))
           (make-poly 'x '(8 0 4 0)))
   
   (assert (add (make-poly 'x '(4 0 2 0))
                (make-poly 'x '(4 2 0 0)))
           (make-poly 'x '(8 2 2 0)))

   (assert (=zero? (make-poly 'x '(0 0 0 0)))
           true)
   
   (assert (negate (make-poly 'x '(4 0 2 0)))
           (make-poly 'x '(-4 0 -2 0)))

   (assert (sub (make-poly 'x '(4 0 2 0))
                (make-poly 'x '(4 0 2 0)))
           (make-poly 'x '()))

    (assert (sub (make-poly 'x '())
                (make-poly 'x '(4 0 2 0)))
           (make-poly 'x '(-4 0 -2 0)))
   )
  )
   
  
(run-poly-tests)

