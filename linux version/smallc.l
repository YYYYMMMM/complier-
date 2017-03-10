%{

#include "header.h"
#include "def.h"
#include <vector>
#include <map>
#include <stdarg.h>
#include "y.tab.h"
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>


extern int yyval; 
extern int yylineno;
extern char *yytext;
//extern  input();
void yyerror(char *);


%}

digitnon0 [1-9]
hexdigit [0-9A-Fa-f]
letter [A-Za-z]
digit  ({digitnon0}|0)

identifier ((_|{letter})(_|{letter}|{digit})*)
dec_int  (({digitnon0})+({digit})*)
oct_int  (0({digit})*)
hex_int  (0(x|X)({digit})*)

%%
[\t\r\f]											{;}
[\n]												{yylineno++;}
[ ]													{;}
\"(.*\n)*.*\" {int i;for (i = 0; yytext[i];++i)		{if (yytext[i]=='\n') yylineno++;}}
\/\*(.*\n)*.*\*\/ {int i;for (i = 0; yytext[i];++i) {if (yytext[i]=='\n') yylineno++;}};


int													{yylval.string = strdup(yytext); return TYPE;}
struct												{yylval.string = strdup(yytext); return STRUCT;}
return												{yylval.string = strdup(yytext); return RETURN;}
if													{yylval.string = strdup(yytext); return IF;}
else												{yylval.string = strdup(yytext); return ELSE;}
break												{yylval.string = strdup(yytext); return BREAK;}
continue											{yylval.string = strdup(yytext); return CONT;}
for													{yylval.string = strdup(yytext); return FOR;}
read												{yylval.string = strdup(yytext); return READ;}
write												{yylval.string = strdup(yytext); return WRITE;}

{dec_int}											{yylval.string = strdup(yytext); return INT; }
{oct_int}											{yylval.string = strdup(yytext); return INT; }
{hex_int}											{yylval.string = strdup(yytext); return INT; }


"("													{yylval.string = strdup(yytext); return LP;}
")"													{yylval.string = strdup(yytext); return RP;}
"["													{yylval.string = strdup(yytext); return LB;}
"]"													{yylval.string = strdup(yytext); return RB;}
"{"													{yylval.string = strdup(yytext); return LC;}
"}"													{yylval.string = strdup(yytext); return RC;}

";"													{yylval.string = strdup(yytext); return SEMI;}
","													{yylval.string = strdup(yytext); return COMMA;}
{identifier}										{yylval.string = strdup(yytext); return ID;}
"."													{yylval.string = strdup(yytext); return DOT;}
"-"													{yylval.string = strdup(yytext); return '-';}


"="													{yylval.string = strdup(yytext); return ASN;}
"&"													{yylval.string = strdup(yytext); return '&';}
"!"													{yylval.string = strdup(yytext); return '!';}
"~"													{yylval.string = strdup(yytext); return '~';}
"+"													{yylval.string = strdup(yytext); return '+';}
"*"													{yylval.string = strdup(yytext); return '*';}
"/"													{yylval.string = strdup(yytext); return '/';}
"%"													{yylval.string = strdup(yytext); return '%';}
"<"													{yylval.string = strdup(yytext); return '<';}
">"													{yylval.string = strdup(yytext); return '>';}
"^"													{yylval.string = strdup(yytext); return '^';}
"|"													{yylval.string = strdup(yytext); return '|';}


"+="												{yylval.string = strdup(yytext); return PLUSASN;}
"-="												{yylval.string = strdup(yytext); return MINUSASN;}
"*="												{yylval.string = strdup(yytext); return PRODASN;}
"/="												{yylval.string = strdup(yytext); return DIVASN;}
"&="												{yylval.string = strdup(yytext); return ANDASN;}
"^="												{yylval.string = strdup(yytext); return XORASN;}
"|="												{yylval.string = strdup(yytext); return ORASN;}
">>="												{yylval.string = strdup(yytext); return SRASN;}
"<<="												{yylval.string = strdup(yytext); return SLASN;}

">>"												{yylval.string = strdup(yytext); return SR;}
"<<"												{yylval.string = strdup(yytext); return SL;}
"++"												{yylval.string = strdup(yytext); return INC;}
"--"												{yylval.string = strdup(yytext); return DEC;}
"&&"												{yylval.string = strdup(yytext); return LOGICAND;}
"||"												{yylval.string = strdup(yytext); return LOGICOR;}
"<="												{yylval.string = strdup(yytext); return LEQ;}
">="												{yylval.string = strdup(yytext); return GEQ;}
"=="												{yylval.string = strdup(yytext); return EQ;}
"!="												{yylval.string = strdup(yytext); return NEQ;}






.													{fprintf(stderr,"Error: unexpected character at line %d.\n", yylineno);}
%%

int yywarp(void){
	return 1;
}
/*
void commentInLine(void){
	char c;
	while((c = input())!='\n');
}

void commentOutLine(void){
	char c1, c2;
	c2 = input();
	do{
		c1 = c2;
		c2 = input();
		if(c1 == '\n'){
			yylineno++;
		}
	}while(!(c1 == '*' && c2 == '/'));
}
*/











