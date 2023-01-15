target: main

input = test.txt

functions:
	clisp functions.lisp < $(input)

main:
	clisp main.lisp < $(input)


