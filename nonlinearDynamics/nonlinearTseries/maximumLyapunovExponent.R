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


tau.ami = timeLag(lor.x, technique = "ami",
                 lag.max = 100, do.plot = F)

emb.dim = estimateEmbeddingDim(lor.x, time.lag = tau.ami,
                               max.embedding.dim = 15, do.plot = F)


######################
## Maximum Lyapunov exponent
# get the sampling period of the lorenz simulation
# computing the differences of time (all differences should be equal)
# sampling.period = diff(lor$time)[1]

ml = maxLyapunov(lor.x,
                 sampling.period=0.01,
                 min.embedding.dim = emb.dim,
                 max.embedding.dim = emb.dim + 3,
                 time.lag = tau.ami,
                 radius=1,
                 max.time.steps=1000,
                 do.plot=FALSE)

# plot(ml,type="l", xlim = c(0,8))
# ml.est = estimate(ml, regression.range = c(0,3),
#                    do.plot = T,type="l")
# cat("expected: 0.906  --- estimate: ", ml.est,"\n")



################################################################################
## Henon System
h=henon(n.sample=  5000,n.transient= 100, a = 1.4, b = 0.3,
        start = c(0.63954883, 0.04772637), do.plot = FALSE)
my.ts=h$x

ml=maxLyapunov(time.series=my.ts,
              min.embedding.dim=2,
              max.embedding.dim=5,
              time.lag=1,
              radius=0.001,theiler.window=4,
              min.neighs=2,min.ref.points=500,
              max.time.steps=40,do.plot=FALSE)

# plot(ml,type="l")

# ml.estimation = estimate(ml,regression.range = c(0,15),
#                           use.embeddings=2:5,
#                           do.plot = TRUE)
#
# # The max Lyapunov exponent of the Henon system is 0.41
# cat("expected: ",0.41," calculated: ",ml.estimation,"\n")



################################################################################
## Rossler system
r=rossler(a=0.15,b=0.2,w=10,start=c(0,0,0), time=seq(0,1000,0.1),do.plot=FALSE)
          my.ts=r$x
          use.cols = c("#999999","#E69F00","#56B4E9")

ml=maxLyapunov(time.series=my.ts,
                min.embedding.dim=5,
                max.embedding.dim = 7,
                time.lag=12,
                radius=0.1,
                theiler.window=50,
                min.neighs=5,
                min.ref.points=length(r),
                max.time.steps=300,
                number.boxes=NULL,
                sampling.period=0.1,
                do.plot=TRUE,
                col=use.cols)

# #  The max Lyapunov exponent of the Rossler system is 0.09
# ml.est=estimate(ml,col=use.cols,do.plot=T,
# fit.lty=1,
# fit.lwd=5)
# cat("expected: ",0.090," calculated: ",ml.est,"\n")
