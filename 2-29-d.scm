#lang scheme

(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (if (number? (left-branch branch))
      (left-branch branch)
      0))

(define (branch-structure branch)
  (cadr branch))

(define (total-weight mobile)
  (cond ((pair? mobile) (+ (if (pair? (left-branch mobile))
                               (total-weight (left-branch mobile))
                               0)
                           (total-weight (right-branch mobile))))
        ((null? mobile) 0)
        (else mobile)))

(define m (list (list 2 (list 2 12)) (list 4 (list 5 6))))
m
(total-weight m)

(define (branch-weight branch)
  (if (< 0 (branch-length branch))
      (* (branch-length branch) (total-weight (right-branch branch)))
      (branch-weight (left-branch branch))))

(define (mobile? m)
  (pair? (car m)))

(define (balanced? mobile)
  (let ((left (left-branch mobile))
        (right (right-branch mobile)))
    (if (mobile? mobile)
        (and  (= (branch-weight left)
                 (branch-weight right))
              (balanced? left)
              (balanced? right)
              )
        #t)))

(balanced? m)


  