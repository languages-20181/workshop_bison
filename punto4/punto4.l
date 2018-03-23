%{
	#include "punto4.tab.h"
	extern int yylval;
	int debug = 0;
%}

%%

sqrt	|
pow		|
exp		|
log		{
	yylval = atoi(yytext); 
	if (debug) printf("FUNCTION = %s\n",yytext);
	return FUNCTION; 
}

[0-9]+				|
[0-9]+\.[0-9]+		|
\.[0-9]+ {
	yylval = atoi(yytext);
	if (debug) printf("NUMBER = %s\n",yytext);
	return NUMBER; 
}

	[a-zA-Z][a-zA-Z0-9]+ {
		yylval = atoi(yytext);
		if (debug) printf("NAME = %s\n",yytext);
		return NAME; 
	}

	[ \t] ;
	\n return 0;
	.  return yytext[0];
%%
