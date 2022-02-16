#!/bin/sh
# SGI
#PBS -V
#PBS -N snaq75p_cffirst
#PBS -e snaq75p_cffirst.err
#PBS -o snaq75p_cffirst.out
#PBS -q workq
#PBS -l place=scatter
#PBS -l select=1:ncpus=21
#PBS -l walltime=400:00:00
# shm, sock, ssm, rdma, rdssm
FABRIC=rdma
#CORES=$[ `cat $PBS_NODEFILE | wc -l` ]
#NODES=$[ `uniq $PBS_NODEFILE | wc -l` ]

#printf "Current time is: `date`\n";
#TEND = 
#printf "Current PBS work directory is: $PBS_O_WORKDIR\n";
#printf "Current PBS queue is: $PBS_O_QUEUE\n"; 
#printf "Current PBS job ID is: $PBS_JOBID\n";
#printf "Current PBS job name is: $PBS_JOBNAME\n";
#printf "PBS stdout log is: $PBS_O_WORKDIR/sgi_mpitest.err\n";
#printf "PBS stderr log is: $PBS_O_WORKDIR/sgi_mpitest.log\n";
#printf "Fabric interconnect selected is: $FABRIC\n";
#printf "This jobs will run on $CORES processors.\n";
##. /etc/profile.d/modules.sh
module load gnu8 openmpi3 && echo "Successfully load modules"

cd $PBS_O_WORKDIR

# add zlib to the path so that openmpi can find it
#export LD_LIBRARY_PATH=/apps/ZLIB128/lib/:$LD_LIBRARY_PATH
# export path to my mpi
export PATH="/home/gustavo/programs/julia-1.6.3/bin:$PATH"

#printf "mpiexec_mpt run command location is: `which mpiexec_mpt`\n";
#printf "\n[STAT] qstat -f $PBS_JOBID\n";
#qstat -f $PBS_JOBID
#printf "\n[END] qstat -f $PBS_JOBID\n";
#TBEGIN=`echo "print time();" | perl`

#MPI_HOSTS=$(sort $PBS_NODEFILE | uniq -c | \
#awk '{print $2 " " $1}' | \
#tr "\n" "," | \
#sed 's/.$//')

###########
# COMMAND #
###########

julia network_estimation.jl > snaq75p_cffirst.outerr 2>&1 

##########
# FINISH #
##########

#TEND=`echo "print time();" | perl`
#printf "Job finished: `date`\n";
#printf "Job walltime: `expr $TEND - $TBEGIN`\n";
