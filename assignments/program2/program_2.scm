; 1)
(* 2000 
   (/ (- (expt (+ 1 0.10) 20) 
         1 ) 
      0.10) 
   (+ 1 0.10))

; 2)
(* 10000 
   (/ (- 1
         (expt (/ (+ 1 0.02)
                  (+ 1 0.05))
               10))
      (- 0.05 0.02)))

; 3)
(/ (* 12000 0.01)
   (- 1
      (expt (+ 1 0.01)
            (- 36))))

; 4)
(- (* (/ 200 0.005)
      (- (expt (+ 1 0.005)
               (+ 120 1))
         1))
   200)

; 5)
(/ (* 1000 0.01)
   (- (expt (+ 1 0.01)
            11)
      1))

; 6)
(* (/ 100 0.01)
   (- 1
      (expt (+ 1 0.01)
            (- 60))))

            