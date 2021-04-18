#lang scheme

(require "modules/sicp/sicp.rkt")
(require "scheme-number.scm")
(require "math.scm")

(install-package-scheme-number)

(assert (add 1 2)
        3)

(assert (sub 5 4)
        1)

(assert (div 8 2)
        4)

(assert (mul 5 5)
        25)

(assert (=zero? 0)
        true)

(assert (=zero? 5)
        false)