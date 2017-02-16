
#

##################################################
# ref
# https://onestepafteranother.wordpress.com/signal-analysis-and-fast-fourier-transforms-in-r/


library(lattice) # for xyplot
library(stats) # for fft

#Domain setup
T <- 12
dt <- 1/50 #s
n <- T/dt
F <-1/dt
df <- 1/T



t <- seq(0,T,by=dt) #also try ts function

freq_a<-5 #Hz
freq_b<-6 #Hz
#CREATE OUR TIME SERIES DATA
y <- 1*sin(2*pi*freq_a*t) +2* sin(2*pi*freq_b*t)

#CREATE OUR FREQUENCY ARRAY
f <- 1:length(t)/T

#FOURIER TRANSFORM WORK
Y <- fft(y)
mag <- sqrt(Re(Y)^2+Im(Y)^2)*2/n
phase <- atan(Im(Y)/Re(Y))
Yr <- Re(Y)
Yi <- Im(Y)


layout(matrix(c(1,2), 2, 1, byrow = TRUE))
plot(t,y,type="l",xlim=c(0,T))
plot(f[1:length(f)/2],mag[1:length(f)/2],type="l")
