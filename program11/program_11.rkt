; Anders Pitman - Program 11 Phase 1 - Scheme Matrix Manipulation

#lang racket/base


(define (getCell matrix row column)
  (getListItem
    (getListItem
      matrix row)
    column))

(define (setCell matrix row column item)
  (setListItem
    matrix
    row
    (setListItem
      (getListItem
        matrix
        row)
      column
      item)))

(define (getListItem theList index)
  (if
    (=
      index
      1)
    (car theList)
    (getListItem
      (cdr theList)
      (-
        index
        1))))

(define (setListItem theList index value)
  (if
    (=
      index
      1)
    (cons
      value
      (cdr theList))
    (cons
      (car theList)
      (setListItem
        (cdr theList)
        (-
          index
          1)
        value))))


; you can ignore this. it's for unit testing in racket
(provide getCell setCell setListItem)
