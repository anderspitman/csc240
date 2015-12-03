#lang racket/base

(require "connect_four.rkt")

(define human #t)
(define move 0)

(define (manVsMan)
  (begin
    (display "Enter your move: ")
    (newline)
    (set! move (read))
    (TAPMarkMove move)
    (TAPShowGame)
    (if
      (TAPWinP move)
       #t
      (manVsMan))))

(define (manVsMachine)
  (begin
    (TAPStartGame)
    (manVsMachineIter)))

(define (manVsMachineIter)
  (begin
    (if human
      (begin
        (set! human #f)
        (display "Enter your move: ")
        (newline)
        (set! move (read))
        (TAPMarkMove move)
        (TAPShowGame))
      (begin
        (set! human #t)
        (display "Automated move...")
        (newline)
        ;(set! move (TAPMakeMove))
        (set! move (TAPMakeMoveStatistical))
        (TAPMarkMove move)
        (TAPShowGame)))
    (if
      (TAPWinP move)
      (TAPGetPlayer)
      (manVsMachineIter))))

(define (machineVsMachine)
  (begin
    (TAPInitializeBoard)
    (machineVsMachineIter)))

(define (machineVsMachineIter)
  (begin
    ;(display "Automated move...")
    ;(newline)
    (set! move (TAPMakeMove))
    (TAPMarkMove move)
    ;(TAPShowGame)
    (cond
      ((TAPWinP move)
       (TAPPreviousPlayer))
      ((TAPGlobalBoardFull)
       0)
      (#t
       (machineVsMachineIter)))))

(define winner 0)
(define player1WinCount 0)
(define player2WinCount 1)
(define tieCount 0)

(define (runNTimes n)
  (begin
    ;(display "n: ")
    ;(display n)
    ;(newline)
    (set! winner (machineVsMachine))
    (cond
      ((= winner 1)
       (set!
         player1WinCount
         (+ player1WinCount 1)))
      ((= winner 2)
       (set!
         player2WinCount
         (+ player2WinCount 1)))
      ((= winner 0)
       (set!
         tieCount
         (+ tieCount 1))))
    (if
      (= n 0)
      (begin
        (display "Player 1 Wins: ")
        (display player1WinCount)
        (newline)
        (display "Player 2 Wins: ")
        (display player2WinCount)
        (newline)
        (display "Ties: ")
        (display tieCount)
        (newline))
      (runNTimes
        (- n 1)))))

;(manVsMan)
;(machineVsMachine)
(manVsMachine)
;(runNTimes 1000)
