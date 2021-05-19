#lang scheme

(require "modules/sicp/sicp.rkt")

(define (make-monitored proc)
  (let ((counter 0))
   (lambda (x)
     (cond ((eq? x 'how-many-calls?) counter)
           ((eq? x 'reset-count) (set! counter 0))
           (else (set! counter (+ counter 1))
                 (proc x))))))

(define m (make-monitored sqrt))

(m 10)
(m 10)

(assert (m 'how-many-calls?)
        2)
(m 'reset-count)

(assert (m 'how-many-calls?)
        0)


