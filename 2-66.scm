#lang scheme

(require "modules/sicp/sicp.rkt")
(require "modules/sicp/tree.rkt")

(define make-record cons)
(define key car)
(define value cdr)

(define (lookup k records)
  (if (null? records)
      nil
      (let ((key (key (entry records))))
        (cond ((null? key) nil)
              ((equal? k key) (value (entry records)))
              ((< k key) (lookup k (left-branch records)))
              (else (lookup k (right-branch records)))))))

(lookup 2 (make-tree (make-record 4 "a")
                     (make-tree (make-record 2 "b")
                                nil
                                nil)
                     nil))

