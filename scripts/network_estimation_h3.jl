using Distributed

# how many runs for snaq
nruns = 20

# set up the max number of threads to use based on nruns
addprocs(nruns)

# load packages to parallel threads
@everywhere using PhyloNetworks
@everywhere using Functors
@everywhere using DataFrames
@everywhere using CSV

#df = CSV.read("../data/CFs_75p.csv")
#cfs = readTableCF(df)
cfs = readTableCF("../data/CFs_75p.csv")

# read starting tree
#start_tree = readTopology("../data/starting_tree/RAxML_bestTree.best")

# read a h=0 network
#net0 = readTopology("../data/snaq/snaq_hypostominae_h0.out")

# calculate a h=1 network
#net1 = readTopology("../data/snaq/snaq_hypostominae_h1.out")
#net1 = snaq!(net0, cfs, hmax=1, filename="../data/snaq/snaq_hypostominae_h1", seed=1324, runs = nruns)

# calculate a h=2 network
net2 = readTopology("../data/snaq/snaq_hypostominae_h2.out")
#net2 = snaq!(net1, cfs, hmax=2, filename="../data/snaq/snaq_hypostominae_h2", seed=1432, runs = nruns)

# calculate a h=3 network
net3 = snaq!(net2, cfs, hmax=3, filename="../data/snaq/snaq_hypostominae_h3", seed=1432, runs = nruns)

# calculate a h=4 network
#net4 = snaq!(net3, cfs, hmax=4, filename="../data/snaq/snaq_hypostominae_h4", seed=2134, runs = nruns)

# calculate a h=5 network
#net5 = snaq!(net4, cfs, hmax=5, filename="../data/snaq/snaq_hypostominae_h5", seed=2143, runs = nruns)

#exit julia
exit()

