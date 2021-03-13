#lang scheme


(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(fold-right - 1 (list 2 3 4))
;same as
(- 2 (- 3 (- 4 1)))

(fold-left - 1 (list 2 3 4))
;same as
(- (- (- 1 2) 3) 4)

(define nil '())
(fold-right list (list 0) (list 1 2 3))
(fold-left list (list 0) (list 1 2 3))