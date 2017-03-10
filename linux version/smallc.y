%{
#include "header.h"
#include "lex.yy.c"
#include "def.h"
#include "ast.h"
#include "semantics.h"
#include "translate.h"
#include "interprete.h"
#include "optimize.h"
using namespace std;
void yyerror(char*);
extern int yylineno;
%}

%union {
    TreeNode* node;
    char* string;
}

%token <string> INT ID SEMI COMMA
%token <string> TYPE LP RP LB RB LC RC STRUCT RETURN
%token <string> IF ELSE BREAK CONT FOR DOT ASN
%token <string> PLUSASN MINUSASN PRODASN DIVASN ANDASN 
%token <string> XORASN ORASN SR SL //INC DEC
%token <string> LOGICAND LOGICOR EQ NEQ SRASN SLASN //LEQ GEQ
%token <string> '!' '~' READ WRITE
%type <node> PROGRAM EXTDEFS EXTDEF SEXTVARS EXTVARS STSPEC FUNC PARAS STMTBLOCK STMTS STMT DEFS SDEFS SDECS DECS VAR INIT EXP EXPS ARRS ARGS UNARYOP


%nonassoc  IFX
%nonassoc ELSE
%right ASN PLUSASN MINUSASN PRODASN DIVASN ANDASN XORASN ORASN SLASN SRASN
%left  LOGICOR
%left  LOGICAND
%left <string> '|'
%left <string> '^'
%left <string> '&'
%left  NEQ
%left  EQ
%left <string> GEQ LEQ '>' '<'
%left SL SR
%left <string> '+' '-'
%left <string> '%' '/' '*'  
%right <string> INC DEC UNARY 
%left  DOT LP LB
%%
PROGRAM						: EXTDEFS									{treeroot = $$ = createNode(yylineno,programType,"program",1,$1);}
;
EXTDEFS						: EXTDEF EXTDEFS							{$$ = createNode(yylineno,extdefsType,"extdefs",2,$1,$2);}
							|											{$$ = createNode(yylineno,epsilon, "NULL", 0);}
;

EXTDEF						: TYPE EXTVARS SEMI							{$$ = createNode(yylineno,extdefType, "extdef1", 2, createNode(yylineno,typeToken, $1, 0),$2); }
							| STSPEC SEXTVARS SEMI						{$$ = createNode(yylineno,extdefType, "extdef2", 2, $1,$2); }
							| TYPE FUNC STMTBLOCK						{$$ = createNode(yylineno,extdefType, "extdef func", 3, createNode(yylineno,typeToken, $1, 0),$2,$3); }
;

SEXTVARS					: ID										{$$ = createNode(yylineno,sextvarsType, "sextvars",1,createNode(yylineno,idToken,$1,0)); }
							| ID COMMA SEXTVARS							{$$ = createNode(yylineno,sextvarsType, "sextvars", 2, createNode(yylineno,idToken, $1, 0),$3); }
							|											{$$ = createNode(yylineno,epsilon, "NULL", 0);}
;

EXTVARS						: VAR										{$$ = createNode(yylineno,extvarsType, "extvars", 1, $1); }
							| VAR COMMA EXTVARS							{$$ = createNode(yylineno,extvarsType, "extvars", 2, $1,$3); }
							| VAR ASN INIT								{$$ = createNode(yylineno,extvarsType, "extvars", 3, $1,createNode(yylineno,biexpType,$2,0),$3); }
							| VAR ASN INIT COMMA EXTVARS				{$$ = createNode(yylineno,extvarsType, "extvars", 4, $1,createNode(yylineno,biexpType,$2,0),$3,$5); }
							|											{$$ = createNode(yylineno,epsilon, "NULL", 0);}
;

STSPEC						: STRUCT ID LC SDEFS RC						{$$ = createNode(yylineno,stspecType, "stspec identifier {}", 3, createNode(yylineno,biexpType,$1,0),createNode(yylineno,idToken, $2, 0),$4); }
							| STRUCT LC SDEFS RC						{$$ = createNode(yylineno,stspecType, "stspec {}", 2, createNode(yylineno,biexpType,$1,0),$3); }
							| STRUCT ID									{$$ = createNode(yylineno,stspecType, "stspec", 2, createNode(yylineno,biexpType,$1,0),createNode(yylineno,idToken, $2, 0)); }
;

FUNC						: ID LP PARAS RP							{$$ = createNode(yylineno,funcType, "func ()", 2, createNode(yylineno,idToken, $1, 0),$3); }
;

