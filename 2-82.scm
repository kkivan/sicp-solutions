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

;This strategy assumes that only same type operators are registred
;Another shortcoming of this strategy is transition coercion, i.e.
;Given we have op registered for B B, expresion (op A B) and available coercions are A->C C->B
;this strategy fails even though we can apply A->C and C->B to A to coerce it B

