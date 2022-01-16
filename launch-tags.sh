#!/bin/bash

rm -f GPATH GRTAGS GTAGS TAG-FILES

# Exclude folders
# find . -type f -not \( -path "./cboot/*" -o -path "./nvtboot/*" \)

# Whitelist folders
# find kernel-5.10 -type f -print > TAG-FILES
# find xxx -type f -print >> TAG-FILES

# Include all files
find . -type f -print > TAG-FILES

gtags -f TAG-FILES
