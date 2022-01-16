setwd("../data/mafft-nexus-edge-trimmed-clean-75p/")

sdsf <- read.table(file = "topostability.txt", header = FALSE, sep = " ", stringsAsFactors = FALSE)

# how many files with sdsf above 0.1?
sum(sdsf$V3 < 0.1, na.rm = TRUE)

# visualize the dist of sdsf
pdf("sdsf_allloci.pdf")
boxplot(V3 ~ V1, data = sdsf)
dev.off()
