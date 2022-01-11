#lang scheme

(require "streams.scm")

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (interleave
   (stream-map (lambda (x)
                 (list (stream-car s) x)) t)
   (pairs (stream-cdr s)
          (stream-cdr t))))

;this implementation causes infinite recursion

(take (pairs integers integers) 20) ; never returns