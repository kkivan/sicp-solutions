#lang scheme

(require "2-67.scm")
(require "modules/sicp/sicp.rkt")

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (encode-symbol symbol tree)
  (let ((left (left-branch tree))
        (right (right-branch tree)))
    (cond ((leaf? tree) nil)
          ((element-of-set? symbol (symbols left)) (cons 0 (encode-symbol symbol left)))
          ((element-of-set? symbol (symbols right)) (cons 1 (encode-symbol symbol right)))
          (else "ERROR symbol not found"))))
        
(define message '(A D A B B C A))

(assert (decode (encode message sample-tree) sample-tree) message)

