#lang scheme

(require "modules/sicp/sicp.rkt")

(require "dispatch-table.scm")

; tags

(define (attach-tag tag contents)
  (cons tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum - TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum - CONTENTS" datum)))

; division

; first division
(define file-div1
  (attach-tag 'div1
              (list (attach-tag 'div1 (list 'john 1000 "Elm Street"))
                    (attach-tag 'div1 (list 'martha 1200 "Sun Street")))))
(define (set-of-records-div1 file)
  file)

(define (get-name-div1 emp)
  (car emp))

(define (get-salary-div1 emp)
  (cadr emp))

(define (get-address-div1 emp)
  (caddr emp))

(put 'get-name 'div1 get-name-div1)
(put 'get-address 'div1 get-address-div1)
(put 'get-salary 'div1 get-salary-div1)
(put 'set-of-records 'div1 set-of-records-div1)

; second division
(define file-div2
  (attach-tag 'div2
              (list (attach-tag 'div2 (reverse (list 'peter 900 "Mel Street")))
                    (attach-tag 'div2 (reverse (list 'alex 800 "Nus Street"))))))

(define (set-of-records-div2 file)
  file)

(define (get-name-div2 emp)
  (caddr emp))

(define (get-salary-div2 emp)
  (cadr emp))

(define (get-address-div2 emp)
  (car emp))

(put 'get-name 'div2 get-name-div2)
(put 'get-address 'div2 get-address-div2)
(put 'get-salary 'div2 get-salary-div2)
(put 'set-of-records 'div2 set-of-records-div2)

(define (set-of-records file)
  (get 'set-of-records (type-tag file)) (contents file))

; file
(define (get-record key file)
  (let ((records (filter (lambda (rec)
                           (equal? key (get-key rec)))
                         (set-of-records file))))
    (if (null? records) nil
        (car records))))

; record

(define (get-key record)
  (get-name record))

(define (make-record key record)
  (attach-tag 'div1 (cons key record)))

; employee
(define (make-employee name salary address)
  (attach-tag 'div1 (list name salary address)))

(define (get-name emp)
  ((get 'get-name (type-tag emp)) (contents emp)))

(define (get-salary emp)
  ((get 'get-salary (type-tag emp)) (contents emp)))

(define (get-address emp)
  ((get 'get-address (type-tag emp)) (contents emp)))

(define e (make-employee 'john 1000 "Elm Street"))

(assert (get-address e)
        "Elm Street")
(assert (get-salary e)
        1000)

(define r (make-record (get-name e) e))

(assert (get-key r)
        (get-name e))

(define (find-employee-record name files)
  (if (null? files)
      nil
      (let ((next (get-record name (car files))))
            (if (null? next)
                (find-employee-record name (cdr files))
                next))))
        

(define john (find-employee-record 'john (list file-div1 file-div2)))
(assert (get-name john)
        'john)
(assert (get-salary john)
        1000)
(assert (get-address john)
        "Elm Street")

(define peter (find-employee-record 'peter (list file-div1 file-div2)))

(assert (get-name peter)
        'peter)
(assert (get-salary peter)
        900)
(assert (get-address peter)
        "Mel Street")