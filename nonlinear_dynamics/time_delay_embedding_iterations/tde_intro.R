##Reference
#http://www.sixhat.net/lorenz-attractor-in-r.html

#require(rgl)
#library(deSolve)
require(tseriesChaos)

timeserie <- 1:9;
dim <- 3;
tau <- 2; 

Xembedded <- embedd(timeserie, m=dim, d=tau);

