TEX = script.tex header.tex

TEX += tmp/lexer.hpp

PNG = struct.pdf

LATEX = pdflatex -halt-on-error

script.pdf: $(TEX) $(PNG) Makefile
	$(LATEX) $< && makeindex script && $(LATEX) $<

%.pdf: %.dot
	dot -Tpdf -o $@ $<

tmp/%.hpp: ../hpp.hpp tmp/src2lst$(EXE)
	tmp/src2lst$(EXE) < $< > $@

tmp/src2lst$(EXE): src2lst.lex
	mkdir -p tmp ; flex -o tmp/src2lst.cpp $< && g++ -o $@ tmp/src2lst.cpp
