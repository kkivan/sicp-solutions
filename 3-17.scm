#lang scheme

(define (four)
  (define x (cons 1 '()))
  (define y (cons x x))
  (define z (cons y '()))
  z)

(define (three) '(1 2 3))

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(define (mcount-pairs x)
  (if (not (mpair? x))
      0
      (+ (mcount-pairs (mcar x))
         (mcount-pairs (mcdr x))
         1)))

(define (infinity)
  (define z (mcons 1 '()))
  (define x (mcons z '()))
  (define y (mcons x '()))
  (begin (set-mcdr! x y)
         y))

(count-pairs (four))

(count-pairs (three))

(mcount-pairs (infinity))