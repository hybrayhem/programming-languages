(defun lexer (input)
    ; (format t input)
    
    (let (tokens (list))
        (loop for c across input
            
            do (
                format t "~%~a" c
                ; (cond 
                ;         ((char= c #\+) (push (list :plus c) tokens))
                ;         ((char= char #\-) (push (list :minus char) tokens))
                ;         ((char= char #\/) (push (list :slash char) tokens))
                ;         ((char= char #\*) (push (list :star char) tokens))
                ;         (char= char #\()  (push (list :lparen char) tokens))
                ;         ((char= char #\)) (push (list :rparen char) tokens))
                ;         ((char= char #\") (push (list :quote char) tokens))
                ;         ((char= char #\,) (push (list :comma char) tokens))

                ;         ; ((char= char #\ ) (push (list :space char) tokens))
                ; )
                
            )
            
        )
    )
    
    
    (format t tokens)
)

(defun getOperandId (op)
    (if (member op (list :plus :minus :slash :star :lparen :rparen :quote :comma))
        (format t "OP_~a" op)
    )
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

    (getOperandId :plus)

    (if (eql gppfile nil) 
        (readTerminal) 
        (readFile gppfile)
    )
)

(gppinterpreter (car *args*))