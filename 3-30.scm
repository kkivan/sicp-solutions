(define (ripple-carry-adder a b sum c-out)
  (let ((c-in (make-wire)))
  (if (null? a)
      'ok
      (begin (full-adder (car a) (car b) c-in (car sum) c-out)
             (ripple-carry-adder (cdr a) (cdr b) (cdr sum) c-out)))))