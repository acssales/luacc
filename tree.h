/********************************* tree.h **************************************

                       Universidade Federal Fluminense

       Instituto de Computacao - Departamento de Ciencia da Computacao


                      TUTORIAL DE COMPILADORES - 2017


Mini Compilador de Lua - luacc
Autor: Augusto C S Sales

*******************************************************************************/

#ifndef TREE_H
#define TREE_H

typedef struct node {
    int n_type;
    int n_value;
    struct node *left;
    struct node *center;
    struct node *right;
} TREE;

enum node_type {
    LUA,
    CHUNK,
    STATLIST,
    STAT,
    ATRIB,
    VARLIST,
    VAR,
    EXPLIST,
    EXP,
    TINTEGER,
    TNAME,
    TNIL
};

TREE *add_node(TREE *t_left, TREE *t_center, TREE *t_right, int type);

void set_value(TREE *t, int value);

void writeCode(TREE *t);

void destroy_tree(TREE *t);

#endif /* TREE_H */
