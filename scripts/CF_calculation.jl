# load packages
using PhyloNetworks
using Functors
using DataFrames
using CSV

# fetch the quartets without the assumption that there are the same terminales in each tree
trees = readlines("../data/mafft-nexus-edge-trimmed-clean-75p/tree_samples/lesstrees_allloci.newick")

# convert from String newick to HybridNetwork with Functors.fmap
trees = Functors.fmap(readTopology, trees)

# calculate quartets
q,t = countquartetsintrees(trees)
df = writeTableCF(q,t)

CSV.write("../data/CFs_75p.csv", df)

#exit julia
exit()

