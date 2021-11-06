(define (or-gage-v2 a1 a2 output)
  (let ((b (make-wire))
        (c (make-wire))
        (d (make-wire)))
    (inverter a1 b)
    (inverter a2 c)
    (and-gate b c d)
    (inverter d output)))

; the delay of above or-gate is inverter-delay + and-gate-delay + inverter-delay