library(lattice) ##xyplot
#reference

ikeda.map = function(X,p,u,k,alpha){
  X.new=X
  
  
  X.new[1,] = p + (u * ( X[1,]*cos(X[3,]) - X[2,]*sin(X[3,]) )) ## x
  X.new[2,] = u * ( X[1,]*sin(X[3,]) - X[2,]*cos(X[3,]) ) ##y
  
  X.new[3,] = (k) - ((alpha) / (1 + X[1,]*X[1,] + X[2,]*X[2,]))   ##t

  X=X.new
  return(X.new)  
}



x <- matrix(c(0,0,0),ncol=1) ## initial conditions

 ikeda.map.ts = function(timesteps,x,p,u,k,alpha) {
   x.ts = matrix(nrow=3,ncol=timesteps)
   x.ts[,1] = x[,1]
   for (t in (2:timesteps)) {
     x = ikeda.map(x,p,u,k,alpha)
     x.ts[,t] = x
  }
   return(x.ts)
 }


N <- 1000
ikedats<-ikeda.map.ts(N,x,1.0,0.9,0.4,6.0)

#plot(ikedats[1,],ikedats[2,], pch = ".", type = "l")

# plot 2D 
p <- xyplot(ikedats[2,] ~ ikedats[1,],
        main=list(label="", cex=2.5),
        xlab=list(label="x[n]", cex=2.5),
        ylab=list(label="y[n]", cex=2.5),
        scales=list(cex=1.5),# labels from the        
        grid=TRUE)

plot(p)
  
# Plot time-series 
#plot.ts(ikedats[1,],)
#plot.ts(ikedats[2,])

write(ikedats[1,], file = "ikeda_xn.dat", ncolumns=1)
write(ikedats[2,], file = "ikeda_yn.dat", ncolumns=1)
