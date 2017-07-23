##Reference
#http://functional-orbitz.blogspot.mx/2009/10/lorenz-attractor-in-r.html

require(rgl)
library(deSolve)
library(scatterplot3d)

##
# Parameters for the solver
pars <- c(alpha = 10,
          beta = 8/3,
          c = 25.58)
##
# In initial state
yini <- c(x = 0.01, y = 0.0, z = 0.0)

lorenz <- function(Time, State, Pars) {
  with(as.list(c(State, Pars)), {
    xdot <- alpha * (y - x)
    ydot <- x * (c - z) - y
    zdot <- x*y - beta*z
    return(list(c(xdot, ydot, zdot)))
  })
}

times <- seq(0, 50, by = 0.01)
out <- as.data.frame(ode(func = lorenz, y = yini, parms = pars, times = times))
  
  
plot.ts(out[,4])
#rgl.snapshot(filename="timeserie.png")#it does not work


##################################
# ###ON LINE ANIMATION 
##################################
# plot3d(out[,2:4],box=FALSE, type="l", lwd=2, col="blue",alpha=0.7)
# #decorate3d(main = "Lorenz Attractor",top = FALSE)
# #rgl.snapshot(filename="animationframe.png")
# 
# for (i in 1:90) {
#   view3d(userMatrix=rotationMatrix(2*pi * i/90, 1, 1, -1))
# }
# #The last 3 parameters are the coordinates of a 3D vector, 
# #and the first parameter is an angle (in radians) describing 
# #a rotation around this axis. 



##################################
##SAVE AN ANIMATION
##################################
##http://www.genomearchitecture.com/2014/03/3d-animations-with-r
plot3d(out[,2:4],box=FALSE, type="l", lwd=2, col="blue",alpha=0.7)
dir.create("image_frames")
for (i in 1:90) {
  view3d(userMatrix=rotationMatrix(2*pi * i/90, 1, 1, -1))
  rgl.snapshot(filename=paste("image_frames/frame-",
                              sprintf("%03d", i), ".png", sep=""))
}

#cd image_frames
#convert -delay 5 -loop 0 frame*.png animated.gif

