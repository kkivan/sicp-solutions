#lang sicp

(#%require sicp-pict)

(define (make-vect x y)
  (cons x y))

(define (make-segment v1 v2)
  (list v1 v2))

(define outline (list (make-segment (make-vect 0 0)
                                    (make-vect 0 1))
                      (make-segment (make-vect 0 1)
                                    (make-vect 1 1))
                      (make-segment (make-vect 1 1)
                                    (make-vect 1 0))
                      (make-segment (make-vect 1 0)
                                    (make-vect 0 0))))

(define x (list (make-segment (make-vect 0 0)
                              (make-vect 1 1))
                (make-segment (make-vect 0 1)
                              (make-vect 1 0))))

(define diamond (list (make-segment (make-vect 0 1)
                                    (make-vect 1 0))
                      (make-segment (make-vect 1 0)
                                    (make-vect 2 1))
                      (make-segment (make-vect 2 1)
                                    (make-vect 1 2))
                      (make-segment (make-vect 1 2)
                                    (make-vect 0 1))))