#!/usr/bin/bash

TREE=$1

cd ../data/fundamental$TREE/

grep 'FigTree' -A 1 out.txt | tail -n 1 > mcmctree.tre
sed -i -E 's/[0-9]+_//g' mcmctree.tre
