using PhyloNetworks
using DataFrames

trees = readMultiPhylo("tree_samples/trees_allloci.newick")

q,t = countquartetsintrees(trees)
df = writeTableCF(q,t)
cfs = readTableCF(df)

# read starting tree
start_tree = readTopology("starting_tree.tre")

# calculate a h=0 network
net0 = snaq!(start_tree, cfs, hmax=0, filename="snaq_hypostominae_h0.txt", seed=1234, runs = 15)

# calculate a h=1 network
net1 = snaq!(net0, cfs, hmax=1, filename="snaq_hypostominae_h1.txt", seed=1234, runs = 15)

# calculate a h=2 network
net2 = snaq!(net1, cfs, hmax=2, filename="snaq_hypostominae_h2.txt", seed=1234, runs = 15)

#exit julia
exit()
