#lang scheme

(require "2-67.scm")
(require "2-68.scm")
(require "modules/sicp/sicp.rkt")

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge pairs)
  (let ((pair (car pairs)))
    (if (null? (cdr pairs))
        (car pairs)
        (let ((first (car pairs)) 
              (second (cadr pairs)) 
              (rest (cddr pairs))) 
          (successive-merge (adjoin-set (make-code-tree first second) 
                                        rest))))))

(define test-tree (generate-huffman-tree '((A 3) (B 5) (C 6) (D 6)))) 

(assert (encode '(A B C D) test-tree) '(0 0 0 1 1 1 1 0))
