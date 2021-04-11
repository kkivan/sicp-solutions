
a. What happens if apply-generic is called with two arguments of type scheme-number or two arguments of type complex for an operation that is not found in the table for those types?
–––
It goes into recursive loop

b.What happens if we call exp with two complex numbers as ar-
guments?
–––
Error would be thrown as there is no exp opeartor for complex numbers and complex numbers cannot be downcasted to scheme-number