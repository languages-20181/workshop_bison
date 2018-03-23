%{
#include <stdio.h>
#include <math.h>
#include <string.h>
%}

%token NAME NUMBER FUNCTION
%%

statement: NAME '=' expression
	| expression {printf("= %d\n",$1);}
	;

expression: expression '+' term {$$ = $1 + $3; }
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

function: FUNCTION '(' expression ',' expression ')' {
		//The only function with two arguments is pow
		$$ = pow($3, $5);
	}
	| FUNCTION '(' expression ')' {
		if(!strcmp("sqrt", $1)) $$ = sqrt($3);
		else if (!strcmp("exp", $1)) $$ = exp($3);
		else if (!strcmp("log", $1)) $$ = log($3);

		//printf("%s\n", $1, $3);
	}

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
