#!/bin/sh
# Convert a pdf to svg, then remove pages without the tables I want.

search_pdfsvg() {
  (
    set -e
    cd "$1"
    for svg in *.svg; do
      page=$(basename "$svg" .svg)
      grep -e Department\ Summary -e Position\ Summary -e Division\ Summary\
          $page.svg > /dev/null ||
      rm .$page.pdf $page.svg
    done
  )
}

main() {
  for pdf in *.pdf; do
    pdf2svg $pdf
    search_pdfsvg ${pdf}2svg
  done
}

#search_pdfsvg 2011-2012_adopted_budget.pdf2svg 
main
