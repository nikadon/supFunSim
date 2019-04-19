#!/bin/bash



find . -name "*.ipynb" \
     -exec bash -c 'jupyter nbconvert "$0" --to markdown ' {} \;  \
     -exec bash -c 'pandoc "${0%.ipynb}.md" -o "${0%.ipynb}.org"' {} \; \
     -exec bash -c 'sed -zi "s/BEGIN_SRC matlab\n *\%\%file/BEGIN_SRC matlab :eval no :tangle/g" "${0%.ipynb}.org"' {} \;
