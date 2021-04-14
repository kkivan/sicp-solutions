#lang scheme

(require "modules/sicp/sicp.rkt")
(require "dispatch-table.scm")

(assert (raise-type 'scheme-number)
        'rat)

(assert (raise-type 'complex)
        nil)