%{
#include <stdio.h>
#include <math.h>
#include <string.h>
%}

%token NAME NUMBER POW EXP SQRT LOG
%%

statement: NAME '=' expression
	| expression {
		if ($1 == (double)((int)$1))
			printf("= %d\n",$1);
		else
			printf("= %f\n",$1);
	}
	;

expression: expression '+' term {$$ = $1 + $3;}
	| expression '-' term {$$ = $1 - $3; }
	| term
	| function
	;

term: term '*' factor {$$ = $1 * $3; }
 	| term '/' factor {
 		if ($3 == 0.0)
 		{
 			yyerror("divide by zero");
			return;
		} else $$ = $1 / $3;
	}
	| factor
	;

factor: '(' expression ')' 	   { $$ =  $2;}
  	| '-' factor	           { $$ = -$2;}
	| NUMBER
	;

function: POW '(' expression ',' expression ')' { $$ = pow($3, $5); }
	| EXP '(' expression ')' { $$ = exp($3); }
	| SQRT '(' expression ')' { $$ = sqrt($3); }
	| LOG '(' expression ')' { $$ = log($3); }
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
