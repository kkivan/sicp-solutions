#lang scheme

(require "modules/sicp/sicp.rkt")
(require "table.scm")

(define (fib n)
  (display n)
  (newline)
  (cond ((= n 0) 0) ((= n 1) 1)
        (else (+ (fib (- n 1)) (fib (- n 2))))))

(define (lookup key table)
  ((table 'lookup-proc) key))
(define (insert! key value table)
  ((table 'insert-proc!) key value))

(define (memoize f)
  (let ((table (make-table equal?)))
    (lambda (x)
      (let ((previously-computed-result
             (lookup (mlist x) table)))
        (or previously-computed-result
            (let ((result (f x))) (insert! (mlist x) result table) result))))))

(define memo-fib
  (memoize
   (lambda (n)
     (display n)
     (newline)
     (cond ((= n 0) 0)
           ((= n 1) 1)
           (else (+ (memo-fib (- n 1))
                    (memo-fib (- n 2))))))))

(memo-fib 8) ; memoization works as expected

(define m (memoize fib)) ; memoization doesn't work as original fib procedure calls fib not a new memoizated lambda
(m 8)

(set! fib (memoize fib)) ; memoization works because we redefined original fib procedure with memoizaited version of itself
(fib 8)


