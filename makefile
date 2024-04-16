LATEX := xelatex
BUILDDIR := pdf
TEXDIR := tex

# ASSIGNMENT_TEXS := $(addprefix $(TEXDIR)/,21014912_ma7011_quantum_simulation.tex assignment_introduction.tex assignment_quantum_crypto_algo.tex assignment_simulation_implementation.tex assignment_implications_for_future_developments.tex assignment_conclusion.tex assignment_appendix_code.tex code/ references.bib)


TEX_FILES := $(addprefix $(TEXDIR)/,21014912_*.tex assignment_*.tex)

TARGET_NAME := 21014912_ma7011_quantum_simulation
PDF_FILES := $(BUILDDIR)/$(TARGET_NAME).pdf

LATEX_INTERMEDIATE := $(BUILDDIR)/
TEXINPUTS:="./tex/"

.PHONY: clean clean-bcf
.PRECIOUS:= $(BUILDDIR)/%.bcf $(BUILDDIR)/%.bbl $(BUILDDIR)/%.toc


$(BUILDDIR)/%.bcf: $(TEXDIR)/%.tex
	TEXINPUTS="./tex/:" ; $(LATEX) -synctex=1 -interaction=nonstopmode --shell-escape -output-directory=$(BUILDDIR) $<

$(BUILDDIR)/%.bbl: $(BUILDDIR)/%.bcf $(TEXDIR)/references.bib
	biber --input-directory $(TEXDIR) $<

$(BUILDDIR)/%.toc: $(TEXDIR)/%.tex
	TEXINPUTS="./tex/:" ; $(LATEX) -synctex=0 -interaction=nonstopmode --shell-escape -output-directory=$(BUILDDIR) $<

$(BUILDDIR)/%.pdf: $(TEXDIR)/%.tex $(BUILDDIR)/%.bbl $(BUILDDIR)/%.toc $(TEX_FILES)
	TEXINPUTS="./tex/:" ; $(LATEX) -synctex=1 -interaction=nonstopmode --shell-escape -output-directory=$(BUILDDIR) $<

$(BUILDDIR):
	mkdir $(BUILDDIR)

all: $(PDF_FILES) $(BUILDDIR)


clean-bcf:
	-rm $(BUILDDIR)/*.bcf $(BUILDDIR)/*.blg

clean:
	-rm $(BUILDDIR)/*.aux $(BUILDDIR)/*.log $(BUILDDIR)/*.out $(BUILDDIR)/*.toc

info:
	@ls -l $(TEX_FILES) pdf/21014912*.pdf pdf/21014912*.b* pdf/21014912*.toc pdf/21014912*.pdf
