#pragma once
#include <stdio.h>
#include <stdlib.h>
enum TOKEN
{
	SEMI,
	COMMA,
	TYPE,
	LP,
	RP,
	LB,
	RB,
	LC,
	RC,
	STRUCT,
	RETURN,
	IF,
	ELSE,
	BREAK,
	CONT,
	FOR,

	DOT,
	MINUS,
	LNOT,
	INC,
	DEC,
	BITNOT,
	PROD,
	DIV,
	MOD,
	PLUS,
	SL,
	SR,
	GE,
	GEQ,
	LE,
	LEQ,
	EQ,
	NEQ,
	BITAND,
	BITXOR,
	BITOR,
	LAND,
	LOR,
	ASN,
	PLUSASN,
	MINUSASN,
	PRODASN,
	DIVASN,
	ANDASN,
	XORASN,
	ORASN,
	SLASN,
	SRASN,

	INT,
	ID,

	READ,
	WRITE
};