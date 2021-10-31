#lang scheme

(require "modules/sicp/sicp.rkt")
(require "mutable-pairs.scm")
(provide make-table)

(define (caar pair)
  (car (car pair)))

(define (make-table same-key?)
  (define (assoc key records)
    (cond ((null? records) false)
          ((same-key? key (caar records)) (car records))
          (else (assoc key (cdr records)))))
  
  (let ((local-table (list '*table*)))

    (define (lookup keys) 
      (define (iter keys table) 
        (let ((subtable (assoc (car keys) (cdr table)))) 
          (if subtable 
              (cond ((null? (cdr keys)) (cdr subtable)) 
                    (else (iter (cdr keys) subtable))) 
              false))) 
      (iter keys local-table))
    
    (define (gen-new-list keys value) 
         (if (null? (mcdr keys)) 
             (cons (mcar keys) value) 
             (list (mcar keys) (gen-new-list (cdr keys) value)))) 
      
     (define (insert! keys value) 
       (define (iter keys table) 
         (let ((subtable (assoc (car keys) (cdr table)))) 
           (if subtable 
               (cond ((null? (mcdr keys)) 
                      (set-cdr! subtable value)) 
                     (else 
                      (iter (cdr keys) subtable))) 
               (set-cdr! table (cons (gen-new-list keys value) (cdr table))))) 
         'ok) 
       (iter keys local-table)) 
    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'display) local-table)
            (else (error "Unknown operation: TABLE" m))))
    dispatch))

(define t (make-table equal?))

(assert ((t 'insert-proc!) (list 'cities 'bangkok) 333)
        'ok)

(assert ((t 'insert-proc!) (list 'cities 'tokyo) 111)
        'ok)

(t 'display)

(assert ((t 'lookup-proc) (list 'cities 'bangkok))
        333)

(assert ((t 'lookup-proc) (list 'cities 'tokyo))
        111)

