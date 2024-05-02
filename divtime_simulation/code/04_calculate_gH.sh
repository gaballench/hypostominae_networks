#!/usr/bin/bash

# this takes the command-line argument to be the number of the tree, either 1 or 2
TREE=$1

mkdir ../data/fundamental$TREE
cd ../data/fundamental$TREE
ln -s ../genetrees.aln genetrees.aln
ln -s ../fundamental_tree_$TREE.newick tree.phylip

cp ../../code/04_mcmctree.ctl 04_mcmctree_gH.ctl
sed -i -e 's/_USEDATA/3/g' 04_mcmctree_gH.ctl
mcmctree 04_mcmctree_gH.ctl