PARAS						: TYPE ID COMMA PARAS						{$$ = createNode(yylineno,parasType, "paras", 2, createNode(yylineno,idToken, $2, 0),$4); }
							| TYPE ID									{$$ = createNode(yylineno,parasType, "paras", 1,createNode(yylineno,idToken, $2, 0)); }
							|											{$$ = createNode(yylineno,epsilon, "NULL", 0);}
;

STMTBLOCK					: LC DEFS STMTS RC							{$$ = createNode(yylineno,stmtblockType, "stmtblock {}", 2, $2,$3); }
;

STMTS						: STMT STMTS								{$$ = createNode(yylineno,stmtsType, "stmts", 2, $1,$2); }
							|											{$$ = createNode(yylineno,epsilon, "NULL", 0);}
;

STMT						: EXP SEMI									{$$ = createNode(yylineno,stmtType, "stmt: exp;", 1, $1); }
							| STMTBLOCK									{$$ = createNode(yylineno,stmtType, "stmt", 1, $1); }
							| RETURN EXPS SEMI							{$$ = createNode(yylineno,stmtType, "return stmt", 2, createNode(yylineno,keywords, $1, 0),$2); }
							| IF LP EXPS RP STMT %prec IFX				{$$ = createNode(yylineno,stmtType, "if stmt", 2, $3,$5); }
							| IF LP EXPS RP STMT ELSE STMT %prec ELSE	{$$ = createNode(yylineno,stmtType, "if stmt", 3, $3,$5,$7);}
							| FOR LP EXP SEMI EXP SEMI EXP RP STMT		{$$ = createNode(yylineno,stmtType, "for stmt", 4, $3,$5,$7,$9); }
							| CONT SEMI									{$$ = createNode(yylineno,stmtType, "cont stmt", 1, createNode(yylineno,keywords, $1, 0)); }
							| BREAK SEMI								{$$ = createNode(yylineno,stmtType, "break stmt", 1, createNode(yylineno,keywords, $1, 0)); }
							| READ LP EXPS RP SEMI						{$$ = createNode(yylineno,stmtType,"read stmt",1, $3);}
							| WRITE LP EXPS RP SEMI						{$$ = createNode(yylineno,stmtType,"write stmt",1, $3);}
;

DEFS						: TYPE DECS SEMI DEFS						{$$ = createNode(yylineno,defsType, "defs1", 3, createNode(yylineno,typeToken, $1, 0),$2,$4); }
							| STSPEC SDECS SEMI DEFS					{$$ = createNode(yylineno,defsType, "defs2", 3, $1,$2,$4); }
							|											{$$ = createNode(yylineno,epsilon, "NULL", 0);}
;

SDEFS						: TYPE SDECS SEMI SDEFS						{$$ = createNode(yylineno,sdefsType, "sdefs", 3, createNode(yylineno,typeToken, $1, 0),$2,$4); }
							|											{$$ = createNode(yylineno,epsilon, "NULL", 0);}
;

SDECS						: ID COMMA SDECS							{$$ = createNode(yylineno,sdecsType, "sdecs", 2, createNode(yylineno,idToken, $1, 0),$3); }
							| ID										{$$ = createNode(yylineno,sdecsType, "sdecs", 1,createNode(yylineno,idToken,$1,0)); }
;

DECS						: VAR										{$$ = createNode(yylineno,decsType, "decs", 1, $1); }
							| VAR COMMA DECS							{$$ = createNode(yylineno,decsType, "decs", 2, $1,$3); }
							| VAR ASN INIT COMMA DECS					{$$ = createNode(yylineno,decsType, "assign decs", 4, $1,createNode(yylineno,biexpType, $2, 0),$3,$5); }
							| VAR ASN INIT								{$$ = createNode(yylineno,decsType, "assign decs", 3, $1,createNode(yylineno,biexpType, $2, 0),$3); }
;

VAR							: ID										{$$ = createNode(yylineno,varType, "var", 1,createNode(yylineno,idToken, $1, 0)); }
							| VAR LB INT RB								{$$ = createNode(yylineno,varType, "var []", 2, $1,createNode(yylineno,intToken, $3, 0)); }
;

INIT						: EXPS										{$$ = createNode(yylineno,initType, "init", 1, $1); }
							| LC ARGS RC								{$$ = createNode(yylineno,initType, "init {}", 1, $2); }
; 

EXP							: EXPS										{$$ = createNode(yylineno,expType, "exp", 1, $1); }
							|											{$$ = createNode(yylineno,epsilon, "NULL", 0);}
;

