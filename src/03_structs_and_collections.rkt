#lang racket ; defines the language we are using

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 3. Structs and Collections
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Structs
; By default, structs are immutable
(struct dog (name breed age))
(define my-pet
  (dog "lassie" "collie" 5))
my-pet ; => #<dog>
; returns whether the variable was constructed with the dog constructor
(dog? my-pet) ; => #t
; accesses the name field of the variable constructed with the dog constructor
(dog-name my-pet) ; => "lassie"

; You can explicitly declare a struct to be mutable with the #:mutable option
(struct rgba-color (red green blue alpha) #:mutable)
(define burgundy
   (rgba-color 144 0 32 1.0))
(set-rgba-color-green! burgundy 10)
(rgba-color-green burgundy) ; => 10

;;; Pairs (immutable)
;; `cons' constructs pairs, `car' and `cdr' extract the first
;; and second elements
(cons 1 2) ; => '(1 . 2)
(car (cons 1 2)) ; => 1
(cdr (cons 1 2)) ; => 2

;;; Lists

;; Lists are linked-list data structures, made of `cons' pairs and end
;; with a `null' (or '()) to mark the end of the list
(cons 1 (cons 2 (cons 3 null))) ; => '(1 2 3)
;; `list' is a convenience variadic constructor for lists
(list 1 2 3) ; => '(1 2 3)
;; a quote can also be used for a literal list value
'(1 2 3) ; => '(1 2 3)
;; a quasiquote (represented by the backtick character) with commas 
;; can be used to evaluate functions
`(1 ,(+ 1 1) 3) ; => '(1 2 3)

;; With lists, car/cdr work slightly differently
(car '(1 2 3)) ; => 1
(cdr '(1 2 3)) ; => '(2 3)

;; Racket also has predefined functions on top of car and cdr, to extract parts of a list
(cadr (list 1 2 3)) ; => 2
(car (cdr (list 1 2 3))) ; => 2

(cddr (list 1 2 3)) ; => '(3)
(cdr (cdr (list 1 2 3))) ; => '(3)

(caddr (list 1 2 3)) ; => 3
(car (cdr (cdr (list 1 2 3)))) ; => 3

;; Can still use `cons' to add an item to the beginning of a list
(cons 4 '(1 2 3)) ; => '(4 1 2 3)

;; Use `append' to add lists together
(append '(1 2) '(3 4)) ; => '(1 2 3 4)

;; Lists are a very basic type, so there is a *lot* of functionality for
;; them, a few examples:
(map add1 '(1 2 3))          ; => '(2 3 4)
(map + '(1 2 3) '(10 20 30)) ; => '(11 22 33)
(filter even? '(1 2 3 4))    ; => '(2 4)
(count even? '(1 2 3 4))     ; => 2
(take '(1 2 3 4) 2)          ; => '(1 2)
(drop '(1 2 3 4) 2)          ; => '(3 4)

;;; Vectors

;; Vectors are fixed-length arrays
#(1 2 3) ; => '#(1 2 3)

;; Use `vector-append' to add vectors together
(vector-append #(1 2 3) #(4 5 6)) ; => #(1 2 3 4 5 6)

;;; Sets

;; Create a set from a list
(list->set '(1 2 3 1 2 3 3 2 1 3 2 1)) ; => (set 1 2 3)

;; Add a member with `set-add'
;; (Functional: returns the extended set rather than mutate the input)
(set-add (set 1 2 3) 4) ; => (set 1 2 3 4)

;; Remove one with `set-remove'
(set-remove (set 1 2 3) 1) ; => (set 2 3)

;; Test for existence with `set-member?'
(set-member? (set 1 2 3) 1) ; => #t
(set-member? (set 1 2 3) 4) ; => #f

;;; Hashes

;; Create an immutable hash table (mutable example below)
(define m (hash 'a 1 'b 2 'c 3))

;; Retrieve a value
(hash-ref m 'a) ; => 1

;; Retrieving a non-present value is an exception
; (hash-ref m 'd) => no value found

;; You can provide a default value for missing keys
(hash-ref m 'd 0) ; => 0

;; Use `hash-set' to extend an immutable hash table
;; (Returns the extended hash instead of mutating it)
(define m2 (hash-set m 'd 4))
m2 ; => '#hash((b . 2) (a . 1) (d . 4) (c . 3))

;; Remember, these hashes are immutable!
m ; => '#hash((b . 2) (a . 1) (c . 3))  <-- no `d'

;; Use `hash-remove' to remove keys (functional too)
(hash-remove m 'a) ; => '#hash((b . 2) (c . 3))
