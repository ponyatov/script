#ifndef _H_SCRIPT
#define _H_SCRIPT

#include <iostream>
#include <cstdlib>
#include <vector>
#include <map>
using namespace std;

struct Sym;
struct Env {
	map<string,Sym*> iron;
	Sym* lookup(string);
};
extern Env glob;
extern void glob_init();

struct Sym {
	string tag,val;
	Sym(string,string); Sym(string);
	Env* env;
	vector<Sym*> nest; void push(Sym*);
	string dump(int=0); string pad(int);
	virtual string tagval(); string tagstr();
};

struct Str:Sym { Str(string); string tagval(); };

struct List:Sym { List(); };

struct Op:Sym { Op(string); };

extern int yylex();
extern int yylineno;
extern char* yytext;
#define TOC(C,X) { yylval.o = new C(yytext); return X; }
extern int yyparse();
extern void yyerror(string);
extern Sym* module;
#include "ypp.tab.hpp"

#endif // _H_SCRIPT
