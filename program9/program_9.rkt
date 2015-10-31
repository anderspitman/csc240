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

(define (updateBag bag item)
  '("a" . 3))


; you can ignore this. it's for unit testing in racket
(provide getValue getCount newPair incPair decPair insertBag getBagCount
         deleteAllBag updateBag)
