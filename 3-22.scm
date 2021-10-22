#lang scheme

(require "modules/sicp/sicp.rkt")
(require "queue.scm")

(provide make-queue-object)

(define (make-queue-object)
  (let ((q (make-queue)))
    (define (dispatch m . args)
      (cond ((eq? m 'front) (front-queue q))
            ((eq? m 'dequeue) (delete-queue! q))
            ((eq? m 'print) (display q))
            ((eq? m 'enqueue) (insert-queue! q (car args)))))
    dispatch))

(define q (make-queue-object))

(q 'enqueue 'a)
(q 'enqueue 'b)
(q 'enqueue 'c)
(q 'dequeue)
(q 'dequeue)
(q 'dequeue)
(q 'print)


