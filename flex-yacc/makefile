LEX = lex # not flex

target: run

build-lexer:
	@echo "Building lexer"
	$(LEX) -o out/gpp_lexer.c gpp_lexer.l

build-parser:
	@echo "Building parser"
	yacc -o out/gpp_interpreter.c gpp_interpreter.y -d -v


build: build-lexer build-parser
	@echo "Building gpp"
	$(CC) -Iout out/gpp_lexer.c out/gpp_interpreter.c -o out/gpp

run: build
	@echo "Running gpp"
	./gpp

demo: build
	@echo "Running gpp with demo program"
	./gpp < demo/demo.gpp


.PHONY: clean # prevent Make from confusing the 'clean' target with a file name
clean:
	$(RM) *.o *.c *.h gpp out/*
# 	phony is unnecessary since we don't have a file named 'clean'
