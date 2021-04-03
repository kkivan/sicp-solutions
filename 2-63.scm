#lang sicp

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                             (right-branch tree)
                             result-list)))))
  (copy-to-list tree '()))


(define t1 (make-tree 7
                     (make-tree 3
                                (make-tree 1 nil nil)
                                (make-tree 5 nil nil))
                     (make-tree 9
                                nil
                                (make-tree 11 nil nil))))

(define t2 (make-tree 3
                     (make-tree 1 nil nil)
                     (make-tree 7
                                (make-tree 5 nil nil)
                                (make-tree 9
                                           nil
                                           (make-tree 11 nil nil)))))

(define t3 (make-tree 5
                     (make-tree 3 (make-tree 1 nil nil) nil)
                     (make-tree 9
                                (make-tree 7 nil nil)
                                (make-tree 11 nil nil))))
                                          
(define trees (list t1 t2 t3))

(map tree->list-1 trees)
(map tree->list-2 trees)
