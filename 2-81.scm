#lang scheme

;a. What happens if apply-generic is called with two arguments of type scheme-number or two arguments of type complex for an operation that is not found in the table for those types?
;–––
;It goes into recursive loop
;
;What happens if we call exp with two complex numbers as ar-
;guments?
;–––
;Error would be thrown as there is no exp opeartor for complex numbers and complex numbers cannot be downcasted to scheme-number
;
;b. It will work with out same type coercion since coercion is done after we didn't hit the original table

;;c.
