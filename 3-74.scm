#lang scheme

(require "streams.scm")
(require "modules/sicp/sicp.rkt")
    
(define (pairs partial current)
  (if (null? partial)
      (cons current nil)
      (if (null? (cdr partial))
                 (cons (car partial) current)
                 (cons (cdr partial) current))))

(define signal (to-stream '(1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.234)))

(define (decode signal)
  (let ((l (car signal))
        (r (cdr signal)))
    (cond ((and (>= l 0) (< r 0)) -1)
          ((and (< l 0) (>= r 0)) 1)
          (else 0))))

; alternative solution using scan
(define signal-pairs (stream-filter (lambda (x) (not (null? (cdr x)))) (scan signal nil pairs)))

(take signal-pairs 10)

(define decoded-signal (stream-map decode signal-pairs))

(take decoded-signal 10)











  