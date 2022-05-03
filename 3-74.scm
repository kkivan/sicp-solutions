#lang scheme

(require "streams.scm")
(require "modules/sicp/sicp.rkt")
    
(take (scan integers 0 +) 10)

(define (pairs partial current)
  (if (null? partial)
      (cons current nil)
      (if (null? (cdr partial))
                 (cons (car partial) current)
                 (cons (cdr partial) current))))

(define signal (to-stream '(1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.234)))

(take signal 100)


(define five (to-stream '(1 2 3 4 5)))

(take (scan five nil pairs) 5)


;(take (stream-filter (lambda (x) (not (null? (cdr x)))) (scan signal nil pairs)) 9)






  