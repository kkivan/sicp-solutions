#lang scheme

(provide to-mlist
         to-list)
(require compatibility/mlist)


(define (to-mlist l)
  (list->mlist (map (lambda (e)
         (if (list? e)
             (to-mlist e)
             e))
         l)))

(define (to-list l)
  (mlist->list (mmap (lambda (e)
                      (if (mlist? e)
                          (to-list e)
                          e))
                    l)))