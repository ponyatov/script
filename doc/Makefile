TEX = script.tex header.tex

LATEX = pdflatex -halt-on-error

script.pdf: $(TEX)
	$(LATEX) $< && $(LATEX) $<
