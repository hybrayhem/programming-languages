;; Define lists of keywords and operators
(defvar *keywords*
        '("and" "or" "not" "equal" "less" "nil" "list" "append" "concat" "set"
                "deffun" "for" "if" "exit" "load" "disp" "true" "false"))

(defvar *operators*
        '("+" "-" "/" "*" "(" ")" "**" ","))

;; Define a function to lexically analyze a string
(defun lex-string (string)
  (with-input-from-string (in string)
    (loop
     (let* ((ch (read-char in nil))
            (token (cond ((or (null ch) (char= ch #\Newline)) 'eoi)
                         ((char= ch #\;) (loop for ch = (read-char in nil)
                                               while (and ch (not (char= ch #\Newline)))
                                               finally (return 'COMMENT)))
                         ((char= ch #\") (loop for buffer = ""
                                               for ch = (read-char in nil)
                                               while (and ch (not (char= ch #\")))
                                               do (setf buffer (concatenate 'string buffer (string ch)))
                                               finally (return (list 'STRING buffer))))
                         ((member ch '(#\+ #\- #\/ #\* #\( #\) #\,))
                           (list (intern (format nil "OP_~A" ch)) (string ch)))
                         ((member ch '(#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9))
                           (loop for buffer = (string ch)
                                 for ch = (read-char in nil)
                                 while (and ch (member ch '(#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)))
                                 do (setf buffer (concatenate 'string buffer (string ch)))
                                 finally (return (list 'VALUEI buffer))))
                         ((member ch '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m
                                           #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z
                                           #\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M
                                           #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z
                                           #\_))
                           (loop for buffer = (string ch)
                                 for ch = (read-char in nil)
                                 while (and ch
                                            (or (member ch '(#\0 #\1 #\2 #\#\z #\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M
                                                                 #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z
                                                                 #\_)))
                                          do (setf buffer (concatenate 'string buffer (string ch)))
                                          finally (return (list 'IDENTIFIER buffer))))
                           (t (error "Lexical error: invalid token ~S" (string ch))))))
            (when (eq token 'eoi) (return))
            (format t "~A~%" token)))))

  ;; Define a function to lexically analyze a file
  (defun lex-file (filename)
    (with-open-file (in filename)
      (loop
       (let* ((ch (read-char in nil))
              (token (cond ((or (null ch) (char= ch #\Newline)) 'eoi)
                           ((char= ch #\;) (loop for ch = (read-char in nil)
                                                 while (and ch (not (char= ch #\Newline)))
                                                 finally (return 'COMMENT)))
                           ((char= ch #\") (loop for buffer = ""
                                                 for ch = (read-char in nil)
                                                 while (and ch (not (char= ch #\")))
                                                 do (setf buffer (concatenate 'string buffer (string ch)))
                                                 finally (return (list 'STRING buffer))))
                           ((member ch '(#\+ #\- #\/ #\* #\( #\) #\** #\,))
                             (list (intern (format nil "OP_~A" ch)) (string ch)))
                           ((member ch '(#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9))
                             (loop for buffer = (string ch)
                                   for ch = (read-char in nil)
                                   while (and ch (member ch '(#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)))
                                   do (setf buffer (concatenate 'string buffer (string ch)))
                                   finally (return (list 'VALUEI buffer))))
                           ((member ch '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m
                                             #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z
                                             #\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M
                                             #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\z #\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M
                                             #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z
                                             #\_)))
                         do (setf buffer (concatenate 'string buffer (string ch)))
                         finally (return (list 'IDENTIFIER buffer))))
              (t (error "Lexical error: invalid token ~S" (string ch))))))
      (when (eq token 'eoi) (return))
      (format t "~A~%" token)))))

(defun parse (tokens)
  "Parse the given tokens using the parser rules."
  (let ((result (parse-program tokens)))
    (if (null (cdr result))
        (car result)
        (error "Extra tokens at end of input: ~s" (cdr result)))))

(defun parse-program (tokens)
  "Parse a program."
  (let ((statements (parse-statements tokens)))
    (values (list 'program (car statements)) (cdr statements))))

(defun parse-statements (tokens)
  "Parse a sequence of statements."
  (let ((result (parse-statement (car tokens))))
    (if result
        (let ((rest (cdr tokens)))
          (if rest
              (multiple-value-bind (statement rest2) (parse-statements rest)
                (values (cons (car result) statement) rest2))
              (values (car result) rest)))
        (values nil tokens))))

(defun parse-statement (token)
  "Parse a statement."
  (cond
   ((eql (car token) 'IDENTIFIER) (parse-assignment token))
   ((eql (car token) 'KW_DEFV) (parse-variable-definition token))
   ((eql (car token) 'KW_DEFF) (parse-function-definition token))
   ((eql (car token) 'KW_IF) (parse-if-statement token))
   ((eql (car token) 'KW_WHILE) (parse-while-statement token))
   ((eql (car token) 'KW_EXIT) (values `(exit) (cdr token)))
   (t (error "Expected statement, got ~s" token))))

(defun parse-assignment (tokens)
  "Parse an assignment statement."
  (multiple-value-bind (variable rest) (parse-variable tokens)
    (let ((assignment (assoc (car variable) environment)))
      (if assignment
          (let ((value (parse-expression rest)))
            (if value
                (values `(set ,variable ,(car value)) (cdr value))
                (error "Expected expression, got ~s" rest)))
          (error "Undefined variable: ~s" (car variable))))))

(defun parse-variable (tokens)
  "Parse a variable."
  (if (eql (car tokens) 'IDENTIFIER)
      (values (list (cadr tokens)) (cddr tokens))
      (error "Expected variable, got ~s" tokens)))

(defun parse-function-definition (tokens)
  "Parse a function definition statement."
  (multiple-value-bind (name rest) (parse-variable tokens)
    (if (and (eql (car rest) 'OP_OP)
             (cdr rest))
        (multiple-value-bind (parameters rest2) (parse-parameters (cdr rest))
          (if (and (eql (car rest2) 'OP_CP)
                   (cdr rest2))
              (multiple-value-bind (body rest3) (parse-statements (cdr rest2))
                (if (eql (car rest3) 'KW_END)
                    (progn
                     (setf environment (acons (car name) (list 'function parameters body) environment))
                     (values `(deffun ,name (lambda ,parameters ,@body)) (cdr rest3)))
                    (error "Expected 'end', got ~s" rest3)))
              (error "Expected ')', got ~s" rest2)))
        (error "Expected '(', got ~s" rest))))

(defun parse-parameters (tokens)
  "Parse a list of function parameters."
  (if (eql (car tokens) 'OP_CP)
      (values nil tokens)
      (multiple-value-bind (parameter rest) (parse-parameter tokens)
        (multiple-value-bind (parameters rest2) (parse-parameters rest)
          (values (cons (car parameter) parameters) rest2)))))

(defun parse-parameter (tokens)
  "Parse a function parameter."
  (multiple-value-bind (variable rest) (parse-variable tokens)
    (if (eql (car rest) 'OP_COMMA)
        (values variable (cdr rest))
        (values variable rest))))

(defun parse-if-statement (tokens)
  "Parse an if statement."
  (multiple-value-bind (predicate rest) (parse-expression tokens)
    (if (and predicate
             (eql (car rest) 'KW_THEN)
             (cdr rest))
        (multiple-value-bind (consequent rest2) (parse-statements (cdr rest))
          (if (eql (car rest2) 'KW_ELSE)
              (multiple-value-bind (alternate rest3) (parse-statements (cdr rest2))
                (if (eql (car rest3) 'KW_END)
                    (values (if ,predicate ,consequent ,alternate) (cdr rest3)) (error "Expected 'end', got ~s" rest3))) (values (if ,predicate ,consequent) rest2)))
        (error "Expected predicate, got ~s" rest))))