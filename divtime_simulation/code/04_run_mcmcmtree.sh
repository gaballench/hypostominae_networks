#!/usr/bin/bash

# this takes the command-line argument to be the number of the tree, either 1 or 2
TREE=$1

cd ../data/fundamental$TREE

ln -s out.BV in.BV

cp ../../code/04_mcmctree.ctl 04_mcmctree_posterior.ctl
sed -i -e 's/_USEDATA/2/g' 04_mcmctree_posterior.ctl
mcmctree 04_mcmctree_posterior.ctl

