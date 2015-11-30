#lang racket/base

(require rackunit
         "connect_four.rkt")

(define (row1)
  '(2 4 6 8))

(define (testMatrix)
  '( (2 4 6 8) (1 3 5 7) (2 9 0 1) ))

(check-equal? (TAPGetCell (testMatrix) 1 1 ) 2 "Simple")
(check-equal? (TAPGetCell (testMatrix) 3 3 ) 0 "Simple")
(check-equal? (TAPGetCell (testMatrix) 2 4 ) 7 "Simple")

(check-equal? (TAPSetListItem (row1) 1 0 ) '(0 4 6 8) "First index")
(check-equal? (TAPSetListItem (row1) 4 0 ) '(2 4 6 0) "Last index")
(check-equal? (TAPSetListItem (row1) 2 2 ) '(2 2 6 8) "Middle index")

(check-equal?
  (TAPSetListItem (testMatrix) 1 '(0 0 0 0) ) 
  '( (0 0 0 0) (1 3 5 7) (2 9 0 1) )
  "First index")
(check-equal?
  (TAPSetListItem (testMatrix) 3 '(0 0 0 0) ) 
  '( (2 4 6 8) (1 3 5 7) (0 0 0 0) )
  "Last index")
(check-equal?
  (TAPSetListItem (testMatrix) 2 '(0 0 0 0) ) 
  '( (2 4 6 8) (0 0 0 0) (2 9 0 1) )
  "Middle index")

(check-equal?
  (TAPSetCell (testMatrix) 1 1 0)
  '( (0 4 6 8) (1 3 5 7) (2 9 0 1) )
  "1,1")
(check-equal?
  (TAPSetCell (testMatrix) 3 4 0)
  '( (2 4 6 8) (1 3 5 7) (2 9 0 0) )
  "3,4")
(check-equal?
  (TAPSetCell (testMatrix) 2 2 0)
  '( (2 4 6 8) (1 0 5 7) (2 9 0 1) )
  "2,2")

; mark move
(define
  boardEmpty
  '((0 0)
    (0 0)))

(define
  boardAfterColumnOneFirstMove
  '((0 0)
    (1 0)))

(define
  boardAfterColumnOneSecondMove
  '((1 0)
    (1 0)))

(define
  boardFull
  '((1 1)
    (1 1)))

(check-equal? (TAPLegalMoveBoard boardEmpty 1) #t)
(check-equal? (TAPLegalMoveBoard boardEmpty 2) #t)
(check-equal? (TAPLegalMoveBoard boardFull 1) #f)
(check-equal? (TAPLegalMoveBoard boardFull 2) #f)
(check-equal? (TAPLegalMoveBoard boardAfterColumnOneSecondMove 1) #f)
(check-equal? (TAPLegalMoveBoard boardAfterColumnOneSecondMove 2) #t)

(check-equal? (TAPFreeRowIndex boardEmpty 1) 2)
(check-equal? (TAPFreeRowIndex boardAfterColumnOneFirstMove 1) 1)
(check-equal? (TAPFreeRowIndex boardAfterColumnOneFirstMove 2) 2)
(check-equal? (TAPFreeRowIndex boardFull 1) 0)

(check-equal? (TAPMarkMoveBoard boardEmpty 1) boardAfterColumnOneFirstMove)
(check-equal?
  (TAPMarkMoveBoard boardAfterColumnOneFirstMove 1)
  boardAfterColumnOneSecondMove)
