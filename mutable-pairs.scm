#lang scheme

(require "modules/sicp/sicp.rkt")

(provide cons
         list
         car
         cdr
         set-car!
         set-cdr!
         pair?)

(define cons mcons)
(define car mcar)
(define cdr mcdr)
(define set-car! set-mcar!)
(define set-cdr! set-mcdr!)
(define pair? mpair?)
(define list mlist)