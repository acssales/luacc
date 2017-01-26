/********************************* lua.y ***************************************

                       Universidade Federal Fluminense

       Instituto de Computacao - Departamento de Ciencia da Computacao


                      TUTORIAL DE COMPILADORES - 2017


Mini Compilador de Lua - luacc
Autor: Augusto C S Sales

*******************************************************************************/

%{
#include <stdio.h>
#include "tree.h"
#include "lex.yy.c"

void yyerror(const char *s);

%}

%union {
    TREE *tval;
    int   ival;
    char *sval;
}

%type <tval> lua chunk statlist stat varlist var explist exp

//Tokens
%token <sval> NAME
%token        NIL
%token <ival> INTEGER

%start lua

%%
lua:
    chunk     {$$ = add_node(NULL, $1, NULL, CHUNK); destroy_tree($$); }
;

chunk:
    statlist  {$$ = add_node(NULL, $1, NULL, STATLIST);}
;

statlist:
    stat      {$$ = add_node(NULL, $1, NULL, STAT);}
;

stat:
    varlist '=' explist {$$ = add_node($1, NULL, $3, ATRIB);}
;

varlist:
    var       {$$ = add_node(NULL, $1, NULL, VAR);}
;

var:
    NAME      {$$ = add_node(NULL, NULL, NULL, NAME);}
;

explist:
    exp       {$$ = add_node(NULL, $1, NULL, EXP);}
;

exp:
    NIL       {$$ = add_node(NULL, NULL, NULL, NIL);}
    | INTEGER {$$ = add_node(NULL, NULL, NULL,INTEGER);}
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
