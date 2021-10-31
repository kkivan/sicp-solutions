#lang scheme

(require "modules/sicp/sicp.rkt")

(define (mcaar pair)
  (mcar (mcar pair)))

(define (make-table same-key?)
  (define (lookup key-1 key-2 table)
    (let ((subtable
           (assoc key-1 (mcdr table))))
      (if subtable
          (let ((record
                 (assoc key-2 (mcdr subtable))))
            (if record
                (mcdr record)
                false))
          false)))

  (define (assoc key records)
    (cond ((null? records) false)
          ((same-key? key (mcaar records)) (mcar records))
          (else (assoc key (mcdr records)))))

  (define (insert! key-1 key-2 value table)
    (let ((subtable (assoc key-1 (mcdr table))))
      (if subtable
          (let ((record (assoc key-2 (mcdr subtable))))
            (if record
                (set-mcdr! record value) (set-mcdr! subtable
                                                    (mcons (mcons key-2 value)
                                                           (mcdr subtable)))))
          (set-mcdr! table
                     (mcons (list key-1
                                  (cons key-2 value))
                            (mcdr table)))))
    'ok)
  (let ((local-table (mlist '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable
             (assoc key-1 (mcdr local-table))))
        (if subtable
            (let ((record
                   (assoc key-2 (mcdr subtable))))
              (if record (mcdr record) false)) false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable
             (assoc key-1 (mcdr local-table))))
        (if subtable
            (let ((record
                   (assoc key-2 (cdr subtable))))
              (if record
                  (set-mcdr! record value) (set-mcdr! subtable
                                                      (mcons (mcons key-2 value)
                                                             (mcdr subtable)))))
            (set-mcdr! local-table
                       (mcons (mlist key-1 (mcons key-2 value))
                              (mcdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation: TABLE" m))))
    dispatch))

(define t (make-table equal?))

(assert ((t 'insert-proc!) 'cities 'bangkok 333)
        'ok)
(assert ((t 'lookup-proc) 'cities 'bangkok)
        333)

