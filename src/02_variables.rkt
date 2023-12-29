#lang racket ; defines the language we are using

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 2. Variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; You can create a variable using define
;; a variable name can use any character except: ()[]{}",'`;#|\
(define some-var 5)
some-var ; => 5

;; You can also use unicode characters
(define ⊆ subset?)
(⊆ (set 3 2) (set 1 2 3)) ; => #t

;; Accessing a previously unassigned variable is an exception
; x ; => x: undefined ...

;; Local binding: `me' is bound to "Bob" only within the (let ...)
(let ([me "Bob"])
  "Alice"
  me) ; => "Bob"

;; let* is like let, but allows you to use previous bindings in creating later bindings
(let* ([x 1]
       [y (+ x 1)])
  (* x y))

;; finally, letrec allows you to define recursive and mutually recursive functions
(letrec ([is-even? (lambda (n)
                     (or (zero? n)
                         (is-odd? (sub1 n))))]
         [is-odd? (lambda (n)
                    (and (not (zero? n))
                         (is-even? (sub1 n))))])
  (is-odd? 11))