#lang racket ; defines the language we are using

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 5. Equality
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; for numbers use `='
(= 3 3.0) ; => #t
(= 2 1)   ; => #f

;; `eq?' returns #t if 2 arguments refer to the same object (in memory),
;; #f otherwise.
;; In other words, it's a simple pointer comparison.
(eq? '() '()) ; => #t, since there exists only one empty list in memory
(let ([x '()] [y '()])
  (eq? x y))  ; => #t, same as above

(eq? (list 3) (list 3)) ; => #f
(let ([x (list 3)] [y (list 3)])
  (eq? x y))            ; => #f — not the same list in memory!

(let* ([x (list 3)] [y x])
  (eq? x y)) ; => #t, since x and y now point to the same stuff

(eq? 'yes 'yes) ; => #t
(eq? 'yes 'no)  ; => #f

(eq? 3 3)   ; => #t — be careful here
            ; It’s better to use `=' for number comparisons.
(eq? 3 3.0) ; => #f

(eq? (expt 2 100) (expt 2 100))               ; => #f
(eq? (integer->char 955) (integer->char 955)) ; => #f

(eq? (string-append "foo" "bar") (string-append "foo" "bar")) ; => #f

;; `eqv?' supports the comparison of number and character datatypes.
;; for other datatypes, `eqv?' and `eq?' return the same result.
(eqv? 3 3.0)                                   ; => #f
(eqv? (expt 2 100) (expt 2 100))               ; => #t
(eqv? (integer->char 955) (integer->char 955)) ; => #t

(eqv? (string-append "foo" "bar") (string-append "foo" "bar"))   ; => #f

;; `equal?' supports the comparison of the following datatypes:
;; strings, byte strings, pairs, mutable pairs, vectors, boxes,
;; hash tables, and inspectable structures.
;; for other datatypes, `equal?' and `eqv?' return the same result.
(equal? 3 3.0)                                                   ; => #f
(equal? (string-append "foo" "bar") (string-append "foo" "bar")) ; => #t
(equal? (list 3) (list 3))                                       ; => #t
