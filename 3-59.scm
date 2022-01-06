#lang scheme

(require "streams.scm")

(define (integrate-series s)
  (div-streams s integers))

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define cosine-series 
  (cons-stream 1 (stream-map - (integrate-series sine-series))))

(define sine-series 
  (cons-stream 0 (integrate-series cosine-series)))

(take exp-series 10)

(take cosine-series 10)

(take sine-series 10)

(define (mul-series s1 s2) 
     (cons-stream (* (stream-car s1) (stream-car s2)) 
                  (add-streams (scale-stream (stream-cdr s1) (stream-car s2)) 
                               (mul-series (stream-cdr s2) s1))))

(define (S Sr)
  (cons-stream 1 Sr))

(define (invert-unit-series s)
  (cons-stream 1 (scale-stream (mul-series s
                                           (invert-unit-series s))
                               -1)))

(take (invert-unit-series integers) 10)

(define (div-series num den)
  (if (= (stream-car den) 0)
      (error "zero division")
      (mul-series num
                  (invert-unit-series den))))

(define tangent-series (div-series sine-series cosine-series))                            