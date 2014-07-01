TEXPROCEEDINGS=proceedings.tex
PDFPROCEEDINGS=$(subst .tex,.pdf,$(TEXPROCEEDINGS))
TEXFRONTPAGE=frontpage.tex
PDFFRONTPAGE=$(subst .tex,.pdf,$(TEXFRONTPAGE))
PAPERS=$(shell sed -e 's/^/submissions\//' -e 's/\#.*//' ordering | tr '\n' ' ')
default : all

all : $(PDFFRONTPAGE) $(PDFPROCEEDINGS)

# Skim on OS X, zathura elsewhere.
preview : $(PDF)
	@if [ `uname` = 'Darwin' ]; then \
	  open -a /Applications/Skim.app $(PDF); \
	else \
	  zathura $(PDF); \
	fi

papers : ordering $(PAPERS)
	#gs -q -sPAPERSIZE=a4 -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=papers.pdf $(PAPERS)

$(PDFFRONTPAGE) : $(TEXFRONTPAGE)
	xelatex -halt-on-error $(TEXFRONTPAGE)

$(PDFPROCEEDINGS) : papers $(TEXPROCEEDINGS)
	xelatex -halt-on-error $(TEXPROCEEDINGS)
	xelatex -halt-on-error $(TEXPROCEEDINGS)

clean :
	rm -f *.aux *.log *.nav *.out *.ptb *.toc *.snm $(PDFPROCEEDINGS) $(PDFFRONTPAGE) *.synctex.gz *.bbl *.blg
