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
(check-equal?
  (largestDifference '(2 6 3) '(4 6 2))
  2
  "First element is greatest difference.")
(check-equal?
  (largestDifference '(4 16 3) '(2 6 2))
  10
  "Second element greatest difference")
(check-equal?
  (largestDifference '(4 16 10) '(2 6 50))
  40
  "Last element greatest difference")
(check-equal?
  (largestDifference '(2 2 1 1) '(1 1 2 2))
  1
  "Repeated values")
(check-equal?
  (largestDifference
    '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25)
    '(25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))
  24
  "Longer list")
(check-equal? (largestDifference '() '()) 0 "Empty")
(check-equal? (absDifference 2 4) 2 "a < b")
(check-equal? (absDifference 6 6) 0 "a = b")
(check-equal? (absDifference 3 2) 1 "a > b")
