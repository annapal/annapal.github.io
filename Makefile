# Build the CV and publish it to the site root as cv.pdf.
#
#   make cv     compile anna_cv/main.tex and copy the result to ./cv.pdf
#   make clean  remove LaTeX build artifacts (leaves cv.pdf in place)
#
# Requires a local LaTeX toolchain with latexmk + biber (e.g. MacTeX or
# BasicTeX + `tlmgr install latexmk biber biblatex`). If latexmk is missing,
# `make cv` prints how to install it instead of failing cryptically.

CV_DIR  := anna_cv
CV_MAIN := main
OUT      := cv.pdf

.PHONY: cv clean

cv:
	@command -v latexmk >/dev/null 2>&1 || { \
	  echo "latexmk not found. Install a LaTeX toolchain first, e.g.:"; \
	  echo "  brew install --cask mactex-no-gui"; \
	  echo "  # or the smaller BasicTeX, then:"; \
	  echo "  #   sudo tlmgr install latexmk biber biblatex fontawesome kpfonts"; \
	  exit 1; \
	}
	cd $(CV_DIR) && latexmk -pdf -interaction=nonstopmode -halt-on-error $(CV_MAIN).tex
	cp $(CV_DIR)/$(CV_MAIN).pdf $(OUT)
	@echo "Built $(OUT) -- commit and push to publish."

clean:
	cd $(CV_DIR) && latexmk -c $(CV_MAIN).tex 2>/dev/null || true
	@echo "Cleaned build artifacts in $(CV_DIR)/."
