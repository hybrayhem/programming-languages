LEX = lex # not flex

target: build run

build:
	@echo "Building lexer"
	$(LEX) gpp_lexer.l
	$(CC) lex.yy.c -o gpp -lfl

run: build
	@echo "Running lexer"
	./gpp

# demo: build
#	@echo "Running lexer with demo program"
#	./gpp < demo.gpp

.PHONY: clean
clean:
	$(RM) *.o lex.yy.c
