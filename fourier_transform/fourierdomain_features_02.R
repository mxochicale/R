
#
# Call /functions_freq_features.R") to use of the following functions
# plot.timeseries.frequency.spectrum(y,t,mag,f)
#  freqfeatures <- freqfeatures(mag)
#
#

##################################################
# ref
# https://onestepafteranother.wordpress.com/signal-analysis-and-fast-fourier-transforms-in-r/


###  Loading Functions
source("~/mxochicale/phd/r-code/functions/functions_freq_features.R")



##################################################################
# Time Domain setup
acq.freq <- 50
dt <- 1/acq.freq #s

T <- 12
df <- 1/T
n <- T/dt


#CREATE OUR TIME SERIES DATA

t <- seq(0,T,by=dt)

dc.component <- 0
component.strength <- c(1,2,3) # strength of signal components
component.freqs <- c(3,10,20)        # frequency of signal components (Hz)
component.delay <- c(0,0,0)         # delay of signal components (radians)


f   <- function(t) {
  dc.component + sum( component.strength * sin(2*pi*component.freqs*t + component.delay))
}

sd.additivenoise <- 5.5    # additive noise standard deviation
mean.amplitude <- 0

y <- sapply(t, function(t) f(t)) +  rnorm(length(t), mean = mean.amplitude, sd = sd.additivenoise)

 # y <- y + 50*t # let's create a linear trend
# trend <- lm(y~t)
# y <- trend$residuals




##################################################################
# Frequency Domain setup

#CREATE OUR FREQUENCY ARRAY
f <- 1:length(t)/T
f <- f[1:length(f)/2]


#FOURIER TRANSFORM WORK
Y <- fft(y)
mag <- Mod(Y)*2/n
mag <- mag[1:length(f)/2]

# Discrete Fourier transforms can be normalized in different ways.
# Some apply the whole normalization to the forward transform, some to
# the reverse transform, some apply the square root to each, and some
# don't normalize at all (in which case the reverse of the forward
# transform will need scaling).
# http://r.789695.n4.nabble.com/Is-R-s-fast-fourier-transform-function-different-from-quot-fft2-quot-in-Matlab-td864669.html


plot.timeseries.frequency.spectrum(y,t,mag,f)
freqfeatures <- freqfeatures(mag)

message(freqfeatures)
