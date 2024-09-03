#!/usr/bin/bash


UCES=../data/mafft-nexus-edge-trimmed-clean-75p/uces_hypostominae
OUTPUT=../evorate

for i in `ls $UCES/*.nexus`; do
    BASENAME=`basename $i`
    iqtree -s $i --prefix $OUTPUT/$BASENAME -m MFP -T 10
done


