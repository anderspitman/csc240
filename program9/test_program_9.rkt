#lang racket/base

(require rackunit
         "program_9.rkt")


(check-equal? (getValue '("a" . 3) ) "a" "Simple a")
(check-equal? (getValue '("b" . 1) ) "b" "Simple b")

(check-equal? (getCount '("a" . 3) ) 3 "Simple 3")
(check-equal? (getCount '("b" . 1) ) 1 "Simple 1")

(check-equal? (newPair "a") '("a" . 1) "Simple a")
(check-equal? (newPair "b") '("b" . 1) "Simple b")

(check-equal? (incPair '("a" . 0) ) '("a" . 1) "Simple 0")
(check-equal? (incPair '("a" . 1) ) '("a" . 2) "Simple 1")
(check-equal? (incPair '("a" . -1) ) '("a" . 0) "Simple negative")

(check-equal? (decPair '("b" . 1) ) '("b" . 0) "Simple 1")
(check-equal? (decPair '("b" . 2) ) '("b" . 1) "Simple 2")
(check-equal? (decPair '("b" . 0) ) '("b" . -1) "Simple negative")

(check-equal? (insertBag '() "a") '(("a" . 1)) "Empty")
(check-equal? (insertBag '(("a" . 1)) "b") '(("a" . 1) ("b" . 1)) "Simple")
(check-equal? (insertBag '(("a" . 1)) "a")
              '(("a" . 2))
              "Already exists should add 1")
(check-equal? (insertBag '(("a" . 1) ("b" . 1)) "a")
              '(("a" . 2) ("b" . 1))
              "Multiple existing items")
(check-equal? (insertBag '(("a" . 1) ("b" . 1) ("c" . 1)) "a")
              '(("a" . 2) ("b" . 1) ("c" . 1))
              "First in bag")
(check-equal? (insertBag '(("a" . 1) ("b" . 1) ("c" . 1)) "b")
              '(("a" . 1) ("b" . 2) ("c" . 1))
              "Middle in bag")
(check-equal? (insertBag '(("a" . 1) ("b" . 1) ("c" . 1)) "c")
              '(("a" . 1) ("b" . 1) ("c" . 2))
              "Last in bag")
(check-equal? (insertBag '(("b" . 1) ("c" . 1)) "a")
              '(("b" . 1) ("c" . 1) ("a" . 1))
              "Is appended to end")

(check-equal? (getBagCount '(("a" . 1)) "a") 1 "Simple")
(check-equal? (getBagCount '() "a") 0 "Empty bag")
(check-equal? (getBagCount '(("a" . 1)) "b") 0 "Not in bag")
(check-equal? (getBagCount '(("a" . 1) ("b" . 3) ("c" . 2)) "c") 2 "Mixed bag")

(check-equal? (deleteAllBag '() "a") '() "Empty bag")
(check-equal? (deleteAllBag '(("a" . 1)) "a") '() "Single occurance")
(check-equal? (deleteAllBag '(("a" . 1) ("b" . 1)) "a")
              '(("b" . 1))
              "Multiple current values")
(check-equal? (deleteAllBag '(("a" . 1) ("b" . 1) ("c" . 1)) "a")
              '(("b" . 1) ("c" . 1))
              "First in bag")
(check-equal? (deleteAllBag '(("a" . 1) ("b" . 1) ("c" . 1)) "b")
              '(("a" . 1) ("c" . 1))
              "Middle in bag")
(check-equal? (deleteAllBag '(("a" . 1) ("b" . 1) ("c" . 1)) "c")
              '(("a" . 1) ("b" . 1))
              "Last in bag")
