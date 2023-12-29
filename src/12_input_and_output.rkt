#lang racket ; defines the language we are using

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 12. Input & output
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Racket has this concept of "port", which is very similar to file
;; descriptors in other languages

;; Open "/tmp/tmp.txt" and write "Hello World"
;; This would trigger an error if the file's already existed
(define out-port (open-output-file "/tmp/tmp.txt"))
(displayln "Hello World" out-port)
(close-output-port out-port)

;; Append to "/tmp/tmp.txt"
(define out-port (open-output-file "/tmp/tmp.txt"
                                   #:exists 'append))
(displayln "Hola mundo" out-port)
(close-output-port out-port)

;; Read from the file again
(define in-port (open-input-file "/tmp/tmp.txt"))
(displayln (read-line in-port))
; => "Hello World"
(displayln (read-line in-port))
; => "Hola mundo"
(close-input-port in-port)

;; Alternatively, with call-with-output-file you don't need to explicitly
;; close the file
(call-with-output-file "/tmp/tmp.txt"
  #:exists 'update ; Rewrite the content
  (λ (out-port)
    (displayln "World Hello!" out-port)))

;; And call-with-input-file does the same thing for input
(call-with-input-file "/tmp/tmp.txt"
  (λ (in-port)
    (displayln (read-line in-port))))