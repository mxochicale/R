##Reference
#http://www.sixhat.net/lorenz-attractor-in-r.html

require(rgl)
library(scatterplot3d)
library(deSolve)
require(tseriesChaos)


##
# Parameters for the solver
parameters <- c(s = 10, r = 28, b = 8/3)

##
# In initial state
yini <- c(X = 0.01, Y = 0.001, Z = 0.001)

Lorenz <- function(t, state, parameters) {
  with(as.list(c(state, parameters)), {
    dX <- s * (Y - X)
    dY <- X * (r - Z) - Y
    dZ <- X * Y - b * Z
    list(c(dX, dY, dZ))
  })
}

timeserie <- seq(0, 50, by = 0.01)
out <- ode(y = yini, times = timeserie, func = Lorenz, parms = parameters)

datawindowframe <- 1500:3000;

Xt <- out[datawindowframe,2];
Yt <- out[datawindowframe,3];
Zt <- out[datawindowframe,4];


write(Xt, file = "lorenz_xt.dat", ncolumns=1)

timeserie <-Xt

#########################################################
#####   scatterplot3d 3D dynamic system plot
#########################################################

###2d manifold
png(file="timeserie.png", bg="transparent")
plot.ts(Xt, type = "l", lwd=4, col="blue")
dev.off()

###3d manifold 
png(file="3d-manifold.png", bg="transparent")
 scatterplot3d(Xt,Yt,Zt, type="l", lwd=3,color="blue",
               xlab = "X(t)", ylab = "Y(t)", zlab = "Z(t)",
               box=FALSE,
               main="",)
dev.off()




#########################################################
#####               rgl 3D dynamic system plot
#########################################################
# ###
# rgl.open()
# rgl.clear()
# rgl.linestrips(Xt,Yt,Zt, lwd=2)
# rgl.viewpoint(fov = 50, zoom = 0.8, 
#               interactive = TRUE,userMatrix = rotationMatrix(100*pi/180, 1,0.3,0))
# decorate3d(c(-20,20), c(-20,20), c(-20,20),
#            aspect=TRUE, expand = 1.1, #,main ="s = 10, r = 28, b = 8/3",
#            #box=FALSE,axes=FALSE,xlab = "X(t)", ylab = "Y(t)", zlab = "Z(t)")
#            box=FALSE,axes=FALSE,xlab = "", ylab = "", zlab = "")





##############
##############
# Reconstructed the state space using the embedding time delay


dim <- 10
tau <- 2 
Xembedded <- embedd(timeserie, m=dim, d=tau);

# Center the data so that the mean of each row is 0
rm=rowMeans(t(Xembedded));
Xembeddedcentered= t(Xembedded - t((matrix(rep(rm,dim(Xembedded)[1]),nrow=dim(Xembedded)[2]))));

A=Xembeddedcentered %*% t(Xembeddedcentered)
E=eigen(A,TRUE)
#barplot(E$values/E$values[1], main = "Eigenvalues -- E$vals/E$vals[1]")
P=t(E$vectors)
# Find the new data and standard deviations of the principal components
PC = P %*% Xembeddedcentered;

p <- prcomp(Xembedded,scale=FALSE);



#########################################################
#####   scatterplot3d 3D dynamic system plot
#########################################################

####2d manifold
#png(file="myplot.png", bg="transparent")
#plot(Yt,Xt, pch = ".", type = "l")
#dev.off()
#plot.ts(Yt,lwd=3)
#plot.ts(-1*PC[2,],lwd=3) ## DIY PC1 and PC2 should be multiplied by -1 
##                      ## so as to have the the same results as prcomp
#plot.ts(p$x[,2],lwd=3)
#plot(-1*PC[2,], -1*PC[1,], pch = ".", type = "l")
#plot(p$x[,1], p$x[,2], pch = ".", type = "l")


###3d embedded manifold 
png(file="3d-embedded-manifold.png", bg="transparent")
scatterplot3d(Xembedded[,1],Xembedded[,2],Xembedded[,3], type="l", lwd=3,color="blue",
              xlab = "x(t)", ylab = "x(t-1)", zlab = "x(t-2)",
              box=FALSE,angle=50,
              main="")
dev.off()


####3d reconstructed manifold 
png(file="3d-reconstructed-manifold.png", bg="transparent")
scatterplot3d(PC[1,],PC[2,],PC[3,], type="l", lwd=3,color="blue",
#scatterplot3d(PC[1,],PC[3,],PC[5,], type="l", lwd=3,color="blue",
              xlab = "PC1", ylab = "PC2", zlab = "PC3",
              box=FALSE,angle=50,
              main="")
dev.off()




#########################################################
#####               rgl 3D reconstructed plot
#########################################################
 #rgl.open()
 #rgl.clear()
 #rgl.linestrips(Xembedded[,1],Xembedded[,2],Xembedded[,3], lwd=2)
 #rgl.linestrips(-1*PC[1,],-1*PC[2,],PC[3,], lwd=2)
# #rgl.linestrips(p$x[,1], p$x[,2],p$x[,3], lwd=2)
# rgl.viewpoint(fov = 50, zoom = 0.8, 
#               interactive = TRUE,userMatrix = rotationMatrix(100*pi/180, 1,0.3,0))
# decorate3d(c(-20,20), c(-20,20), c(-20,20),
#            aspect=TRUE, expand = 1.1,
#            #box=FALSE, axis=FALSE,xlab = "PC1", ylab = "PC2", zlab = "PC3",
#            box=FALSE,axes=FALSE,xlab = "", ylab = "", zlab = "")
# 

