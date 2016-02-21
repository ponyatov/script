#include "hpp.hpp"
#define YYERR "\n\n"<<yylineno<<":"<<msg<<"["<<yytext<<"]\n\n"
void yyerror(string msg) { cout<<YYERR; cerr<<YYERR; exit(-1); }
int main() { glob_init(); yyparse(); cout<<module->dump(); return 0; }

Sym::Sym(string T,string V) { tag=T; val=V; env=&glob; }
Sym::Sym(string V):Sym("",V) {}
void Sym::push(Sym*o) { nest.push_back(o); }

string Sym::tagval() { return "<"+tag+":"+val+">"; }
string Sym::tagstr() { string S = "<"+tag+":'";
	for (int i=0,n=val.length();i<n;i++)
		switch (val[i]) {
			case '\t': S+="\\t"; break;
			case '\n': S+="\\n"; break;
			default: S+=val[i];
		}
	return S+"'>"; }
string Sym::pad(int n) { string S; for (int i=0;i<n;i++) S+='\t'; return S; }
string Sym::dump(int depth) { string S = "\n"+pad(depth)+tagval();
	for (auto it=nest.begin(),e=nest.end();it!=e;it++)
		S += (*it)->dump(depth+1);
	return S; }

Str::Str(string V):Sym("str",V) {}
string Str::tagval() { return tagstr(); }

List::List():Sym("","") {}

Op::Op(string V):Sym("op",V) {}

Env glob;
void glob_init(){}

