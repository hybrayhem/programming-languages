LEX = lex # not flex

target: run

build:
	@echo "Building lexer"
	$(LEX) -o gpp_lexer.c gpp_lexer.l
	$(CC) gpp_lexer.c -o gpp -lfl

run: build
	@echo "Running lexer"
	./gpp

demo: build
	@echo "Running lexer with demo program"
	./gpp demo.gpp

.PHONY: clean # prevent Make from confusing the 'clean' target with a file name
clean:
	$(RM) *.o *.c gpp 
# 	phony is unnecessary since we don't have a file named 'clean'
