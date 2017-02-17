
#

##################################################
# ref
# http://www.di.fc.ul.pt/~jpn/r/fourier/fourier.html


library(lattice) # for xyplot
library(stats) # for fft

plot.timeseries <- function(time.series, tn) {

# plot <- xyplot(time.series ~ 0: length(time.series),
 plot <- xyplot( time.series ~ tn,
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
  print(plot)
}


# set.seed(101)
acq.freq <- 50                   # data acquisition (sample) frequency (Hz)
time     <- 12                  # measuring time interval (seconds)
tn       <- seq(0,time-1/acq.freq, 1/acq.freq) # vector of sampling time-points (s)
f.0      <- 1/time
w        <- 2*pi*f.0
# N_length <- length(ts)



cycles <- time/4

mainfreq <-  1/(time/cycles)

dc.component <- 0
component.strength <- c(1,0,0) # strength of signal components
component.freqs <- c(mainfreq,0,0)        # frequency of signal components (Hz)
component.delay <- c(0,0,0)         # delay of signal components (radians)


f   <- function(tn) {
  dc.component + sum( component.strength * sin(2*pi*component.freqs*tn + component.delay))
}

sd.additivenoise <- 0.005    # additive noise standard deviation
mean.amplitude <- 0

trajectory <- sapply(tn, function(t) f(t)) +  rnorm(length(tn), mean = mean.amplitude, sd = sd.additivenoise)


x11(width = 9, height = 9, xpos = 0, ypos=0)
plot.timeseries(trajectory,tn)

# trajectory <- trajectory + 25*ts # let's create a linear trend
# trend <- lm(trajectory ~tn)
# detrended.trajectory <- trend$residuals
# plot.timeseries(detrended.trajectory)

plot.frequency.spectrum <- function(X.k, xlimits=c(0,length(X.k))) {
  plot.data  <- cbind(0:(length(X.k)-1), Mod(X.k))

  # TODO: why this scaling is necessary?
  plot.data[2:length(X.k),2] <- 2*plot.data[2:length(X.k),2]

  plot(plot.data, t="h", lwd=2, main="",
       xlab="Frequency (Hz)", ylab="Strength",
       xlim=xlimits, ylim=c(0,max(Mod(plot.data[,2]))))
}

## length of the signal
X.k <- fft(trajectory)
x11(width = 9, height = 9, xpos = 0, ypos=-1)
plot.frequency.spectrum(X.k,xlimits=c(0,acq.freq/2))

# X.k <- fft(detrended.trajectory)
#graphics.off()
