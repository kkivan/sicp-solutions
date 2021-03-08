#lang scheme

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))

(define m (list (list 1 (list 2 3)) (list 4 (list 5 6))))

(define (total-weight mobile)
  (display mobile)
  (newline)
  (cond ((pair? mobile) (+ (if (pair? (left-branch mobile))
                               (total-weight (left-branch mobile))
                               0)
                           (total-weight (right-branch mobile))))
        ((null? mobile) 0)
        (else mobile)))

(total-weight m)
