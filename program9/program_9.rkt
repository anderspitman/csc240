; Anders Pitman - Program 9 - Scheme Bag Functions

#lang racket/base


(define (getValue pair)
  (car pair))

(define (getCount pair)
  (cdr pair))

(define (newPair item)
  (cons item 1) )

(define (incPair pair)
  (cons
    (getValue pair)
    (+
      (getCount pair)
      1)))

(define (decPair pair)
  (cons
    (getValue pair)
    (-
      (getCount pair)
      1)))

(define (insertBag bag item)
  (if (not (null? bag))
    (if
      (string=?
        (getValue (car bag))
        item)
      (cons
        (cons
          (getValue (car bag))
          (+
            1
            (getCount (car bag))))
        (cdr bag))
      (cons
        (car bag)
        (insertBag
          (cdr bag)
          item)))
    (cons
      (newPair item)
      '())))


(define (getBagCount bag item)
  (if (not (null? bag))
    (if
      (string=?
        (getValue (car bag))
        item)
      (getCount (car bag))
      (getBagCount
        (cdr bag)
        item))
    0))

(define (deleteAllBag bag item)
  (if (not (null? bag))
    (if
      (string=?
        (getValue (car bag))
        item)
      (cdr bag)
      (cons
        (car bag)
        (deleteAllBag
          (cdr bag)
          item)))
    '()))

(define (deleteBag bag item)
  (if (not (null? bag))
    (if
      (>
        (getBagCount bag item)
        1)
      (if
        (string=?
          (getValue (car bag))
          item)
        (cons
          (cons
            (getValue (car bag))
            (-
              (getCount (car bag))
              1))
          (cdr bag))
        (cons
          (car bag)
          (deleteBag
            (cdr bag)
            item)))
      (deleteAllBag
        bag
        item))
    '()))

(define (intersectBag bagA bagB)
  (if (and
        (not (null? bagA))
        (not (null? bagB)))
    (cons
      (cons
        (getValue (car bagA))
        (minimum
          (getBagCount
            bagA
            (getValue (car bagA)))
          (getBagCount
            bagB
            (getValue (car bagA)))))
      (intersectBag
        (cdr bagA)
        (cdr bagB)))
    '()))

(define (minimum a b)
  (if (< a b)
    a
    b))

(define (unionBag bagA bagB)
  (cond
    ((not (null? bagA))
     ; As long as A is not null, recursively add the count of the first item
     ; of A with the count of that item in B (which may be 0 if the item
     ; doesn't exist in B), and append the result to the output bag
     (cons
       (cons
         (getValue (car bagA))
         (+
           (getCount (car bagA))
           (getBagCount
             bagB
             (getValue (car bagA)))))
       (unionBag
         (cdr bagA)
         ; Need to reduce B along with A, which makes the final condition work
         (deleteAllBag
           bagB
           (getValue (car bagA))))))
    ((not (null? bagB))
      ; Once A is exhausted, anything remaining in B represents the items
      ; that existed in B but not in A, so they can simply be added to the end
      ; with their current counts
     bagB)
    (#t
     '())))


; you can ignore this. it's for unit testing in racket
(provide getValue getCount newPair incPair decPair insertBag getBagCount
         deleteAllBag deleteBag intersectBag unionBag)
