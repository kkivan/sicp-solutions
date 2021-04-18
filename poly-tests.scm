#lang scheme

(require "modules/sicp/sicp.rkt")
(require "dispatch-table.scm")
(require "math.scm")
(require "poly.scm")
(require "scheme-number.scm")

(install-polynomial-package)
(install-package-scheme-number)

(assert (variable (contents (make-poly 'x '((1 2) (3 4)))))
        'x)

(assert (term-list (contents (make-poly 'x '((1 2) (3 4)))))
        '((1 2) (3 4)))

(assert (add (make-poly 'x '((1 2) (3 4)))
             (make-poly 'x '((1 2) (3 4))))
        (make-poly 'x '((1 4) (3 8))))

        