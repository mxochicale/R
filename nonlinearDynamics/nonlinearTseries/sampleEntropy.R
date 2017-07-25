#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#
# FileName:
# FileDescription:
#
#
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Miguel P. Xochicale [http://mxochicale.github.io]
# Doctoral Researcher in Human-Robot Interaction
# University of Birmingham, U.K. (2014-2018)
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Source
# https://cran.r-project.org/web/packages/nonlinearTseries/vignettes/nonlinearTseries_quickstart.html


library('nonlinearTseries')
library('plot3D')


######################
## DATA: Lorenz System

# by default, the simulation creates a RGL plot of the system's phase space
lor = lorenz(do.plot = F)

# suppose that we have only measured the x-component of the Lorenz system
lor.x = lor$x

# tau-delay estimation based on the mutual information function
tau.ami = timeLag(lor.x, technique = "ami",
                  lag.max = 100, do.plot = F)

emb.dim = estimateEmbeddingDim(lor.x, time.lag = tau.ami,
                               max.embedding.dim = 15, do.plot = F)


######################
## correratioon dimensions
cd = corrDim(lor.x,
             min.embedding.dim = emb.dim,
             max.embedding.dim = emb.dim + 5,
             time.lag = tau.ami,
             min.radius = 0.001, max.radius = 50,
             n.points.radius = 40,
             do.plot=FALSE)
# # plot(cd)
# cd.est = estimate(cd, regression.range=c(0.75,3),
#                   use.embeddings = 5:7)
# cat("expected: 2.05  --- estimate: ",cd.est,"\n")


######################
## Sample Entropy
se = sampleEntropy(cd, do.plot = F)
se.est = estimate(se, do.plot = F,
                  regression.range = c(8,25))
cat("Sample entropy estimate: ", mean(se.est), "\n")
