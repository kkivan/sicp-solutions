#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) nil)
        ((element-of-set? (car set1) set2) (cons (car set1)
                                                 (intersection-set (cdr set1)
                                                                   set2)))
        (else (intersection-set (cdr set1) set2))))


(adjoin-set 4 (list 1 2 3))

(intersection-set (list 1 2 4 5) (list 1 2 3))

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((element-of-set? (car set1) set2) (union-set (cdr set1) set2))
        (else (union-set (cdr set1) (adjoin-set (car set1) set2)))))
  
(union-set (list 1 2 3) (list 3 4 2 5))


