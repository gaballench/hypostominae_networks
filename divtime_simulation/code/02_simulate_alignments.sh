#!/usr/bin/bash

LOCUSLENGTH=$1
# simulate one alignment of length 1000 under the JC model for ach of the trees in genetrees.newick and return
# a single file with a data partition in phylip format
seq-gen -mHKY -t0.5 -f0.25,0.25,0.25,0.25 -l$LOCUSLENGTH -n1 ../data/genetrees.newick > ../data/genetrees.aln
