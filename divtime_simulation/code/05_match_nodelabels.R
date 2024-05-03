library(ape)
library(coda)
library(SiPhyNetwork)

network <- read.net("../data/network.extnewick")
fundtree1 <- read.tree("../data/fundamental_tree_1.newick")[[1]]
fundtree2 <- read.tree("../data/fundamental_tree_2.newick")[[1]]
mcmctree1 <- read.tree("../data/fundamental1/species_tree_with_nodelabels.tre")
mcmctree2 <- read.tree("../data/fundamental2/species_tree_with_nodelabels.tre")

# append t_n to the node labels in the mcmcmtree trees
mcmctree1$node.label <- paste("t_n", mcmctree1$node.label, sep="")
mcmctree2$node.label <- paste("t_n", mcmctree2$node.label, sep="")

# match node labels
df1 <- data.frame(fundtree = fundtree1$node.label,
                  mcmctree = mcmctree1$node.label)
df2 <- data.frame(fundtree = fundtree2$node.label,
                  mcmctree = mcmctree2$node.label)

# read in mcmc trace files
mcmc1 <- read.table("../data/fundamental1/mcmc.txt", sep="\t", header=TRUE)
mcmc2 <- read.table("../data/fundamental2/mcmc.txt", sep="\t", header=TRUE)
mcmc1 <- mcmc1[, grep(pattern="t_n", x=colnames(mcmc1))]
mcmc2 <- mcmc2[, grep(pattern="t_n", x=colnames(mcmc2))]

# save each individual node before converting everything into a grand mcmc object
n12_chain <- as.mcmc(mcmc1$t_n13, mcmc2$t_n13)
n6_chain <- as.mcmc(mcmc1$t_n14, mcmc2$t_n14)
n4_chain <- as.mcmc(mcmc1$t_n15, mcmc2$t_n15)
n1_chain <- as.mcmc(mcmc1$t_n16)
n3_chain <- as.mcmc(mcmc1$t_n17, mcmc2$t_n16)
n2_chain <- as.mcmc(mcmc1$t_n18, mcmc2$t_n17)
n5_chain <- as.mcmc(mcmc1$t_n19, mcmc2$t_n18)
n11_chain <- as.mcmc(mcmc1$t_n20, mcmc2$t_n19)
n10_chain <- as.mcmc(mcmc1$t_n21, mcmc2$t_n20)
n7_chain <- as.mcmc(mcmc1$t_n22, mcmc2$t_n21)
n9_chain <- as.mcmc(mcmc1$t_n23, mcmc2$t_n22)
n8_chain <- as.mcmc(mcmc2$t_n23)

# now the whole thing
mcmc1 <- as.mcmc(mcmc1)
mcmc2 <- as.mcmc(mcmc2)

# both chains show good intrachain convergence
effectiveSize(mcmc1)
effectiveSize(mcmc2)

# plot the corresponding nodes accross analyses

# n12
plot(density(mcmc1[,"t_n13"]), xlim=c(0, 2), ylim=c(0,7))
lines(density(mcmc2[,"t_n13"]), lty=2)

# n6
plot(density(mcmc1[,"t_n14"]), xlim=c(0, 2), ylim=c(0,7))
lines(density(mcmc2[,"t_n14"]), lty=2)

# n4
plot(density(mcmc1[,"t_n15"]), xlim=c(0, 2), ylim=c(0,7))
lines(density(mcmc2[,"t_n15"]), lty=2)

# n1
plot(density(mcmc1[,"t_n16"]), xlim=c(0, 2), ylim=c(0,7))

# n3
plot(density(mcmc1[,"t_n17"]), xlim=c(0, 2), ylim=c(0,7))
lines(density(mcmc2[,"t_n16"]), lty=2)

# n2
plot(density(mcmc1[,"t_n18"]), xlim=c(0, 2), ylim=c(0,15))
lines(density(mcmc2[,"t_n17"]), lty=2)

# n5
plot(density(mcmc1[,"t_n19"]), xlim=c(0, 2), ylim=c(0,15))
lines(density(mcmc2[,"t_n18"]), lty=2)

# n11
plot(density(mcmc1[,"t_n20"]), xlim=c(0, 2), ylim=c(0,15))
lines(density(mcmc2[,"t_n19"]), lty=2)

# n10
plot(density(mcmc1[,"t_n21"]), xlim=c(0, 2), ylim=c(0,15))
lines(density(mcmc2[,"t_n20"]), lty=2)

# n7
plot(density(mcmc1[,"t_n22"]), xlim=c(0, 2), ylim=c(0,15))
lines(density(mcmc2[,"t_n21"]), lty=2)

