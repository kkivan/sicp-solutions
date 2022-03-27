#lang scheme

(require "streams.scm")

(define (merge-weighted s1 s2 weight-proc)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
         (let ((s1car (stream-car s1))
               (s2car (stream-car s2)))
           (cond ((< (weight-proc s1car)
                     (weight-proc s2car)) (cons-stream s1car
                                                       (merge-weighted (stream-cdr s1) s2 weight-proc)))
                 ((> (weight-proc s1car)
                     (weight-proc s2car)) (cons-stream
                                           s2car
                                           (merge-weighted s1 (stream-cdr s2) weight-proc)))
                 (else (cons-stream
                        s1car
                        (cons-stream s2car
                                    (merge-weighted (stream-cdr s1)
                                                    (stream-cdr s2)
                                                    weight-proc)))))))))

(define (weighted-pairs s t weight)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (merge-weighted
    (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t))
    (weighted-pairs (stream-cdr s) (stream-cdr t) weight) weight)))

(take (weighted-pairs integers
                      integers
                      (lambda (p)
                        (let ((f (car p))
                              (s (cadr p)))
                          (+ (* f f f)
                             (* s s s))
                        )))
      10)

      
