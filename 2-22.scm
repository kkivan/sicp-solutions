#lang scheme

(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (square x)
  (* x x))

(define (reverse l)
  (define (iter source target)
    (if (null? source)
        target
        (iter (cdr source)
              (cons (car source) target))))
  (iter l '()))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things)) answer))))
  (reverse (iter items '())))

(square-list (list 1 2 3 4))
