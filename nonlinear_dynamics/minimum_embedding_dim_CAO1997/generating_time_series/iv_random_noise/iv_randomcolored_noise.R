library(lattice) ##xyplot
#reference

# simulate Gaussian White Noise process 
#set.seed(123)
#y = rnorm(60, mean=0.01, sd=0.05)

randomcolorednoise.map = function(X){
  X.new=X
  
  X.new[1,] = 0.95*X[1,] + rnorm(1, mean=0.01, sd=0.05)

  X=X.new
  return(X.new)  
}

x <- matrix(c(0),ncol=1) ## initial conditions

randomcolorednoise.map.ts = function(timesteps,x) {
    x.ts = matrix(nrow=1,ncol=timesteps)
     x.ts[,1] = x[,1]
    for (t in (2:timesteps)) {
      x = randomcolorednoise.map(x)
      x.ts[,t] = x
   }
    return(x.ts)
  }
 

N <- 10000
randomcolorednoise<-randomcolorednoise.map.ts(N,x)

write(randomcolorednoise, file = "randomcolorednoise_xn_N10000.dat", ncolumns=1)
