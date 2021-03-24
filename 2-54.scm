#lang sicp

(define (fringe t)
  (cond ((pair? t) (append (fringe (car t)) (fringe (cdr t))))
        ((null? t) '())
        (else (list t))))

(define (flat-equal? left right)
  (equal? (fringe left) (fringe right)))

(equal? '(this is a list) '(this is a list))

(flat-equal? '(this is a list) '(this (is a) list))

