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

; solution 
(define empty-board nil)
(define (safe-t? k positions) #t)

(define (safe? col positions)
  (let ((candidate (car positions))
        (rest (cdr positions)))
    (if (null? rest)
        #t
        (not (contains? (lambda (x)
                          (conflict? x candidate))
                        rest)))))  

(define (contains? condition list)
  (cond ((not (pair? list)) #f)
        ((condition (car list)) #t)
        (else (contains? condition (cdr list)))))

(define (conflict? a b)
  (let ((ax (car a))
        (ay (cadr a))
        (bx (car b))
        (by (cadr b)))
    (or (= ax bx)
        (= (abs (- ax bx)) (abs (- ay by))))))

(define (adjoin-position row col rest-of-queens)
  (cons (list row col) rest-of-queens))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions)
           (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)      
                   (adjoin-position new-row
                                    k
                                    rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(length (queens 8))

