#lang scheme

(require "modules/sicp/sicp.rkt")
(require "dispatch-table.scm")

(assert (attach-tag 'scheme-number 1)
        1)

(assert (type-tag  1)
        '(scheme-number))

(assert (contents (attach-tag 'scheme-number 1))
        1)
        

