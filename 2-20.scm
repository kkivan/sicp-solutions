#lang scheme

(define (remainder-2 x)
  (remainder x 2))

(define (parity a b)
  (= (remainder-2 a) (remainder-2 b)))

(define (filter l predicate)
  (if (null? l)
      '()
      (let ((current (car l))
            (rest (cdr l)))
        (if (predicate current)
            (cons current (filter rest predicate))
            (filter rest predicate)))))
      
(define (same-parity a . b)
  (cons a (filter b (lambda (x) (parity a x)))))

(same-parity 1 2 3 4 5 6 7)

  

   