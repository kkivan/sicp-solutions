
#lang scheme

(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (* sub-tree sub-tree)))
       tree))

(define t (list 1 (list 2 3 4) (list 5 6 (list 7 8 9))))

(square-tree t)


