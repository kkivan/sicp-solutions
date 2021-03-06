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
         stream-ref
         stream-filter
         integers
         ones
         take
         the-empty-stream
         to-stream
         scan)

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
  (map (lambda (x) (stream-ref s x))
       (enumerate-interval 0 (- n 1))))

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

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))


(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter
                       pred
                       (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define (to-stream list)
  (cons-stream (car list)
               (if (null? (cdr list))
                   the-empty-stream
                   (to-stream (cdr list)))))

(define (scan stream initial proc)
  (if (stream-null? stream)
      the-empty-stream
      (let ((result (proc initial (stream-car stream))))
        (cons-stream result
                 (scan (stream-cdr stream) result proc)))))

