#lang racket/base

; Anders Pitman - Program 6

(define theList '((a b) c (d (e f) ) ((g (h) i))) )

(define (extractA) (car (car theList)))
(define (extractB) (car (cdr (car theList))))
(define (extractC) (car (cdr theList)))
(define (extractD) (car (car (cdr (cdr theList)))))
(define (extractE) (car (car (cdr (car (cdr (cdr theList)))))))
(define (extractF) (car (cdr (car (cdr (car (cdr (cdr theList))))))))
(define (extractG) (car (car (car (cdr (cdr (cdr theList)))))))
(define (extractH) (car (car (cdr (car (car (cdr (cdr (cdr theList)))))))))
(define (extractI) (car (cdr (cdr (car (car (cdr (cdr (cdr theList)))))))))

(extractA)
(extractB)
(extractC)
(extractD)
(extractE)
(extractF)
(extractG)
(extractH)
(extractI)

; you can ignore this. it's for unit testing in racket
(provide extractA extractB extractC extractD extractE extractF extractG
         extractH extractI)

  
