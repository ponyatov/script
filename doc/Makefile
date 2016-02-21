TEX = script.tex header.tex

LATEX = pdflatex -halt-on-error

script.pdf: $(TEX) Makefile
	$(LATEX) $< && makeindex script && $(LATEX) $<
