TEX=proceedings.tex
PDF=$(subst .tex,.pdf,$(TEX))
PAPERS=$(shell sed -e 's/^/submissions\//' -e 's/\#.*//' ordering | tr '\n' ' ')
default : $(PDF)

# Skim on OS X, zathura elsewhere.
preview : $(PDF)
	@if [ `uname` = 'Darwin' ]; then \
	  open -a /Applications/Skim.app $(PDF); \
	else \
	  zathura $(PDF); \
	fi

papers : ordering $(PAPERS)
	gs -q -sPAPERSIZE=a4 -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=papers.pdf $(PAPERS)


$(PDF) : papers $(TEX)
	xelatex -halt-on-error $(TEX)
	xelatex -halt-on-error $(TEX)

clean :
	rm -f *.aux *.log *.nav *.out *.ptb *.toc *.snm $(PDF) $(TEX) *.synctex.gz *.bbl *.blg
