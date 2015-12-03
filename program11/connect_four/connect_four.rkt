; Anders Pitman - Program 11 - Scheme Connect Four Game

#lang racket/base

;------------------------------------------------------------------------------
; Globals
;------------------------------------------------------------------------------

(define TAPGame '())


;------------------------------------------------------------------------------
; Public Functions
;------------------------------------------------------------------------------

(define (TAPStartGame)
  (begin
    (display "Ready Player 1")
    (TAPInitializeBoard)
    (newline)))

(define (TAPMarkMove column)
  (if (TAPLegalMoveP column)
    (TAPSetGameState
      (TAPNextPlayer)
      (TAPMarkMoveBoard
        (TAPGetBoard)
        (TAPGetCurrentPlayer)
        column))
    #f))

(define (TAPShowGame)
  (begin
    (display "Current player: ")
    (display (TAPGetCurrentPlayer))
    (newline)
    (display "Next player: ")
    (display (TAPNextPlayer))
    (newline)
    (newline)
    (TAPShowBoard (TAPGetBoard))))

(define (TAPLegalMoveP column)
  (TAPLegalMoveBoard (TAPGetBoard) column))

(define (TAPWinP lastMove)
  (TAPWinBoard
    (TAPGetBoard)
    (TAPNextPlayer)
    lastMove))

(define (TAPWillWinP moveColumn)
  (TAPWinBoard
    (TAPMarkMoveBoard
      (TAPGetBoard)
      (TAPGetCurrentPlayer)
      moveColumn)
    (TAPGetCurrentPlayer)
    moveColumn))


;------------------------------------------------------------------------------
; Constants
;------------------------------------------------------------------------------
(define (PLAYER1_MARKER) 1)
(define (PLAYER2_MARKER) 2)
(define (NUM_ROWS) 6)
(define (NUM_COLUMNS) 7)
(define (WIN_COUNT) 4)


;------------------------------------------------------------------------------
; Private Functions
;------------------------------------------------------------------------------

(define (TAPSetGameState nextPlayer board)
  (set!
    TAPGame
    (cons
      nextPlayer
      board)))

(define (TAPGetCurrentPlayer)
  (car TAPGame))

(define (TAPNextPlayer)
  (if
    (=
      (TAPGetCurrentPlayer)
      (PLAYER1_MARKER))
    (PLAYER2_MARKER)
    (PLAYER1_MARKER)))

(define (TAPGetBoard)
  (cdr TAPGame))

(define (TAPInitializeBoard)
  (TAPSetGameState
    (PLAYER1_MARKER)
    '((0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0)
      (0 0 0 0 0 0 0))))

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

(define (TAPMarkMoveBoard board player column)
  (if
    (TAPLegalMoveBoard board column)
    (TAPSetCell
      board
      (TAPFreeRowIndex
        board
        column)
      column
      player)
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



(define (TAPLegalMoveBoard board column)
  (=
    (TAPGetCell board 1 column)
    0))

(define (TAPRandomMove)
  (+
    1
    (random (NUM_COLUMNS))))

(define (TAPWinBoard board player lastMove)
  (or
    (TAPWinVertical
      board
      player
      lastMove)
    (TAPWinHorizontal
      board
      player
      lastMove)
    (TAPWinDiagonalForwardSlash
      board
      player
      lastMove)
    (TAPWinDiagonalBackSlash
      board
      player
      lastMove)
    #f))

(define (TAPWinVertical board player column)
  (=
    (TAPCountDown
      board
      player
      (+
        1
        (TAPFreeRowIndex
          board
          column))
      column)
    4))

(define (TAPCountDown board player row column)
  (if
    (> row (NUM_ROWS))
    0
    (if
      (=
        player
        (TAPGetCell
          board
          row
          column))
      (+
        1
        (TAPCountDown
          board
          player
          (+
            row
            1)
          column))
      0)))

(define (TAPWinHorizontal board player lastMove)
  (=
    4
    ; left plus right minus 1 since the first column gets counted twice
    (-
      (+
        (TAPNumLeft
          board
          player
          (+
            1
            (TAPFreeRowIndex
              board
              lastMove))
          lastMove)
        (TAPNumRight
          board
          player
          (+
            1
            (TAPFreeRowIndex
              board
              lastMove))
          lastMove))
      1)))

(define (TAPNumLeft board player row column)
  (if
    (=
      column
      0)
    0
    (if
      (=
        player
        (TAPGetCell
          board
          row
          column))
       (+
         1
         (TAPNumLeft
           board
           player
           row
           (-
             column
             1)))
       0)))

(define (TAPNumRight board player row column)
  (if
    (=
      column
      (+
        (NUM_COLUMNS)
        1))
    0
    (if
      (=
        player
        (TAPGetCell
          board
          row
          column))
       (+
         1
         (TAPNumRight
           board
           player
           row
           (+
             column
             1)))
       0)))

(define (TAPWinDiagonalForwardSlash board player lastMove)
  (=
    4
    ; minus 1 since the first position gets counted twice
    (-
      (+
        (TAPNumUpAndRight
         board
         player
         (+
           (TAPFreeRowIndex
             board
             lastMove)
           1)
         lastMove)
        (TAPNumDownAndLeft
          board
          player
          (+
            (TAPFreeRowIndex
              board
              lastMove)
            1)
          lastMove))
      1)))

(define (TAPNumUpAndRight board player row column)
  (if
    (or
      (= row 0)
      (> column (NUM_COLUMNS))
      (not
        (=
          player
          (TAPGetCell
            board
            row
            column))))
    0
    (+
      1
      (TAPNumUpAndRight
        board
        player
        (- row 1)
        (+ column 1)))))

(define (TAPNumDownAndLeft board player row column)
  (if
    (or
      (> row (NUM_ROWS))
      (= column 0)
      (not
        (=
          player
          (TAPGetCell
            board
            row
            column))))
    0
    (+
      1
      (TAPNumDownAndLeft
        board
        player
        (+ row 1)
        (- column 1)))))

(define (TAPWinDiagonalBackSlash board player lastMove)
  (=
    4
    ; minus 1 since the first position gets counted twice
    (-
      (+
        (TAPNumUpAndLeft
         board
         player
         (+
           (TAPFreeRowIndex
             board
             lastMove)
           1)
         lastMove)
        (TAPNumDownAndRight
          board
          player
          (+
            (TAPFreeRowIndex
              board
              lastMove)
            1)
          lastMove))
      1)))


(define (TAPNumDownAndRight board player row column)
  (if
    (or
      (> row (NUM_ROWS))
      (> column (NUM_COLUMNS))
      (not
        (=
          player
          (TAPGetCell
            board
            row
            column))))
    0
    (+
      1
      (TAPNumDownAndRight
        board
        player
        (+ row 1)
        (+ column 1)))))

(define (TAPNumUpAndLeft board player row column)
  (if
    (or
      (= row 0)
      (= column 0)
      (not
        (=
          player
          (TAPGetCell
            board
            row
            column))))
    0
    (+
      1
      (TAPNumUpAndLeft
        board
        player
        (- row 1)
        (- column 1)))))


;------------------------------------------------------------------------------
; Matrix functions
;------------------------------------------------------------------------------
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
(provide TAPGetBoard TAPGetCell TAPSetCell TAPSetListItem TAPStartGame
         TAPMarkMove
         TAPInitializeBoard TAPLegalMoveP TAPLegalMoveBoard TAPMarkMoveBoard
         TAPFreeRowIndex TAPShowGame TAPRandomMove TAPWinBoard TAPWinVertical
         TAPCountDown TAPWinHorizontal TAPNumLeft TAPNumRight TAPNumUpAndRight
         TAPNumDownAndLeft TAPWinDiagonalForwardSlash TAPNumDownAndRight
         TAPNumUpAndLeft TAPWinDiagonalBackSlash TAPWinP TAPWillWinP)
