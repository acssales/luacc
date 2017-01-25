/******************************** lua.flex *************************************

                       Universidade Federal Fluminense

       Instituto de Computacao - Departamento de Ciencia da Computacao


                      TUTORIAL DE COMPILADORES - 2017


Mini Compilador de Lua - luacc
Autor: Augusto C S Sales

*******************************************************************************/

%{
#include<stdio.h>
#include "lua.tab.h"

%}

NAME         [a-zA-Z|_][a-zA-Z0-9_]*
INTEGER      [0-9]*

%%
[ \t]
nil          {return NIL;}
{INTEGER}    {yylval.ival = atoi(yytext); return INTEGER;}
{NAME}       {yylval.sval = yytext; return NAME;}
=            {return '=';}
%%
