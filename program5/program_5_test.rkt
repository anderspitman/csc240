#lang racket/base

(require rackunit
         "program_5.rkt")

; (a)
(check-equal? (an 0 0 0) 0 "Base 0")
(check-equal? (an 1 0 0) 1 "Base 1")
(check-equal? (an 1 0 1) 1 "Recurse b 0")
(check-equal? (an 1 1 1) 2 "Recurse b 1")

; 3, 5, 7, 9, 11, 13
(define (seq1 n) (an 3 2 n))
(check-equal? (seq1 0) 3 "3")
(check-equal? (seq1 1) 5 "5")
(check-equal? (seq1 2) 7 "7")
(check-equal? (seq1 3) 9 "9")
(check-equal? (seq1 4) 11 "11")
(check-equal? (seq1 5) 13 "13")

; 7, 12, 17, 22, 27
(define (seq2 n) (an 7 5 n))
(check-equal? (seq2 0) 7 "7")
(check-equal? (seq2 1) 12 "12")
(check-equal? (seq2 2) 17 "17")
(check-equal? (seq2 3) 22 "22")
(check-equal? (seq2 4) 27 "27")


; (b)
(check-equal? (pow 1 0) 1 "Base")
(check-equal? (pow 1 1) 1 "Odd")
(check-equal? (pow 2 2) 4 "Even")
(check-equal? (pow 3 2) 9 "Three squared")
(check-equal? (pow 2 3) 8 "Two cubed")
