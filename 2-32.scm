
#lang scheme

(define (subsets s)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map subsets rest)))))

(subsets (list 1 2 3))