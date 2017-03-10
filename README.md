# Files and its function

ReadMe: readme file
smallc.y: Yacc program
smallc.l:Lex program
makefile: makefile
report.pdf: report
def.h: definitions of the tree node of the syntax tree
translate.h: translate the syntax tree to three-address code
interpete.h: interpret the IR into MIPS code
ast.h: relevent functions of syntax tree
header.h: header.h
lzb.s: MIPS code of read() and write()
semantics.h: to check semantic errors
optimize.h: do some optimizations and allocate registers

test: test MIPS code



For implementation details, please refer to report.pdf 

## Linux Version

To make sure linux version can run correctly, please install Flex and Bison tool

## Windows(VS 2015) version

https://sourceforge.net/p/winflexbison/wiki/Visual%20Studio%20custom%20build%20rules/

will help to establish working environment