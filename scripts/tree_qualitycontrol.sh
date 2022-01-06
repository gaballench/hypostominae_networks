#!/usr/bin/bash

for i in `ls *.log`; do
    grep -a "    Average standard deviation of split frequencies = " $i | \
	sdsf=`awk '{split($0, array, " "); print array[8]}'`
    echo "$i $sdsf" >> topostability.txt
done
