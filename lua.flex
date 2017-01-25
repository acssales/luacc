/******************************** lua.flex *************************************

                       Universidade Federal Fluminense

       Instituto de Computacao - Departamento de Ciencia da Computacao


                      TUTORIAL DE COMPILADORES - 2017
               

Mini Compilador de Lua - luacc
Autor: Augusto C S Sales

*******************************************************************************/

%{

#include<stdio.h>

%}

NAME         [a-zA-Z|_][a-zA-Z0-9_]*
INTEGER      [0-9]*

%%

nil          {printf("Achei um nil!");}
{INTEGER}    {printf("Achei um int! %d", atoi(yytext));}
{NAME}       {printf("Achei um name! %s", yytext);}
=            {printf("Achei um '=' !");}

%%

int main(int argc, char* argv[])
{
    // Le um unico script OU modo interativo (ou seja, digite direto no console)
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;
    yylex();
    return 0;
}
