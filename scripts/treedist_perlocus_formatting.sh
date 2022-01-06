#!/usr/bin/bash

mkdir tree_samples

# clean temp files
rm *~

for i in `ls job*`; do
    for j in `ls $i/*.nexus`; do
	pxlog -f "$j.run*.t" -b 500 | pxt2new -o $j.newick  
    done
done

for i in `ls *.newick`; do
    echo $i >> trees_allloci.newick
done