# n9
plot(density(mcmc1[,"t_n23"]), xlim=c(0, 2), ylim=c(0,15))
lines(density(mcmc2[,"t_n22"]), lty=2)

# n8
plot(density(mcmc1[,"t_n23"]), xlim=c(0, 2), ylim=c(0,15))

# calculate the median times and HPD intervals on the combined samples whenever we had more than one node being sampled across mc chains
n12_hpdi <- HPDinterval(n12_chain) 
n6_hpdi <- HPDinterval(n6_chain) 
n4_hpdi <- HPDinterval(n4_chain) 
n1_hpdi <- HPDinterval(n1_chain)
n3_hpdi <- HPDinterval(n3_chain) 
n2_hpdi <- HPDinterval(n2_chain) 
n5_hpdi <- HPDinterval(n5_chain) 
n11_hpdi <- HPDinterval(n11_chain) 
n10_hpdi <- HPDinterval(n10_chain) 
n7_hpdi <- HPDinterval(n7_chain) 
n9_hpdi <- HPDinterval(n9_chain) 
n8_hpdi <- HPDinterval(n8_chain)

n12_median <- median(n12_chain) 
n6_median <- median(n6_chain) 
n4_median <- median(n4_chain) 
n1_median <- median(n1_chain)
n3_median <- median(n3_chain) 
n2_median <- median(n2_chain) 
n5_median <- median(n5_chain) 
n11_median <- median(n11_chain) 
n10_median <- median(n10_chain) 
n7_median <- median(n7_chain) 
n9_median <- median(n9_chain) 
n8_median <- median(n8_chain)

# annotations in newick are of the following form
#[&age_median=value,
# age_95%HPD={min,max}]
n12_strings <- paste("[&age_median=", n12_median, ",age_95%HPD=", n12_hpdi[1], ",", n12_hpdi[2], "}]", sep="")
n6_strings <- paste("[&age_median=", n6_median,  ",age_95%HPD={", n6_hpdi[1],  ",", n6_hpdi[2], "}]", sep="")
n4_strings <- paste("[&age_median=", n4_median,  ",age_95%HPD={", n4_hpdi[1],  ",", n4_hpdi[2], "}]", sep="")
n1_strings <- paste("[&age_median=", n1_median,  ",age_95%HPD={", n1_hpdi[1],  ",", n1_hpdi[2], "}]", sep="")
n3_strings <- paste("[&age_median=", n3_median,  ",age_95%HPD={", n3_hpdi[1],  ",", n3_hpdi[2], "}]", sep="")
n2_strings <- paste("[&age_median=", n2_median,  ",age_95%HPD={", n2_hpdi[1],  ",", n2_hpdi[2], "}]", sep="")
n5_strings <- paste("[&age_median=", n5_median,  ",age_95%HPD={", n5_hpdi[1],  ",", n5_hpdi[2], "}]", sep="")
n11_strings <- paste("[&age_median=", n11_median, ",age_95%HPD=", n11_hpdi[1], ",", n11_hpdi[2], "}]", sep="")
n10_strings <- paste("[&age_median=", n10_median, ",age_95%HPD=", n10_hpdi[1], ",", n10_hpdi[2], "}]", sep="")
n7_strings <- paste("[&age_median=", n7_median,  ",age_95%HPD={", n7_hpdi[1],  ",", n7_hpdi[2], "}]", sep="")
n9_strings <- paste("[&age_median=", n9_median,  ",age_95%HPD={", n9_hpdi[1],  ",", n9_hpdi[2], "}]", sep="")
n8_strings <- paste("[&age_median=", n8_median,  ",age_95%HPD={", n8_hpdi[1],  ",", n8_hpdi[2], "}]", sep="")

# node 8 and node H24 must be contemporary, and therefore they share the time info
nH24_strings <- n8_strings

nodes <- c("n12",
"n6",
"n4",
"n1",
"n3",
"n2",
"n5",
"n11",
"n10",
"n7",
"n9",
"n8", "#H24")

strings <- c(n12_strings, 
n6_strings, 
n4_strings, 
n1_strings,
n3_strings, 
n2_strings, 
n5_strings, 
n11_strings, 
n10_strings, 
n7_strings, 
n9_strings, 
n8_strings, nH24_strings)

### replace node labels with age info
annotated_network <- network

for (i in seq_along(nodes)) {
    label_idx <- which(annotated_network$node.label == nodes[i])
    annotated_network$node.label[label_idx] <- strings[i]
}

write.net(annotated_network, file="../data/annotated_network.extnewick")
