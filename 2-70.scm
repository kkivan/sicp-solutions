#lang scheme

(require "2-68.scm")
(require "2-69.scm")

(define freq
  '((A 2)
    (NA 16)
    (BOOM 1) (SHA 3)
    (GET 2)
    (YIP 9)
    (JOB 2)
    (WAH 1)))
(define message '(GET A JOB
                      SHA NA NA NA NA NA NA NA NA
                      GET A JOB
                      SHA NA NA NA NA NA NA NA NA
                      WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
                      SHA BOOM))

(define encoded-message (encode message (generate-huffman-tree freq)))

(length encoded-message) ; 84

; With fixed length 8-symbol alfabet would take 3 bits for every symbol 
(* 3 (length message)) ; 108


