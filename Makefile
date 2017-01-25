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

luacc: lex.yy.c lua.tab.c
	gcc -o luacc lua.tab.c -lfl

lex.yy.c: lua.flex
	flex lua.flex

lua.tab.h lua.tab.c: lua.y
	bison -d lua.y

# Remove todos arquivos compilados
clean:
	rm -f lex.yy.c lua.tab.* luacc

run: luacc
	./luacc
