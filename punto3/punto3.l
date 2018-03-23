%{
	#include <stdio.h>
	#include "y.tab.h"
	#include "punto3.h"
	#include "float.h"
	#include "math.h"
	#include <stdbool.h>
	#include <string.h>

	int yyparse();
%}

%option noyywrap

%%

"exit"					{ exit(0); }
\n 						{ return EOLN; }
"e"						{ return E; }
"ln"					{ return LN; }
"log"					{ return LOG; }
"sqrt"					{ return SQRT; }
\( 						{ return LPARENTHESIS; }
\)						{ return RPARENTHESIS; }
\^						{ return EXPONENT; }
\*						{ return MULTIPLY; }
\/						{ return DIVIDE; }
\+						{ return ADD; }
\-						{ return SUBTRACT; }
\= 						{
							yylval.fun->equals = true;
							return EQUALS;
						}
[a-zA-Z][0-9]*			{
							yylval.fun->find = strdup(yytext);
							if (!yylval.fun->equals)
								yylval.fun->var = strdup(yytext);
							return VARIABLE;
						}
[0-9\.]+ 				{
							sscanf(yytext, "%lf", &yylval.fun->dub);
							return NUMBER;
						}
[ \t]					;
. 						{
							printf("Invalid input. Exiting.\n");
							exit(-1);
						}

%%
