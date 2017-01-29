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

void set_value(TREE *t, int value)
{
    t->n_value = value;
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

/*============================= Code Generation ==============================*/

void _writeCode(FILE *f, TREE *t)
{
    if (!t || !f) return;

    switch(t->n_type) {
        case STATLIST:
            _writeCode(f, t->left);
            _writeCode(f, t->right);
            break;
        case ATRIB:
            _writeCode(f, t->left);
            _writeCode(f, t->right);
            break;
        case TNAME:
            fprintf(f, "namevar:\n");
            break;
        case TINTEGER:
            fprintf(f, "\t.long\t");
            fprintf(f, "%d\n", t->n_value);
            break;
        default:
            break;
    }

    _writeCode(f, t->center);
    return;
}

void writeCode(TREE *t)
{
    FILE *output = fopen("out.s", "w");
    _writeCode(output, t);
    fclose(output);
}

/*============================================================================*/
