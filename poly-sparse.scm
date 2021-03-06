#lang scheme

(require "dispatch-table.scm")
(require "math.scm")
(require "modules/sicp/sicp.rkt")

(provide install-polynomial-package
         make-poly)

(provide term-list
         variable)

(define (variable p) (car p))

(define (term-list p) (cdr p))

;"We will assume that term lists are represented as lists of terms,
;arranged from highest-order to lowest-order term"
(define (make-poly var terms)
  (apply-generic 'make (list 'polynomial var terms)))
                 
(define (install-polynomial-package)
  ;; internal procedures
  ;; representation of poly
  (define (make-poly variable term-list)
    (cons variable (filter (lambda (term)
                             (not (=zero? (coeff term))))
                           term-list)))

  (define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))

  (define (variable? x) (symbol? x))

  ;; representation of terms and term lists
  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else
           (let ((t1 (first-term L1)) (t2 (first-term L2)))
             (cond ((> (order t1) (order t2))
                    (adjoin-term
                     t1 (add-terms (rest-terms L1) L2)))
                   ((< (order t1) (order t2))
                    (adjoin-term
                     t2 (add-terms L1 (rest-terms L2))))
                   (else
                    (adjoin-term
                     (make-term (order t1)
                                (add (coeff t1) (coeff t2)))
                     (add-terms (rest-terms L1)
                                (rest-terms L2)))))))))

  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
        (the-empty-termlist)
        (add-terms (mul-term-by-all-terms (first-term L1) L2)
                   (mul-terms (rest-terms L1) L2))))

  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
        (the-empty-termlist)
        (let ((t2 (first-term L)))
          (adjoin-term
           (make-term (+ (order t1) (order t2))
                      (mul (coeff t1) (coeff t2)))
           (mul-term-by-all-terms t1 (rest-terms L))))))

  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))

  (define (the-empty-termlist) '())

  (define (first-term term-list) (car term-list))

  (define (rest-terms term-list) (cdr term-list))

  (define (empty-termlist? term-list) (null? term-list))

  (define (make-term order coeff) (list order coeff))

  (define (order term) (car term))

  (define (coeff term) (cadr term))

  (define (add-poly p1 p2)
    (make-poly (variable p1)
               (add-terms (term-list p1)
                          (term-list p2))))
  
  (define (mul-poly p1 p2)
    (make-poly (variable p1)
               (mul-terms (term-list p1)
                          (term-list p2))))
 
  ;; interface to rest of the system
  (define (tag p) (attach-tag 'polynomial p))
  
  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  
  (put 'make '(polynomial)
       (lambda (args)
         (tag (make-poly (car args) (cadr args)))))

  (put '=zero? '(polynomial)
       (lambda (p)
         (null? (term-list p))))
  
  (put 'negate '(polynomial)
       (lambda (p)
         (tag (make-poly (variable p) (map (lambda (term)
                                             (make-term (order term) (negate (coeff term))))
                                           (term-list p))))))

  (put 'sub '(polynomial polynomial)
       (lambda (l r)
         (add (tag l) (negate (tag r)))))
  
  'done)
