#!/usr/bin/bash

# move to the data dir
cd ../data
# run the file preparator script from the data dir
../scripts/./file_preparation.sh

# visit each job dir and submit the job
for i in `ls -d job*`; do
    cd $i
    qsub *.pbs
    cd ..
done
