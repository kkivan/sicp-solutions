#lang scheme

(require "modules/sicp/sicp.rkt")

; tree
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                             (right-branch tree)
                             result-list)))))
  (copy-to-list tree '()))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree
                                 (cdr non-left-elts)
                                 right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree
                       this-entry left-tree right-tree)
                      remaining-elts))))))))

; set

(define (make-set list)
  (list->tree list))

(define (all-elements set)
  (tree->list set))

; change to tree O(n) -> O(logn)
(define (element-of-set? x set)
  (if (null? set)
      false
      (let ((value (entry set)))
        (cond ((null? value) false)
              ((equal? x value) true)
              ((< x value) (element-of-set? x (left-branch set)))
              (else (element-of-set? x (right-branch set)))))))

(define (balance tree)
  (list->tree (tree->list tree)))

(define (adjoin-set x set)
  (cond ((null? set) (make-set (list x)))
        ((= x (entry set)) set)
        ((< x (entry set)) (make-tree (entry set)
                                      (adjoin-set x (left-branch set))
                                      (right-branch set)))
        (else (make-tree (entry set)
                         (left-branch set)
                         (adjoin-set x (right-branch set))))))

;Use the results of Exercise 2.63 and Exercise 2.64 to give Θ(n) implementations of union-set and ;intersection-set for sets implemented as (balanced) binary trees.41

(define (intersection-set set1 set2)
  (let ((list (tree->list set2)))
    (let ((intersected-list (filter (lambda (x)
                                      (element-of-set? x set1))
                                    list)))
      (list->tree intersected-list))))

(define (union-set set1 set2)
  (define (iter set list)
    (if (null? list)
        (balance set)
        (iter (adjoin-set (car list) set) (cdr list))))
  (iter set1 (tree->list set2)))

(assert (balance (adjoin-set 3 (make-set '(1 2 4 5))))
        (make-set '(1 2 3 4 5)))

(assert (intersection-set (make-set '(1 2 4 5))
                          (make-set '(1 2 3)))
        (make-set '(1 2)))

(assert (union-set (make-set '(1 2 3 4 6))
                   (make-set '(1 2 5)))
        (make-set '(1 2 3 4 5 6)))
