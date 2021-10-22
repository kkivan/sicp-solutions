#lang scheme

(require "queue.scm")

(require "modules/sicp/sicp.rkt")
(define q1 (make-queue))

(assert (insert-queue! q1 'a)
        (mlist (mlist 'a) 'a))

(assert (print-queue q1)
        (mlist 'a))

(insert-queue! q1 'b)

(assert (print-queue q1)
        (mlist 'a 'b))

(assert (delete-queue! q1)
        'a)

(assert (print-queue q1)
        (mlist 'b))

(delete-queue! q1)

(assert (print-queue q1)
        nil)