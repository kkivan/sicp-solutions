
#lang scheme

(define (tree-map proc tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map proc sub-tree)
             (proc sub-tree)))
       tree))

(define t (list 1 (list 2 3 4) (list 5 6 (list 7 8 9))))

(define (square x) (* x x))

(tree-map square t)


