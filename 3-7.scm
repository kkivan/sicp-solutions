#lang scheme

(require "modules/sicp/sicp.rkt")

(provide make-account)

(define (make-account balance secret)  
  (define (dispatch m secret password new-password)
    (let ((attempts 0))
      (define (withdraw amount)
        (cond ((>= balance amount) (begin (set! balance (- balance amount))
                                          balance))
              (else "Insufficient funds")))
      (define (deposit amount)
        (set! balance (+ balance amount))
        balance)
      (define (call-the-cops)
        (error "calling the cops"))
      (define (invalid-attempt x)
        (set! attempts (+ attempts 1))
        (if (> attempts 7)
            (call-the-cops)
            "Wrong password – try again"))
      (define (reset-attempts)
        (set! attempts 0))
      (cond ((eq? secret password) (reset-attempts)
                                   (cond ((eq? m 'withdraw) withdraw)
                                         ((eq? m 'deposit) deposit)
                                         ((eq? m 'make-joint) (lambda (m password)
                                                            (dispatch m new-password password nil)))
                                         (else (error "Unknown request - MAKE-ACCOUNT"
                                                      m))))
            (else invalid-attempt))))
  (lambda (m . passwords)
    (dispatch m secret (car passwords) (if (null? (cdr passwords))
                                           nil
                                           (cadr passwords)))))

(define (make-joint account orig-pass joint-pass)
  (account 'make-joint orig-pass joint-pass))

(define a (make-account 100 'qwerty))

(assert ((a 'withdraw 'qwerty) 40)
        60)
(assert  ((a 'deposit 'qwerty) 1000)
         1060)

((a 'deposit 'qerty) 1000)
((a 'deposit 'qerty) 1000)
((a 'deposit 'qerty) 1000)
((a 'deposit 'qerty) 1000)
((a 'deposit 'qerty) 1000)
((a 'deposit 'qerty) 1000)
((a 'deposit 'qerty) 1000)
((a 'deposit 'qwerty) 1000)
((a 'deposit 'qerty) 1000)

(define b (make-joint a 'qwerty 'abc))

((a 'deposit 'qwerty) 1)

(assert ((b 'deposit 'abc) 100)
        2161)

(assert ((b 'deposit 'admin) 100)
        "Wrong password – try again")

; tests that number of attempts is not shared
((a 'deposit 'nan) 100)
((a 'deposit 'nan) 100)
((a 'deposit 'nan) 100)
((b 'deposit 'nan) 100)
((b 'deposit 'nan) 100)
((b 'deposit 'nan) 100)
((b 'deposit 'nan) 100)
((b 'deposit 'nan) 100)
