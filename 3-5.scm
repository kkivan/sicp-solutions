#lang scheme

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1)
                 trials-passed))))
  (iter trials 0))

(define (square x)
  (* x x))

(define (pre x y)
  (<= (+ (square (- x 5))
         (square (- y 7)))
      9))

(define (estimate-integral predicate x1 x2 y1 y2 trials)
  (define (exp)
    (predicate (random-in-range x1 x2)
               (random-in-range y1 y2)))
  (let ((rect-area (* (- x2 x1) (- y2 y1))))
    (* (monte-carlo trials exp)
       rect-area)))

(estimate-integral pre 2 8 4 10 100)



  