# hypostominae_networks

This repository contains the code and data associated with the article "Reticulate Evolution Explains Phylogenetic and Taxonomic Conflict in Neotropical Armoured Catfishes (Loricariidae: Hypostominae)" by Ballen et al. (202X)

## Methods

The TICR pipeline (Stenz et al. 2015) has been proposed in the literature as a way to generate the necessary input for analyses using SNaQ (Solís-Lemus and Ané 2016). However, it assumes that terminals are shared across loci, which is not the case of our dataset. Also, it uses a single summary tree per locus, while we are here interested in incorporating topological uncertainty by using the whole posterior density of trees rather than a single ML gene tree or a Bayesian summary. Instead of heavily modifying that earlier pipeline, we created our own one described below. An additional advantage of this new procedure is that it leverages memory usage during analysis, which was found to be a serious limitation even when using high performance computing.
A Bayesian analysis was carried out on each locus alignment in order to sample from the posterior distribution of topologies using MrBayes (Ronquist and Huelsenbeck 2003). After assessing topological convergence using the standard deviation of split frequencies (SDSF, Nylander et al. 2008), we carried out format conversion and thinning of posterior tree samples using phyx (Brown, Walker, and Smith 2017). We then calculated concordance factors using PhyloNetworks (Solís-Lemus, Bastide, and Ané 2017) with a composite tree sample including posterior trees from all loci. Finally, we carried out network estimation using SNaQ (Solís-Lemus and Ané 2016).


## Pipeline

The input for the pipeline is a set of alignments, one per locus, in nexus format. The The script `file_preparation.sh` will create four different directories and move one locus alignment into each so that all directories have similar numbers of nexus files. It then uses the a template MrBayes script filled with placeholders and do the necessary replacements for inputting alignment name and directory name; then it creates a job submission script using a PSB template for each of the four directories which iterates over MrBayes scripts `.mb` taking the corresponding nexus file as input. The four jobs are then submitted by the script `submit_jobs.sh` and left to run until completion.

The script `tree_qualitycontrol.sh` amalgamates information on topological convergence in MCMC sampling by fetching the reported SDSF from the .log file for each of the loci and moved to a file containing the locus name and said value, writing them to a text file. Then the script `tree_qualitycontrol.R` reads that text file and produces a boxplot of SDSF values per job, allowing to check visually whether there is any value above the chosen threshold of 0.1. The number of loci that show values above this threshold is also printed. 

Tree format conversion from nexus to newick and further thinning in order to lower memory usage was carried out wrapping phyx in the `treedist_perlocus_formatting.sh` script, the script writes all the converted topologies into a single file which is the used for calculation of concordance factors with the script `CF_calculation.jl` using PhyloNetworks. The resulting csv file is then used as input by iterative calls to SNaQ in the `network_estimation.jl` script along with the initial tree, which was estimated using maximum likelihood in RAxML. We used h = 0 to 3 and 20 independent runs in order to decide how many hybridisation events were necessary to explain the concordance factors and to estimate the best network(s).

## References

Ballen, Gustavo, Fabio Roxo, Nathan Lujan, Jonathan W. Armbruster, and Claudia Solís-Lemus. (submitted). Reticulate Evolution Explains Phylogenetic and Taxonomic Conflict in Neotropical Armoured Catfishes (Loricariidae: Hypostominae). Bulletin of the Society of Systematic Biologists XX: XX-XX.

Brown, Joseph W, Joseph F Walker, and Stephen A Smith. 2017. “Phyx: Phylogenetic Tools for Unix.” Edited by Janet Kelso. Bioinformatics 33 (12): 1886–88. https://doi.org/10.1093/bioinformatics/btx063.

Nylander, Johan A. A., James C. Wilgenbusch, Dan L. Warren, and David L. Swofford. 2008. “AWTY (Are We There yet?): A System for Graphical Exploration of MCMC Convergence in Bayesian Phylogenetics.” Bioinformatics 24 (4): 581–83. https://doi.org/10.1093/bioinformatics/btm388.

Ronquist, F., and J. P. Huelsenbeck. 2003. “MrBayes 3: Bayesian Phylogenetic Inference Under Mixed Models.” Bioinformatics 19 (12): 1572–74. https://doi.org/10.1093/bioinformatics/btg180.

Solís-Lemus, Claudia, and Cécile Ané. 2016. “Inferring Phylogenetic Networks with Maximum Pseudolikelihood Under Incomplete Lineage Sorting.” Edited by Scott Edwards. PLOS Genetics 12 (3): e1005896. https://doi.org/10.1371/journal.pgen.1005896.

Solís-Lemus, Claudia, Paul Bastide, and Cécile Ané. 2017. “PhyloNetworks: A Package for Phylogenetic Networks.” Molecular Biology and Evolution 34 (12): 3292–98. https://doi.org/10.1093/molbev/msx235.

Stenz, Noah W. M., Bret Larget, David A. Baum, and Cécile Ané. 2015. “Exploring Tree-Like and Non-Tree-Like Patterns Using Genome Sequences: An Example Using the Inbreeding Plant Species Arabidopsis Thaliana (L.) Heynh.” Systematic Biology 64 (5): 809–23. https://doi.org/10.1093/sysbio/syv039.

