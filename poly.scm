#lang scheme

(require "dispatch-table.scm")
(require "math.scm")
(require "modules/sicp/sicp.rkt")
(require "term.scm")

(provide install-polynomial-package
         make-poly
         adjoin-term)

(provide term-list
         variable)

(define (variable p) (car p))

(define (term-list p) (cdr p))

(define (adjoin-term term term-list)
    (let ((tag (type-tag term-list)))
      (attach-tag tag ((get 'adjoin-term (list tag)) term (contents term-list)))))

;"We will assume that term lists are represented as lists of terms,
;arranged from highest-order to lowest-order term"
(define (make-poly var terms)
  (apply-generic 'make (list 'polynomial var terms)))
               
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
        the-empty-termlist
        (add-terms (mul-term-by-all-terms (first-term L1) L2)
                   (mul-terms (rest-terms L1) L2))))

  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
        the-empty-termlist
        (let ((t2 (first-term L)))
          (adjoin-term
           (make-term (+ (order t1) (order t2))
                      (mul (coeff t1) (coeff t2)))
           (mul-term-by-all-terms t1 (rest-terms L))))))

  (define the-empty-termlist '())

  (define (first-term term-list)
    (apply-generic 'first-term term-list))
  
  (define (rest-terms term-list) (apply-generic 'rest-terms term-list))
 
  (define (empty-termlist? term-list)
    (null? (contents term-list))) 

  (define (add-poly p1 p2)
    (make-poly (variable p1)
               (add-terms (term-list p1)
                          (term-list p2))))
  
  (define (mul-poly p1 p2)
    (make-poly (variable p1)
               (mul-terms (term-list p1)
                          (term-list p2))))

  
  (define (div-terms L1 L2)
    (if (empty-termlist? L1)
        (list the-empty-termlist the-empty-termlist)
        (let ((t1 (first-term L1))
              (t2 (first-term L2)))
          (if (> (order t2) (order t1))
              (list the-empty-termlist L1) ; return remainder
              (let ((new-c (div (coeff t1) (coeff t2)))
                    (new-o (- (order t1) (order t2))))
                (let ((rest-of-result (div-terms (adjoin-term (make-term new-o
                                                                         new-c)
                                                              (rest-terms L1))
                                                 L2)))
                  (list (adjoin-term (make-term new-o
                                                new-c)
                                     (if (null? (car rest-of-result))
                                         (attach-tag (type-tag L1) the-empty-termlist)
                                         (car rest-of-result)))
                        (cadr rest-of-result))))))))
  
  (define (div-poly p1 p2)
    (if (eq? (variable p1)
             (variable p2))
        (map (lambda (term-list)
               (tag (make-poly (variable p1)
                               term-list)))
             (div-terms (term-list p1)
                        (term-list p2)))
        (error "polynomials with different variable")))
 
  (define (tag p) (attach-tag 'polynomial p))

  (put 'div '(polynomial polynomial) div-poly)
                  
  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  
  (put 'make '(polynomial)
       (lambda (args)
         (tag (make-poly (car args) (cadr args)))))

  (put '=zero? '(polynomial)
       (lambda (p)
         (all-satisfy =zero?
                      (contents (term-list p)))))
    
  (put 'negate '(polynomial)
       (lambda (p)
         (tag (make-poly (variable p)
                         (negate (term-list p))))))
           
  (put 'sub '(polynomial polynomial)
       (lambda (l r)
         (add (tag l) (negate (tag r)))))
  
  'done)
