(define (run-forever) (run-forever)) 
(define (try p)
  (if (halts? p p) (run-forever) 'halted))

if we call (try try) 
in case if halts? returns true try will run forever which contradicts with our halts? result
in case if halts? return false its halted immediatelly which again contradicts with reterned value from halts?
