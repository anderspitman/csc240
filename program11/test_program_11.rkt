#lang racket/base

(require rackunit
         "program_11.rkt")

(define (row1)
  '(2 4 6 8))

(define (testMatrix)
  '( (2 4 6 8) (1 3 5 7) (2 9 0 1) ))

(check-equal? (getCell (testMatrix) 1 1 ) 2 "Simple")
(check-equal? (getCell (testMatrix) 3 3 ) 0 "Simple")
(check-equal? (getCell (testMatrix) 2 4 ) 7 "Simple")

(check-equal? (setListItem (row1) 1 0 ) '(0 4 6 8) "First index")
(check-equal? (setListItem (row1) 4 0 ) '(2 4 6 0) "Last index")
(check-equal? (setListItem (row1) 2 2 ) '(2 2 6 8) "Middle index")

(check-equal?
  (setListItem (testMatrix) 1 '(0 0 0 0) ) 
  '( (0 0 0 0) (1 3 5 7) (2 9 0 1) )
  "First index")
(check-equal?
  (setListItem (testMatrix) 3 '(0 0 0 0) ) 
  '( (2 4 6 8) (1 3 5 7) (0 0 0 0) )
  "Last index")
(check-equal?
  (setListItem (testMatrix) 2 '(0 0 0 0) ) 
  '( (2 4 6 8) (0 0 0 0) (2 9 0 1) )
  "Middle index")

(check-equal?
  (setCell (testMatrix) 1 1 0)
  '( (0 4 6 8) (1 3 5 7) (2 9 0 1) )
  "1,1")
(check-equal?
  (setCell (testMatrix) 3 4 0)
  '( (2 4 6 8) (1 3 5 7) (2 9 0 0) )
  "3,4")
(check-equal?
  (setCell (testMatrix) 2 2 0)
  '( (2 4 6 8) (1 0 5 7) (2 9 0 1) )
  "2,2")
