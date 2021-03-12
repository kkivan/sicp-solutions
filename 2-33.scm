#lang scheme

(define nil '())

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
  
(define (map p sequence)
  (accumulate (lambda (x y)
                    (append y (list (p x)))) nil sequence))

(define (append seq1 seq2)
  (accumulate cons seq1 seq2))

(define (length sequence)
  (accumulate (lambda (x y) (+ y 1)) 0 sequence))

(define (square x) (* x x))

(define l (list 1 2 3))

(map square l)
(append l l)
(length l)