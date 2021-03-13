#lang scheme

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define m '((1 2 3 4) (4 5 6 6) (6 7 8 9)))
(define (display-matrix m)
  (for-each (lambda (x)
              (display x)
              (newline))
            m))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(dot-product '(1 2 3) '(1 2 3))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

; can be done with dot-product
(define (matrix-*-vector m v)
  (map * (accumulate-n + 0 m) v))

(matrix-*-vector m '(1 2 3 4))

(define (transpose mat)
  (accumulate-n cons '() mat))
(transpose m)

; can be done with matrix-*-vector
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x)
           (map (lambda (y)
                  (dot-product x y))
                cols))
         m)))

(define mat '((1 2 3) (4 5 6)))
(define n-mat '((1 4) (2 5) (3 6)))
(matrix-*-matrix mat n-mat)