#lang sicp

(#%require sicp-pict)

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
         (make-frame new-origin
                     (vector-sub (m corner1) new-origin)
                     (vector-sub (m corner2) new-origin)))))))



(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define (compose f1 f2)
  (lambda (x)
    (f1 (f2 x))))

(define rotate180 (compose rotate90
                           rotate90))

(define flip-horiz rotate180)

(define rotate270 (compose rotate180 rotate90))

(paint (rotate180 einstein))