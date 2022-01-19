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

# fetch the quartets without the assumption that there are the same terminales in each tree
trees = readlines("../data/mafft-nexus-edge-trimmed-clean-75p/tree_samples/lesstrees_allloci.newick")

# convert from String newick to HybridNetwork with Functors.fmap
trees = Functors.fmap(readTopology, trees)

# calculate quartets
q,t = countquartetsintrees(trees)
df = writeTableCF(q,t)
cfs = readTableCF(df)

# read starting tree
start_tree = readTopology("../data/starting_tree/RAxML_bestTree.best")

# calculate a h=0 network
net0 = snaq!(start_tree, cfs, hmax=0, filename="../data/snaq/snaq_hypostominae_h0", seed=1234, runs = nruns)

# calculate a h=1 network
net1 = snaq!(net0, cfs, hmax=1, filename="../data/snaq/snaq_hypostominae_h1", seed=1324, runs = nruns)

# calculate a h=2 network
net2 = snaq!(net1, cfs, hmax=2, filename="../data/snaq/snaq_hypostominae_h2", seed=1432, runs = nruns)

# calculate a h=3 network
net3 = snaq!(net2, cfs, hmax=3, filename="../data/snaq/snaq_hypostominae_h3", seed=1432, runs = nruns)

# calculate a h=4 network
net4 = snaq!(net3, cfs, hmax=4, filename="../data/snaq/snaq_hypostominae_h4", seed=2134, runs = nruns)

# calculate a h=5 network
net5 = snaq!(net4, cfs, hmax=5, filename="../data/snaq/snaq_hypostominae_h5", seed=2143, runs = nruns)

#exit julia
exit()

