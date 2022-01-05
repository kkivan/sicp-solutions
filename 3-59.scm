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
 
(take sine-series 10)

   