%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
#define TOK_ERROR 1
%}

%option noyywrap
blanco   [ \t]
entero   [0-9]+
real     [0-9]*"."[0-9]+
simbolo  "+"|"-"|"*"|"/"|"("|")"|\n

%%
{blanco}    ;
{entero}    { yylval.entero = atoi(yytext);
                return TOK_ENTERO; }
{real}      { yylval.real = atof(yytext);
                return TOK_REAL; }

{simbolo}   { return yytext[0]; }
.           { printf("Error Morfologico\n");
                return TOK_ERROR;}
%%