EXPS						: EXPS ASN EXPS								{$$ = createNode(yylineno,expsType, $2, 2, $1,$3); }
							| EXPS PLUSASN EXPS							{$$ = createNode(yylineno,expsType, $2, 2, $1,$3); }
							| EXPS MINUSASN EXPS						{$$ = createNode(yylineno,expsType, $2, 2, $1,$3); }
							| EXPS PRODASN EXPS							{$$ = createNode(yylineno,expsType, $2, 2, $1,$3); }
							| EXPS DIVASN EXPS							{$$ = createNode(yylineno,expsType, $2, 2, $1,$3); }
							| EXPS ANDASN EXPS							{$$ = createNode(yylineno,expsType, $2, 2, $1,$3); }
							| EXPS XORASN EXPS							{$$ = createNode(yylineno,expsType, $2, 2, $1,$3); }
							| EXPS ORASN EXPS							{$$ = createNode(yylineno,expsType, $2, 2, $1,$3); }
							| EXPS SR EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS SL EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS LOGICAND EXPS						{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS LOGICOR EXPS							{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS LEQ EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS GEQ EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS EQ EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS NEQ EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS SRASN EXPS							{$$ = createNode(yylineno,expsType, $2, 2, $1,$3); }
							| EXPS SLASN EXPS							{$$ = createNode(yylineno,expsType, $2, 2, $1,$3); }
							| EXPS '+' EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS '-' EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS '&' EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS '*' EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS '/' EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS '%' EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS '<' EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS '>' EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS '^' EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| EXPS '|' EXPS								{$$ = createNode(yylineno,biexpType, $2, 2, $1,$3); }
							| UNARYOP EXPS %prec UNARY					{$$ = createNode(yylineno,expsType, "exps unary", 2, $1,$2); }
							| LP EXPS RP								{$$ = createNode(yylineno,expsType, "exps ()", 1, $2); }
							| ID LP ARGS RP								{$$ = createNode(yylineno,expsType, "exps f()", 2, createNode(yylineno,idToken, $1, 0),$3); }
							| ID ARRS									{$$ = createNode(yylineno,expsType, "exps arr", 2, createNode(yylineno,idToken, $1, 0),$2); }
							| ID DOT ID									{$$ = createNode(yylineno,expsType, "exps struct", 3, createNode(yylineno,idToken, $1, 0),createNode(yylineno,biexpType, $2, 0),createNode(yylineno,idToken, $3, 0)); }
							| INT										{$$ = createNode(yylineno,intToken, $1, 0); }
;

ARRS						: LB EXP RB ARRS							{$$ = createNode(yylineno,arrsType, "arrs []", 2, $2,$4); }
							|											{$$ = createNode(yylineno,epsilon, "NULL", 0);}
;

ARGS						: EXP COMMA ARGS							{$$ = createNode(yylineno,argsType, "args", 2, $1,$3); }
							| EXP										{$$ = createNode(yylineno,argsType, "args", 1, $1); }
;

UNARYOP						: '+'										{$$ = createNode(yylineno,unaryopType, $1, 0);}
							| '-'										{$$ = createNode(yylineno,unaryopType, $1, 0);}
							| '~'										{$$ = createNode(yylineno,unaryopType, $1, 0);}
							| '!'										{$$ = createNode(yylineno,unaryopType, $1, 0);}
							| INC										{$$ = createNode(yylineno,unaryopType, $1, 0);}
							| DEC										{$$ = createNode(yylineno,unaryopType, $1, 0);}
;

%%
#include <stdio.h>
#include "header.h"
#include "semantics.h"
#include "translate.h"
void yyerror(char *s)
{
	fflush(stdout);
	fprintf(stderr,"%d :%s %s\n",yylineno,s,yytext);
}
int main(int argc, char *argv[])
{
	freopen(argv[1], "r", stdin);
    
	if(!yyparse()){
		fprintf(stderr,"Parsing complete.\n");
		freopen("AST", "w", stdout);
		printAst(treeroot,0);
		semantics(treeroot);
		fprintf(stderr,"Semantics check complete.\n");
		phase3_translate();
		fprintf(stderr,"Translate complete.\n");
		optimize();
		fprintf(stderr,"Optimize complete.\n");
		freopen("MIPSCode.s", "w", stdout);
		interpret();
	}
	else
		printf("Parsing failed.\n");
	return 0;
}
int yywrap()
{
	return 1;
}
/*
void yyerror(const char *s){
    fprintf(stderr, "[line %d]: %s %s\n", yylloc.first_line, s, yytext);
}
*/