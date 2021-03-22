#lang sicp

(#%require sicp-pict)

(define (split a b)
  (lambda (painter n)
      (if (= n 0)
      painter
      (let ((smaller ((split a b) painter (- n 1))))
        (a painter (b smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))

(paint (right-split einstein 2))
(paint (up-split einstein 2))