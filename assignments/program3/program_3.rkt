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
(define (LF_LOWER) (VLF_UPPER))
(define (LF_UPPER) 0.300)
(define (MF_LOWER) (LF_UPPER))
(define (MF_UPPER) 3.0)
(define (HF_LOWER) (MF_UPPER))
(define (HF_UPPER) 30.0)
(define (VHF_LOWER) (HF_UPPER))
(define (VHF_UPPER) 328.6)
(define (UHF_LOWER) (VHF_UPPER))
(define (UHF_UPPER) 2009.0)

(define (classifyFrequency frequency)
  (cond ((inRange frequency (VLF_LOWER) (VLF_UPPER)) "VLF")
        ((inRange frequency (LF_LOWER) (LF_UPPER)) "LF")
        ((inRange frequency (MF_LOWER) (MF_UPPER)) "MF")
        ((inRange frequency (HF_LOWER) (HF_UPPER)) "HF")
        ((inRange frequency (VHF_LOWER) (VHF_UPPER)) "VHF")
        ((inRange frequency (UHF_LOWER) (UHF_UPPER)) "UHF")
        (#t "FREQUENCY OUT OF RANGE")
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
(provide calcOvertimePay
         calcSimplePay
         overtimeRate
         computeHourlyPay
         anyOvertime
         computeCommissionedPay
         computeWeeklyPaycheck)

  
