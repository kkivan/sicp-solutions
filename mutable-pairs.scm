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
         caddr
         caadr
         cdadr
         cddr
         cadddr
         cdddr
         cdar
         append)

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
(define append mappend)
  
(define (cadr pair) (car (cdr pair)))

(define (caddr p) (car (cdr (cdr p))))

(define (caadr p) (car (car (cdr p))))

(define (cdadr p) (cdr (car (cdr p))))

(define (cddr pair) (cdr (cdr pair)))

(define (cadddr pair) (car (cdr (cdr (cdr pair)))))

(define (cdddr pair) (cdr (cdr (cdr pair))))

(define (cdar pair) (cdr (car pair)))


