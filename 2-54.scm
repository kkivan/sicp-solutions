#lang sicp

(define (fringe t)
  (cond ((pair? t) (append (fringe (car t)) (fringe (cdr t))))
        ((null? t) '())
        (else (list t))))

; solution without eq?
(define (flat-equal? left right)
  (equal? (fringe left) (fringe right)))

(equal? '(this is a list) '(this is a list))

(flat-equal? '(this is a list) '(this (is a) list))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define (transpose mat)
  (accumulate-n cons '() mat))

(define (contains? condition list)
  (cond ((not (pair? list)) #f)
        ((condition (car list)) #t)
        (else (contains? condition (cdr list)))))

; soution with eq and matrix transpose
(define (equal-transpose left right)
  (not (contains? (lambda (row)
               (not (eq? (car row) (cadr row))))
             (transpose (list (fringe left) (fringe right))))))

(equal-transpose '(this is a list) '(this (is a) list))