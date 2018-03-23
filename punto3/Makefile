
LEX = lex
YACC = yacc -d


CC = gcc


punto3: y.tab.o lex.yy.o
	$(CC) -o punto3 y.tab.o lex.yy.o -ly -ll -lm 

y.tab.o: y.tab.c
lex.yy.o: lex.yy.c



y.tab.c y.tab.h: punto3.y
	$(YACC) -v punto3.y



lex.yy.c: punto3.l
	$(LEX) punto3.l



clean:
	-rm -f lex.yy.c lex.yy.o *.tab.*  punto3 *.output
