#lang scheme

(provide get
         put)

(define dispatch-table '())

(define (put op type proc)
  (set! dispatch-table (cons (list op type proc) dispatch-table)))

(define (dispatch-op row) (car row))

(define (dispatch-type row) (cadr row))

(define (dispatch-proc row) (caddr row))

(define (get op type)
  (dispatch-proc (car (filter (lambda (row)
                                (and (eq? op (dispatch-op row))
                                     (eq? type (dispatch-type row))))
                              dispatch-table))))


