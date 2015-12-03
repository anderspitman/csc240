; Anders Pitman - Program 11 - Scheme Connect Four Game

#lang racket/base

;------------------------------------------------------------------------------
; Constants
;------------------------------------------------------------------------------
(define (PLAYER1_MARKER) 1)
(define (PLAYER2_MARKER) 2)
(define (NUM_ROWS) 6)
(define (NUM_COLUMNS) 7)
(define (WIN_COUNT) 4)
(define (NUM_ITERATIONS) 10000)


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
      (TAPBoardMarkMove
        (TAPGetBoard)
        (TAPGetPlayer)
        column))
    #f))

(define (TAPShowGame)
  (begin
    (display "Current player: ")
    (display (TAPGetPlayer))
    (newline)
    (display "Next player: ")
    (display (TAPNextPlayer))
    (newline)
    (newline)
    (TAPShowBoard (TAPGetBoard))))

(define (TAPMakeMove)
  (TAPChooseLegal (TAPRandomMove)))

(define (TAPLegalMoveP column)
  (TAPBoardLegalMove (TAPGetBoard) column))

(define (TAPWinP lastMove)
  (TAPBoardWin
    (TAPGetBoard)
    (TAPPreviousPlayer)
    lastMove))

(define (TAPWillWinP moveColumn)
  (TAPBoardWillWin
    (TAPGetBoard)
    (TAPGetPlayer)
    moveColumn))


;------------------------------------------------------------------------------
; State Object Functions
;------------------------------------------------------------------------------

(define (TAPStateCreate player board)
  (cons player board))

(define (TAPStateGetPlayer state)
  (car state))

(define (TAPStateGetBoard state)
  (cdr state))

(define (TAPStateGetNextPlayer state)
  (if
    (=
      (TAPStateGetPlayer state)
      (PLAYER1_MARKER))
    (PLAYER2_MARKER)
    (PLAYER1_MARKER)))


;------------------------------------------------------------------------------
; Board Object Functions
;------------------------------------------------------------------------------

(define (TAPBoardMarkMove board player column)
  (if
    (TAPBoardLegalMove board column)
    (TAPSetCell
      board
      (TAPFreeRowIndex
        board
        column)
      column
      player)
    board))

(define (TAPBoardLegalMove board column)
  (=
    (TAPGetCell board 1 column)
    0))

(define (TAPBoardFull board)
  (TAPBoardFullIter board 1))

(define (TAPBoardFullIter board column)
  (if
    (> column (NUM_COLUMNS))
    #t
    (and
      (not (TAPBoardLegalMove
             board 
             column))
      (TAPBoardFullIter
          board
          (+ column 1)))))

(define (TAPBoardWillWin board player moveColumn)
  (TAPBoardWin
    (TAPBoardMarkMove
      board
      player
      moveColumn)
    player
    moveColumn))

