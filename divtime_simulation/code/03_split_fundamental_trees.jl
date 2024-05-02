using PhyloNetworks

network = readTopology("../data/network.extnewick")

fundtrees = displayedTrees(network,
                           0.0,
                           nofuse = true,
                           keeporiginalroot = true)

# write the first tree to file
# please note that this method will write a node label HX where the hybrid edge was attached
# also, the attachment point will become a single-child node which needs to be removed manually: (t1, (t2)); -> (t1, t2);
# finally, the ntaxa, ntrees line needs to be in the file in order to be phylip-compliant
writeTopology(fundtrees[1], "../data/fundamental_tree_1.newick")
writeTopology(fundtrees[2], "../data/fundamental_tree_2.newick")
