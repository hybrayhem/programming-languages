(setf operators '(#\+ #\- #\/ #\( #\) #\* #\" ))
(setf keywords '(and or equal less nil list append concat set deffun for if exit load disp true false))

(defun lexer (input)
    (format t input)
)
    
(defun readFile(filename)
    ; get file name and print it
    (format t filename)
)

(defun readTerminal()
    ; get terminal command and print it
    (loop
        (terpri)
        (format t "> ")
        (setf command (read-line))
        (lexer command)
    )
)


(defun gppinterpreter (&optional gppfile)
    (format t "G++ 1.8.2 Interpreter (default)")
    (terpri)

    (if (eql gppfile nil) 
        (readTerminal) 
        (readFile gppfile)
    )
)

(gppinterpreter (car *args*))