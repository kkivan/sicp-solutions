#lang scheme

(define x (list (list 1 2) (list 3 4)))

(define (fringe t)
  (cond ((pair? t) (append (fringe (car t)) (fringe (cdr t))))
        ((null? t) '())
        (else (list t))))

(fringe x)

(fringe (list x x))
