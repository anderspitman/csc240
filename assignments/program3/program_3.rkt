#lang racket/base

; Anders Pitman - Program 3
;
; Functions you're looking for:
; calcWaterWeightInPipe
; classifyFrequency
; computeWeeklyPaycheck

; Shared
(define (inRange value lowerLimit upperLimit)
  (and (>= value lowerLimit) (< value upperLimit)))

; (1)
(define (PI) 3.14159)

(define (calcWaterWeightInPipe pipeDiameter pipeLength pureWater)
  (* (PI)
     (/ pipeDiameter 24)
     pipeLength
     (if pureWater 62.4 64.08)))

; (2)
(define (VLF_LOWER) 0.010)
(define (VLF_UPPER) 0.030)
(define (LF_UPPER) 0.300)
(define (MF_UPPER) 3.0)
(define (HF_UPPER) 30.0)
(define (VHF_UPPER) 328.6)
(define (UHF_UPPER) 2009.0)

(define (OUT_OF_RANGE) "FREQUENCY OUT OF RANGE")

(define (classifyFrequency frequency)
  (cond ((< frequency (VLF_LOWER)) (OUT_OF_RANGE))
        ((< frequency (VLF_UPPER)) "VLF")
        ((< frequency (LF_UPPER)) "LF")
        ((< frequency (MF_UPPER)) "MF")
        ((< frequency (HF_UPPER)) "HF")
        ((< frequency  (VHF_UPPER)) "VHF")
        ((< frequency  (UHF_UPPER)) "UHF")
        (#t (OUT_OF_RANGE))
        ))

; (3)
(define (OVERTIME_THRESHOLD) 40.0)

(define (computeWeeklyPaycheck hourly hoursOrSales hourlyRate giftDonation)
  (- (if hourly
       (computeHourlyPay hoursOrSales hourlyRate)
       (computeCommissionedPay hoursOrSales))
     giftDonation))


; Hourly
(define (computeHourlyPay hoursWorked payRate)
  (if (anyOvertime hoursWorked) 
      (calcOvertimePay hoursWorked payRate)
      (calcSimplePay hoursWorked payRate)))

(define (anyOvertime hoursWorked)
  (> hoursWorked (OVERTIME_THRESHOLD)))

(define (calcSimplePay hoursWorked payRate)
  (* hoursWorked payRate))

(define (calcOvertimePay hoursWorked payRate)
  (if (anyOvertime hoursWorked)
      (+ (* (OVERTIME_THRESHOLD) payRate)
         (* (- hoursWorked (OVERTIME_THRESHOLD))
            (overtimeRate payRate)))
      0.0))

(define (overtimeRate payRate)
  (* payRate 1.5))


; Comissioned
(define (computeCommissionedPay salesAmount)
  (cond ((< salesAmount 1000.0) (* salesAmount 0.01))
        ((inRange salesAmount 1000.0 10000.0) (* salesAmount 0.025))
        ((>= salesAmount 10000.0) (* salesAmount 0.06))
        ))

; you can ignore this. it's for unit testing in racket
(provide classifyFrequency
         calcOvertimePay
         calcSimplePay
         overtimeRate
         computeHourlyPay
         anyOvertime
         computeCommissionedPay
         computeWeeklyPaycheck)

  
