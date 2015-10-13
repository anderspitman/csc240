#lang racket/base

(require rackunit
         "program_7.rkt")

; dot product
(check-equal? (computeDotProduct '(1) '(1)) 1 "Simple")
(check-equal? (computeDotProduct '(1 3 -5) '(4 -2 -1)) 3 "Given")

; check duplicates
(check-equal? (hasDuplicates '(77 22 66 44 55)) #f "Simple false")
(check-equal? (hasDuplicates '(15 22 11 25 22 14)) #t "Simple true")
(check-equal? (valueInList 15 '(15 22 11 25 22 14)) #t "Simple true")
(check-equal? (valueInList 99 '(15 22 11 25 22 14)) #f "Simple false")

; difference
(check-equal? (largestDifference '(2 6 3) '(4 6 2)) 2 "Simple case")
(check-equal? (largestDifference '() '()) 0 "Empty")
(check-equal? (absDifference 2 4) 2 "a < b")
(check-equal? (absDifference 6 6) 0 "a = b")
(check-equal? (absDifference 3 2) 1 "a > b")
