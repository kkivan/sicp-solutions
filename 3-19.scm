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

(define (jump l)
  (if (mpair? l)
      (mcdr l)
      nil))

(define (double-jump l) (jump (jump l)))

(define (cycle? l)
  (let ((slow l)
        (fast (double-jump l)))
    (define (advance)
      (cond ((or (null? slow)
                 (null? fast)) #f)
            ((eq? slow fast) #t)
            (else (begin (set! slow (jump slow)))
                         (set! fast (double-jump fast))
                         (advance))))
    (advance)))

(assert (cycle? (mlist '(a b c))) #f)

(assert (cycle? (make-cycle (mlist '(a b c)))) #t)


