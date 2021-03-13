#lang scheme

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x)
                         (if (pair? x)
                             (count-leaves x)
                             1)) t)))

(define (assert x y)
  (if (= x y)
      "passed"
      "failed"))

(define x (cons (list 1 2) (list 3 4)))

(assert (count-leaves x) 4)
(assert (count-leaves (list x x)) 8)
