%{
#include <fstream>
using namespace std;
ofstream lexhpp("tmp/lexer.hpp");
ofstream lexhead("tmp/lexer.head");
ofstream lexcomment("tmp/lexer.comment");
ofstream lexstring("tmp/lexer.string");
ofstream lexsym("tmp/lexer.sym");
%}
%option main
%option noyywrap

%x head
%%
^extern\ [a-z*]+\ yy(lex|lineno|text).+\n	{lexhpp<<yytext;}
^#define\ TOC.+\n							{lexhpp<<yytext;}

%\{\n					{BEGIN(head);lexhead<<yytext;}
<head>%\}\n				{BEGIN(INITIAL);lexhead<<yytext;lexstring<<yytext;}
<head>^#include.+\n		{lexhead<<yytext;}
<head>string.+\n		{lexhead<<yytext;lexstring<<yytext;}

^#\[^\\n\]*.+\n			{lexcomment<<yytext;}

^%x\ lexstring\n%%\n	{lexstring<<yytext;}
^.+lexstring.+\n		{lexstring<<yytext;}

^.+TOC\(Sym.+\n			{lexsym<<yytext;}

\n	{}
.	{}
%%
