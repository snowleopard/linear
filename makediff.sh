latexdiff ./journal_submission.tex ./journal_revision.tex > diff.tex; 
pdflatex diff; bibtex diff; pdflatex diff; pdflatex diff;
open diff.pdf
