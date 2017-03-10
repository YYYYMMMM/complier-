/* A Bison parser, made by GNU Bison 2.7.  */

/* Bison interface for Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2012 Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_SMALLC_TAB_H_INCLUDED
# define YY_YY_SMALLC_TAB_H_INCLUDED
/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INT = 258,
     ID = 259,
     SEMI = 260,
     COMMA = 261,
     TYPE = 262,
     LP = 263,
     RP = 264,
     LB = 265,
     RB = 266,
     LC = 267,
     RC = 268,
     STRUCT = 269,
     RETURN = 270,
     IF = 271,
     ELSE = 272,
     BREAK = 273,
     CONT = 274,
     FOR = 275,
     DOT = 276,
     ASN = 277,
     PLUSASN = 278,
     MINUSASN = 279,
     PRODASN = 280,
     DIVASN = 281,
     ANDASN = 282,
     XORASN = 283,
     ORASN = 284,
     SR = 285,
     SL = 286,
     LOGICAND = 287,
     LOGICOR = 288,
     EQ = 289,
     NEQ = 290,
     SRASN = 291,
     SLASN = 292,
     READ = 293,
     WRITE = 294,
     IFX = 295,
     LEQ = 296,
     GEQ = 297,
     UNARY = 298,
     DEC = 299,
     INC = 300
   };
#endif


#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{
/* Line 2058 of yacc.c  */
#line 15 "smallc.y"

    TreeNode* node;
    char* string;


/* Line 2058 of yacc.c  */
#line 108 "smallc.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */

#endif /* !YY_YY_SMALLC_TAB_H_INCLUDED  */
