using PhyloNetworks
using DataFrames
using Functors

#trees = readMultiTopology("../data/mafft-nexus-edge-trimmed-clean-75p/tree_samples/trees_allloci.newick")

# try to fetch the quartets without the assumption that there are the same terminales in each tree
trees = readlines("../data/mafft-nexus-edge-trimmed-clean-75p/tree_samples/lesstrees_allloci.newick")

# convert from String newick to HybridNetwork with Functors.fmap
trees = fmap(readTopology, trees)

# calculate quartets
q,t = countquartetsintrees(trees)
df = writeTableCF(q,t)
cfs = readTableCF(df)

# read starting tree
start_tree = readTopology("../data/starting_tree/RAxML_bestTree.best")

# calculate a h=0 network
net0 = snaq!(start_tree, cfs, hmax=0, filename="snaq_hypostominae_h0.txt", seed=1234, runs = 16)

# calculate a h=1 network
net1 = snaq!(net0, cfs, hmax=1, filename="snaq_hypostominae_h1.txt", seed=1324, runs = 16)

# calculate a h=2 network
net2 = snaq!(net1, cfs, hmax=2, filename="snaq_hypostominae_h2.txt", seed=1432, runs = 16)

#exit julia
exit()
