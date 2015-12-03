#lang racket/base

(require "connect_four.rkt")

(display "Hi there")
(newline)

(TAPStartGame)
(TAPShowGame)

(define (getMove)
  (begin
    (display "Enter your move: ")
    (newline)
    (define move (read))
    (TAPMarkMove move)
    (TAPShowGame)
    (if
      (TAPWinP move)
      #t
      (getMove))))

(getMove)
