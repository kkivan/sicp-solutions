#lang scheme

(require "modules/sicp/sicp.rkt")
(require "dispatch-table.scm")

(define (num rat)
  (car rat))

(define (denom rat)
  (cdr rat))

(define (real complex)
  (car complex))

(define (imag complex)
  (cdr complex))

(define (make-rat num den)
  (attach-tag '(rat) (cons num den)))

(define (make-complex-real-imag real imag)
  (attach-tag '(complex) (cons real imag)))

(define (=zero? num)
  (apply-generic '=zero? num))

(put '=zero? '(scheme-number) (lambda (x) (= x 0)))
(put '=zero? '(rat) (lambda (rat) (=zero? (num rat))))
(put '=zero? '(complex) (lambda (comp) (and (=zero? (real comp))
                                            (=zero? (imag comp)))))

(assert (=zero? 0)
        true)

(assert (=zero? (make-rat 0 2))
        true)

(assert (=zero? (make-rat (make-rat 0 1) 2))
        true)

(assert (=zero? (make-complex-real-imag (make-rat 0 2) 0))
        true)