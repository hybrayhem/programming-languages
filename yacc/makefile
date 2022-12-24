target: run

build:
	@echo "Building parser"
	yacc -o gpp_interpreter.c gpp_interpreter.y
	$(CC) gpp_interpreter.c -o gpp

run: build
	@echo "Running parser"
	./gpp

demo: build
	@echo "Running parser with demo program"
	./gpp demo.gpp

.PHONY: clean # prevent Make from confusing the 'clean' target with a file name
clean:
	$(RM) *.o *.c gpp 
# 	phony is unnecessary since we don't have a file named 'clean'
