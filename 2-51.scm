#lang sicp

(#%require sicp-pict)

(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              split-point
                              (make-vect 0.0 1.0)))
          (paint-right
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.0)
                              (make-vect 0.5 1.0))))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

(define (below painter1 painter2)
  (let ((split-point (make-vect 0 0.5)))
    (let ((paint-bottom
           (transform-painter painter1
                              (make-vect 0.0 0.0)
                              (make-vect 1 0)
                              split-point))
          (paint-top
           (transform-painter painter2
                              split-point
                              (make-vect 1.0 0.5)
                              (make-vect 0 1))))
      (lambda (frame)
        (paint-top frame)
        (paint-bottom frame)))))
(paint (below einstein einstein))

(define (compose f1 f2)
  (lambda (x)
    (f1 (f2 x))))
  
(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

(define rotate270 (compose rotate90
                           (compose rotate90
                                    rotate90)))

(define (below-2 painter1 painter2)
  (rotate270 (beside (rotate90 painter1)
                     (rotate90 painter2))))

(paint (below-2 einstein einstein))


