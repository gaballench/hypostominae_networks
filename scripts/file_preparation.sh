#!/usr/bin/bash

# create a simple log file for recording which files are being created and where
touch fileops.log
echo "nexus mrbayes dir" > fileops.log

# create the directory for each job
mkdir job1 job2 job3 job4

# set the counter var
COUNTER=1

# process each nexus file to create the script and move them to the appropriate dir
for i in `ls *.nexus`; do
    # reset the counter to 1 if it's higher than 4
    if [[ "$COUNTER" -gt 4 ]]; then
	let "COUNTER=1"
    fi
    # create the mb script from the template file and just append the extension .mb
    touch $i.mb
    cat ../scripts/template.mb > $i.mb
    # replace the placeholder ALIGNMENT with the alignment filename
    sed -i "s/ALIGNMENT/$i/g" $i.mb
    # move the script and alignment to the job dir
    mv $i "job$COUNTER"
    mv $i.mb "job$COUNTER"
    # record filenames to the logger
    echo "$i $i.mb job$COUNTER" >> fileops.log
    # add one to the counter for entering the next folder
    let "COUNTER+=1"
done

# prepare the pbs scripts using the template file template.pbs
for i in `ls -d job*`; do
    # create the pbs script from the template file and just append the extension .pbs
    touch $i.pbs
    cat ../scripts/template.pbs > $i.pbs
    # replace the placeholder ALIGNMENT with the alignment filename
    sed -i "s/JOBDIR/$i/g" $i.pbs
    mv $i.pbs $i
done
