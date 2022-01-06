#!/usr/bin/bash

# remember to mkdir tree_samples before in the pipeline
for i in `ls job*`; do
    for j in `ls $i/*.log`; do
	pxlog -f $j -b BURNIN | pxt2new -o $j.newick
    done
done

for i in `ls *.newick`; do
    echo $i >> trees_allloci.newick
done
