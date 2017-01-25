#******************************** Makefile *************************************
#
#                      Universidade Federal Fluminense
#
#      Instituto de Computacao - Departamento de Ciencia da Computacao
#
#
#                     TUTORIAL DE COMPILADORES - 2017
#
#
# Mini Compilador de Lua - luacc
# Autor: Augusto C S Sales
#
#******************************************************************************/

luacc: lex.yy.c
	gcc -o luacc lex.yy.c -lfl

lex.yy.c: lua.flex
	flex lua.flex

# Remove todos arquivos intermediarios
clean:
	rm -f lex.yy.c luacc

run: luacc
	./luacc
