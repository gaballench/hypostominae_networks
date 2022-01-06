using PhyloNetworks
using DataFrames

trees = readMultiPhylo("tree_samples/trees_allloci.newick")

q,t = countquartetsintrees(trees)
df = writeTableCF(q,t)
cfs = readTableCF(df)

# add dummy columns to df so that it is get-pop-tree.pl-compliant
zeros = repeat([0], nrow(df))

df_zeros = DataFrame(CF12_34_lo=zeros,
                     CF12_34_hi=zeros,
                     CF13_24_lo=zeros,
                     CF13_24_hi=zeros,
                     CF14_23_lo=zeros,
                     CF14_23_hi=zeros)

df_ticr = hcat(select(df, 1:5),
               select(df_zeros, 1:2),
               select(df, 6),
               select(df_zeros, 3:4),
               select(df, 7),
               select(df_zeros, 5:6))

# add code for reading the initial tree

# add code for calling snaq under the different assumptions h=0:3
