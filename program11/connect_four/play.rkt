#lang racket/base

(require "connect_four.rkt")

(display "Hi there")
(newline)


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
        (set! move (TAPMakeMove))
        (TAPMarkMove move)
        (TAPShowGame)))
    (if
      (TAPWinP move)
       #t
      (manVsMachine))))

(define (machineVsMachine)
  (begin
    (TAPStartGame)
    (machineVsMachineIter)))

(define (machineVsMachineIter)
  (begin
    ;(display "Automated move...")
    ;(newline)
    (set! move (TAPMakeMove))
    (TAPMarkMove move)
    ;(TAPShowGame)
    (if
      (or
        (TAPWinP move)
        (TAPBoardFull))
       #t
      (machineVsMachineIter))))

;(machineVsMachine)

(define (runNTimes n)
  (begin
    (display "n: ")
    (display n)
    (newline)
    (machineVsMachine)
    (if
      (= n 0)
      #t
      (runNTimes
        (- n 1)))))

;(manVsMan)

(runNTimes 1000)
