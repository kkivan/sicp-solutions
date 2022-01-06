#lang scheme

(require "modules/sicp/sicp.rkt")

(provide cons-stream
         delay
         force
         stream-car
         stream-cdr
         stream-null?
         stream-map
         add-streams
         div-streams
         mul-streams
         scale-stream
         integers
         ones
         take)

(define (memo-func function)
  (let ((already-run? false)
        (result false))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (function))
                 (set! already-run? true)
                 result)
          result))))

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream a b)
     (cons a (memo-func (lambda () b))))))

(define (delay x)
  (lambda () x))

(define (force x)
  (x))

(define (stream-car s)
  (car s))

(define (stream-cdr s)
  (force (cdr s)))

(define (stream-null? s)
  (eq? s nil))
(define the-empty-stream nil)

(define (take s n)
  (if (or (stream-null? s)
          (= 0 n))
      nil
      (cons (stream-car s)
            (take (stream-cdr s) (- n 1)))))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (div-streams s1 s2)
  (stream-map / s1 s2))

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define integers
  (cons-stream 1 (add-streams ones integers)))

(define ones (cons-stream 1 ones))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor))
              stream))


