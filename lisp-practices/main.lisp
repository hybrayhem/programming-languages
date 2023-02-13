;;;; Program Description
;;; Comment
;; Comment

#||
Multiline
Comment
||#

(format t "Hello, World!~%")
(print "What is your name?")

(defvar *name* (read)) ;; Global variable surround with *'s

(defun greeting (name)
  (format t "Hello ~a!~%" name))

;; default
(greeting *name*)

(setq *print-case* :capitalize)
(greeting *name*)

(setq *print-case* :upcase)
(greeting *name*)

(setq *print-case* :downcase)
(greeting *name*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(+ 5 (- 4 3)); = 6

(defvar *number* 0)
(setf *number* 6) ;; change value to 6

(let ((x 5)) (print x));; define variable in local scope of let
; print with x newline

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(format t "Number with commas ~:d ~%" 10000000)
(format t "PI to 5 characters ~5f ~%" 3.141593)
(format t "PI to 4 decimals ~,4f ~%" 3.141593)
(format t "10 Percent ~,,2f ~%" .10)
(format t "10 Dollars ~$ ~%~%" 10)

; Arithmetic operators: + - * / expt(^) rem(remainder in division) mod(%)
(+ 3 8); = 11
(- 3 8); = -5
(* 3 8); = 24

(/ 9 3); = 9/3
(/ 9 2.0); = 4.5 (float)
(/ 9.0 2); = 4.5

(expt 2 3); = 8
(rem 13 5); = 3
(mod 13 5); = 3 

; Other Mathematical Predicares
; unary: sqrt log floor ceiling null
; binary: eq oddp evenp numberp
(eq 'cat 'cat); = T
; n-ary: max min

; Logic operators: = < > <= >= /= (not equal)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *color* 'red)

(format t "(eq *color 'red) = ~d~%" (eq *color* 'red)); t
(format t "(eq 5.5 5.3) = ~d~%" (eq 5.5 5.3)); nil

(format t "(equalp \"Red\" \"red\") = ~d~%" (equalp "Red" "red")); t
(format t "(equalp 1.0 1) = ~d~%" (equalp 1.0 1)); t

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *age* 18)

(if (>= *age* 18)
    (format t "You are an adult!~%")
    (format t "You are a minor!~%"))

(if (and (>= *age* 10) (<= *age* 14))
    (format t "You are a child!~%"))

(if (and (>= *age* 14) (<= *age* 18))
    (format t "You are a teenager!~%"))


(defvar *num* 2)
(defvar *num-times-2* 0)
(defvar *num-times-3* 0)

(if (= *num* 2)
    (progn ; to put multiple statements
          (format t "Num is 2.~%")
          (setf *num-times-2* (* *num* 2))
          (setf *num-times-3* (* *num* 3)))

    (format t "Num is not 2.~%"))

(format t "Num * 2 = ~d~%" *num-times-2*)
(format t "Num * 3 = ~d~%" *num-times-3*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Switch case
(setf *age* 5)

(defun get-school (age)
  (case age
    (5 (print "Kindergarten"))
    (6 (print "First Grade"))
    (otherwise (print "Middle School")) ; default
    ))

(get-school *age*)

(terpri) ; newline

; execute multiple statements with "when"
(defvar *school* nil)

(when (= *age* 5)
      (print "You are 5 years old.")
      (setf *school* "Kindergarten")
      (format t "You are in ~a.~%" *school*))

(setf *age* 18)
(cond ((>= *age* 18)
        (setf *school* "College")
        (format t "You are going to ~a.~%" *school*))
      ((< *age* 18)
        (print "Not ready for college."))
      (t (print "Not sure what you are doing.")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Loops
(setq x 1)
(loop for x in '(Canis Vulpus Lepus Felis) do (format t "~a~%" x))

(loop for y from 10 to 20 do (print y))
(terpri)

(dotimes (z 12) (print z))
(terpri)
(terpri)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; List operations
(cons 'luke 'obi) ; adds to front of list
(cons 'luke '(obi anakin))
(list 'luke 'obi 'anakin) ; creates list

(format t "First item = ~d~%" (car '(luke obi anakin)))
(format t "Rest without first item = ~d~%" (cdr '(luke obi anakin)))
(format t "Second item = ~d~%" (cadr '(luke obi anakin mando vader))) ; cadr = car(cdr), evaluates right to left
(format t "Third item = ~d~%" (caddr '(luke obi anakin mando vader)))

(format t "Is list = ~d~%" (listp '(luke obi anakin mando vader)))

(member 'anakin '(luke obi anakin mando vader)); = (anakin mando vader)
(format t "Is Anakin in list = ~d~%" (if (member 'anakin '(luke obi anakin mando vader)) 't nil))

(defparameter *a-list* '(yet another phrase))
(setf *a-list* (append '(luke obi) *a-list*)) ; append to list
(format t "List = ~a~%" *a-list*)
(push 'anakin *a-list*) ; push to front of list, no need to setf
(format t "List = ~a~%" *a-list*)

(format t "3rd item = ~a~%~%" (nth 2 *a-list*))

(defvar emperor (list :name "Vader" :age 45 :ship "Star Destroyer"))
(defvar jedi (list :name "Obi" :age 50 :ship "The Negotiator"))

(defvar empire-list nil)
(push emperor empire-list)

(dolist (item empire-list) (format t "~{~a : ~a : ~a ~}~%" item)) ; ~{ ~} is a list iterator

(defparameter *ship-list*
              '((X-Wing ("Luke Skywalker" "Wedge Antilles" "Biggs Darklighter") (1050 kmh))
                (Y-Wing ("Porkins" "Dutch Vander" "Jan Dodonna") (950 kmh))
                (A-Wing ("Garven Dreis" "Wes Janson" "Hobbie Klivian") (1100 kmh))
                (TIE-Interceptor ("Soontir Fel" "Maarek Stele" "Darth Vader") (1100 kmh))))

(format t "X-Wing Crew = ~a~%" (cadr (assoc 'x-wing *ship-list*)))
(format t "TIE-Interceptor Speed = ~a~%~%" (caddr (assoc 'tie-interceptor *ship-list*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Functions
(defun avg (a b)
  (/ (+ a b) 2))
(format t "Average of 5 and 10 = ~d~%" (avg 5 10))

; optional arguments
(defun avg2 (a b &optional c)
  (if c
      (/ (+ a b c) 3)
      (/ (+ a b) 2)))

(format t "Average of 5 and 10 = ~d~%" (avg2 5 10))
(format t "Average of 5, 10, and 15 = ~d~%~%" (avg2 5 10 15))

; multiple arguments
(defvar *total* 0)

(defun sum (&rest nums)
  (dolist (num nums)
    (setf *total* (+ *total* num)))
  (format t "Sum = ~d~%" *total*))
(sum 1 6 8 9)

; return-from 
(defun sum2 (a b)
  (return-from sum2 (+ a b)))

; mapcar
(format t "Is number? = ~d~%" (mapcar #'numberp '(1 n 8 h 4 7)))

; local function binding
(flet ((sin2x (x) (sin (* 2 x)))
       (cos2x (x) (cos (* 2 x))))
  (format t "sin(2*0.2) + cos(2*0.2) = ~d~%~%" (+ (sin2x 0.2) (cos2x 0.2))))

; higher order functions
(defun add (a b)
  (+ a b))

(defun sub (a b)
  (- a b))

; higher order function
(defun operate (a b func)
  (funcall func a b))

(format t "Add 5 and 10 = ~d~%" (operate 5 10 #'add))
(format t "Subtract 5 and 10 = ~d~%" (operate 5 10 #'sub))

; mapcar is a function that calls its first argument with each element of its second argument
(format t "Square of 1 to 10 = ~a~%~%" (mapcar (lambda (x) (* x x)) '(1 2 3 4 5 6 7 8 9 10)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Macros
; Functions executes when called, but macros are compiled when defined

(defmacro ifit (statement &rest body)
  `(if, statement           ; , is for indicating that as variable not constant
        (progn ,@body)))    ; @ is a splice operator

(ifit (>= 10 5)
        (format t "Checking if 10 is greater than 5~%")
        (format t "10 is not greater than 5~%")
        (terpri)
)

(defmacro letx (var val &rest body)
  `(let ((,var ,val)) ,@body))

(defun substract (a b)
  (letx diff (- a b)
    (format t "Difference = ~d~%" diff)))

(substract 10 5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Classes
(defclass animal ()
    (name sound))

(defparameter *dog* (make-instance 'animal))
(setf (slot-value *dog* 'name) "Fido")
(setf (slot-value *dog* 'sound) "Woof")

(format t "~a says ~a~%~%" (slot-value *dog* 'name) (slot-value *dog* 'sound))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Arrays
(defvar *array* (make-array 10 :initial-element 0))
(format t "Array = ~a~%" *array*)

(setf (aref *array* 0) 1)
(setf (aref *array* 1) 2)

(format t "Set first element ~a~%" (aref *array* 0))
(format t "Set second element ~a~%~%" (aref *array* 1))
(format t "Array = ~a~%" *array*)

; Multidimensional arrays
(defvar *array2* (make-array '(3 3) :initial-contents '((1 2 3) (4 5 6) (7 8 9))))
(format t "Array2 = ~a~%" *array2*)

; Print with loop
(loop for i from 0 to 2 do
  (loop for j from 0 to 2 do
    (format t "Array2[~d][~d] = ~d~%" i j (aref *array2* i j))))

(format t "~%")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Conditionals

; if
(if (> 10 5)
    (format t "10 is greater than 5~%"))

; when
(when (> 10 5)
    (format t "10 is greater than 5~%"))

; unless
(unless (> 10 5)
    (format t "10 is not greater than 5~%"))

; cond
(cond ((> 10 5) (format t "10 is greater than 5~%"))
      ((< 10 5) (format t "10 is less than 5~%"))
      (t (format t "10 is equal to 5~%")))

; case
(case 10
  (5 (format t "10 is equal to 5~%"))
  (10 (format t "10 is equal to 10~%"))
  (t (format t "10 is not equal to 5 or 10~%")))

; and
(and (> 10 5) (< 10 15))
; or
(or (> 10 5) (< 10 5))
; not
(not (> 10 5))
