#lang scheme

(require "streams.scm")

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x)
                  (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

(define (triplets s1 s2 s3)
  (cons-stream
   (list (stream-car s1) (stream-car s2) (stream-car s3))
   (interleave
    (stream-map (lambda (x)
                  (cons (stream-car s1) x))
                (stream-cdr (pairs s2 s3)))
    (triplets (stream-cdr s1) (stream-cdr s2) (stream-cdr s3)))))

(define ts (triplets integers integers integers))

(define (square x)
  (* x x ))

(take (stream-filter (lambda (x)
                             (let ((i (car x))
                                   (j (car (cdr x)))
                                   (k (car (cdr (cdr x)))))
                               (= (+ (square i) (square j))
                                  (square k))
                               )) ts) 3)
