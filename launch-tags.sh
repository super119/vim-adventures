#!/bin/bash
find kernel-4.14 -type f -print > TAG-FILES
find nvidia -type f -print >> TAG-FILES

gtags -f TAG-FILES -i
ctags -L TAG-FILES --fields=+niazS --extras=+q --c++-kinds=+px --c-kinds=+px --output-format=e-ctags
