#lang scheme

;(require "modules/sicp/sicp.rkt")
(require compatibility/mlist)
(provide cons
         list
         car
         cdr
         set-car!
         set-cdr!
         pair?
         list?
         map
         cadr
         length
         caddr)

(define cons mcons)
(define car mcar)
(define cdr mcdr)
(define set-car! set-mcar!)
(define set-cdr! set-mcdr!)
(define pair? mpair?)
(define list mlist)
(define list? mlist?)
(define map mmap)
(define length mlength)
  
(define (cadr pair)
  (car (cdr pair)))

(define (caddr p) (car (cdr (cdr p))))



