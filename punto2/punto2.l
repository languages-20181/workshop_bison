%{
#include "punto2.tab.h"
extern int yylval;
%}

%%
[0-9]+ {yylval = atoi(yytext); return NUMBER; }
[a-zA-Z][a-zA-Z0-9]+ {yylval = atoi(yytext); return NAME; }
[ \t] ;
\n return 0;
.  return yytext[0];
%%
