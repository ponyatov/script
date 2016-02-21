%{
#include <fstream>
using namespace std;
ofstream lexhpp("tmp/lexer.hpp");
ofstream lexhead("tmp/lexer.head");
ofstream lexcomment("tmp/lexer.comment");
ofstream lexstring("tmp/lexer.string");
ofstream lexsym("tmp/lexer.sym");
ofstream lexbrs("tmp/lexer.brs");
ofstream lexops("tmp/lexer.ops");
ofstream lexspace("tmp/lexer.spaces");
ofstream lexmk("tmp/lexer.mk");
ofstream yppmk("tmp/parser.mk");
%}
%option main
%option noyywrap

%x head
%%
^extern\ [a-z*]+\ yy(lex|lineno|text).+\n	{lexhpp<<yytext;}
^#define\ TOC.+\n							{lexhpp<<yytext;}

%\{\n						{BEGIN(head);lexhead<<yytext;}
<head>%\}\n					{BEGIN(INITIAL);lexhead<<yytext;lexstring<<yytext;}
<head>^#include.+\n			{lexhead<<yytext;}
<head>string.+\n			{lexhead<<yytext;lexstring<<yytext;}

^#\[^\\n\]*.+\n				{lexcomment<<yytext;}

^%x\ lexstring\n%%\n		{lexstring<<yytext;}
^.+lexstring.+\n			{lexstring<<yytext;}

^.+TOC\(Sym.+\n				{lexsym<<yytext;}
^.+TOC\(Op,[LR][BQC]\)\n	{lexbrs<<yytext;}
^.+TOC\(Op.+\n				{lexops<<yytext;}

^\[.+\{\}\n					{lexspace<<yytext;}

^.+lpp\.lpp\n				{lexmk<<yytext;}
^\tflex.+\n                 {lexmk<<yytext;}

^.+ypp\.ypp\n				{yppmk<<yytext;}
^\tbison.+\n				{yppmk<<yytext;}

\n	{}
.	{}
%%
