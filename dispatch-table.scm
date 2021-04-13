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
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if (not (null? proc))
          (apply proc (map contents args))
          (apply apply-generic (cons op (coerce args)))))))

(define (coerce args)
  (let ((type-tags (map type-tag args)))
    (if (= (length args) 2)
        (let ((type1 (car type-tags))
              (type2 (cadr type-tags))
              (a1 (car args))
              (a2 (cadr args)))
          (let ((t1->t2 (get-coercion type1 type2))
                (t2->t1 (get-coercion type2 type1)))
            (cond ((not (null? t1->t2))
                   (list (t1->t2 a1) a2)) ; return args
                  ((not (null? t2->t1))
                   (list a1 (t2->t1 a2))) ; return args
                  (else
                   (error "No method for these types"
                          (list type-tags))))))
        (error "No method for these types"
               (list type-tags)))))

(define (try-coerce type args)
  (if (pair? args)
      (let ((arg (car args)))
        (let ((proc (get-coercion (type-tag arg) type)))
          (if (null? proc)
              nil
              (cons (proc arg) (try-coerce type (cdr args))))))
      nil))

(define coercion-table '())

(define (put-coercion t1 t2 coer)
  (set! coercion-table (cons (cons (list t1 t2) coer) coercion-table)))

(define (coer-types coer)
  (car coer))

(define (coer-proc coer)
  (cdr coer))

(define (get-coercion t1 t2)
  (let ((rows (filter (lambda (row)
                        (equal? (list t1 t2) (coer-types row)))
                      coercion-table)))
    (if (pair? rows)
        (coer-proc (car rows))
        nil)))




