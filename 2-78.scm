#lang scheme

(require "modules/sicp/sicp.rkt")

(define (attach-tag tag contents)
  (if (eq? tag 'scheme-number)
      contents
      (cons tag contents)))

(define (type-tag datum)
  (if (number? datum)
      'scheme-number
      (if (pair? datum)
          (car datum)
          (error "Bad tagged datum - TYPE-TAG" datum))))

(define (contents datum)
  (if (number? datum)
      datum
      (if (pair? datum)
          (cdr datum)
          (error "Bad tagged datum - CONTENTS" datum))))

(assert (attach-tag 'scheme-number 1)
        1)

(assert (type-tag  1)
        'scheme-number)

(assert (contents (attach-tag 'scheme-number 1))
        1)
        

