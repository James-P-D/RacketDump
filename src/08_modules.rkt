#lang racket ; defines the language we are using

;; Modules let you organize code into multiple files and reusable
;; libraries; here we use sub-modules, nested in the whole module that
;; this text makes (starting from the "#lang" line)

(module cake racket/base ; define a `cake' module based on racket/base

  (provide print-cake) ; function exported by the module

  (define (print-cake n)
    (show "   ~a   " n #\.)
    (show " .-~a-. " n #\|)
    (show " | ~a | " n #\space)
    (show "---~a---" n #\-))

  (define (show fmt n ch) ; internal function
    (printf fmt (make-string n ch))
    (newline)))

;; Use `require' to get all `provide'd names from a module
(require 'cake) ; the ' is for a local submodule
(print-cake 3)
; (show "~a" 1 #\A) ; => error, `show' was not exported