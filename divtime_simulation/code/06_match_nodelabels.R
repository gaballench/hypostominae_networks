library(ape)
library(coda)
library(SiPhyNetwork)

network <- read.net("../data/network.extnewick")
fundtree1 <- read.tree("../data/fundamental_tree_1.newick")
fundtree2 <- read.tree("../data/fundamental_tree_2.newick")
mcmctree1 <- read.tree("../data/fundamental1/mcmctree.tre")
mcmctree2 <- read.tree("../data/fundamental2/mcmctree.tre")

# append t_n to the node labels in the mcmcmtree trees
mcmctree1$node.label <- paste("t_n", mcmctree1$node.label, sep="")
mcmctree2$node.label <- paste("t_n", mcmctree2$node.label, sep="")

# match node labels
df1 <- data.frame(fundtree = fundtree1$node.label,
                  mcmctree = mcmctree1$node.label)
df2 <- data.frame(fundtree = fundtree2$node.label,
                  mcmctree = mcmctree2$node.label)

### most of the code below does a manual matching of nodes. we want to
### use the dfs above for automatically fetching node correspondences


# read in mcmc trace files
mcmc1 <- read.table("../data/fundamental1/mcmc.txt", sep="\t", header=TRUE)
mcmc2 <- read.table("../data/fundamental2/mcmc.txt", sep="\t", header=TRUE)
mcmc1 <- mcmc1[, grep(pattern="t_n", x=colnames(mcmc1))]
mcmc2 <- mcmc2[, grep(pattern="t_n", x=colnames(mcmc2))]

# make a list of fundamental node labels
fundtree_nodelabels <- unique(c(df1$fundtree, df2$fundtree))
age_chains <- list()
length(age_chains) <- length(fundtree_nodelabels)
names(age_chains) <- fundtree_nodelabels

for (i in fundtree_nodelabels) {
    #cat(i, "\n")
    age_samples <- vector()
    if (i %in% df1$fundtree) {
        df1_idx <- which(df1$fundtree == i)
        age_samples <- unlist(mcmc1[, df1$mcmctree[df1_idx]])
    }
    if (i %in% df2$fundtree) {
        df2_idx <- which(df2$fundtree == i)
        age_samples <- c(age_samples, unlist(mcmc2[, df2$mcmctree[df2_idx]]))
    }
    age_chains[[i]] <- as.mcmc(age_samples)
}

age_stats <- data.frame(
    node = fundtree_nodelabels,
    mean = sapply(X=age_chains, FUN=mean),
    median = sapply(X=age_chains, FUN=median),
    hpd_lower = sapply(X=age_chains, FUN=function(x)HPDinterval(x)[1]),
    hpd_upper = sapply(X=age_chains, FUN=function(x)HPDinterval(x)[2])
)

age_strings <- vector(length=nrow(age_stats), mode="character")

for (i in 1:nrow(age_stats)) {
    age_strings[i] <- paste("[&age_mean=",
                            age_stats$mean[i],
                            "@age_median=",
                            age_stats$median[i],
                            "@age_95%HPD={",
                            age_stats$hpd_lower[i],
                            "@",
                            age_stats$hpd_upper[i],
                            "}]",
                            sep="")
}


### replace node labels with age info
annotated_network <- network

for (i in seq_along(fundtree_nodelabels)) {
    label_idx <- which(annotated_network$node.label == fundtree_nodelabels[i])
    annotated_network$node.label[label_idx] <- age_strings[i]
}

formatted_net <- gsub(pattern="@", replacement=",", write.net(annotated_network))
annotated_network$node.label <- gsub(pattern="@", replacement=",", annotated_network$node.label)
writeLines(formatted_net, "../data/annotated_network.extnewick")

### try to calculate bran lengths in time with the posterior medians

Ntips <- length(network$tip.label)

# transfer the age information from sampled nodes to hybrid unsampled ones
age_stats_bkp <- age_stats
for (i in 1:nrow(network$reticulation)) {
    parent <- network$reticulation[i, 1]
    parent_label <- network$node.label[parent-Ntips]
    child <- network$reticulation[i, 2]
    child_label <- network$node.label[child-Ntips]
    if (!(parent_label %in% fundtree_nodelabels) & !(child_label %in% fundtree_nodelabels)){
        stop("None of parent and child reticulation edge were sampled in time\nin reticulation ", i, "\n")
    }
    if ((parent_label %in% fundtree_nodelabels) & (child_label %in% fundtree_nodelabels)){
        cat("Both parent and child reticulation edge were sampled in time\nin reticulation", i, "\n")
        next
    }
    if ((parent_label %in% fundtree_nodelabels)) {
        parent_idx <- which(age_stats$node == parent_label)
        age_stats <- rbind(age_stats, age_stats[parent_idx, ])
        age_stats[nrow(age_stats), "node"] <- child_label
        next
    }
    if ((child_label %in% fundtree_nodelabels)) {
        child_idx <- which(age_stats$node == child_label)
        age_stats <- rbind(age_stats, age_stats[child_idx, ])
        age_stats[nrow(age_stats), "node"] <- parent_label
    }
}

age_brlens <- vector(length=length(network$edge.length), mode="numeric")
# calculate branch lengths in time
for (i in 1:nrow(network$edge)) {
    parent <- network$edge[i, 1]
    child <- network$edge[i, 2]
    parent_idx <- which(age_stats$node == network$node.label[parent-Ntips])
    parent_age <- age_stats[parent_idx, "median"]
    if (child <= Ntips) { # calc ages beforehand and 0 if tips
        child_age <- 0.0
    } else {
        child_idx <- which(age_stats$node == network$node.label[child-Ntips])
        child_age <- age_stats[child_idx, "median"]
    }
    age_brlens[i] <- parent_age - child_age
}

net <- network

net$edge.length <- age_brlens

# branches don't seem to match :'(
