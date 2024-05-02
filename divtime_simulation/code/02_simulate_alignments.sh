#!/usr/bin/bash

# simulate one alignment of length 1000 under the JC model for ach of the trees in genetrees.newick and return
# a single file with a data partition in phylip format
seq-gen -mHKY -t0.5 -f0.25,0.25,0.25,0.25 -l1000 -n1 ../data/genetrees.newick > ../data/genetrees.aln
