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
  smallBoardEmpty
  '((0 0)
    (0 0)))

(define
  smallboardAfterColumnOneFirstMove
  '((0 0)
    (1 0)))

(define
  smallboardAfterColumnOneSecondMove
  '((1 0)
    (1 0)))

(define
  smallboardFull
  '((1 1)
    (1 1)))

(define
  boardEmpty
  '((0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)))

(define
  boardWinVertical
  '((0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)
    (1 0 0 0 0 0 0)
    (1 2 0 0 0 0 0)
    (1 2 0 0 0 0 0)
    (1 2 0 0 0 0 0)))

(define
  boardWinHorizontal
  '((0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)
    (0 0 0 0 2 0 0)
    (0 0 0 0 2 0 0)
    (1 1 1 1 2 0 0)))

(define
  boardWinHorizontalSandwich
  '((0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)
    (2 1 1 1 1 2 0)))

(define
  boardWinDiagonalForwardSlash
  '((0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)
    (0 0 0 1 2 0 0)
    (0 0 1 1 1 0 0)
    (0 1 1 2 2 0 0)
    (1 2 2 2 1 2 0)))

(define
  boardWinDiagonalBackSlash
  '((0 0 0 0 0 0 0)
    (0 0 0 0 0 0 0)
    (1 0 0 0 0 0 0)
    (1 1 0 0 0 0 0)
    (2 2 1 0 0 0 0)
    (1 2 2 1 2 0 0)))

(define
  boardMoreThan4
  '((0 0 0 0 0 0 1)
    (0 0 0 0 0 0 1)
    (0 0 0 0 0 0 1)
    (1 0 0 0 0 0 2)
    (1 2 0 0 0 0 1)
    (1 2 2 2 2 2 1)))

(define
  boardFull
  '((2 1 1 2 2 1 1)
    (1 2 2 1 1 2 2)
    (2 1 1 2 2 1 1)
    (1 2 2 1 1 2 2)
    (2 1 1 2 2 1 1)
    (1 2 2 1 1 2 2)))

(define
  boardLegalMoves
  '((2 0 1 0 2 0 0)
    (1 2 2 1 1 2 2)
    (2 1 1 2 2 1 1)
    (1 2 2 1 1 2 2)
    (2 1 1 2 2 1 1)
    (1 2 2 1 1 2 2)))

(define (PLAYER_ONE) 1)
(define (PLAYER_TWO) 2)


