LEX = lex # not flex
YACC = yacc

target: run


build-parser:
	@echo "Building parser"
	$(YACC) -o out/gpp_interpreter.c gpp_interpreter.y -d -v

build-lexer:
	@echo "Building lexer"
	$(LEX) -o out/gpp_lexer.c gpp_lexer.l


# GPP Section
build: build-parser build-lexer
	@echo "Building gpp"
	$(CC) out/gpp_lexer.c out/gpp_interpreter.c -o out/gpp 2> out/gpp.log

run: build
	@echo "Running gpp"
	out/gpp

demo: build
	@echo "Running gpp with demo program"
	out/gpp < demo/demo.gpp


.PHONY: clean # prevent Make from confusing the 'clean' target with a file name
# 	phony is unnecessary since we don't have a file named 'clean'
clean:
	$(RM) out/*
#	$(RM) *.o *.c *.h gpp
