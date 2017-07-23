library(deSolve)


library(lattice) ##xyplot
#reference



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

timeserie <- seq(0, 150, by = 0.01)
out <- ode(y = yini, times = timeserie, func = Lorenz, parms = parameters)



datawindowframe <- 1500:(-1+1500+10000);

Xt <- out[datawindowframe,2];
Yt <- out[datawindowframe,3];
Zt <- out[datawindowframe,4];


write(Xt, file = "lorenz_xn_N10000.dat", ncolumns=1)
write(Yt, file = "lorenz_yn_N10000.dat", ncolumns=1)
write(Zt, file = "lorenz_zn_N10000.dat", ncolumns=1)

plot(Xt, Zt, pch = ".", type = "l")

