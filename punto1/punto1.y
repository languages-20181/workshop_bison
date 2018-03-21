%{
#include<stdio.h>

%}

%token NAME NUMBER
%%
statement: NAME '=' expression
	| expression {printf("= %d\n",$1);}
	;
expression: expression '+' term {$$ = $1 + $3; }
	| expression '-' term {$$ = $1 - $3; }
	| term
	;
term: term '*' factor {$$ = $1 * $3; }
 | term '/' factor {if ($3 == 0.0){
 				yyerror("divide by zero");
				return;}
 				else $$ = $1 / $3;
				}
	| factor
	;
factor: '(' expression ')' { $$ =$2;}
	| NUMBER
	;

%%
extern FILE *yyin;
main()
{
	yyparse();
}
yyerror(s)
char *s;
{
	fprintf(stderr, "%s\n",s);
}
