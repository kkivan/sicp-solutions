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

;; Term
(define (make-term order coeff)
  (list order coeff))

(define (order term) (car term))

(define (coeff term) (cadr term))

;; Term-lists
(define (make-sparse-term-list terms)
  (attach-tag 'sparse (filter (lambda (term)
                                (not (=zero? (coeff term))))
                              terms)))

(define (make-dense-term-list terms)
  (attach-tag 'dense terms))

;"We will assume that term lists are represented as lists of terms,
;arranged from highest-order to lowest-order term"
(define (make-poly var terms)
  (apply-generic 'make (list 'polynomial var terms)))

(provide install-sparse-term-list-package
         make-sparse-term-list)
         
(define (install-sparse-term-list-package)
  (put 'first-term '(sparse) (lambda (list)
                               (car list)))
  (put 'rest-terms '(sparse) (lambda (list)
                               (attach-tag 'sparse (cdr list))))
  )
                 
(define (install-polynomial-package)
  ;; internal procedures
  ;; representation of poly
  (define (make-poly variable term-list)
    (cons variable term-list))

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

  (define (adjoin-term term term-list) ; to generic
    (if (=zero? (coeff term))
        term-list
        (attach-tag 'sparse (cons term (contents term-list)))))

  (define (the-empty-termlist) (attach-tag 'sparse '()))

  (define (first-term term-list)
    (apply-generic 'first-term term-list))
  
  (define (rest-terms term-list) (apply-generic 'rest-terms term-list))

 
  (define (empty-termlist? term-list) ; to generic
    (null? (cdr term-list))) 

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

  (put '=zero? '(polynomial) ;; make generic
       (lambda (p)
         (all-satisfy =zero?
                      (contents (term-list p)))))
  
  (put 'negate '(polynomial) ;; add negate for term-list
       (lambda (p)
         (tag (make-poly (variable p)
                         (attach-tag 'sparse
                                     (map (lambda (term)
                                            (make-term (order term)
                                                       (negate (coeff term))))
                                          (contents (term-list p))))))))

  (put 'sub '(polynomial polynomial)
       (lambda (l r)
         (add (tag l) (negate (tag r)))))
  
  'done)
