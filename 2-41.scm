;Write a procedure to find all ordered triples of distinct positive integers i , j , and k less ;than or equal to a given integer n that sum to a given integer s.

#lang scheme

(define nil '())

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))
(define accumulate fold-right)

(define (enumerate-interval start end)
  (if (> start end)
      nil
      (cons start (enumerate-interval (+ start 1) end))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (unique-pairs n)
  (flatmap
   (lambda (i)
     (map (lambda (j) (list i j))
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))

(define (sum seq)
  (fold-right + 0 seq))

(define (permutations s k)
  (if (or (null? s) (= k 0))
      (list nil) 
      (filter (lambda (x) (= (length x) k))
              (flatmap (lambda (x)
                 (map (lambda (p) (cons x p))
                      (permutations (filter (lambda (i) (> i x))
                                            s)
                                    (- k 1))))
               s))))

(permutations (list 1 2 3 4 5) 3)

(define (triplets n s)
  (filter (lambda (triplet)
            (= (sum triplet) s))
          (permutations (enumerate-interval 1 n) 3)))

(triplets 6 10)