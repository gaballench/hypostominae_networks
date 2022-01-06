using PhyloNetworks
using DataFrames

tt = readMultiPhylo("tree_samples/trees_allloci.newick")
cfs = readTableFCs(tt)

