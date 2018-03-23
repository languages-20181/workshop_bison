%{
#include <math.h>
#include <stdio.h>
#define YYSTYPE double
int yyerror (char const *s);
extern int yylex (void);
%}

%token NUMBER
%token PLUS MINUS TIMES DIVIDE POWER SQR
%token LEFT RIGHT
%token END

%left PLUS MINUS
%left TIMES DIVIDE
%left NEG
%right POWER
%left SQR

%error-verbose
%start Input
%%

Input: /* empty */;
Input: Input Line;

Line: END
Line: exp END { printf("Result: %f\n", $1); }

exp: NUMBER { $$=$1; };
exp: exp PLUS exp { $$ =$1 + $3; };
exp: exp MINUS exp { $$ = $1 - $3; };
exp: exp TIMES exp { $$ = $1 * $3; };
exp: exp DIVIDE exp { $$ = $1 / $3; };
exp: MINUS exp %prec NEG { $$ = -$2; };
exp: exp POWER exp { $$ = pow($1, $3); };
exp: exp SQR exp {$$ = sqrt($2);};
exp: LEFT exp RIGHT { $$ = $2; };

%%
int yyerror(char const *s) {
  printf("%s\n", s);
}
int main() {
    int ret = yyparse();
    if (ret){
	fprintf(stderr, "%d error found.\n",ret);
    }
    return 0;
}
