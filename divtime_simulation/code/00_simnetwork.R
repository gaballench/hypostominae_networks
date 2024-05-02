library(SiPhyNetwork)

set.seed(1980)

nets <- sim.bdh.taxa.ssa(n = 12,
                         numbsim = 50,
                         lambda = 1,
                         mu = 0.02,
                         nu = 0.20,
                         twolineages = TRUE,
                         hybprops = c(1,1,1),
                         hyb.inher.fxn = make.beta.draw(10,10))

for (i in seq_along(nets)) {
    inet <- nets[[i]]
    if (!inherits(inet, "phylo")) {
        print("Malformed network")
    }else{
        print(paste(length(nets[[i]]$inheritance), ", i=", i, sep=""))
    }
}

# network 11 looks just nice

write.net(net = nets[[11]],
          file = "../data/network.extnewick"
          )
