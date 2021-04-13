#lang scheme

(require "../../dispatch-table.scm")

(provide numer
         denom
         make-rat)

(define (numer rat)
  (car rat))

(define (denom rat)
  (cdr rat))

(define (make-rat num den)
  (attach-tag 'rat (cons num den)))