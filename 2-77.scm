It works because before each complex number we have tag 'complex
and only after it we have tags 'rectangular or 'polar.
Procedure apply-generic is invoked 2 time first it dispatches on type complex
and then on rectangular or polar as there two levels of abstraction.
