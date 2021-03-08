; DotProduct: Compute dot product of two 1D arrays
; Author: Pieter van Tuijl 
https://github.com/pietert2000

; ----------------------------------------------------
; The program finds the dot product of two one-dimensional arrays. It is given
;   * n (length of array X and Y), assume n > 0. Also, it is a requirement that both arrays have the same length
;   * n-element array X
;   * n-element array Y

; ----------------------------------------------------
; High level algorithm

; dot_product = 0
; for i in range(n):
;   dot_product += X[i] * Y[i]

; ----------------------------------------------------
; Low level algorithm

; dot_product := 0
; forloop: 
;     if i >= n then goto done
;     dot_product := dot_product + X[i] * Y[i]
;     i := i + 1
;     goto forloop
; done:
;     terminate

; ----------------------------------------------------
; Assembly Language

; Register usage
;   R1 = n
;   R2 = i
;   R3 = dot product

; Initialise
load    R1,n[R0]      ; R1 = n
lea     R2,0[R0]      ; R2 = i = 0
; load    R3,dp[R0]     ; R3 = dp (dot_product) = 0
lea     R10,1[R0]     ; R10 = constant 1

; Top of forloop
forloop
; if i >= n then goto done
      cmp R2,R1       ; compare i, n
      jumpge done[R0] ; if i>=n then goto done
; dot_product := dot_product + X[i] * Y[i]
      load R4,X[R2]   ; R4 = X[i]
      load R5,Y[R2]   ; R5 = Y[i]
      mul  R6,R4,R5   ; R6 = X[i] * Y[i]
      add  R3,R3,R6   ; dp = dp + R6
; i := i + 1
      add  R2,R2,R10  ; i = i + 1
; goto forloop
      jump forloop[R0]; go to top of forloop

; Exit from forloop
done  
; Store final result back in dp
      store R3,dp[R0]  ; dp = R3
; terminate
      trap  R0,R0,R0

; Data area
; With the following data, the expected result for dp is 34 (0022)
n     data   3
dp    data   0
X     data   2
      data   5
      data   3
Y     data   6
      data   2
      data   4
     
