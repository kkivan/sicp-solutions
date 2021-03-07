#lang scheme

;a (1 3 (5 7) 9)
;b ((7))
;c (1 (2 (3 (4 (5 (6 7))))))

(define a (list 1 3 (cons 5 7) 9))
(define b (cons (cons 7 '()) '()))
(define c (list 1 2 3 4 5 6 7))

(define (generate list)
  (cond ((null? (cdr (cdr list))) (cons (car list) (cdr list)))
        ((null? list) '())
        (else (cons (car list) (cons (generate (cdr list)) '())))))

(define d (generate c))

(cdr (cadr (cdr a)))

(car (car b))

(car (cdr (cadr (cadr (cadr (cadr (cadr d)))))))
