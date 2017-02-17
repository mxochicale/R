
#

##################################################
# ref
# https://onestepafteranother.wordpress.com/signal-analysis-and-fast-fourier-transforms-in-r/


##################################################################
##################################################################
###
###  LIBRARIES
###
library(lattice) # for xyplot
library(stats) # for fft
library(base) # which.min(x) or which.max(x)

##################################################################
##################################################################
###
###  FUNCTIONS
###
plot.timeseries <- function(time.series, tn) {

# plot <- xyplot(time.series ~ 0: length(time.series),
 # plot <-

 xyplot( time.series ~ tn,
                    col.line = c('red'), type = c("b"), lty=1, lwd=3,
                    pch=1, cex=1.5,
                    xlab=list(label="sample", cex=2),
                    ylab=list(label="x(t)", cex=2),
                    scales=list(font=1, cex=2
                                #,y=list(at=seq(-2,2,1),limits=c(-2.1,2.1))
                                #x=list(at=seq(-5,5,2),limits=c(-7,7))
                    ),
                    abline=list(h=c(0),lwd=4,lty=2),

                    ##function to modify the grid pattern
                    panel=function(...) {
                      panel.xyplot(...)
                      panel.grid(h=-20, v=-1, col.line="blue", lwd=0.5, lty=3 )
                    }

  )

}

plot.frequency.spectrum <- function(X,f){

xyplot( X ~ f,
                   col.line = c('red'),
                   type = c("b"), lty=1, lwd=3,
                   pch=1, cex=1.5,
                   xlab=list(label="Frequency (Hz)", cex=2),
                   ylab=list(label="Strength", cex=2),
                   scales=list(font=1, cex=2,
                     y=list(limits=c( 0,  max(X) +  (20*max(X))/100   ) )
                     ),
                   ##function to modify the grid pattern
                   panel=function(...) {
                     panel.xyplot(...)
                     panel.grid(h=-20, v=-1, col.line="blue", lwd=0.5, lty=3 )
                   }

                   )

}



##################################################################
##################################################################
###
###  MAIN
###


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

sd.additivenoise <- 0.5    # additive noise standard deviation
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


pts <- plot.timeseries(y,t)
pfs <- plot.frequency.spectrum( mag, f)
print(pts, split = c(1, 1, 1, 2), more = TRUE)
print(pfs, split = c(1, 2, 1, 2), more = FALSE)



##################################################################
# Frequency Domain Features

### * DC Component
DC_component <- mag[1]

### * Energy  READ MORE [https://cran.r-project.org/web/packages/psd/vignettes/normalization.pdf]
energy <- sum(mag)

### * ratio between the maximum magnitude and the sum of all the magnitude values
max_sum_mag_ratio <- max(mag) / sum(mag)

### * frequency bin that contains the maxium magnitude value
max_mag_bin <- which.max(mag)
freq_bin <- f[max_mag_bin]

freq.feat <- c(DC_component, energy, max_sum_mag_ratio, freq_bin)


message("FREQFEAT >>> ", "dc:",freq.feat[1], "  energy:", freq.feat[2], "  smratio:", freq.feat[3], "  fbin:", freq.feat[4])
