#lang scheme

(require "modules/sicp/sicp.rkt")

(define (mcaar pair)
  (mcar (mcar pair)))

(define (make-table same-key?)
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

    (define (lookup keys) 
      (define (iter keys table) 
        (let ((subtable (assoc (mcar keys) (mcdr table)))) 
          (if subtable 
              (cond ((null? (mcdr keys)) (mcdr subtable)) 
                    (else (iter (mcdr keys) subtable))) 
              false))) 
      (iter keys local-table))
    
    (define (gen-new-list keys value) 
         (if (null? (mcdr keys)) 
             (mcons (mcar keys) value) 
             (mlist (mcar keys) (gen-new-list (mcdr keys) value)))) 
      
     (define (insert! keys value) 
       (define (iter keys table) 
         (let ((subtable (assoc (mcar keys) (mcdr table)))) 
           (if subtable 
               (cond ((null? (mcdr keys)) 
                      (set-mcdr! subtable value)) 
                     (else 
                      (iter (mcdr keys) subtable))) 
               (set-mcdr! table (mcons (gen-new-list keys value) (mcdr table))))) 
         'ok) 
       (iter keys local-table)) 
    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'display) local-table)
            (else (error "Unknown operation: TABLE" m))))
    dispatch))

(define t (make-table equal?))

(assert ((t 'insert-proc!) (mlist 'cities 'bangkok) 333)
        'ok)

(assert ((t 'insert-proc!) (mlist 'cities 'tokyo) 111)
        'ok)

(t 'display)

(assert ((t 'lookup-proc) (mlist 'cities 'bangkok))
        333)

(assert ((t 'lookup-proc) (mlist 'cities 'tokyo))
        111)

