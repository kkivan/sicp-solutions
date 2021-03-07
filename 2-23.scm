#lang scheme

(define (for-each proc list)
  (cond ((null? list) '())
        (else (proc (car list))
              (for-each proc (cdr list)))))

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

(list 1 (list 2 (list 3 4)))