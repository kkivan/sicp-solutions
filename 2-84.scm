#lang scheme

(require "dispatch-table.scm")
(require "modules/sicp/sicp.rkt")

(assert (higher-type? 'rat 'scheme-number)
        true)

(assert (higher-type? 'rat 'complex)
        false)
