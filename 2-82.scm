#lang scheme

(require "dispatch-table.scm")
(require "modules/sicp/rat.scm")
(require "modules/sicp/sicp.rkt")
(require "complex.scm")

(put-coercion 'scheme-number 'rat (lambda (n)
                                    (make-rat n 1)))

(assert (try-coerce '(rat) (list (make-rat 1 2)
                                 (make-rat 1 2)
                                 (make-rat 1 2)))
        (list (make-rat 1 2)
              (make-rat 1 2)
              (make-rat 1 2)))

(assert (try-coerce '(rat) (list (make-rat 1 2) 99))
        (list (make-rat 1 2) (make-rat 99 1)))

(assert (try-coerce '(rat) (list (make-rat 1 2)
                                 (make-complex-real-imag 1 2)
                                 (make-rat 3 4)))
        (list (make-rat 1 2)))

(assert (coerce (list (make-rat 1 2)
                      (make-rat 1 2)
                      4))
        (list (make-rat 1 2)
              (make-rat 1 2)
              (make-rat 4 1)))

