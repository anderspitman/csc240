; Anders Pitman - Program 11 - Scheme Connect Four Game

#lang racket/base

(define TAPGame '())

(define (TAPInitializeBoard)
  (set!
    TAPGame
    '((0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0))))

(define (TAPStartGame)
  (begin
    (display "Ready Player 1")
    (TAPInitializeBoard)
    (newline)))

(define (TAPShowRow row)
  (if
    (null? row)
    (begin (newline))
    (begin
      (display (car row))
      (display " ")
      (TAPShowRow (cdr row)))))

(define (TAPShowBoard board)
  (if
    (null? board)
    (newline)
    (begin
      (TAPShowRow (car board))
      (TAPShowBoard (cdr board)))))

(define (TAPShowGame)
  (TAPShowBoard TAPGame))

(define (TAPMarkMove column)
  (set!
    TAPGame
    (TAPMarkMoveBoard TAPGame column)))

(define (TAPMarkMoveBoard board column)
  (if
    (TAPLegalMoveBoard board column)
    (TAPSetCell
      board
      (TAPFreeRowIndex
        board
        column)
      column
      1)
    board))

; Computes the first available row in the column, or 0 if full
(define (TAPFreeRowIndex board column)
  (if
    (null? board)
    0
    (if
      (>
        (TAPGetListItem
          (car board)
          column)
        0)
      0
      (+
        1
        (TAPFreeRowIndex
          (cdr board)
          column)))))



(define (TAPLegalMoveP column)
  (TAPLegalMoveBoard TAPGame))

(define (TAPLegalMoveBoard board column)
  (=
    (TAPGetCell board 1 column)
    0))







(define (TAPGetCell matrix row column)
  (TAPGetListItem
    (TAPGetListItem
      matrix row)
    column))

(define (TAPSetCell matrix row column item)
  (TAPSetListItem
    matrix
    row
    (TAPSetListItem
      (TAPGetListItem
        matrix
        row)
      column
      item)))

(define (TAPGetListItem theList index)
  (if
    (=
      index
      1)
    (car theList)
    (TAPGetListItem
      (cdr theList)
      (-
        index
        1))))

(define (TAPSetListItem theList index value)
  (if
    (=
      index
      1)
    (cons
      value
      (cdr theList))
    (cons
      (car theList)
      (TAPSetListItem
        (cdr theList)
        (-
          index
          1)
        value))))


; you can ignore this. it's for unit testing in racket
(provide TAPGetCell TAPSetCell TAPSetListItem TAPStartGame TAPMarkMove
         TAPInitializeBoard TAPLegalMoveP TAPLegalMoveBoard TAPMarkMoveBoard
         TAPFreeRowIndex)

;(TAPStartGame)
;(TAPShowGame)
;(TAPMarkMove 7)
;(TAPShowGame)
