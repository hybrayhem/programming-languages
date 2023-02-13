;; ------
;; Basics
;; ------
(defun hello-world ()
  ;;               ^^ no arguments
  (print "hello world!"))


(hello-world)
;; "hello world!"  <-- output
;; "hello world!"  <-- a string is returned.
(format t "~& ~&")

; print newline




;; ------
;; Arguments
;; ------
(defun hello (name)
  "Say hello to `name'." ;; docstring
  (format t "hello ~a !~&" name))
;; HELLO

(hello "me")
;; hello me !  <-- this is printed by `format`
;; NIL         <-- return value: `format t` prints a string to standard output and returns nil.
(format t "~& ~&")



;; ------
;; Optional arguments
;; ------
(defun hello-optional (name &optional age gender)
  (format t "hello-optional ~a ~a ~a" name age gender))
(hello-optional "me") ;; a value for the required argument, zero optional arguments
(hello-optional "me" "7") ;; a value for age
(hello-optional "me" 7 :h) ;; a value for age and gender

(format t "~& ~&")



;; ------
;; Named parameters
;; ------
(defun hello-named (name &key happy)
  "If `happy' is `t', print a smiley"
  (format t "hello-named ~a " name)
  (when happy
        (format t ":)~&")))

(hello-named "me")
(hello-named "me" :happy t)
(hello-named "me" :happy nil) ;; useless, equivalent to (hello "me")

(format t "~& ~&")



;; (defun hello (name &key happy lisper cookbook-contributor-p) ...)

;; (defun hello (name &key (happy t)) ;; now happy is true by default

;; happy-p is a predicate variable, true if the key was supplied, -p is just a convention
(defun hello-is-supplied (name &key (happy nil happy-p))
  (format t "Key supplied? ~a~&" happy-p)
  (format t "hello-is-supplied ~a " name)
  (when happy-p
        (if happy
            (format t ":)")
            (format t ":("))))


(defun mean (x &rest numbers)
  (/ (apply #'+ x numbers)
     (1+ (length numbers))))
(mean 1)
(mean 1 2) ;; => 3/2 (yes, it is printed as a ratio)
(mean 1 2 3 4 5) ;;  => 3

(format t "~& ~&")



