#lang racket/base

(require rackunit
         "program_3.rkt")

; overtimeRate
(check-equal? (overtimeRate 13) 19.5 "Simple rate")

; calcOvertimePay
(check-equal? (calcOvertimePay 20 10.0) 0.0 "Simple no overtime")
(check-equal? (calcOvertimePay 40 10.0) 0.0 "No overtime upper bound")
(check-equal? (calcOvertimePay 41 10.0) 415.0 "Overtime lower bound")
(check-equal? (calcOvertimePay 50 10.0) 550.0 "Simple overtime")

; calcSimplePay
(check-equal? (calcSimplePay 10.0 10.0) 100.0 "Simple pay")

; computHourly
(check-equal? (computeHourlyPay 15 13.0) 195.0 "Simple hourly")
(check-equal? (computeHourlyPay 40 5.0) 200.0 "Hourly no overtime upper bound")
(check-equal? (computeHourlyPay 41 5.0) 207.5 "Hourly overtime lower bound")
(check-equal? (computeHourlyPay 60 13.0) 910.0 "Simple overtime")

; hasOvertime
(check-equal? (anyOvertime 20) #f "No overtime")
(check-equal? (anyOvertime 40) #f "No overtime upper bound")
(check-equal? (anyOvertime 41) #t "Overtime lower bound")
(check-equal? (anyOvertime 50) #t "Overtime")


; computeCommissionedPay
(check-equal? (computeCommissionedPay 500.0) 5.0 "Commissioned 1%")
(check-equal? (computeCommissionedPay 999.99) (* 999.99 0.01) "Commissioned 1% upper bound")
(check-equal? (computeCommissionedPay 1000.0) (* 1000.0 0.025) "Commissioned 2.5% lower bound")
(check-equal? (computeCommissionedPay 9999.99) (* 9999.99 0.025) "Commissioned 2.5% upper bound")
(check-equal? (computeCommissionedPay 10000.00) (* 10000.00 0.06) "Commissioned 6% lower bound")
(check-equal? (computeCommissionedPay 100000.00) (* 100000.00 0.06) "Commissioned 6% upper")

; computeWeeklyPaycheck
(check-equal? (computeWeeklyPaycheck #t 10.0 10.0 0.0 ) 100.0 "Simple hourly no gift")
(check-equal? (computeWeeklyPaycheck #t 10.0 10.0 20.0 ) 80.0 "Simple hourly gift")
(check-equal? (computeWeeklyPaycheck #f 1000.0 0.0 0.0 ) 25.0 "Simple commission no gift")
(check-equal? (computeWeeklyPaycheck #f 10000.0 0.0 200.0 ) 400.0 "Simple commission gift")
