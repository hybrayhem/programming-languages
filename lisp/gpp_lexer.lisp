; gppinterpreter(zero or one input(input may be file name to interpret)) 
; (format t "Hello, world!")
; (setf keywords '(and or equal less nil list append concat set deffun for if exit load disp true false))
; (print keywords)

; (defun lexer (input)
; (

; ))

; (defun readFile(filename)
; (
;     ; get file name and print it
;     ; (setf fileName (read-line))
;     ; (format t "~s : " filename)
; ))

; (defun readTerminal()
; (

; ))


(defun gppinterpreter (&optional gppfile) (
    (if (eql gppfile nil) 
        (readTerminal) 
        (readFile)
    )

    ; (format t "G++ 1.8.2 Interpreter (default)")
    ; (loop
    ;     (format t "> ")
    ; )
))

(gppinterpreter (first *args*))