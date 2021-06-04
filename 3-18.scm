#lang scheme

(require "modules/sicp/sicp.rkt")

(define (last-pair x)
  (if (null? (mcdr x))
      x
      (last-pair (mcdr x))))

(define (make-cycle x)
  (set-mcdr! (last-pair x) x) x)

(define (mlist args)
  (fold-right mcons '() args))

(define (cycle? l)
  (let ((visited '()))
    (define (iter l)
      (cond ((not (mpair? l)) #f)
            ((memq (mcar l) visited) #t)
            (else (begin (set! visited (cons (mcar l) visited))
                         (iter (mcdr l))))))
    (iter l)))


(assert (cycle? (mlist '(a b c)))
        #f)

(assert (cycle? (make-cycle (mlist '(a b c))))
        #t)