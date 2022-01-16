#!/usr/bin/bash

cd ../data/mafft-nexus-edge-trimmed-clean-75p/
for j in `ls -d job*`; do
    cd $j
    echo "Processing $j..."
    for i in `ls *.log`; do
	sdsf=$(grep -a "    Average standard deviation of split frequencies = " $i | awk '{split($0, array, " "); print array[8]}')
	echo "$i $sdsf" >> topostability.txt
    done
    cd ../
done

