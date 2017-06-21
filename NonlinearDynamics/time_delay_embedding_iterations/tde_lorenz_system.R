##Reference
#http://www.sixhat.net/lorenz-attractor-in-r.html

require(rgl)
library(deSolve)
require(tseriesChaos)


##
# Parameters for the solver
parameters <- c(s = 10, r = 28, b = 8/3)

##
# In initial state
yini <- c(X = 0.01, Y = 0.001, Z = 0.001)
#yini <- c(X = 10, Y = 10, Z = 10)

Lorenz <- function(t, state, parameters) {
  with(as.list(c(state, parameters)), {
    dX <- s * (Y - X)
    dY <- X * (r - Z) - Y
    dZ <- X * Y - b * Z
    list(c(dX, dY, dZ))
  })
}

timeserie <- seq(0, 50, by = 0.01)
library(deSolve)
out <- ode(y = yini, times = timeserie, func = Lorenz, parms = parameters)

datawindowframe <- 1500:3000;
Xt <- out[datawindowframe,2];
Yt <- out[datawindowframe,3];
Zt <- out[datawindowframe,4];

timeserie <-Xt



##############
##############
# Reconstructed the state space using the embedding time delay



dim <- 3
max_tau <- 50 

# projections of the first and second variables 
dir.create("images_frames_for_m3_TAU")
for (tau in 0:max_tau) {
	Xembedded <- embedd(timeserie, m=dim, d=tau);
	png(filename=paste("images_frames_for_m3_TAU/manifold_d3_t-", 
                   sprintf("%d", tau), ".png", sep=""), width=400,height=400)
	plot(Xembedded[,2],Xembedded[,1], pch = ".", type = "l", main=paste("dim=3, tau=",sprintf("%d",tau), sep="") )
	dev.off()
}



dim <- 2
dir.create("images_frames_for_m2_TAU")
for (tau in 0:max_tau) {
	Xembedded <- embedd(timeserie, m=dim, d=tau);
  	png(filename=paste("images_frames_for_m2_TAU/manifold_d2_t-", 
                     sprintf("%d", tau), ".png", sep=""), width=400,height=400)
  	plot(Xembedded[,2],Xembedded[,1], pch = ".", type = "l", main=paste("dim=2, tau=",sprintf("%d",tau), sep="") )
  	dev.off()
}




# time series 
dim <- 3
dir.create("images_frames_of_timeseries_for_m3_TAU")
for (tau in 0:max_tau) {
  	Xembedded <- embedd(timeserie, m=dim, d=tau);
  	png(filename=paste("images_frames_of_timeseries_for_m3_TAU/timeseries_d3_t-", 
                     sprintf("%d", tau), ".png", sep=""), width=400,height=400)
  	plot.ts(Xembedded[,1:3], main=paste("dim=3, tau=",sprintf("%d",tau), sep="") )
  	dev.off()
}





