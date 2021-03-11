
#lang scheme

(define (subsets s)
  (display s)
  (newline)
  (if (null? s)
      (list '())
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x))
                          rest)))))

(subsets (list 1 2 3))


