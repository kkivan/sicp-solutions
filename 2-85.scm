#lang scheme

(require "dispatch-table.scm")
(require "modules/sicp/sicp.rkt")
(require "2-79.scm")
(require "modules/sicp/rat.scm")
(require "complex.scm")

(put-coercion 'complex 'rat (lambda (comp)
                              (make-rat (real (contents comp)) 1)))

(put-coercion 'rat 'scheme-number (lambda (rat)
                                    (numer (contents rat))))

(define (push-type type)
  (let ((down-types (cdr (memq type reversed-types-tower))))
    (if (pair? down-types)
        (car down-types)
        nil)))

(assert (push-type 'rat)
        'scheme-number)

(assert (push-type 'scheme-number)
        nil)

(define (drop arg)
  (let ((pushed ((get-coercion (type-tag arg) (push-type (type-tag arg))) arg)))
    (if (equ? arg (raise pushed))
        pushed
        arg)))

(assert (drop (make-rat 3 1))
        3)

(assert (drop (make-complex-real-imag 3 0))
        (make-rat 3 1))

(assert (drop (make-rat 3 2))
        (make-rat 3 2))