MAIN     = main
OUTDIR   = build
LATEXMK  = latexmk
FLAGS    = -cd -synctex=1 -interaction=nonstopmode -file-line-error -xelatex -outdir=$(OUTDIR)

.PHONY: all build clean distclean view watch fresh help

all: build

build:
	$(LATEXMK) $(FLAGS) $(MAIN).tex

clean:
	$(LATEXMK) -c -outdir=$(OUTDIR) $(MAIN).tex

distclean:
	$(LATEXMK) -C -outdir=$(OUTDIR) $(MAIN).tex

view:
	@start "" "$(OUTDIR)\$(MAIN).pdf"

watch:
	$(LATEXMK) -pvc $(FLAGS) $(MAIN).tex

fresh: distclean build

help:
	@echo Available targets:
	@echo   make build      Build the PDF (default)
	@echo   make clean      Remove auxiliary files, keep PDF
	@echo   make distclean  Remove all generated files
	@echo   make view       Open the PDF
	@echo   make watch      Continuous preview (auto-rebuild on changes)
	@echo   make fresh      Clean + rebuild from scratch
