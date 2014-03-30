.PHONY: all clean
FILE=report

all: $(FILE).pdf

$(FILE).pdf: $(FILE).tex
	pdflatex $(FILE).tex

clean:
	rm -rf *.aux *.bbl *.blg *.dvi *.log *.out *.synctex.gz *.toc *.lot *.lof
