#!/usr/bin/bash

# example       dirname gamma oneminusgamma genetrees locuslength ntrees burnin sampfreq nsample
# ./pipeline.sh testrun 0.1 0.9 100 1000 2 2000 10 10000

# set up conda
CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh

# fetch argvars
DIRNAME=$1
# network-specific values
GAMMA=$2
ONEMINUSGAMMA=$3
# simulation quantities
GENETREES=$4
LOCUSLENGTH=$5
# set number of fundamental trees
NTREES=$6
# posterior sampling
BURNIN=$7 # 2000
SAMPFREQ=$8 # 10
NSAMPLE=$9 # 10000

# create a directory for the simulation
# copy the network template and code in order to pack everything
mkdir ../$DIRNAME
mkdir ../$DIRNAME/data
mkdir ../$DIRNAME/code
cp -r ../data/network_template.extnewick ../$DIRNAME/data/
cp -r ../code ../$DIRNAME/
# change dir and execute the rest from there
cd ../$DIRNAME/code
# generate the network with arbitrary values of gamma and 1-gamma
# e.g. 0.01 and 0.99 for a very tree-like network with little 'introgression'
./000_manipulate_gamma.sh $GAMMA $ONEMINUSGAMMA
# simulate gene trees
julia 01_simulate_genetrees.jl $GENETREES
# simulate alignments
conda activate networksim
./02_simulate_alignments.sh $LOCUSLENGTH
conda deactivate
# split fundamental trees
julia 03_split_fundamental_trees.jl
# calculate gH on each fundamental tree in parallel,  the iterator is the tree id
conda activate genomics
parallel ./04_calculate_gH.sh {1} $GENETREES $BURNIN $SAMPFREQ $NSAMPLE ::: `seq 1 $NTREES`
# execute mcmctree on each tree in parallel, the iterator is the tree id
parallel ./04_run_mcmctree.sh {1} $GENETREES $BURNIN $SAMPFREQ $NSAMPLE ::: `seq 1 $NTREES`
# capture species tree
parallel ./05_capture_speciestree.sh ::: `seq 1 $NTREES`
# match node labels, summarise node ages, and annotate network
conda deactivate
Rscript 06_match_nodelabels.R
