library(lattice) ##xyplot



N <- 1000


#reference
#http://www.stat.cmu.edu/~cshalizi/462/lectures/03/03.R

henon.map = function(x,a,b){
  x.new=x
  x.new[1,] = 1 - a*x[1,]*x[1,] + x[2,]
  x.new[2,] = b*x[1,]
  x=x.new
  return(x.new)
}

#x <- matrix(nrow=2,ncol=1)
x <- matrix(c(.0,.0),ncol=1)


henon.map.ts = function(timesteps,x,a,b) {
  x.ts = matrix(nrow=2,ncol=timesteps)
  x.ts[,1] = x[,1]
  for (t in (2:timesteps)) {
    x = henon.map(x,a,b)
    x.ts[,t] = x
  }
  return(x.ts)
}


hmts<-henon.map.ts(N,x,1.4,0.3)


# 2D plot 
p <- xyplot(hmts[2,] ~ hmts[1,],
       type="p",
       main=list(label="", cex=2.5),
       xlab=list(label="x[n]", cex=2.5),
       ylab=list(label="y[n]", cex=2.5),
       scales=list(cex=1.5),# labels from the        
       grid=TRUE)
plot(p)


write(hmts[1,], file = "henon_xn.dat", ncolumns=1)
write(hmts[2,], file = "henon_yn.dat", ncolumns=1)


