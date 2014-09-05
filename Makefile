TEXFILES = $(wildcard *.tex)
PDFFILES = $(TEXFILES:.tex=.pdf)
DVIFILES = $(TEXFILES:.tex=.dvi)
PSFILES  = $(TEXFILES:.tex=.ps)

all: pdf

ps:  $(PSFILES)
pdf: $(PDFFILES)

%.pdf: %.tex src/*.tex
	@rubber --pdf $<
pdflatex: $(TEXFILES)
	@pdflatex $(TEXFILES:.tex=)
	@TEXMFOUTPUT=`pwd` bibtex `pwd`/$(TEXFILES:.tex=)
	@pdflatex $(TEXFILES:.tex=)
	@pdflatex $(TEXFILES:.tex=)
	@if [ -d bin ];then mv *.pdf bin; else mkdir bin; mv *.pdf bin/;fi
%.ps: %.tex
	@rubber --ps $<
%.dvi: %.tex
	@rubber $<
clean:
	@rubber --clean --pdf $(TEXFILES:.tex=)
	@rubber --clean --ps $(TEXFILES:.tex=)
	@rubber --clean $(TEXFILES:.tex=)
distclean:
	@rm -rf bin
evince:
	@evince $(PDFFILES) &> /dev/null &
preview:
	@open bin/$(PDFFILES) &> /dev/null &
.PHONY: pdf clean all

