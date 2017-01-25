/********************************* lua.y ***************************************

                       Universidade Federal Fluminense

       Instituto de Computacao - Departamento de Ciencia da Computacao


                      TUTORIAL DE COMPILADORES - 2017


Mini Compilador de Lua - luacc
Autor: Augusto C S Sales

*******************************************************************************/

%{
#include <stdio.h>
#include "lex.yy.c"

void yyerror(const char *s);
%}

%union {
    int   ival;
    char *sval;
}

//Tokens
%token <sval> NAME
%token        NIL
%token <ival> INTEGER


%start lua

%%
lua:
    chunk {printf("bison: cheguei na raiz\n");}
;

chunk:
    statlist
;

statlist:
    stat
;

stat:
    varlist '=' explist
;

varlist:
    var
;

var:
    NAME      {printf("bison: achei um id! %s\n", yylval.sval);}
;

explist:
    exp
;

exp:
    NIL       {printf("bison: achei um nil!\n");}
    | INTEGER {printf("bison: achei um int! %d\n", yylval.ival);}
;


%%
int main(int argc, char* argv[])
{
    // Reads a file OR reads from standard input
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else
        yyin = stdin;

    // parse through the input until the end:
    do {
        yyparse();
    } while (!feof(yyin));

    return 0;
}

void yyerror(const char *s) {
    printf("EEK, parse error!  Message: %s\n", s);
    // might as well halt now:
    // exit(-1);
}