(define (TAPBoardWin board player lastMove)
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

(define (TAPBoardRandomLegalMove board)
  (TAPBoardRandomLegalMoveIter board (TAPRandomMove)))

(define (TAPBoardRandomLegalMoveIter board move)
  (if (TAPBoardLegalMove board move)
    move
    (TAPBoardRandomLegalMoveIter board (TAPRandomMove))))


;------------------------------------------------------------------------------
; Global Data Accessor Functions
;------------------------------------------------------------------------------

(define (TAPGetGameState)
  TAPGame)

(define (TAPSetGameState nextPlayer board)
  (set!
    TAPGame
    (TAPStateCreate
      nextPlayer
      board)))

(define (TAPGetPlayer)
  (TAPStateGetPlayer TAPGame))

(define (TAPNextPlayer)
  (TAPStateGetNextPlayer TAPGame))

(define (TAPPreviousPlayer)
  (TAPNextPlayer))

(define (TAPGetBoard)
  (TAPStateGetBoard TAPGame))

;------------------------------------------------------------------------------
; Private Functions
;------------------------------------------------------------------------------

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

(define (TAPShowHistogram aList)
  (if
    (null? aList)
    #t
    (begin
      (TAPShowBar (car aList))
      (newline)
      (TAPShowHistogram (cdr aList)))))

(define (TAPShowBar value)
  (TAPShowBarIter (TAPNumSymbols value)))

(define (TAPShowBarIter numSymbols)
  (if
    (= numSymbols 0)
    #t
    (begin
      (display "*")
      (TAPShowBarIter
        (- numSymbols 1)))))

(define (TAPNumSymbols value)
  (display value)
  (round
    (*
      (/ value (NUM_ITERATIONS))
      100)))


;------------------------------------------------------------------------------
; Move Decision Functions
;------------------------------------------------------------------------------

(define (TAPMakeMoveStatistical)
  (TAPBestMove))

(define (TAPBestMove)
  (TAPMax
    (TAPTryMoves
      (TAPGetGameState)
      (TAPGetLegalMoves
        (TAPGetBoard)))))

(define (TAPMax theList)
  (TAPMaxIter theList 0 1 1))

(define (TAPMaxIter theList currentMax index maxIndex)
  (if
    (null? theList)
    maxIndex
    (if
      (>
        (car theList)
        currentMax)
      (TAPMaxIter
        (cdr theList)
        (car theList)
        (+ index 1)
        index)
      (TAPMaxIter
        (cdr theList)
        currentMax
        (+ index 1)
        maxIndex))))

(define (TAPTryMoves gameState moves)
  (if
    (null? moves)
    '()
    (cons
      (TAPTryMoveMultipleTimes
        gameState
        (car moves)
        (NUM_ITERATIONS))
      (TAPTryMoves
        gameState
        (cdr moves)))))

(define (TAPTryMoveMultipleTimes gameState move numIterations)
  (if
    (= numIterations 0)
    0
    (+
      (TAPTryMove
        gameState
        move)
      (TAPTryMoveMultipleTimes
        gameState
        move
        (- numIterations 1)))))

(define (TAPTryMove gameState move)
  ;(display "Trying move: ") (display move) (newline)
  (TAPTryMoveState
    (TAPStateCreate
      (TAPStateGetNextPlayer gameState)
      (TAPBoardMarkMove
        (TAPStateGetBoard gameState)
        (TAPStateGetPlayer gameState)
        move))
    (TAPStateGetPlayer gameState)))

(define (TAPTryMoveState gameState player)
  (if
    (TAPBoardFull (TAPStateGetBoard gameState))
    0
    (TAPTryMoveIter
      gameState
      player
      (TAPBoardRandomLegalMove (TAPStateGetBoard gameState)))))

(define (TAPTryMoveIter gameState player move)
  ;(display "move: ") (display move) (newline)
  (cond
    ((TAPBoardWillWin
       (TAPStateGetBoard gameState)
       (TAPStateGetPlayer gameState)
       move)
     (if
       (=
         player
         (TAPStateGetPlayer gameState))
       1
       0))
    ((TAPBoardFull (TAPStateGetBoard gameState))
     0)
    (#t
     (TAPTryMoveIter
       (TAPStateCreate
         (TAPStateGetNextPlayer gameState)
         (TAPBoardMarkMove
           (TAPStateGetBoard gameState)
           (TAPStateGetPlayer gameState)
        move))
       player
       (TAPBoardRandomLegalMove (TAPStateGetBoard gameState))))))

(define (TAPChooseLegal move)
  (if (TAPLegalMoveP move)
    move
    (TAPChooseLegal (TAPRandomMove))))

(define (TAPRandomMove)
  (+
    1
    (random (NUM_COLUMNS))))

(define (TAPGlobalBoardFull)
  (TAPBoardFull (TAPGetBoard)))

(define (TAPGetLegalMoves board)
  (TAPGetLegalMovesIter board 1))

(define(TAPGetLegalMovesIter board column)
  (if
    (> column (NUM_COLUMNS))
    '()
    (if
      (TAPBoardLegalMove
        board
        column)
      (cons
        column
        (TAPGetLegalMovesIter
          board
          (+ column 1)))
      (TAPGetLegalMovesIter
        board
        (+ column 1)))))



;------------------------------------------------------------------------------
; Win Determination Functions
;------------------------------------------------------------------------------

(define (TAPWinVertical board player column)
  (winningNumber
    (TAPCountDown
      board
      player
      (+
        1
        (TAPFreeRowIndex
          board
          column))
      column)))

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
  (winningNumber
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
  (winningNumber
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
  (winningNumber
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

(define (winningNumber number)
  (>= number (WIN_COUNT)))


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
(provide TAPBoardFull TAPBoardLegalMove TAPBoardMarkMove TAPBoardWin 
  
         TAPGetBoard TAPGetCell TAPSetCell TAPSetListItem TAPStartGame
         TAPMarkMove TAPMakeMove TAPGetPlayer TAPPreviousPlayer
         TAPInitializeBoard TAPLegalMoveP 
         TAPFreeRowIndex TAPShowGame TAPRandomMove TAPWinVertical
         TAPCountDown TAPWinHorizontal TAPNumLeft TAPNumRight TAPNumUpAndRight
         TAPNumDownAndLeft TAPWinDiagonalForwardSlash TAPNumDownAndRight
         TAPNumUpAndLeft TAPWinDiagonalBackSlash TAPWinP TAPWillWinP
         TAPGlobalBoardFull TAPGetLegalMoves TAPMakeMoveStatistical
         TAPShowHistogram TAPSetGameState TAPMax)
