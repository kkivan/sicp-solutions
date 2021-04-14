#lang scheme

(require "modules/sicp/sicp.rkt")
(provide get
         put
         apply-generic
         attach-tag
         type-tag
         contents
         put-coercion
         get-coercion
         coerce
         try-coerce
         dispatch-table
         raise-type
         higher-type?
         try-up-cast
         up-cast
         raise)

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
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if (not (null? proc))
          (apply proc (map contents args))
          (apply apply-generic (cons op (up-cast args)))))))

(define (coerce args)
  (let ((type-tags (map type-tag args)))
      (if (= (length args) (length (try-coerce type-tags args)))
          (try-coerce type-tags args)
          (try-coerce (cdr type-tags) args))))
          
(define (try-coerce types args)
  (if (pair? types)
      (let ((type (car types)))
        (if (pair? args)
            (let ((arg (car args)))
              (let ((proc (get-coercion (type-tag arg) type)))
                (if (null? proc)
                    nil
                    (cons (proc arg) (try-coerce types (cdr args))))))
            nil))
      nil))

(define coercion-table '())

(define (put-coercion t1 t2 coer)
  (set! coercion-table (cons (cons (list t1 t2) coer) coercion-table)))

(define (coer-types coer)
  (car coer))

(define (coer-proc coer)
  (cdr coer))

(define (get-coercion t1 t2)
  (if (eq? t1 t2)
      (lambda (x) x)
      (let ((rows (filter (lambda (row)
                            (equal? (list t1 t2) (coer-types row)))
                          coercion-table)))
        (if (pair? rows)
            (coer-proc (car rows))
            nil))))

(define types-tower '(scheme-number rat complex))

(define (raise x)
  (let ((from (type-tag x))
        (to (raise-type (type-tag x))))
    (if (null? to)
        nil
        ((get-coercion from to) x))))

(define (raise-type x)
  (let ((up-types (cdr (memq x types-tower))))
    (if (null? up-types)
        nil
        (car up-types))))

(define (higher-type? t1 t2)
  (< (length (memq t1 types-tower))
     (length (memq t2 types-tower))))

(define (up-cast args)
  (let ((first-type (type-tag (car args))))
    (if (all-satisfy (lambda (x)
                       (eq? (type-tag x) first-type))
                     args)
        args
        (up-cast (try-up-cast args)))))
 
  
(define (try-up-cast args)
  (if (not (null? (cdr args)))
      (let ((first (car args))
            (second (cadr args)))
        (cond ((eq? (type-tag first)
                    (type-tag second)) (cons first (try-up-cast (cdr args))))
              ((higher-type? (type-tag first)
                             (type-tag second)) (try-up-cast (cons first
                                                                   (cons (raise second)
                                                                         (cddr args)))))
              (else (try-up-cast (cons (raise first)
                                       (cdr args))))))
      args))