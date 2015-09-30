#lang racket/base

(require rackunit
         "program_6.rkt")

(check-equal? (extractA) 'a "A")
(check-equal? (extractB) 'b "B")
(check-equal? (extractC) 'c "C")
(check-equal? (extractD) 'd "D")
(check-equal? (extractE) 'e "E")
(check-equal? (extractF) 'f "F")
(check-equal? (extractG) 'g "G")
(check-equal? (extractH) 'h "H")
(check-equal? (extractI) 'i "I")
