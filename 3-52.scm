#lang scheme

(define sum 0)

(define (accum x) (set! sum (+ x sum)) sum)

(define seq
  (stream-map accum
              (stream-enumerate-interval 1 20)))
; sum == 1

(define y (stream-filter even? seq))
; sum == 6
; note that we check sum for even, not an int from the interval

(define z
  (stream-filter (lambda (x) (= (remainder x 5) 0))
                 seq))
; sum == 10

(stream-ref y 7)
; sum == 136
(display-stream z)
; sum == 210