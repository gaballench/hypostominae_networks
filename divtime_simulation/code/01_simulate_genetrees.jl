using PhyloCoalSimulations, PhyloNetworks, Random

nsims = parse(Int64, ARGS[1])

Random.seed!(1810)

network = readTopology("../data/network.extnewick")

genetrees = simulatecoalescent(network, nsims, 1) 

writeMultiTopology(genetrees, "../data/genetrees.newick")