(check-equal? (TAPBoardLegalMove smallBoardEmpty 1) #t)
(check-equal? (TAPBoardLegalMove smallBoardEmpty 2) #t)
(check-equal? (TAPBoardLegalMove smallboardFull 1) #f)
(check-equal? (TAPBoardLegalMove smallboardFull 2) #f)
(check-equal? (TAPBoardLegalMove smallboardAfterColumnOneSecondMove 1) #f)
(check-equal? (TAPBoardLegalMove smallboardAfterColumnOneSecondMove 2) #t)

(check-equal? (TAPFreeRowIndex smallBoardEmpty 1) 2)
(check-equal? (TAPFreeRowIndex smallboardAfterColumnOneFirstMove 1) 1)
(check-equal? (TAPFreeRowIndex smallboardAfterColumnOneFirstMove 2) 2)
(check-equal? (TAPFreeRowIndex smallboardFull 1) 0)
(check-equal? (TAPFreeRowIndex boardEmpty 1) 6)
(check-equal? (TAPFreeRowIndex boardWinVertical 1) 2)
(check-equal? (TAPFreeRowIndex boardWinVertical 2) 3)

(check-equal? (TAPFreeRowIndex boardWinHorizontal 1) 5)
(check-equal? (TAPFreeRowIndex boardWinHorizontal 2) 5)
(check-equal? (TAPFreeRowIndex boardWinHorizontal 6) 6)

(check-equal?
  (TAPBoardMarkMove smallBoardEmpty 1 1)
  smallboardAfterColumnOneFirstMove)
(check-equal?
  (TAPBoardMarkMove smallboardAfterColumnOneFirstMove 1 1)
  smallboardAfterColumnOneSecondMove)


(check-equal? (TAPCountDown boardWinVertical (PLAYER_ONE) 3 1) 4)
(check-equal? (TAPCountDown boardWinVertical (PLAYER_ONE) 4 1) 3)
(check-equal? (TAPCountDown boardWinVertical (PLAYER_ONE) 5 1) 2)
(check-equal? (TAPCountDown boardWinVertical (PLAYER_ONE) 6 1) 1)

(check-equal? (TAPCountDown boardWinVertical (PLAYER_TWO) 3 1) 0)
(check-equal? (TAPCountDown boardWinVertical (PLAYER_TWO) 4 2) 3)

(check-equal? (TAPWinVertical boardWinVertical (PLAYER_ONE) 1) #t)
(check-equal? (TAPWinVertical boardWinVertical (PLAYER_TWO) 2) #f)
(check-equal? (TAPWinVertical boardWinVertical (PLAYER_ONE) 2) #f)
(check-equal? (TAPWinVertical boardWinVertical (PLAYER_ONE) 2) #f)

(check-equal? (TAPNumLeft boardWinHorizontal (PLAYER_ONE) 6 1) 1)
(check-equal? (TAPNumLeft boardWinHorizontal (PLAYER_ONE) 6 2) 2)
(check-equal? (TAPNumLeft boardWinHorizontal (PLAYER_ONE) 6 3) 3)
(check-equal? (TAPNumLeft boardWinHorizontal (PLAYER_ONE) 6 4) 4)
(check-equal? (TAPNumLeft boardWinHorizontal (PLAYER_ONE) 6 5) 0)
(check-equal? (TAPNumLeft boardWinHorizontal (PLAYER_ONE) 6 6) 0)
(check-equal? (TAPNumLeft boardWinHorizontal (PLAYER_ONE) 6 7) 0)

(check-equal? (TAPNumRight boardWinHorizontal (PLAYER_ONE) 6 1) 4)
(check-equal? (TAPNumRight boardWinHorizontal (PLAYER_ONE) 6 2) 3)
(check-equal? (TAPNumRight boardWinHorizontal (PLAYER_ONE) 6 3) 2)
(check-equal? (TAPNumRight boardWinHorizontal (PLAYER_ONE) 6 4) 1)
(check-equal? (TAPNumRight boardWinHorizontal (PLAYER_ONE) 6 5) 0)
(check-equal? (TAPNumRight boardWinHorizontal (PLAYER_ONE) 6 6) 0)
(check-equal? (TAPNumRight boardWinHorizontal (PLAYER_ONE) 6 7) 0)

(check-equal? (TAPNumLeft boardWinHorizontalSandwich (PLAYER_ONE) 6 4) 3)
(check-equal? (TAPNumLeft boardWinHorizontalSandwich (PLAYER_ONE) 6 2) 1)

(check-equal? (TAPWinHorizontal boardWinHorizontal (PLAYER_ONE) 1) #t)
(check-equal? (TAPWinHorizontal boardWinHorizontal (PLAYER_ONE) 2) #t)
(check-equal? (TAPWinHorizontal boardWinHorizontal (PLAYER_ONE) 3) #t)
(check-equal? (TAPWinHorizontal boardWinHorizontal (PLAYER_ONE) 4) #t)
(check-equal? (TAPWinHorizontal boardWinHorizontal (PLAYER_ONE) 5) #f)
; assume last move always results in occupied bottom row, otherwise
; uncomment these
;(check-equal? (TAPWinHorizontal boardWinHorizontal (PLAYER_ONE) 6) #f)
;(check-equal? (TAPWinHorizontal boardWinHorizontal (PLAYER_ONE) 7) #f)

(check-equal?
  (TAPNumUpAndRight boardWinDiagonalForwardSlash (PLAYER_ONE) 6 1) 4)
(check-equal?
  (TAPNumUpAndRight boardWinDiagonalForwardSlash (PLAYER_ONE) 5 2) 3)
(check-equal?
  (TAPNumUpAndRight boardWinDiagonalForwardSlash (PLAYER_ONE) 4 3) 2)
(check-equal?
  (TAPNumUpAndRight boardWinDiagonalForwardSlash (PLAYER_ONE) 3 4) 1)

(check-equal?
  (TAPNumDownAndLeft boardWinDiagonalForwardSlash (PLAYER_ONE) 3 4) 4)
(check-equal?
  (TAPNumDownAndLeft boardWinDiagonalForwardSlash (PLAYER_ONE) 4 3) 3)
(check-equal?
  (TAPNumDownAndLeft boardWinDiagonalForwardSlash (PLAYER_ONE) 5 2) 2)
(check-equal?
  (TAPNumDownAndLeft boardWinDiagonalForwardSlash (PLAYER_ONE) 6 1) 1)

(check-equal?
  (TAPWinDiagonalForwardSlash boardWinDiagonalForwardSlash (PLAYER_ONE) 1) #t)
(check-equal?
  (TAPWinDiagonalForwardSlash boardWinDiagonalForwardSlash (PLAYER_ONE) 2) #t)
(check-equal?
  (TAPWinDiagonalForwardSlash boardWinDiagonalForwardSlash (PLAYER_ONE) 3) #t)
(check-equal?
  (TAPWinDiagonalForwardSlash boardWinDiagonalForwardSlash (PLAYER_ONE) 4) #t)

(check-equal?
  (TAPNumDownAndRight boardWinDiagonalBackSlash (PLAYER_ONE) 3 1) 4)
(check-equal?
  (TAPNumDownAndRight boardWinDiagonalBackSlash (PLAYER_ONE) 4 2) 3)
(check-equal?
  (TAPNumDownAndRight boardWinDiagonalBackSlash (PLAYER_ONE) 5 3) 2)
(check-equal?
  (TAPNumDownAndRight boardWinDiagonalBackSlash (PLAYER_ONE) 6 4) 1)

(check-equal?
  (TAPNumUpAndLeft boardWinDiagonalBackSlash (PLAYER_ONE) 6 4) 4)
(check-equal?
  (TAPNumUpAndLeft boardWinDiagonalBackSlash (PLAYER_ONE) 5 3) 3)
(check-equal?
  (TAPNumUpAndLeft boardWinDiagonalBackSlash (PLAYER_ONE) 4 2) 2)
(check-equal?
  (TAPNumUpAndLeft boardWinDiagonalBackSlash (PLAYER_ONE) 3 1) 1)

(check-equal?
  (TAPWinDiagonalBackSlash boardWinDiagonalBackSlash (PLAYER_ONE) 1) #t)
(check-equal?
  (TAPWinDiagonalBackSlash boardWinDiagonalBackSlash (PLAYER_ONE) 2) #t)
(check-equal?
  (TAPWinDiagonalBackSlash boardWinDiagonalBackSlash (PLAYER_ONE) 3) #t)
(check-equal?
  (TAPWinDiagonalBackSlash boardWinDiagonalBackSlash (PLAYER_ONE) 4) #t)


(check-equal? (TAPBoardWin boardWinVertical (PLAYER_ONE) 1) #t)
(check-equal? (TAPBoardWin boardWinHorizontal (PLAYER_ONE) 1) #t)
(check-equal? (TAPBoardWin boardWinHorizontal (PLAYER_ONE) 2) #t)
(check-equal? (TAPBoardWin boardWinHorizontal (PLAYER_ONE) 3) #t)
(check-equal? (TAPBoardWin boardWinHorizontal (PLAYER_ONE) 4) #t)

(check-equal? (TAPBoardWin boardWinDiagonalForwardSlash (PLAYER_ONE) 1) #t)
(check-equal? (TAPBoardWin boardWinDiagonalForwardSlash (PLAYER_ONE) 2) #t)
(check-equal? (TAPBoardWin boardWinDiagonalForwardSlash (PLAYER_ONE) 3) #t)
(check-equal? (TAPBoardWin boardWinDiagonalForwardSlash (PLAYER_ONE) 4) #t)

(check-equal? (TAPBoardWin boardWinDiagonalBackSlash (PLAYER_ONE) 1) #t)
(check-equal? (TAPBoardWin boardWinDiagonalBackSlash (PLAYER_ONE) 2) #t)
(check-equal? (TAPBoardWin boardWinDiagonalBackSlash (PLAYER_ONE) 3) #t)
(check-equal? (TAPBoardWin boardWinDiagonalBackSlash (PLAYER_ONE) 4) #t)

(check-equal? (TAPBoardWin boardWinVertical (PLAYER_TWO) 1) #f)
(check-equal? (TAPBoardWin boardWinVertical (PLAYER_TWO) 1) #f)

(check-equal? (TAPBoardWin boardMoreThan4 (PLAYER_TWO) 4) #t)

(check-equal? (TAPBoardFull boardFull) #t)
(check-equal? (TAPBoardFull boardEmpty) #f)
(check-equal? (TAPBoardFull boardWinVertical) #f)
(check-equal? (TAPBoardFull boardWinDiagonalForwardSlash) #f)

(check-equal? (TAPGetLegalMoves boardLegalMoves) '(2 4 6 7))
(check-equal? (TAPGetLegalMoves boardEmpty) '(1 2 3 4 5 6 7))
(check-equal? (TAPGetLegalMoves boardFull) '())
