#lang scheme

(require "streams.scm")

(define (integrate-series s)
  (div-streams s integers))

(define exp-series
  (cons-stream 1 (integrate-series exp-series)))

(define cosine-series 
  (cons-stream 1 (stream-map - (integrate-series sine-series))))

(define sine-series 
  (cons-stream 0 (integrate-series cosine-series)))

(take exp-series 10)

(take cosine-series 10)

(take sine-series 10)

(define (mul-series s1 s2) 
     (cons-stream (* (stream-car s1) (stream-car s2)) 
                  (add-streams (scale-stream (stream-cdr s1) (stream-car s2)) 
                               (mul-series (stream-cdr s2) s1))))

(define (S Sr)
  (cons-stream 1 Sr))

(define (invert-unit-series s)
  (cons-stream 1 (scale-stream (mul-series s
                                           (invert-unit-series s))
                               -1)))

;(take (invert-unit-series integers) 10)

(define (div-series num den)
  (if (= (stream-car den) 0)
      (error "zero division")
      (mul-series num
                  (invert-unit-series den))))

(define tangent-series (div-series sine-series cosine-series))


(define (partial-sums s) 
   (add-streams s (cons-stream 0 (partial-sums s)))) 
  
(define (pi-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (pi-summands (+ n 2)))))

(define pi-stream
  (scale-stream (partial-sums (pi-summands 1)) 4))

;(take pi-stream 1000)

;(take (pi-summands 1) 10)

(define (square x)
  (* x x ))

(define (euler-transform s)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1))
        (s2 (stream-ref s 2)))
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))

(stream-ref pi-stream 100)
(stream-ref (euler-transform pi-stream) 100)
(stream-ref (euler-transform (euler-transform pi-stream)) 100)
(stream-ref (euler-transform (euler-transform (euler-transform pi-stream))) 100)

(define (make-tableau transform s)
  (cons-stream s (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car (make-tableau transform s)))

(take (accelerated-sequence euler-transform pi-stream) 10)
 
(define (stream-limit s tolerance)
  (let ((first (stream-car s))
        (second (stream-car (stream-cdr s))))
  (if (>= tolerance (abs (- first second)))
      second
      (stream-limit (stream-cdr s) tolerance))))

(stream-limit (accelerated-sequence euler-transform pi-stream) 0.001)

(define (ln2-summands n)
  (cons-stream (/ 1.0 n)
               (stream-map - (ln2-summands (+ n 1)))))

(define ln2-stream
  (partial-sums (ln2-summands 1)))

(stream-ref ln2-stream 100)

(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(take (interleave integers integers) 10)

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x)
                  (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

; 198 pairs precede (1, 100)
(stream-ref (pairs integers integers) 199)

; all integers 99 times precedes (99, 100)
; all integers 100 times precedes (100, 100)
(take (pairs integers integers) 10)


