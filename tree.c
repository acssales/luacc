/********************************* tree.c **************************************

                       Universidade Federal Fluminense

       Instituto de Computacao - Departamento de Ciencia da Computacao


                      TUTORIAL DE COMPILADORES - 2017


Mini Compilador de Lua - luacc
Autor: Augusto C S Sales

*******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include "tree.h"

/*========================= Structure Functionality ==========================*/

TREE *add_node(TREE *t_left, TREE *t_center, TREE *t_right, int type)
{
    TREE *tnode = (TREE*)malloc(sizeof(TREE));

    if(t_left)   tnode->left   = t_left;
    if(t_center) tnode->center = t_center;
    if(t_right)  tnode->right  = t_right;
    tnode->n_type = type;

    return tnode;
}

void destroy_tree(TREE *t)
{
    if(!t) return;

    destroy_tree(t->left);
    destroy_tree(t->center);
    destroy_tree(t->right);

    free(t);
}

/*============================================================================*/
