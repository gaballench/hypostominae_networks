#!/usr/bin/bash

cd ../data/mafft-nexus-edge-trimmed-clean-75p

mkdir tree_samples

# clean temp files
#rm *~

for i in `ls -d job*`; do
    echo "Entering $i..."
    for j in `ls $i/*.nexus`; do
	pxlog -t $j.run*.t -b 500 | pxt2new >> tree_samples/trees_allloci.newick  
    done
done
