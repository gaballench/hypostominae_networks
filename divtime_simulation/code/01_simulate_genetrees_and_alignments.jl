using PhyloCoalSimulations, PhyloNetworks, Random

Random.seed!(1810)

network = readTopology("../data/network.extnewick")

genetrees = simulatecoalescent(network, 1000, 1) 

writeMultiTopology(genetrees, "../data/genetrees.newick")
