#lang scheme

(require "streams.scm")
(require "modules/sicp/sicp.rkt")

(define (random-nums requests initial)
  (define (random-update prev)
    (remainder (+ (* 13 prev) 5) 24))
  (let ((request (stream-car requests)))
    (cond ((eq? (car request) 'generate) (cons-stream (random-update initial)
                                                      (random-nums (stream-cdr requests) (random-update initial))))
          ((eq? (car request) 'reset) (random-nums (stream-cdr requests) (cdr request)))
          (else "Bad request"))))

(define req-stream
  (cons-stream (cons 'generate nil)
               (cons-stream (cons 'generate nil)
                            (cons-stream (cons 'reset 5)
                                         (cons-stream (cons 'generate nil)
                                                      the-empty-stream)))))

(take (random-nums req-stream 1) 3)
(take (random-nums req-stream 2) 3)
(take (random-nums req-stream 3) 3)


              