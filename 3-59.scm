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