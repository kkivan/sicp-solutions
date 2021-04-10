#lang scheme

(require "modules/sicp/sicp.rkt")
(provide get
         put
         apply-generic
         attach-tag
         type-tag
         contents
         dispatch-table)

(define dispatch-table '())

(define (put op type proc)
  (set! dispatch-table (cons (list op type proc) dispatch-table)))

(define (dispatch-op row) (car row))

(define (dispatch-type row) (cadr row))

(define (dispatch-proc row) (caddr row))

(define (get op type)
  (let ((rows (filter (lambda (row)
                                (and (eq? op (dispatch-op row))
                                     (equal? type (dispatch-type row))))
                              dispatch-table)))
    (if (pair? rows)
        (dispatch-proc (car rows))
        nil)))

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

(define (apply-generic op . args)
  (let ((type-tags (flatmap type-tag args)))
    (let ((proc (get op type-tags)))
      (if (not (null? proc))
          (apply proc (map contents args))
          nil))))
