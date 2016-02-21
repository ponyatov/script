%{
#include <fstream>
using namespace std;
ofstream lexhpp("tmp/lexer.hpp");
%}
%option main
%option noyywrap
%%
^extern\ [a-z\*]+\ yy(lex|lineno|text).+\n	{lexhpp<<yytext;}

\n	{}
.	{}
%%
