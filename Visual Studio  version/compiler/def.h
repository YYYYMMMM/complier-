//This file gives definition of the abstract syntax trees.
#pragma once

typedef enum{
	programType,
	extdefsType,
	extdefType,
	sextvarsType,
	extvarsType,
	stspecType,
	funcType,
	parasType,
	stmtblockType,
	stmtsType,
	stmtType,
	defsType,
	sdefsType,
	sdecsType,
	decsType,
	varType,
	initType,
	expType,
	expsType,
	arrsType,
	argsType,
	unaryopType,
	idToken,
	biexpType,
	keywords,
	typeToken,
	intToken,
	epsilon
} nodeTypeEnum;

typedef struct TreeNode {
    nodeTypeEnum type; //type of the treenodes
    int lineNum;
    char* data;
    int size, capacity;
    struct TreeNode** children;
} TreeNode;

