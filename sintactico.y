%{
#include <stdio.h>
void yyerror(char* s);
%}

%union
{
    double real;
    int entero;
}

%token <real>   TOK_REAL
%token <entero> TOK_ENTERO

%start linea
%left '+' '-'
%left '*' '/'

%type <real>   exp_real
%type <entero> exp_entera

%%
linea:          exp '\n' {}
                ;
exp:            exp_real {printf("%f\n", $1);}
                |exp_entera {printf("%d\n", $1);}
                ;
exp_entera:     TOK_ENTERO { $$ = $1;}
                |exp_entera '+' exp_entera { $$ = $1 + $3;}
                |exp_entera '-' exp_entera { $$ = $1 - $3;}
                |exp_entera '*' exp_entera { $$ = $1 * $3;}
                |'(' exp_entera ')' { $$ = $2;}
;
exp_real:       TOK_REAL { $$ = $1;}
                |exp_real '+' exp_real { $$ = $1 + $3;}
                |exp_real '-' exp_real { $$ = $1 - $3;}
                |exp_real '*' exp_real { $$ = $1 * $3;}
                |exp_real '/' exp_real { if ($3) $$=$1/$3;
                else $$=$1; }
                |'(' exp_real ')' { $$ = $2;}
                ;
%%

int main()
{
    return(yyparse());
}
void yyerror(char* s)
{
    printf(stderr,"%s\n", s);
}