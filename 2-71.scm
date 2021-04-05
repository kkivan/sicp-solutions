#lang scheme

(require "2-68.scm")
(require "2-69.scm")

; n = 5
(define freq
  '((A 1)
    (B 2)
    (C 4)
    (D 8)
    (E 16)))

(length (encode '(E) (generate-huffman-tree freq))) ; 1 bit
(length (encode '(A) (generate-huffman-tree freq))) ; n - 1 bit





