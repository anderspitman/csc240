; Anders Pitman - Program 5
#lang racket/base

; (a)
(define (an a b n)
  (if (= n 0)
    a
    (+ (an a b (- n 1))
       b)))

; (b)

; I always got infinite recursion unless I define my own square function. Is
; that correct?
(define (square x) (* x x))
(define (pow b x)
  (cond ((= x 0) 1)
        ((even? x)
         (square (pow b 
                      (/ x 2))))
        (#t
         (* b 
           (square (pow b 
                        (/ (- x 1) 
                           2)))))
        ))

; you can ignore this. it's for unit testing in racket
(provide an pow)
