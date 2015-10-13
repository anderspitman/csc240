; Anders Pitman - Program 7 - Dot product, duplicate checker, and largest
;                             difference.

#lang racket/base


; dot product
(define (computeDotProduct listA listB)
  (if
    (or
      (null? listA)
      (null? listB))
    0
    (+
      (*
        (car listA)
        (car listB))
      (computeDotProduct
        (cdr listA)
        (cdr listB)))))


; check duplicates
(define (hasDuplicates theList)
  (if
    (null? theList)
    #f
    (if
      (valueInList
        (car theList)
        (cdr theList))
      #t
      (hasDuplicates
        (cdr theList)))))

(define (valueInList value theList)
  (if
    (null? theList)
    #f
    (if
      (=
        value
        (car theList))
      #t
      (valueInList
        value
        (cdr theList)))))


; largest difference
(define (largestDifference listA listB)
  (if
    (or
      (null? listA)
      (null? listB))
    0
    (largestDifferenceIter
      (absDifference
        (car listA)
        (car listB))
      (cdr listA)
      (cdr listB))))

(define (largestDifferenceIter startDifference listA listB)
  (if
    (or
      (null? listA)
      (null? listB))
    startDifference
    (if
      (>
        startDifference
        (absDifference
          (car listA)
          (car listB)))
      (largestDifferenceIter
        startDifference
        (cdr listA)
        (cdr listB))
      (largestDifferenceIter
        (car listA)
        (car listB)))))

(define (absDifference a b)
  (if (<= a b)
    (- b a)
    (- a b)))
    

; you can ignore this. it's for unit testing in racket
(provide computeDotProduct hasDuplicates valueInList largestDifference
         absDifference)
