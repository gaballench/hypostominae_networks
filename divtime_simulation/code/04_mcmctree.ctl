          seed = -1
       seqfile = genetrees.aln
      treefile = tree.phylip
      mcmcfile = mcmc.txt
       outfile = out.txt

         ndata = _GENETREES
       seqtype = 0    * 0: nucleotides; 1:codons; 2:AAs
       usedata = _USEDATA    * 0: no data; 1:seq like; 2:normal approximation; 3:out.BV (in.BV)
         clock = 1    * 1: global clock; 2: independent rates; 3: correlated rates
       RootAge = 'B(39.0,41.0)'  * safe constraint on root age, used if no fossil for root.

         model = 0    * 0:JC69, 1:K80, 2:F81, 3:F84, 4:HKY85
         alpha = 0    * alpha for gamma rates at sites
         ncatG = 1    * No. categories in discrete gamma

     cleandata = 0    * remove sites with ambiguity data (1:yes, 0:no)?

       BDparas = 1 1 0.1  * birth, death, sampling
   kappa_gamma = 6 2      * gamma prior for kappa, not used here b/c JC69
   alpha_gamma = 1 1      * gamma prior for alpha

   rgene_gamma = 1 1 0.5 0  * gammaDir prior for rate for genes
  *sigma2_gamma = 2 10 1   * gammaDir prior for sigma^2     (for clock=2 or 3)

         print = 1   * 0: no mcmc sample; 1: everything except branch rates 2: everything
        burnin = _BURNIN
      sampfreq = _SAMPFREQ
       nsample = _NSAMPLE