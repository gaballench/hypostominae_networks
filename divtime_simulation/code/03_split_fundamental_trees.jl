using PhyloNetworks

network = readTopology("../data/network.extnewick")

fundtrees = displayedTrees(network,
                           0.0,
                           nofuse = false,
                           keeporiginalroot = true)

# write the trees to a file
# first tree
write("../data/fundamental_tree_1.newick", "  $(network.numTaxa)  1\n")
io = open("../data/fundamental_tree_1.newick", "a")
writeTopology(fundtrees[1], io)
close(io)
# second tree
write("../data/fundamental_tree_2.newick", "  $(network.numTaxa)  1\n")
io = open("../data/fundamental_tree_2.newick", "a")
writeTopology(fundtrees[2], io)
close(io)
